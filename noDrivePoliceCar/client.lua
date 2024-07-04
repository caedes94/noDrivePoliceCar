local policeVehicles = {
    "police",
    "police2",
    "police3",
    "police4",
    "policeb",
    "policet"
}

-- Fonction pour vérifier si le véhicule est un véhicule de police
function isPoliceVehicle(vehicleModel)
    for _, policeVehicle in ipairs(policeVehicles) do
        if GetHashKey(policeVehicle) == vehicleModel then
            return true
        end
    end
    return false
end

-- Vérifie si le joueur essaie de monter dans le siège conducteur d'un véhicule de police
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local vehicleModel = GetEntityModel(vehicle)
            local seat = GetPedInVehicleSeat(vehicle, -1)

            if isPoliceVehicle(vehicleModel) and seat == playerPed then
                TriggerServerEvent('checkPlayerJob')
            end
        end
    end
end)

RegisterNetEvent('preventDriverSeat')
AddEventHandler('preventDriverSeat', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local seat = GetPedInVehicleSeat(vehicle, -1)

        if seat == playerPed then
            TaskLeaveVehicle(playerPed, vehicle, 0)
            exports.bulletin:Send({
                message  = 'Vous ne pouvez pas conduire ce véhicule de police.',
                timeout  = 5000,
                position = 'bottomleft',
                progress = true
            })
        end
    end
end)
