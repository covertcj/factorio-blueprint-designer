require 'gui.designer-list'

function init_designers()
    global.designers = {}
    global.last_designer = {}
    global.player_characters = {}
end

function create_designer(player, name)
    player.print('Creating Designer: ' .. name, {r = 0, g = 1, b = 0, a = 1})
    local new_designer = {
        name = name,
        surface = 'bpd_' .. name
    }
    
    local radius = settings.startup['bpd-designer-radius'].value
    local radius_tiles = radius * 32
    local surface = game.create_surface(new_designer.surface, {
        width = radius_tiles,
        height = radius_tiles
    })
    
    for x = -radius, radius do
        for y = -radius, radius do
            surface.set_chunk_generated_status({x, y}, defines.chunk_generated_status.entities)
        end
    end
    
    local tiles = {}
    for x = -radius_tiles, radius_tiles - 1 do
        for y = -radius_tiles, radius_tiles - 1 do
            if (x + y) % 2 == 0 then
                table.insert(tiles, {name = "lab-dark-1", position = {x, y}})
            else
                table.insert(tiles, {name = "lab-dark-2", position = {x, y}})
            end
        end
    end
    surface.set_tiles(tiles)
    
    global.designers[name] = new_designer
    refresh_designer_list(player)
end

function delete_designer(player, name)
    local surface_name = 'bpd_' .. name
    
    for _, player in ipairs(game.players) do
        if player.surface.name == surface_name then
            exit_designer(player)
        end
    end
    
    game.delete_surface(game.surfaces[surface_name])
    
    player.print('Deleted Designer: ' .. name, {r = 0.75, g = 0.25, b = 0.25, a = 1})
    global.designers[name] = nil
    refresh_designer_list(player)
end

function enter_designer(player, name)
    if name == nil then
        name = global.last_designer[player.index]
    end

    if name ~= nil and game.surfaces[name] == nil then
        name = nil
    end

    if name == nil then
        name = next(global.designers)
    end

    if name == nil then
        name = 'default'
        create_designer(player, name)
    end

    global.last_designer[player.index] = name

    player.print('Enterig Designer: ' .. name)
    
    if not is_in_designer(player) then
        global.player_characters[player.index] = player.character
        player.character = nil
    end
    
    if settings.startup['bpd-designer-always-day'].value then
        game.surfaces['bpd_' .. name].freeze_daytime = true
    end

    player.teleport({0, 0}, 'bpd_' .. name)
    player.cheat_mode = true
end

function exit_designer(player)
    if not is_in_designer(player) then return end
    
    player.cheat_mode = false
    
    local character = global.player_characters[player.index]
    player.teleport({0, 0}, character.surface)
    player.character = character
end

function is_in_designer(player)
    return starts_with(player.surface.name, 'bpd_')
end
