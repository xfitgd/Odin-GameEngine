package engine

import "core:math"
import "core:mem"
import "core:slice"
import "core:sync"
import "core:debug/trace"
import "core:math/linalg"
import "base:intrinsics"
import "base:runtime"
import vk "vendor:vulkan"

@private Graphics_Create :: proc() {
    ColorTransform_InitMatrixRaw(&__defColorTransform)
}

@private Graphics_Clean :: proc() {
    ColorTransform_Deinit(&__defColorTransform)
}

ResourceUsage :: enum {GPU,CPU}

__IObjectIn :: struct {
    set:VkDescriptorSet,
    camera: ^Camera,
    projection: ^Projection,
    colorTransform: ^ColorTransform,
    __in: __MatrixIn,
    actualType: typeid,
    vtable: ^IObjectVTable,
}

IObjectVTable :: struct {
    Draw: proc (self:^IObject, cmd:vk.CommandBuffer),
    Deinit: proc (self:^IObject),
    Update: proc (self:^IObject),
    __in: __IObjectVTable,
}

__IObjectVTable :: struct {
    __GetUniformResources: proc (self:^IObject) -> []VkUnionResource,
}

IObject :: struct {
    __in: __IObjectIn,
}


ColorTransform :: struct {
    __in: __ColorMatrixIn,
}

__ColorMatrixIn :: struct {
    mat: linalg.Matrix,
    matUniform:VkBufferResource,
    checkInit: mem.ICheckInit,
}

@private __defColorTransform : ColorTransform

__MatrixIn :: struct {
    mat: linalg.Matrix,
    matUniform:VkBufferResource,
    checkInit: mem.ICheckInit,
}


ColorTransform_InitMatrixRaw :: proc(self:^ColorTransform, mat:linalg.Matrix = {1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1}) {
    self.__in.mat = mat
    __ColorTransform_Init(self)
}

@private __ColorTransform_Init :: #force_inline proc(self:^ColorTransform) {
    mem.ICheckInit_Init(&self.__in.checkInit)
    VkBufferResource_CreateBuffer(&self.__in.matUniform, {
        len = size_of(linalg.Matrix),
        type = .UNIFORM,
    }, mem.ptr_to_bytes(&self.__in.mat), true)
}

ColorTransform_Deinit :: proc(self:^ColorTransform) {
    mem.ICheckInit_Deinit(&self.__in.checkInit)
    VkBufferResource_Deinit(&self.__in.matUniform)
}

ColorTransform_UpdateMatrixRaw :: proc(self:^ColorTransform, _mat:linalg.Matrix) {
    mem.ICheckInit_Check(&self.__in.checkInit)
    self.__in.mat = _mat
    VkBufferResource_CopyUpdate(&self.__in.matUniform, &self.__in.mat)
}


@(require_results)
SRT_2D_Matrix :: proc "contextless" (t: linalg.Point3DF, r: f32 = 0.0, s: linalg.PointF = {1.0, 1.0}, cp:linalg.PointF = {0.0, 0.0}) -> linalg.Matrix4x4f32 {
	pivot := linalg.matrix4_translate(linalg.Point3DF{cp.x,cp.y,0.0})
	translation := linalg.matrix4_translate(t)
	rotation := linalg.matrix4_rotate_f32(r, linalg.Vector3f32{0.0, 0.0, 1.0})
	scale := linalg.matrix4_scale(linalg.Point3DF{s.x,s.y,1.0})
	return linalg.mul(translation, linalg.mul(rotation, linalg.mul(pivot, scale)))
}

@private IObject_Init :: proc(self:^IObject, $actualType:typeid,
    pos:linalg.Point3DF, rotation:f32, scale:linalg.PointF = {1,1},
    camera:^Camera, projection:^Projection, colorTransform:^ColorTransform = nil, pivot:linalg.PointF = {0.0, 0.0})
    where actualType != IObject && intrinsics.type_is_subtype_of(actualType, IObject) {

    mem.ICheckInit_Init(&self.__in.__in.checkInit)
    self.__in.camera = camera
    self.__in.projection = projection
    self.__in.colorTransform = colorTransform == nil ? &__defColorTransform : colorTransform
    
    self.__in.__in.mat = SRT_2D_Matrix(pos, rotation, scale, pivot)

    self.__in.set.__set = 0

    VkBufferResource_CreateBuffer(&self.__in.__in.matUniform, {
        len = size_of(linalg.Matrix),
        type = .UNIFORM,
    }, mem.ptr_to_bytes(&self.__in.__in.mat), true)

    resources := __GetUniformResources(self)
    defer delete(resources, context.temp_allocator)
    __IObject_UpdateUniform(self, resources)

    self.__in.actualType = actualType
}

