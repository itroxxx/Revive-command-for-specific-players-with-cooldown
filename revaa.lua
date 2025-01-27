local allowedDiscordIDs = {
    "837909436659138611",
    "DISCORD_ID_2",
    "DISCORD_ID_3"
}

local cooldownTime = 900 -- cooldown aika
local lastReviveTime = {}

RegisterCommand('revaa', function(source, args, rawCommand)
    local player = source
    local discordID = GetPlayerIdentifiers(player)[3] 

    if isAllowed(discordID) then
        local currentTime = os.time()
        if lastReviveTime[player] == nil or (currentTime - lastReviveTime[player]) >= cooldownTime then
            TriggerClientEvent('ars_ambulancejob:healPlayer', player, { revive = true })
            lastReviveTime[player] = currentTime
            TriggerClientEvent('chat:addMessage', player, { args = { '^2Success', 'Revasit ittes!' } })
        else
            local remainingTime = cooldownTime - (currentTime - lastReviveTime[player])
            TriggerClientEvent('chat:addMessage', player, { args = { '^1Error', 'Cooldown päällä ' .. math.ceil(remainingTime / 60) .. ' minuuttia kunnes voit tehdä komennon uudelleen' } })
        end
    else
        TriggerClientEvent('chat:addMessage', player, { args = { '^1Error', 'Ei taida oikeudet riittää.' } })
    end
end, false)

function isAllowed(discordID)
    for _, id in ipairs(allowedDiscordIDs) do
        if discordID == "discord:" .. id then
            return true
        end
    end
    return false
end