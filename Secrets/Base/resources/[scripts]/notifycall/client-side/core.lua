-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("NotifyCall",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPauseMenuActive() then
		SendNUIMessage({ name = "Open" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("NotifyCall","Consultar as notificações.","keyboard","F2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(Data)
	local Blip = AddBlipForCoord(Data["x"],Data["y"],Data["z"])
	local Road = GetStreetNameAtCoord(Data["x"],Data["y"],Data["z"])
	Data["street"] = GetStreetNameFromHashKey(Road)

	SendNUIMessage({ name = "New", payload = Data })

	SetBlipSprite(Blip,270)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,Data["color"])
	SetBlipScale(Blip,0.9)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Data["title"])
	EndTextCommandSetBlipName(Blip)

	SetTimeout(60000,function()
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function(Data,Callback)
	SetNuiFocus(true,true)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAYPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Waypoint",function(Data,Callback)
	SetNewWaypoint(Data["x"] + 0.0001,Data["y"] + 0.0001)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Phone",function(Data,Callback)
	exports["lb-phone"]:CreateCall({ number = Data["phone"] })

	Callback("Ok")
end)