//!alloc result array in temp_allocator
@private __GetUniformResources :: proc(self:^IObject) -> []VkUnionResource {
    if self.__in.vtable != nil && self.__in.vtable.__in.__GetUniformResources != nil {
        return self.__in.vtable.__in.__GetUniformResources(self)
    } else {
        trace.panic_log("__GetUniformResources is not implemented")
    }
}

@private __GetUniformResources_AnimateImage :: #force_inline proc(self:^IObject) -> []VkUnionResource {
    res := mem.make_non_zeroed([]VkUnionResource, 5, context.temp_allocator)
    res[0] = &self.__in.__in.matUniform
    res[1] = &self.__in.camera.__in.matUniform
    res[2] = &self.__in.projection.__in.matUniform
    res[3] = &self.__in.colorTransform.__in.matUniform

    animateImage : ^AnimateImage= auto_cast self
    res[4] = &animateImage.__in2.frameUniform
    return res[:]
}

@private __GetUniformResources_TileImage :: #force_inline proc(self:^IObject) -> []VkUnionResource {
    res := mem.make_non_zeroed([]VkUnionResource, 5, context.temp_allocator)
    res[0] = &self.__in.__in.matUniform
    res[1] = &self.__in.camera.__in.matUniform
    res[2] = &self.__in.projection.__in.matUniform
    res[3] = &self.__in.colorTransform.__in.matUniform

    tileImage : ^TileImage = auto_cast self
    res[4] = &tileImage.__in2.tileUniform
    return res[:]
}

@private __GetUniformResources_Default :: #force_inline proc(self:^IObject) -> []VkUnionResource {
    res := mem.make_non_zeroed([]VkUnionResource, 4, context.temp_allocator)
    res[0] = &self.__in.__in.matUniform
    res[1] = &self.__in.camera.__in.matUniform
    res[2] = &self.__in.projection.__in.matUniform
    res[3] = &self.__in.colorTransform.__in.matUniform

    return res[:]
}

@private __IObject_UpdateUniform :: #force_inline proc(self:^IObject, resources:[]VkUnionResource) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    mem.copy_non_overlapping(&self.__in.set.__resources[0], &resources[0], len(resources) * size_of(VkUnionResource))
    VkUpdateDescriptorSets(mem.slice_ptr(&self.__in.set, 1))
}

IObject_UpdateTransform :: proc(self:^IObject, pos:linalg.Point3DF, rotation:f32 = 0.0, scale:linalg.PointF = {1.0,1.0}, pivot:linalg.PointF = {0.0,0.0}) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    self.__in.__in.mat = SRT_2D_Matrix(pos, rotation, scale, pivot)
    VkBufferResource_CopyUpdate(&self.__in.__in.matUniform, &self.__in.__in.mat)
}
IObject_UpdateTransformMatrixRaw :: proc(self:^IObject, _mat:linalg.Matrix) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    self.__in.__in.mat = _mat
    VkBufferResource_CopyUpdate(&self.__in.__in.matUniform, &self.__in.__in.mat)
}
IObject_UpdateColorTransform :: proc(self:^IObject, colorTransform:^ColorTransform) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    self.__in.colorTransform = colorTransform
    __IObject_UpdateUniform(self, __GetUniformResources(self))
}
IObject_UpdateCamera :: proc(self:^IObject, camera:^Camera) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    self.__in.camera = camera
    __IObject_UpdateUniform(self, __GetUniformResources(self))
}
IObject_UpdateProjection :: proc(self:^IObject, projection:^Projection) {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    self.__in.projection = projection
    __IObject_UpdateUniform(self, __GetUniformResources(self))
}
IObject_GetColorTransform :: #force_inline proc "contextless" (self:^IObject) -> ^ColorTransform {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    return self.__in.colorTransform
}
IObject_GetCamera :: #force_inline proc "contextless" (self:^IObject) -> ^Camera {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    return self.__in.camera
}
IObject_GetProjection :: #force_inline proc "contextless" (self:^IObject) -> ^Projection {
    mem.ICheckInit_Check(&self.__in.__in.checkInit)
    return self.__in.projection
}

