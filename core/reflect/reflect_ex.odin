package reflect

import "base:runtime"
import "core:strings"


is_valid_enum_value :: proc "contextless" (enum_type: typeid, #any_int value: int) -> bool {
    info := runtime.type_info_base(type_info_of(enum_type))
    if v, ok := info.variant.(runtime.Type_Info_Enum); ok {
      for i in v.values {
        if i == runtime.Type_Info_Enum_Value(value) do return true
      }
    }
    return false
}

is_valid_enum_value_not_set :: proc "contextless" (enum_type: typeid, #any_int value: int) -> bool {
    info := runtime.type_info_base(type_info_of(enum_type))
    if v, ok := info.variant.(runtime.Type_Info_Enum); ok {
        max_value := len(v.values) - 1
        return value >= 0 && value <= max_value
    }
    return false
}

is_valid_enum_name :: proc "contextless" (enum_type: typeid, name: string) -> bool {
    info := runtime.type_info_base(type_info_of(enum_type))
    if v, ok := info.variant.(runtime.Type_Info_Enum); ok {
        for &enum_name in v.names {
            if strings.compare(enum_name, name) == 0 {
                return true
            }
        }
    }
    return false
}