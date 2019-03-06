data:extend({
    {
        type = 'sprite',
        name = 'bpd-enter-icon-small',
        filename = '__blueprint-designer__/graphics/gui/enter-icon-small.png',
        width = 16,
        height = 16
    },
    {
        type = 'sprite',
        name = 'bpd-delete-icon-small',
        filename = '__blueprint-designer__/graphics/gui/delete-icon-small.png',
        width = 16,
        height = 16
    },
    {
        type = 'sprite',
        name = 'bpd-main-button',
        filename = '__blueprint-designer__/graphics/gui/main-button.png',
        width = 32,
        height = 32 
    }
})

data.raw['gui-style'].default['bpd-small-sprite-button'] = {
    type = 'button_style',
    parent = 'button',
    width = 16,
    height = 16
}
