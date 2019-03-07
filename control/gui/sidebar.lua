require 'mod-gui'

function create_main_button(player)
    local parent = mod_gui.get_frame_flow(player)

    parent.add({ type = 'sprite-button', name = 'bpd-main-button', sprite='bpd-main-button', tooltip={'bpd.main-button'}})
end
