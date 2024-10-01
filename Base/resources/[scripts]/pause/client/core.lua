-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("pause", Hensa)
vSERVER = Tunnel.getInterface("pause")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Pause = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Pause", function()
	if UsingLbPhone then
		if not Pause and not IsPauseMenuActive() and not exports["lb-phone"]:IsOpen() and not LocalPlayer["state"]["Bennys"] then
			Pause = true
			SetNuiFocus(true, true)
			SetCursorLocation(0.5, 0.5)
			TriggerScreenblurFadeIn(1)
			SendNUIMessage({ Action = "Open" })
		end
	else
		if not Pause and not IsPauseMenuActive() and not LocalPlayer["state"]["Bennys"] then
			Pause = true
			SetNuiFocus(true, true)
			SetCursorLocation(0.5, 0.5)
			TriggerScreenblurFadeIn(1)
			SendNUIMessage({ Action = "Open" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ActiveMap",function()
	ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE", 0, -1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Pause","Abrir as configurações","keyboard","Escape")
RegisterKeyMapping("ActiveMap","Abrir o mapa","keyboard","P")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Action", function(Data, Callback)
	if Data["action"] == "ActiveMap" then
		SetNuiFocus(false, false)
		ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE", 0, -1)
	elseif Data["action"] == "Settings" then
		SetNuiFocus(false, false)
		ActivateFrontendMenu("FE_MENU_VERSION_LANDING_MENU", 0, -1)
	elseif Data["action"] == "Disconnect" then
		SetNuiFocus(false, false)
		vSERVER.Disconnect()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	Pause = false
	SetNuiFocus(false, false)
	TriggerScreenblurFadeOut(1)
end)