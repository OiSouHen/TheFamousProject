-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Display = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("NotifyCall",function()
	if Display and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPauseMenuActive() then
		SendNUIMessage({ Action = "Open" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("NotifyCall","Consultar as notificações.","keyboard","F2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAYPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Waypoint",function(Data,Callback)
	SetNewWaypoint(Data["x"] + 0.0001,Data["y"] + 0.0001)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Phone",function(Data,Callback)
	exports["lb-phone"]:CreateCall({ number = Data["phone"] })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(Data)
	local Blip = AddBlipForCoord(Data["x"],Data["y"],Data["z"])
	local Road = GetStreetNameAtCoord(Data["x"],Data["y"],Data["z"])
	Data["street"] = GetStreetNameFromHashKey(Road)
	Display = true

	SendNUIMessage({ Action = "New", Payload = Data })

	SetBlipSprite(Blip,161)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,Data["color"])
	SetBlipScale(Blip,0.5)
	PulseBlip(Blip)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Data["title"])
	EndTextCommandSetBlipName(Blip)

	SetTimeout(60000,function()
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
		end
	end)
end)