function starts_with(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function remove_prefix(str, prefix)
    if starts_with(str, prefix) then
        return str:sub(#prefix + 1, -1)
    else
        return nil
    end
end
