package gui

import "base:intrinsics"
import "core:math/linalg"
import "core:math"
import "../"

pos_align_x :: enum {
    center,
    left,
    right,
}

pos_align_y :: enum {
    middle,
    top,
    bottom,
}

//do subtype to iobject
gui_component :: struct {
    gui_pos : linalg.PointF,
    gui_center_pt : linalg.PointF,
    gui_scale : linalg.PointF,
    gui_rotation : f32,
    gui_align_x : pos_align_x,
    gui_align_y : pos_align_y,
}

@(require_results, private="file") __base_mat :: #force_inline proc "contextless" (self:^$T, mul: linalg.PointF) -> Maybe(linalg.Matrix)
    where intrinsics.type_is_subtype_of(T, gui_component) && intrinsics.type_is_subtype_of(T, engine.IObject)  {
    return engine.SR_2D_Matrix2(self.gui_scale, self.gui_rotation, self.gui_center_pt * mul)
}

 gui_component_init :: proc (self:^$T)
    where intrinsics.type_is_subtype_of(T, gui_component) && intrinsics.type_is_subtype_of(T, engine.IObject)  {
    
    window_width :f32 = 2.0 / self.projection.mat[0, 0]
    window_height :f32 = 2.0 / self.projection.mat[1, 1]
    
    base : Maybe(linalg.Matrix) = nil
    mat : linalg.Matrix

    switch self.gui_align_x {
        case .left:
            switch self.gui_align_y {
                case .top:
                    base = __base_mat(self, linalg.PointF{1.0, -1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{-window_width / 2.0 + self.gui_pos.x, window_height / 2.0 - self.gui_pos.y, 0.0})
                case .middle:
                    base = __base_mat(self, linalg.PointF{1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{-window_width / 2.0 + self.gui_pos.x, self.gui_pos.y, 0.0})
                case .bottom:
                    base = __base_mat(self, linalg.PointF{1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{-window_width / 2.0 + self.gui_pos.x, -window_height / 2.0 + self.gui_pos.y, 0.0})     
            }
        case .center:
            switch self.gui_align_y {
                case .top:
                    base = __base_mat(self, linalg.PointF{1.0, -1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{self.gui_pos.x, window_height / 2.0 - self.gui_pos.y, 0.0})
                case .middle:
                    base = __base_mat(self, linalg.PointF{1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{self.gui_pos.x, self.gui_pos.y, 0.0})
                case .bottom:
                    base = __base_mat(self, linalg.PointF{1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{self.gui_pos.x, -window_height / 2.0 + self.gui_pos.y, 0.0})     
            }
        case .right:
            switch self.gui_align_y {
                case .top:
                    base = __base_mat(self, linalg.PointF{-1.0, -1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{window_width / 2.0 - self.gui_pos.x, window_height / 2.0 - self.gui_pos.y, 0.0})
                case .middle:
                    base = __base_mat(self, linalg.PointF{-1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{window_width / 2.0 - self.gui_pos.x, self.gui_pos.y, 0.0})
                case .bottom:
                    base = __base_mat(self, linalg.PointF{-1.0, 1.0})
                    mat = engine.__T_2D_Matrix(linalg.Point3DF{window_width / 2.0 - self.gui_pos.x, -window_height / 2.0 + self.gui_pos.y, 0.0})     
            }
    }

    self.mat = base != nil ? linalg.mul(mat, base.?) : mat
}

gui_component_size ::  proc (self:^$T)
    where intrinsics.type_is_subtype_of(T, gui_component) && intrinsics.type_is_subtype_of(T, engine.IObject) {
    gui_component_init(self)

    engine.IObject_UpdateTransformMatrix(auto_cast self)
}