IObject_GetActualType :: #force_inline proc "contextless" (self:^IObject) -> typeid {
    return self.__in.actualType
}

IObject_Draw :: proc (self:^IObject, cmd:vk.CommandBuffer) {
    if self.__in.vtable != nil && self.__in.vtable.Draw != nil {
        self.__in.vtable.Draw(self, cmd)
    } else {
        trace.panic_log("IObjectType_Draw: unknown object type")
    }
}

IObject_Deinit :: proc(self:^IObject) {
    if self.__in.vtable != nil && self.__in.vtable.Deinit != nil {
        self.__in.vtable.Deinit(self)
    } else {
        trace.panic_log("IObjectType_Deinit: unknown object type")
    }
}

IObject_Update :: proc(self:^IObject) {
    if self.__in.vtable != nil && self.__in.vtable.Update != nil {
        self.__in.vtable.Update(self)
    }
    //Update Not Required Default
}


SetRenderClearColor :: proc "contextless" (color:linalg.Point3DwF) {
    gClearColor = color
}

//AUTO DELETE USE engineDefAllocator
@private __VertexBuf_Init :: proc (self:^__VertexBuf($NodeType), array:[]NodeType, _flag:ResourceUsage, _useGPUMem := false) {
    mem.ICheckInit_Init(&self.checkInit)
    if len(array) == 0 do trace.panic_log("VertexBuf_Init: array is empty")
    VkBufferResource_CreateBuffer(&self.buf, {
        len = vk.DeviceSize(len(array) * size_of(NodeType)),
        type = .VERTEX,
        resourceUsage = _flag,
        single = false,
        useGCPUMem = _useGPUMem,
    }, mem.slice_to_bytes(array), false, engineDefAllocator)
}

@private __VertexBuf_Deinit :: proc (self:^__VertexBuf($NodeType)) {
    mem.ICheckInit_Deinit(&self.checkInit)

    VkBufferResource_Deinit(&self.buf)
}

@private __VertexBuf_Update :: proc (self:^__VertexBuf($NodeType), array:[]NodeType) {
    VkBufferResource_MapUpdateSlice(&self.buf, array, engineDefAllocator)
}

//AUTO DELETE USE engineDefAllocator
@private __StorageBuf_Init :: proc (self:^__StorageBuf($NodeType), array:[]NodeType, _flag:ResourceUsage, _useGPUMem := false) {
    mem.ICheckInit_Init(&self.checkInit)
    if len(array) == 0 do trace.panic_log("StorageBuf_Init: array is empty")
    VkBufferResource_CreateBuffer(&self.buf, {
        len = vk.DeviceSize(len(array) * size_of(NodeType)),
        type = .STORAGE,
        resourceUsage = _flag,
        single = false,
        useGCPUMem = _useGPUMem,
    }, mem.slice_to_bytes(array), false, engineDefAllocator)
}

@private __StorageBuf_Deinit :: proc (self:^__StorageBuf($NodeType)) {
    mem.ICheckInit_Deinit(&self.checkInit)

    VkBufferResource_Deinit(&self.buf)
}

@private __StorageBuf_Update :: proc (self:^__StorageBuf($NodeType), array:[]NodeType) {
    VkBufferResource_MapUpdateSlice(&self.buf, array, engineDefAllocator)
}

//AUTO DELETE USE engineDefAllocator
@private __IndexBuf_Init :: proc (self:^__IndexBuf, array:[]u32, _flag:ResourceUsage, _useGPUMem := false) {
    mem.ICheckInit_Init(&self.checkInit)
    if len(array) == 0 do trace.panic_log("IndexBuf_Init: array is empty")
    VkBufferResource_CreateBuffer(&self.buf, {
        len = vk.DeviceSize(len(array) * size_of(u32)),
        type = .INDEX,
        resourceUsage = _flag,
        useGCPUMem = _useGPUMem,
    }, mem.slice_to_bytes(array), false, engineDefAllocator)
}


