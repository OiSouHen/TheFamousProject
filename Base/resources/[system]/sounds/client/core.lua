-----------------------------------------------------------------------------------------------------------------------------------------
-- SOUNDS:PRIVATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sounds:Private")
AddEventHandler("sounds:Private",function(Sound,Volume)
	SendNUIMessage({ transactionType = "playSound", transactionFile = Sound, transactionVolume = Volume })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOUNDS:AREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sounds:Area")
AddEventHandler("sounds:Area",function(Sound,Volume,OtherCoords,Distance,Route)
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	if (not Route or (Route and LocalPlayer["state"]["Route"] == Route)) and #(Coords - OtherCoords) <= Distance then
		SendNUIMessage({ transactionType = "playSound", transactionFile = Sound, transactionVolume = Volume })
	end
end)