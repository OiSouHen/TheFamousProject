-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("admin", Hensa)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Spectate = {}
Blips = false
Checkpoint = 0
LastSave = os.time() + 300
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Quake"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEAUTO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60000)

		if os.time() >= LastSave then
			TriggerEvent("SaveServer",true)
			LastSave = os.time() + 300
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Doords")
AddEventHandler("admin:Doords",function(Coords,Model,Heading)
	vRP.Archive("coordenadas.txt","Coords = "..Coords..", Hash = "..Model..", Heading = "..Heading)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",SplitUnique(Coords["x"])..","..SplitUnique(Coords["y"])..","..SplitUnique(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COPYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:CopyCoords")
AddEventHandler("admin:CopyCoords",function(Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vKEYBOARD.Copy(source,"Cordenadas:",SplitUnique(Coords["x"])..","..SplitUnique(Coords["y"])..","..SplitUnique(Coords["z"]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",SplitUnique(Coords["x"])..","..SplitUnique(Coords["y"])..","..SplitUnique(Coords["z"])..","..SplitUnique(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RaceConfig(Left,Center,Right,Distance)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Archive(Passport..".txt","{")

		vRP.Archive(Passport..".txt","['Left'] = vec3("..SplitUnique(Left["x"])..","..SplitUnique(Left["y"])..","..SplitUnique(Left["z"]).."),")
		vRP.Archive(Passport..".txt","['Center'] = vec3("..SplitUnique(Center["x"])..","..SplitUnique(Center["y"])..","..SplitUnique(Center["z"]).."),")
		vRP.Archive(Passport..".txt","['Right'] = vec3("..SplitUnique(Right["x"])..","..SplitUnique(Right["y"])..","..SplitUnique(Right["z"]).."),")
		vRP.Archive(Passport..".txt","['Distance'] = "..Distance)

		vRP.Archive(Passport..".txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEVTOOLSKICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:DevToolsKick")
AddEventHandler("admin:DevToolsKick", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Kick(source,"Expulso da cidade.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)