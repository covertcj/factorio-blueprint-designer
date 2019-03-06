require 'gui.designer-list'

function init_designers()
    global.designers = {}
    global.last_designer = {}
end

function create_designer(player, name)
    player.print('Creating Designer: ' .. name, {r = 0, g = 1, b = 0, a = 1})
    local new_designer = {
        name = name,
        surface = 'bpd_' .. name
    }

    -- TODO: Create the designer's surface
    
    global.designers[name] = new_designer
    refresh_designer_list(player)
end

function delete_designer(name)
    -- TODO: Destroy the designer's surface
    player.print('Deleted Designer: ' .. name, {r = 0.75, g = 0.25, b = 0.25, a =1})
    global.designers[name] = nil
end

function enter_desinger(player, name)
    player.print('Enterig Designer: ' .. name)
end
