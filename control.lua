require 'util.strings'

require 'control.gui.designer-list'
require 'control.designer-management'

script.on_init(function()
    init_designers()
    init_designer_list()
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
        hide_designer_list(player)
    elseif starts_with(ev.element.name, 'blueprint-designer-list-enter-') then
        local name = remove_prefix(ev.element.name, 'blueprint-designer-list-enter-')
        player.print('Enter: ' .. name)
    elseif starts_with(ev.element.name, 'blueprint-designer-list-delete-') then
        local name = remove_prefix(ev.element.name, 'blueprint-designer-list-delete-')
        player.print('Delete: ' .. name)
    end
end)
