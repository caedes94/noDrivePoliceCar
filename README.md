Ce script empêche les joueurs sans le métier de police, sheriff ou métiers similaires de conduire des véhicules de police, en utilisant le système de notification bulletin.

"Cela ne fonctionne que du côté conducteur."

Si vous ne souhaitez pas utiliser 'bulletin' comme système de notification, remplacez la ligne 45 côté client.lua par celle-ci .


       if seat == playerPed then
            TaskLeaveVehicle(playerPed, vehicle, 0)
            TriggerEvent('chat:addMessage', {
                args = { "Vous ne pouvez pas conduire ce véhicule de police." }
            })
