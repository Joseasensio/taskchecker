
RegisterNetEvent("taskchecker:syncClothing", function(component, drawable, texture)
    local src = source
    --  Send all other players
    TriggerClientEvent("taskchecker:changeClothing", -1, src, component, drawable, texture)
end)