ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Fonction pour vérifier si un joueur a un métier autorisé
function hasAuthorizedJob(xPlayer)
    local authorizedJobs = {
        "police",
        "sheriff",
        -- Ajoutez d'autres métiers autorisés ici
    }

    for _, job in ipairs(authorizedJobs) do
        if xPlayer.job.name == job then
            return true
        end
    end
    return false
end

RegisterServerEvent('checkPlayerJob')
AddEventHandler('checkPlayerJob', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if not hasAuthorizedJob(xPlayer) then
            TriggerClientEvent('preventDriverSeat', _source)
        end
    end
end)
