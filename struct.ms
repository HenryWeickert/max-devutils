-- 3dsmax development utilities



struct _DevUtilsStruct (
    public
    fn inherit name parent_struct_name mixin_struct_name =(
        -- Creates a new struct and inherits all attributes+methods
        -- from parent_struct_name as well as mixin_struct_name

        local base_struct = execute (parent_struct_name+"()")
        local mixin_struct = execute (mixin_struct_name+"()")

        local base_prop_names = (getPropNames base_struct())
        local mixin_prop_names = (getPropNames mixin_struct())

        local base_defintions_string = ""
        for prop in base_prop_names do (
            local prop_name = prop as string
            base_defintions_string += prop_name+" = _base."+prop_name+","
        )
        local mixin_definitions_string = ""
        for prop in mixin_prop_names do (
            local prop_name = prop as string
            mixin_definitions_string += prop_name+" = _mixin."+prop_name+","
        )

        local definitions_string = base_defintions_string + mixin_definitions_string
        last_definitions_character = substring definitions_string (definitions_string.count) -1
        if last_definitions_character == "," then (
            local definitions_string = substring definitions_string 1 (definitions_string.count-1)
        )

        local struct_definition_string = "
            struct "+name+"(
                _base = "+parent_struct_name+"(),
                _mixin = "+mixin_struct_name+"(),
                "+definitions_string+"
            )
        "
        execute (struct_definition_string)
        new_struct = execute(name)

        new_struct
    )
)

DevUtilsStruct = _DevUtilsStruct()
