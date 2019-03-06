function show_designer_list(player)
    local designer_list_frame = player.gui.center.add({type = 'frame', name = 'blueprint-designer-list-gui', direction = 'vertical'})
    global.designer_lists[player.index] = designer_list_frame
    
    local main_flow = designer_list_frame.add({type = 'flow', name = 'mainflow', direction = 'vertical'})
    local designers_flow = main_flow.add({type = 'flow', name = 'designersflow', direction = 'vertical'})
    local creation_flow = main_flow.add({type = 'flow', name = 'creationflow', direction = 'horizontal'})
    
    if next(global.designers) == nil then
        designers_flow.add({type = 'label', name = 'nodesigners', caption = {'bd.no-designers-yet'}})
    else
        for _, designer in pairs(global.designers) do
            local flow = designers_flow.add({type = 'flow', name = designer.name .. 'flow', direction = 'horizontal'})
            flow.add({type = 'label', name = designer.name .. 'label', caption = designer.name})

            flow.add({type = 'sprite-button', name = 'blueprint-designer-list-enter-' .. designer.name, sprite='bpd-enter-icon-small', style='bpd-small-sprite-button'})
            flow.add({type = 'sprite-button', name = 'blueprint-designer-list-delete-' .. designer.name, sprite='bpd-delete-icon-small', style='bpd-small-sprite-button'})
        end
    end
    
    creation_flow.add({type = 'textfield', name = 'designername', tooltip = {'bd.create-designer-field'}})
    creation_flow.add({type = 'button', name = 'blueprint-designer-create-designer', caption = {'bd.create-designer-button'}})
    
    player.opened = designer_list_frame
end
