function init_designers()
    global.designers = {}
    global.last_designer = {}
end

function create_designer(player, name)
    player.print('Creating designer "' .. name .. '"', {r = 0, g = 1, b = 0, a = 1})
    local new_designer = {
        name = name,
        surface = 'bpd_' .. name
    }

    -- TODO: Create the designer's surface
    
    global.designers[name] = new_designer
end

function delete_designer(name)
    -- TODO: Destroy the designer's surface
    global.designers[name] = nil
end
