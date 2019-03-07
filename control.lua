require 'util.strings'

require 'control.gui.main-button'
require 'control.gui.designer-list'
require 'control.designer-management'

script.on_init(function()
    init_designers()
    init_designer_list()
end)

script.on_event(defines.events.on_player_created, function(ev)
    local player = game.players[ev.player_index]
    
    create_main_button(player)
end)

script.on_event('bpd-toggle-designers-list', function(ev)
    toggle_designer_list(game.players[ev.player_index])
end)

script.on_event('bpd-enter-designer', function(ev)
    local player = game.players[ev.player_index]
    hide_designer_list(player)
    
    if is_in_designer(player) then
        exit_designer(player)
    else
        enter_designer(player)
    end
end)

script.on_event(defines.events.on_gui_click, function(ev)
    local player = game.players[ev.player_index]
    
    if ev.element.name == 'bpd-list-close' then
        hide_designer_list(player)
    elseif ev.element.name == 'bpd-create-designer' then
        local name = designer_list_get_name_text(player)
        
        if name == '' or name == nil then
            player.print('You need to enter a designer name', {r = 1, g = 0, b = 0, a = 1})
            return
        end
        
        if global.designers[name] then
            player.print('There\'s already a designer named "' .. name .. '"', {r = 1, g = 0, b = 0, a = 1})
            return
        end
        
        create_designer(player, name)
    elseif starts_with(ev.element.name, 'bpd-list-enter-') then
        local name = remove_prefix(ev.element.name, 'blueprint-designer-list-enter-')
        hide_designer_list(player)
        enter_designer(player, name)
    elseif starts_with(ev.element.name, 'bpd-list-delete-') then
        local name = remove_prefix(ev.element.name, 'bpd-list-delete-')
        delete_designer(player, name)
    elseif ev.element.name == 'bpd-main-button' then
        toggle_designer_list(player)
    end
end)

script.on_event(defines.events.on_built_entity, function(ev)
    local player = game.players[ev.player_index]
    if not is_in_designer(player) then return end
    
    local type = ev.created_entity.type
    if type == 'entity-ghost' or type == 'tile-ghost' then
        local _, revived_entity, request = ev.created_entity.revive({return_item_request_proxy = true})

        if revived_entity and request then
            for name, count in pairs(request.item_requests) do
                revived_entity.insert { name = name, count = count }
            end

            request.destroy()
        end
    end
    
    if type == 'lab' then
        ev.created_entity.active = false
    end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(ev)
    local player = game.players[ev.player_index]
    if not is_in_designer(player) then return end
    
    ev.entity.destroy()
end)
