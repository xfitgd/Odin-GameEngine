package font


import "core:math"
import "../"
import "core:c"
import "core:mem"
import "core:slice"
import "core:debug/trace"
import "core:math/linalg"
import "vendor:engine/geometry"
import "core:unicode"
import "core:unicode/utf8"
import "core:sync"
import "core:fmt"
import "base:runtime"
import "vendor:freetype"


@(private="file") CharData :: struct {
    rawShape : ^geometry.RawShape,
    advanceX : f32,
}
@(private="file") CharNode :: struct #packed {
    size:u32,
    char:rune,
    advanceX:f32,
}

Font :: struct {}

@(private="file") SCALE_DEFAULT : f32 : 256

@(private) FontT :: struct {
    face:freetype.Face,
    charArray : map[rune]CharData,
   

    mutex:sync.Mutex,

    scale:f32,//default 256
}

FontRenderOpt :: struct {
    scale:linalg.PointF,    //(0,0) -> (1,1)
    offset:linalg.PointF,
    pivot:linalg.PointF,
    area:Maybe(linalg.PointF),
    color:linalg.Point3DwF,
    flag:engine.ResourceUsage,
}

FontRenderOpt2 :: struct {
    opt:FontRenderOpt,
    ranges:[]FontRenderRange,
}

FontRenderRange :: struct {
    font:^Font,
    scale:linalg.PointF,    //(0,0) -> (1,1)
    color:linalg.Point3DwF,
    len:uint,
}

@(private="file") freetypeLib:freetype.Library = nil

@(private="file") _Init_FreeType :: proc "contextless" () {
    err := freetype.init_free_type(&freetypeLib)
    if err != .Ok do trace.panic_log(err)
}

@(private) _Deinit_FreeType :: proc "contextless" () {
    err := freetype.done_free_type(freetypeLib)
    if err != .Ok do trace.panic_log(err)
    freetypeLib = nil
}

FreetypeErr :: freetype.Error

Font_Init :: proc(_fontData:[]byte, #any_int _faceIdx:int = 0) -> (font : ^Font = nil, err : FreetypeErr = .Ok)  {
    font_ := mem.new_non_zeroed(FontT)
    defer if err != .Ok do free(font_)

    font_.scale = SCALE_DEFAULT
    font_.mutex = {}

    font_.charArray = make_map( map[rune]CharData)

    if freetypeLib == nil do _Init_FreeType()

    err = freetype.new_memory_face(freetypeLib, raw_data(_fontData), auto_cast len(_fontData), auto_cast _faceIdx, &font_.face)
    defer if err != .Ok {
        err = freetype.done_face(font_.face)
    }
    if err != .Ok do return

    err = freetype.set_char_size(font_.face, 0, 16 * 256 * 64, 0, 0)
    if err != .Ok do return

    font = auto_cast font_
    return
}

Font_Deinit :: proc(self:^Font) -> (err : freetype.Error = .Ok) {
    self_:^FontT = auto_cast self
    sync.mutex_lock(&self_.mutex)

    err = freetype.done_face(self_.face)
    if err != .Ok do trace.panic_log(err)

    for key,value in self_.charArray {
        geometry.RawShape_Free(value.rawShape, engine.defAllocator())
    }
    delete(self_.charArray)
    sync.mutex_unlock(&self_.mutex)
    free(self_)

    return
}

Font_SetScale :: proc(self:^Font, scale:f32) {
    self_:^FontT = auto_cast self
    sync.mutex_lock(&self_.mutex)
    self_.scale = SCALE_DEFAULT / scale
    sync.mutex_unlock(&self_.mutex)
}

@(private="file") _Font_RenderString2 :: proc(_str:string,
_renderOpt:FontRenderOpt2,
vertList:^[dynamic]geometry.ShapeVertex2D,
indList:^[dynamic]u32,
allocator : runtime.Allocator) -> (rect:linalg.RectF, err:geometry.ShapesError = .None) {
    i : int = 0
    opt := _renderOpt.opt
    rectT : linalg.RectF
    rect = linalg.Rect_Init(f32(0.0), 0.0, 0.0, 0.0)

    for r in _renderOpt.ranges {
        opt.scale = _renderOpt.opt.scale * r.scale
        opt.color = r.color

        if r.len == 0 || i + auto_cast r.len >= len(_str) {
            _, rectT = _Font_RenderString(auto_cast r.font, _str[i:], opt, vertList, indList, allocator) or_return
            rect = linalg.Rect_Or(rect, rectT)
            break;
        } else {
            opt.offset, rectT = _Font_RenderString(auto_cast r.font, _str[i:i + auto_cast r.len], opt, vertList, indList, allocator) or_return
            rect = linalg.Rect_Or(rect, rectT)
            i += auto_cast r.len
        }
    }
    return
}

