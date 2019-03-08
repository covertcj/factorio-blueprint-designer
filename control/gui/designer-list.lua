global.designer_lists = global.designer_lists or {}
-- function init_designer_list()
--     global.designer_lists = global.designer_lists or {}
-- end

function toggle_designer_list(player)
    if global.designer_lists[player.index] then
        hide_designer_list(player)
    else
        show_designer_list(player)
    end
end

function refresh_designer_list(player)
    if not global.designer_lists[player.index] then return end

    generate_designer_table(global.designer_lists[player.index].mainflow.designersflow)
end

function show_designer_list(player)
    if global.designer_lists[player.index] then return end

    local designer_list_frame = player.gui.center.add({type = 'frame', name = 'bpd-list-gui', direction = 'vertical'})
    global.designer_lists[player.index] = designer_list_frame
    
    local main_flow = designer_list_frame.add({type = 'flow', name = 'mainflow', direction = 'vertical'})
    local designers_flow = main_flow.add({type = 'flow', name = 'designersflow', direction = 'vertical'})
    
    generate_designer_table(designers_flow)
    
    local creation_flow = main_flow.add({type = 'flow', name = 'creationflow', direction = 'horizontal'})
    creation_flow.add({type = 'textfield', name = 'designername', tooltip = {'bpd.create-designer-field'}})
    creation_flow.add({type = 'button', name = 'bpd-create-designer', caption = {'bpd.create-designer-button'}})
    creation_flow.add({type = 'button', name = 'bpd-list-close', caption = {'bpd.close-designer-list-button'}})
    
    player.opened = designer_list_frame
end

function generate_designer_table(parent)
    parent.clear()

    if next(global.designers) == nil then
        parent.add({type = 'label', name = 'nodesigners', caption = {'bpd.no-designers-yet'}})
    else
        local designer_table = parent.add({type = 'table', name = 'designertable', column_count=3})
        for _, designer in pairs(global.designers) do
            designer_table.add({type = 'label', name = designer.name .. 'label', caption = designer.name})

            designer_table.add({type = 'sprite-button', name = 'bpd-list-enter-' .. designer.name, sprite='bpd-enter-icon-small', style='bpd-small-sprite-button'})
            designer_table.add({type = 'sprite-button', name = 'bpd-list-delete-' .. designer.name, sprite='bpd-delete-icon-small', style='bpd-small-sprite-button'})
        end
    end
end

function hide_designer_list(player)
    local list = global.designer_lists[player.index]
    if not list then return end

    global.designer_lists[player.index] = nil
    list.destroy()
end

function designer_list_get_name_text(player)
    local list = global.designer_lists[player.index]
    if not list then return nil end
    
    local name_field = list.mainflow.creationflow.designername
    return name_field.text
end
