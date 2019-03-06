data:extend({
    {
        type = 'sprite',
        name = 'bpd-enter-icon-small',
        filename = '__blueprint-designer__/graphics/icons/enter-icon-small.png',
        width = 16,
        height = 16
    },
    {
        type = 'sprite',
        name = 'bpd-delete-icon-small',
        filename = '__blueprint-designer__/graphics/icons/delete-icon-small.png',
        width = 16,
        height = 16
    }
})

data.raw['gui-style'].default['bpd-small-sprite-button'] = {
    type = 'button_style',
    parent = 'button',
    width = 16,
    height = 16
}
