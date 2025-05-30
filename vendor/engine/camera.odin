package engine

import "core:math"
import "core:mem"
import "core:slice"
import "core:sync"
import "core:math/linalg"
import "base:intrinsics"
import "base:runtime"
import vk "vendor:vulkan"

Camera :: struct {
    __in: __MatrixIn,
}

Camera_InitMatrixRaw :: proc (self:^Camera, mat:linalg.Matrix) {
    mem.ICheckInit_Init(&self.__in.checkInit)
    self.__in.mat = mat
    __Camera_Init(self)
}

@private __Camera_Init :: #force_inline proc(self:^Camera) {
    mem.ICheckInit_Init(&self.__in.checkInit)
    VkBufferResource_CreateBuffer(&self.__in.matUniform, {
        len = size_of(linalg.Matrix),
        type = .UNIFORM,
    }, mem.ptr_to_bytes(&self.__in.mat), true)
}

Camera_Deinit :: proc(self:^Camera) {
    mem.ICheckInit_Deinit(&self.__in.checkInit)
    VkBufferResource_Deinit(&self.__in.matUniform)
}

Camera_UpdateMatrixRaw :: proc(self:^Camera, _mat:linalg.Matrix) {
    mem.ICheckInit_Check(&self.__in.checkInit)
    self.__in.mat = _mat
    VkBufferResource_CopyUpdate(&self.__in.matUniform, &self.__in.mat)
}

@private __Camera_Update :: #force_inline proc(self:^Camera, eyeVec:linalg.Point3DF, focusVec:linalg.Point3DF, upVec:linalg.Point3DF = {0,0,1}) {
    f := linalg.normalize(focusVec - eyeVec)
	s := linalg.normalize(linalg.cross(upVec, f))
	u := linalg.normalize(linalg.cross(f, s))

	fe := linalg.dot(f, eyeVec)

    self.__in.mat = {
		+s.x, +s.y, +s.z, -linalg.dot(s, eyeVec),
		+u.x, +u.y, +u.z, -linalg.dot(u, eyeVec),
		+f.x, +f.y, +f.z, -fe,
		   0,    0,    0, 1,
	}
}

Camera_Init :: proc (self:^Camera, eyeVec:linalg.Point3DF = {0,0,-1}, focusVec:linalg.Point3DF = {0,0,0}, upVec:linalg.Point3DF = {0,1,0}) {
    __Camera_Update(self, eyeVec, focusVec, upVec)
    __Camera_Init(self)
}

Camera_Update :: proc(self:^Camera, eyeVec:linalg.Point3DF = {0,0,-1}, focusVec:linalg.Point3DF = {0,0,0}, upVec:linalg.Point3DF = {0,0,1}) {
    __Camera_Update(self, eyeVec, focusVec, upVec)
    Camera_UpdateMatrixRaw(self, self.__in.mat)
}