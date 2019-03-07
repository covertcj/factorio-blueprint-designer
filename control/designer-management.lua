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
    
    local e = surface.create_entity{name = "electric-energy-interface", position = {0, 0}, force = player.force}
    e.minable = false
    
    e = surface.create_entity{name = "big-electric-pole", position = {5, 0}, force = player.force}
    e.minable = false
    e = surface.create_entity{name = "medium-electric-pole", position = {2, 0}, force = player.force}
    e.minable = false
    
    e = surface.create_entity{name = "infinity-chest", position = {-3, -1}, force = player.force}
    e.minable = false
    e = surface.create_entity{name = "express-loader", position = {-3, 1}, force = player.force, direction = defines.direction.south}
    e.minable = false
    
    global.designers[name] = new_designer
    refresh_designer_list(player)
end

function delete_designer(player, name)
    local surface_name = 'bpd_' .. name
    
    for _, p in pairs(game.players) do
        if p.surface.name == surface_name then
            exit_designer(p)
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
    
    if settings.get_player_settings(player)['bpd-designer-announce'].value then
        player.print('Enterig Designer: ' .. name)
    end
    
    if not is_in_designer(player) then
        global.player_characters[player.index] = player.character
        player.character = nil
    end
    
    local surface = game.surfaces['bpd_' .. name]
    local always_day = settings.global['bpd-designer-always-day'].value
    surface.freeze_daytime = always_day
    if always_day then
        surface.daytime = 0
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
