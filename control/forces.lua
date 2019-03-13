function get_player_forces()
    global.player_forces = global.player_forces or {}
    return global.player_forces
end

function get_designer_force(player)
    local force_name = player.force.name
    if not starts_with(force_name, 'bpd_force_') then
        force_name = 'bpd_force_' .. force_name
    end

    if game.forces[force_name] then
        return game.forces[force_name]
    end

    local force = game.create_force(force_name)
    force.research_all_technologies()
    force.set_friend(player.force, true)
    player.force.set_friend(force, true)
    
    return force
end

function apply_designer_force(player)
    get_player_forces()[player.index] = player.force
    player.force = get_designer_force(player)
end

function restore_player_force(player)
    local force = get_player_forces()[player.index]
    if force then
        player.force = force
    end
end