@(private="file") _Font_RenderString :: proc(self:^FontT,
    _str:string,
    _renderOpt:FontRenderOpt,
    _vertArr:^[dynamic]geometry.ShapeVertex2D,
    _indArr:^[dynamic]u32,
    allocator : runtime.Allocator) -> (pt:linalg.PointF, rect:linalg.RectF, err:geometry.ShapesError = .None) {

    maxP : linalg.PointF = {min(f32), min(f32)}
    minP : linalg.PointF = {max(f32), max(f32)}

    offset : linalg.PointF = {}

    sync.mutex_lock(&self.mutex)
    for s in _str {
        if _renderOpt.area != nil && offset.y <= _renderOpt.area.?.y do break
        if s == '\n' {
            offset.y -= f32(self.face.size.metrics.height) / (64.0 * self.scale) 
            offset.x = 0
            continue
        }
        minP = math.min_array(minP, offset)

        _Font_RenderChar(self, s, _vertArr, _indArr, &offset, _renderOpt.area, _renderOpt.scale, _renderOpt.color, allocator) or_return
        
        maxP = math.max_array(maxP,linalg.PointF{offset.x, offset.y + f32(self.face.size.metrics.height) / (64.0 * self.scale) })
    }
    sync.mutex_unlock(&self.mutex)

    size : linalg.PointF = _renderOpt.area != nil ? _renderOpt.area.? : (maxP - minP) * linalg.PointF{1,1}

    maxP = {min(f32), min(f32)}
    minP = {max(f32), max(f32)}

    for &v in _vertArr^ {
        v.pos -= _renderOpt.pivot * size * _renderOpt.scale
        v.pos += _renderOpt.offset

        minP = math.min_array(minP, v.pos)
        maxP = math.max_array(maxP, v.pos)
    }
    rect = linalg.Rect_Init_LTRB(minP.x, maxP.x, minP.y, maxP.y)

    subX :f32 = rect.pos.x + rect.size.x / 2.0
    subY :f32 = rect.pos.y + rect.size.y / 2.0
    for &v in _vertArr^ {
        v.pos.x -= subX
        v.pos.y -= subY
    }
    rect = linalg.Rect_Move(rect, linalg.PointF{subX, subY})

    pt = offset * _renderOpt.scale + _renderOpt.offset
    return
}

