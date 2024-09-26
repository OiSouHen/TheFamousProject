-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("pause")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Pause = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("PauseBreak",function()
	if not exports["lb-phone"]:IsOpen() and not Pause and not IsPauseMenuActive() then
		Pause = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hud:Active",false)
		SendNUIMessage({ Action = "Open" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	Pause = false
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Skinweapon",function(Data,Callback)
	Pause = false
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)

	if LocalPlayer["state"]["Admin"] then
		TriggerEvent("skinweapon:Open")
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ActiveMap",function()
	ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE",0,-1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("PauseBreak","Abrir as configurações","keyboard","Escape")
RegisterKeyMapping("ActiveMap","Abrir o mapa","keyboard","P")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Disconnect",function(Data,Callback)
	vSERVER.Disconnect()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTINGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Settings",function(Data,Callback)
	Pause = false
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)
	ActivateFrontendMenu("FE_MENU_VERSION_LANDING_MENU",0,-1)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Map",function(Data,Callback)
	Pause = false
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)
	ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE",0,-1)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Premium",function(Data,Callback)
	Callback(Premium)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUMBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("PremiumBuy",function(Data,Callback)
	Callback(vSERVER.PremiumBuy(Data["Hierarchy"],Data["Selectables"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Home",function(Data,Callback)
	Callback(vSERVER.Home())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("StoreList",function(Data,Callback)
	Callback(vSERVER.StoreList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORESBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("StoreBuy",function(Data,Callback)
	if not LocalPlayer["state"]["Prison"] then
		Callback(vSERVER.StoreBuy(Data["Index"],Data["Amount"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BATTLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Battlepass",function(Data,Callback)
	Callback(vSERVER.Rolepass())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BATTLEPASSBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("BattlepassBuy",function(Data,Callback)
	Callback(vSERVER.RolepassBuy())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BATTLEPASSRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("BattlepassRescue",function(Data,Callback)
	if not LocalPlayer["state"]["Prison"] then
		Callback(vSERVER.RolepassRescue(Data["Mode"],Data["Number"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Boxes",function(Data,Callback)
	Callback(Boxes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("OpenBox",function(Data,Callback)
	Callback(vSERVER.OpenBox(Data))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKETPLACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Marketplace",function(Data,Callback)
	Callback(vSERVER.Marketplace())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKETPLACEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MarketplaceInventory",function(Data,Callback)
	Callback(vSERVER.MarketplaceInventory(Data["Mode"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKETPLACEANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MarketplaceAnnounce",function(Data,Callback)
	Callback(vSERVER.MarketplaceAnnounce(Data))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKETPLACEBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MarketplaceBuy",function(Data,Callback)
	Callback(vSERVER.MarketplaceBuy(Data["Id"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKETPLACECANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MarketplaceCancel",function(Data,Callback)
	Callback(vSERVER.MarketplaceCancel(Data["Id"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAUSE:NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("pause:Notify")
AddEventHandler("pause:Notify",function(Title,Message,Type)
	SendNUIMessage({ Action = "Notify", Payload = { Title,Message,Type } })
end)