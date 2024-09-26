-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Block = false
local Opened = false
local Animation = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	{ ["Name"] = "Policia", ["Coords"] = vec3(-791.88,-1226.85,6.41), ["Mode"] = "1" },
	{ ["Name"] = "Policia2", ["Coords"] = vec3(-1108.39,-824.54,14.56), ["Mode"] = "1" },
	{ ["Name"] = "Paramedico", ["Coords"] = vec3(-1266.26,348.24,65.65), ["Mode"] = "2" },
	{ ["Name"] = "Restaurante", ["Coords"] = vec3(-631.68,228.32,82.17), ["Mode"] = "2" },
	{ ["Name"] = "MecanicoLider", ["Coords"] = vec3(-1063.48,-2097.31,13.63), ["Mode"] = "2" },
	{ ["Name"] = "MecanicoMembro", ["Coords"] = vec3(-1068.16,-2101.91,13.66), ["Mode"] = "2" },
	{ ["Name"] = "Armas01", ["Coords"] = vec3(1271.19,-160.71,98.43), ["Mode"] = "2" },
	{ ["Name"] = "Armas02", ["Coords"] = vec3(595.38,924.55,233.9), ["Mode"] = "2" },
	{ ["Name"] = "Armas03", ["Coords"] = vec3(-236.9,3948.48,46.51), ["Mode"] = "2" },
	{ ["Name"] = "Municao01", ["Coords"] = vec3(-2675.01,1331.03,140.33), ["Mode"] = "2" },
	{ ["Name"] = "Municao02", ["Coords"] = vec3(2705.53,619.64,91.63), ["Mode"] = "2" },
	{ ["Name"] = "Municao03", ["Coords"] = vec3(-382.33,1586.44,351.64), ["Mode"] = "2" },
	{ ["Name"] = "Drogas01", ["Coords"] = vec3(715.75,-171.32,70.8), ["Mode"] = "2" },
	{ ["Name"] = "Drogas02", ["Coords"] = vec3(2181.29,-1157.18,167.63), ["Mode"] = "2" },
	{ ["Name"] = "Drogas03", ["Coords"] = vec3(2000.2,-10.14,203.58), ["Mode"] = "2" },
	{ ["Name"] = "Drogas04", ["Coords"] = vec3(545.31,2440.53,59.74), ["Mode"] = "2" },
	{ ["Name"] = "Desmanche01", ["Coords"] = vec3(1462.6,-718.03,86.23), ["Mode"] = "2" },
	{ ["Name"] = "Desmanche02", ["Coords"] = vec3(1525.76,1732.48,114.85), ["Mode"] = "2" },
	{ ["Name"] = "Roubos01", ["Coords"] = vec3(1734.19,1279.27,134.57), ["Mode"] = "2" },
	{ ["Name"] = "Lavagem01", ["Coords"] = vec3(1668.23,6511.28,37.85), ["Mode"] = "2" },
	{ ["Name"] = "Lavagem02", ["Coords"] = vec3(2200.96,4689.48,37.56), ["Mode"] = "2" },
	{ ["Name"] = "Lavagem03", ["Coords"] = vec3(-1894.68,2063.62,141.02), ["Mode"] = "2" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "client",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "client",
			service = "Personal"
		},{
			event = "chest:Armour",
			label = "Colete Balístico",
			tunnel = "server"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "client",
			service = "Normal"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "client",
			service = "Tray"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],0.25,{
			name = "Chest:"..Name,
			heading = 0.0,
			useZ = true
		},{
			Distance = 1.25,
			shop = v["Name"],
			options = Labels[v["Mode"]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Open")
AddEventHandler("chest:Open",function(Name,Mode,Item,Blocked,Force)
	if vSERVER.Permissions(Name,Mode,Item) and GetEntityHealth(PlayerPedId()) > 100 then
		if Blocked or SplitBoolean(Name,"Helicrash",":") then
			Block = true
		end

		Opened = true

		if Mode ~= "Item" then
			Animation = true
			vRP.playAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
		end

		TriggerEvent("inventory:Open",{
			Type = "Chest",
			Resource = "chest",
			Force = Force
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Item",function(Name)
	if vSERVER.Permissions(Name,"Item") and GetEntityHealth(PlayerPedId()) > 100 then
		Opened = true
		TriggerEvent("inventory:Open",{
			Type = "Chest",
			Resource = "chest"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:RECYCLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Recycle",function()
	if vSERVER.Permissions("Recycle","Tray") and GetEntityHealth(PlayerPedId()) > 100 then
		Opened = true
		TriggerEvent("inventory:Open",{
			Type = "Chest",
			Resource = "chest"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Opened then
		if Animation then
			Animation = false
			vRP.Destroy()
		end

		Opened = false
		Block = false
	end
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
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Block)
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
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Primary,Secondary,PrimaryWeight,SecondaryWeight,SecondarySlots = vSERVER.Mount()
	if Primary then
		Callback({ Primary = Primary, Secondary = Secondary, PrimaryMaxWeight = PrimaryWeight, SecondaryMaxWeight = SecondaryWeight, SecondarySlots = SecondarySlots })
	end
end)