@private __IndexBuf_Deinit :: proc (self:^__IndexBuf) {
    mem.ICheckInit_Deinit(&self.checkInit)

    VkBufferResource_Deinit(&self.buf)
}

@private __IndexBuf_Update :: #force_inline proc (self:^__IndexBuf, array:[]u32) {
    VkBufferResource_MapUpdateSlice(&self.buf, array, engineDefAllocator)
}

@private __VertexBuf :: struct($NodeType:typeid) {
    buf:VkBufferResource,
    checkInit: mem.ICheckInit,
}

@private __IndexBuf :: distinct __VertexBuf(u32)
@private __StorageBuf :: struct($NodeType:typeid) {
    buf:VkBufferResource,
    checkInit: ICheckInit,
}

//! Non Zeroed Alloc
AllocObject :: #force_inline proc($T:typeid) -> (^T, runtime.Allocator_Error) where intrinsics.type_is_subtype_of(T, IObject) #optional_allocator_error {
    sync.mutex_lock(&gAllocObjectMtx)
    defer sync.mutex_unlock(&gAllocObjectMtx)
    obj, err := mem.alloc_bytes_non_zeroed(size_of(T),align_of(T), engineDefAllocator)
    if err != .None do return nil, err
	return transmute(^T)raw_data(obj), .None
}

//! Non Zeroed Alloc
AllocObjectSlice :: #force_inline proc($T:typeid, #any_int count:int) -> ([]T, runtime.Allocator_Error) where intrinsics.type_is_subtype_of(T, IObject) #optional_allocator_error {
    sync.mutex_lock(&gAllocObjectMtx)
    defer sync.mutex_unlock(&gAllocObjectMtx)
    arr, err := mem.alloc_bytes_non_zeroed(count * size_of(T), align_of(T), engineDefAllocator)
    if err != .None do return nil, err
    s := runtime.Raw_Slice{raw_data(arr), count}
    return transmute([]T)s, .None
}

//! Non Zeroed Alloc
AllocObjectDynamic :: #force_inline proc($T:typeid) -> ([dynamic]T, runtime.Allocator_Error) where intrinsics.type_is_subtype_of(T, IObject) #optional_allocator_error {
    sync.mutex_lock(&gAllocObjectMtx)
    defer sync.mutex_unlock(&gAllocObjectMtx)
    res, err := make_non_zeroed_dynamic_array([dynamic]T, engineDefAllocator)
    if err != .None do return nil, err
    return res, .None
}

FreeObject :: #force_inline proc(obj:^$T) where intrinsics.type_is_subtype_of(T, IObject) {
    aObj := ALLOC_OBJ{
        typeSize = size_of(T),
        len = 1,
        deinit = obj.__in.vtable.Deinit,
        obj = rawptr(obj),
    }
    sync.mutex_lock(&gAllocObjectMtx)
    append(&gAllocObjects, aObj)
    sync.mutex_unlock(&gAllocObjectMtx)
}

FreeObjectSlice :: #force_inline proc(arr:$T/[]$E) where intrinsics.type_is_subtype_of(E, IObject) {
    aObj := ALLOC_OBJ{
        typeSize = size_of(E),
        len = len(arr),
        deinit = len(arr) > 0 ? arr[0].__in.vtable.Deinit : nil,
        obj = rawptr(raw_data(arr)),
    }
    sync.mutex_lock(&gAllocObjectMtx)
    append(&gAllocObjects, aObj)
    sync.mutex_unlock(&gAllocObjectMtx)
}

FreeObjectDynamic :: #force_inline proc(arr:$T/[dynamic]$E) where intrinsics.type_is_subtype_of(E, IObject) {
    aObj := ALLOC_OBJ{
        typeSize = size_of(E),
        len = cap(arr),
        deinit = len(arr) > 0 ? arr[0].__in.vtable.Deinit : nil,
        obj = rawptr(raw_data(arr)),
    }
    sync.mutex_lock(&gAllocObjectMtx)
    append(&gAllocObjects, aObj)
    sync.mutex_unlock(&gAllocObjectMtx)
}

