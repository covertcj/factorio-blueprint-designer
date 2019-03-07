data:extend({
    {
        type = 'int-setting',
        name = 'bpd-designer-radius',
        setting_type = 'startup',
        default_value = 8,
        minimum_value = 1,
        maximum_value = 50 
    },
    {
        type = 'bool-setting',
        name = 'bpd-designer-always-day',
        setting_type = 'runtime-global',
        default_value = true
    },
    {
        type = 'bool-setting',
        name = 'bpd-designer-announce',
        setting_type = 'runtime-per-user',
        default_value = true
    }
})