RegisterNetEvent("sounds:Private")
AddEventHandler("sounds:Private",function(sound,volume)
	SendNUIMessage({ transactionType = "playSound", transactionFile = sound, transactionVolume = volume })
end)