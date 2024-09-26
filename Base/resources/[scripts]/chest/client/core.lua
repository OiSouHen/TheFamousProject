-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	{ ["Name"] = "Policia", ["Coords"] = vec3(486.46,-994.94,31.07),  ["Mode"] = "1" },
	{ ["Name"] = "Policia", ["Coords"] = vec3(1844.31,2573.84,46.26), ["Mode"] = "1" },
	{ ["Name"] = "Paramedico", ["Coords"] = vec3(306.17,-601.98,43.25),  ["Mode"] = "2" },
	{ ["Name"] = "Burgershot", ["Coords"] = vec3(-1194.02,-900.49,13.8), ["Mode"] = "2" },
	{ ["Name"] = "Tuners", ["Coords"] = vec3(-345.07,-127.91,39.19), ["Mode"] = "2" },
	{ ["Name"] = "Ottos", ["Coords"] = vec3(-1144.33,-2004.02,13.37), ["Mode"] = "2" },
	{ ["Name"] = "Ballas", ["Coords"] = vec3(94.76,-1984.01,20.66),  ["Mode"] = "2" },
	{ ["Name"] = "Families", ["Coords"] = vec3(-30.36,-1434.34,31.7),  ["Mode"] = "2" },
	{ ["Name"] = "Vagos", ["Coords"] = vec3(346.9,-2068.08,21.06),  ["Mode"] = "2" },
	{ ["Name"] = "Aztecas", ["Coords"] = vec3(513.26,-1802.72,28.71), ["Mode"] = "2" },
	{ ["Name"] = "Bloods", ["Coords"] = vec3(231.43,-1752.75,29.18), ["Mode"] = "2" },
	{ ["Name"] = "BurgershotTray01", ["Coords"] = vec3(-1190.85,-894.39,14.05), ["Mode"] = "3" },
	{ ["Name"] = "BurgershotTray02", ["Coords"] = vec3(-1192.82,-893.83,14.0), ["Mode"] = "3" },
	{ ["Name"] = "BurgershotTray03", ["Coords"] = vec3(-1194.79,-893.33,14.04), ["Mode"] = "3" },
	{ ["Name"] = "BurgershotTray04", ["Coords"] = vec3(-1196.81,-892.8,14.08), ["Mode"] = "3" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "shop",
			service = "Personal"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Compartimento Lider",
			tunnel = "shop",
			service = "Owner"
		},{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "shop",
			service = "Normal"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Tray"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],0.25,{
			name = "Chest:"..Name,
			heading = 0.0,
			useZ = true
		},{
			Distance = 1.35,
			shop = v["Name"],
			options = Labels[v["Mode"]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Open")
AddEventHandler("chest:Open",function(Name,Init,Item)
	if vSERVER.Permissions(Name,Init,Item) and GetEntityHealth(PlayerPedId()) > 100 then
		SetNuiFocus(true,true)
		SendNUIMessage({ Action = "Open" })
		TriggerEvent("sounds:Private","chest",0.35)

		if Init ~= "Item" then
			vRP.PlayAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() and not exports["hud"]:Wanted() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Update(Data["slot"],Data["target"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chest",function(Data,Callback)
	local Inventory,Chest,InvPeso,InvMaxPeso,ChestPeso,ChestMaxPeso,Slots = vSERVER.Chest()
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, invPeso = InvPeso, invMaxpeso = InvMaxPeso, chestPeso = ChestPeso, chestMaxpeso = ChestMaxPeso, Slots = Slots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(Action,invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ Action = Action, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Close")
AddEventHandler("chest:Close",function(Action)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
	vRP.Destroy()
end)