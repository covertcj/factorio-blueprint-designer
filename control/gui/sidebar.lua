require 'mod-gui'

global.sidebars = global.sidebars or {}
global.clear_buttons = global.clear_buttons or {}

function create_sidebar(player)
    if global.sidebars[player.index] then return end

    local parent = mod_gui.get_frame_flow(player)
    local sidebar = parent.add({ type = 'flow', name ='bpd-sidebar', direction='horizontal'})

    global.sidebars[player.index] = sidebar

    sidebar.add({ type = 'sprite-button', name = 'bpd-main-button', sprite='bpd-main-button', tooltip={'bpd.main-button'}})
end

function show_clear_button(player)
    if global.clear_buttons[player.index] then return end

    local sidebar = global.sidebars[player.index]
    global.clear_buttons[player.index] = sidebar.add({ type = 'button', name = 'bpd-clear-button', caption={'bpd.clear-button'}, tooltip={'bpd.clear-button-tooltip'}})
end

function hide_clear_button(player)
    local clear = global.clear_buttons[player.index]
    if clear then
        global.clear_buttons[player.index] = nil
        clear.destroy()
    end
end