@(private="file") _Font_RenderChar :: proc(self:^FontT,
    _char:rune,
    _vertArr:^[dynamic]geometry.ShapeVertex2D,
    _indArr:^[dynamic]u32,
    offset:^linalg.PointF,
    area:Maybe(linalg.PointF),
    scale:linalg.PointF,
    color:linalg.Point3DwF,
    allocator : runtime.Allocator) -> (shapeErr:geometry.ShapesError = .None) {
    ok := _char in self.charArray
    charD : ^CharData

    FTMoveTo :: proc "c" (to: ^freetype.Vector, user: rawptr) -> c.int {
        data : ^FontUserData = auto_cast user
        data.pen = linalg.PointF{f32(to.x) / (64 * data.scale), f32(to.y) / (64 * data.scale)}

        if data.idx > 0 {
            data.polygon.nPolys[data.nPoly] = data.nPolyLen
            data.nPoly += 1
            data.polygon.nTypes[data.nTypes] = data.nTypesLen
            data.nTypes += 1
            data.nPolyLen = 0
            data.nTypesLen = 0
        }
        return 0
    }
    FTLineTo :: proc "c" (to: ^freetype.Vector, user: rawptr) -> c.int {
        data : ^FontUserData = auto_cast user
        end := linalg.PointF{f32(to.x) / (64 * data.scale), f32(to.y) / (64 * data.scale)}
    
        data.polygon.poly[data.idx] = data.pen
        data.polygon.types[data.typeIdx] = .Line
        data.pen = end
        data.idx += 1
        data.nPolyLen += 1
        data.typeIdx += 1
        data.nTypesLen += 1
        return 0
    }
    FTConicTo :: proc "c" (control: ^freetype.Vector, to: ^freetype.Vector, user: rawptr) -> c.int {
        data : ^FontUserData = auto_cast user
        ctl := linalg.PointF{f32(control.x) / (64 * data.scale), f32(control.y) / (64 * data.scale)}
        end := linalg.PointF{f32(to.x) / (64 * data.scale), f32(to.y) / (64 * data.scale)}
    
        data.polygon.poly[data.idx] = data.pen
        data.polygon.poly[data.idx+1] = ctl
        data.polygon.types[data.typeIdx] = .Quadratic
        data.pen = end
        data.idx += 2
        data.nPolyLen += 2
        data.typeIdx += 1
        data.nTypesLen += 1
        return 0
    }
    FTCubicTo :: proc "c" (control0, control1, to: ^freetype.Vector, user: rawptr) -> c.int {
        data : ^FontUserData = auto_cast user
        ctl0 := linalg.PointF{f32(control0.x) / (64 * data.scale), f32(control0.y) / (64 * data.scale)}
        ctl1 := linalg.PointF{f32(control1.x) / (64 * data.scale), f32(control1.y) / (64 * data.scale)}
        end := linalg.PointF{f32(to.x) / (64 * data.scale), f32(to.y) / (64 * data.scale)}
    
        data.polygon.poly[data.idx] = data.pen
        data.polygon.poly[data.idx+1] = ctl0
        data.polygon.poly[data.idx+2] = ctl1
        data.polygon.types[data.typeIdx] = .Unknown
        data.pen = end
        data.idx += 3
        data.nPolyLen += 3
        data.typeIdx += 1
        data.nTypesLen += 1
        return 0
    }
    FontUserData :: struct {
        pen : linalg.PointF,
        polygon : ^geometry.Shapes,
        idx : u32,
        nPoly : u32,
        nPolyLen : u32,
        nTypes : u32,
        nTypesLen : u32,
        typeIdx : u32,
        scale : f32,
    }
    @static funcs : freetype.Outline_Funcs = {
        move_to = FTMoveTo,
        line_to = FTLineTo,
        conic_to = FTConicTo,
        cubic_to = FTCubicTo,
    }

    if ok {
        charD = &self.charArray[_char]
    } else {
        ch := _char
        for {
            fIdx := freetype.get_char_index(self.face, auto_cast ch)
            if fIdx == 0 {
                if ch == '□' do trace.panic_log("not found □")
                ok = '□' in self.charArray
                if ok {
                    charD = &self.charArray['□']
                    break
                }
                ch = '□'

                continue
            }
            err := freetype.load_glyph(self.face, fIdx, {.No_Bitmap})
            if err != .Ok do trace.panic_log(err)

            if self.face.glyph.outline.n_points == 0 {
                charData : CharData = {
                    advanceX = f32(self.face.glyph.advance.x) / (64.0 * SCALE_DEFAULT),
                    rawShape = nil
                }
                self.charArray[ch] = charData

                charD = &self.charArray[ch]
                break
            }
    
            //TODO FT_Outline_New FT_Outline_Copy FT_Outline_Done로 임시객체로 복제하여 Lock Free 구현
            if freetype.outline_get_orientation(&self.face.glyph.outline) == freetype.Orientation.FILL_RIGHT {
                freetype.outline_reverse(&self.face.glyph.outline)
            }
        
            poly : geometry.Shapes = {
                nPolys = mem.make_non_zeroed([]u32, self.face.glyph.outline.n_contours),
                nTypes = mem.make_non_zeroed([]u32, self.face.glyph.outline.n_contours),
                types = mem.make_non_zeroed([]geometry.CurveType, self.face.glyph.outline.n_points*3),
                poly = mem.make_non_zeroed([]linalg.PointF, self.face.glyph.outline.n_points*3),
                colors = mem.make_non_zeroed([]linalg.Point3DwF, self.face.glyph.outline.n_contours),
            }
            for &c in poly.colors {
                c = linalg.Point3DwF{0,0,0,1}//?no matter
            }
            defer {
                delete(poly.nPolys, )
                delete(poly.nTypes, )
                delete(poly.types, )
                delete(poly.poly, )
                delete(poly.colors, )
            }
            data : FontUserData = {
                polygon = &poly,
                idx = 0,
                typeIdx = 0,
                nPolyLen = 0,
                nTypesLen = 0,
                scale = self.scale,
            }
        
            err = freetype.outline_decompose(&self.face.glyph.outline, &funcs, &data)
            if err != .Ok do trace.panic_log(err)

            charData : CharData
            if data.idx == 0 {
                charData = {
                    advanceX = f32(self.face.glyph.advance.x) / (64.0 * self.scale),
                    rawShape = nil
                }
                self.charArray[ch] = charData
            
                charD = &self.charArray[ch]
                break
            } else {
                sync.mutex_unlock(&self.mutex)
                defer sync.mutex_lock(&self.mutex)

                poly.nPolys[data.nPoly] = data.nPolyLen
                poly.nTypes[data.nTypes] = data.nTypesLen
                poly.poly = mem.resize_non_zeroed_slice(poly.poly, data.idx, )
                poly.types = mem.resize_non_zeroed_slice(poly.types, data.typeIdx, )
               
                poly.strokeColors = nil
                poly.thickness = nil

                rawP : ^geometry.RawShape
                rawP , shapeErr = geometry.Shapes_ComputePolygon(&poly, engine.defAllocator())//높은 부하 작업 High load operations
                if shapeErr != .None do return

                defer if shapeErr != .None {
                    geometry.RawShape_Free(rawP, engine.defAllocator())
                }

                charData = {
                    advanceX = f32(self.face.glyph.advance.x) / (64.0 * self.scale),
                    rawShape = rawP
                }
            }
            self.charArray[ch] = charData
            
            charD = &self.charArray[ch]
            break
        }
    }
    if area != nil && offset.x + charD.advanceX >= area.?.x {
        offset.y -= f32(self.face.size.metrics.height) / (64.0 * self.scale) 
        offset.x = 0
        if offset.y <= -area.?.y do return
    }
    if charD.rawShape != nil {
        vlen := len(_vertArr^)

        non_zero_resize_dynamic_array(_vertArr, vlen + len(charD.rawShape.vertices))
        runtime.mem_copy_non_overlapping(&_vertArr^[vlen], &charD.rawShape.vertices[0], len(charD.rawShape.vertices) * size_of(geometry.ShapeVertex2D))

        i := vlen
        for ;i < len(_vertArr^);i += 1 {
            _vertArr^[i].pos += offset^
            _vertArr^[i].pos *= scale
            if _vertArr^[i].color.a > 0.0 {
                _vertArr^[i].color = color
            }
        }

        ilen := len(_indArr^)
        non_zero_resize_dynamic_array(_indArr, ilen + len(charD.rawShape.indices))
        runtime.mem_copy_non_overlapping(&_indArr^[ilen], &charD.rawShape.indices[0], len(charD.rawShape.indices) * size_of(u32))

        i = ilen
        for ;i < len(_indArr^);i += 1 {
            _indArr^[i] += auto_cast vlen
        }
    }
    offset.x += charD.advanceX

    return
}

Font_RenderString2 :: proc(_str:string, _renderOpt:FontRenderOpt2, allocator := context.allocator) -> (res:^geometry.RawShape, err:geometry.ShapesError = .None)  {
    vertList := make([dynamic]geometry.ShapeVertex2D, allocator)
    indList := make([dynamic]u32, allocator)

    _Font_RenderString2(_str, _renderOpt, &vertList, &indList, allocator) or_return
    shrink(&vertList)
    shrink(&indList)
    res = new (geometry.RawShape, allocator)
    res^ = {
        vertices = vertList[:],
        indices = indList[:],
    }
    return
}

Font_RenderString :: proc(self:^Font, _str:string, _renderOpt:FontRenderOpt, allocator := context.allocator) -> (res:^geometry.RawShape, err:geometry.ShapesError = .None) {
    vertList := make([dynamic]geometry.ShapeVertex2D, allocator)
    indList := make([dynamic]u32, allocator)

    _, rect := _Font_RenderString(auto_cast self, _str, _renderOpt, &vertList, &indList, allocator) or_return

    shrink(&vertList)
    shrink(&indList)
    res = new (geometry.RawShape, allocator)
    res^ = {
        vertices = vertList[:],
        indices = indList[:],
        rect = rect,
    }
    return
}