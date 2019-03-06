script.on_init(function()
    global.designers = {}
    global.designer_lists = {}
    global.last_designer = {}
end)

script.on_event(defines.events.on_player_created, function(ev)
    end)

script.on_event('open-designers-list', function(ev)
    show_designer_list(game.players[ev.player_index])
end)

script.on_event('open-designers-list-2', function(ev)
    game.players[ev.player_index].print('Oh yeah baby, that control')
end)

script.on_event(defines.events.on_gui_click, function(ev)
    local player = game.players[ev.player_index]
    
    if ev.element.name == 'blueprint-designer-create-designer' then
        local list = global.designer_lists[ev.player_index]
        if not list then return end
        
        local name_field = list.mainflow.creationflow.designername
        local name = name_field.text

        if name == '' or name == nil then
            player.print('You need to enter a designer name', {r = 1, g = 0, b = 0, a = 1})
            return
        end
        
        if global.designers[name] then
            player.print('There\'s already a designer named "' .. name .. '"', {r = 1, g = 0, b = 0, a = 1})
            return
        end
        
        create_designer(player, name)
        list.destroy()
    end
end)

function create_designer(player, name)
    player.print('Creating designer "' .. name .. '"', {r = 0, g = 1, b = 0, a = 1})
    local new_designer = {
        name = name,
        surface = 'bpd_' .. name
    }
    
    global.designers[name] = new_designer
end

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
