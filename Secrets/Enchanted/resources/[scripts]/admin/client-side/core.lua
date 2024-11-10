-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vSERVER = Tunnel.getInterface("admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportWay()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Ped = GetVehiclePedIsUsing(Ped)
    end

	local Wayblip = GetFirstBlipInfoId(8)
	local Coordsblip = GetBlipCoords(Wayblip)
	if DoesBlipExist(Wayblip) then
		for Number = 1,1000 do
			SetEntityCoordsNoOffset(Ped,Coordsblip["x"],Coordsblip["y"],Number + 0.0,1,0,0)

			RequestCollisionAtCoord(Coordsblip["x"],Coordsblip["y"],Coordsblip["z"])
			while not HasCollisionLoadedAroundEntity(Ped) do
				Wait(1)
			end

			if GetGroundZFor_3dCoord(Coordsblip["x"],Coordsblip["y"],Number + 0.0) then
				break
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportLimbo()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,Node = GetNthClosestVehicleNode(Coords["x"],Coords["y"],Coords["z"],1,0,0,0)

	SetEntityCoords(Ped,Node["x"],Node["y"],Node["z"] + 1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:Tuning")
AddEventHandler("admin:Tuning",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		SetVehicleModKit(Vehicle,0)
		ToggleVehicleMod(Vehicle,18,true)
		SetVehicleMod(Vehicle,11,GetNumVehicleMods(Vehicle,11) - 1,false)
		SetVehicleMod(Vehicle,12,GetNumVehicleMods(Vehicle,12) - 1,false)
		SetVehicleMod(Vehicle,13,GetNumVehicleMods(Vehicle,13) - 1,false)
		SetVehicleMod(Vehicle,15,GetNumVehicleMods(Vehicle,15) - 1,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			vSERVER.buttonTxt()
-- 		end
-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Markers = {}
local DefaultLeft = 2.0
local ConfigRace = false
local DefaultRight = -2.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGRACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("configrace",function(source,Message)
	if LocalPlayer["state"]["Admin"] then
		for _,v in pairs(Markers) do
			if DoesBlipExist(v["Blip"]) then
				RemoveBlip(v["Blip"])
			end
		end

		local NameRace = "nulled"
		if not ConfigRace and Message[1] then
			NameRace = Message[1]
		end

		Markers = {}
		DefaultLeft = 2.0
		DefaultRight = -2.0
		ConfigRace = not ConfigRace

		while ConfigRace do
			Wait(1)

			local Ped = PlayerPedId()
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Left = GetOffsetFromEntityInWorldCoords(Vehicle,DefaultLeft,5.0,0.0)
			local Right = GetOffsetFromEntityInWorldCoords(Vehicle,DefaultRight,5.0,0.0)
			local Center = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,5.0,0.0)

			if IsDisabledControlPressed(1,10) then
				DefaultLeft = DefaultLeft + 0.1
				DefaultRight = DefaultRight - 0.1
			end

			if IsDisabledControlPressed(1,11) then
				DefaultLeft = DefaultLeft - 0.1
				DefaultRight = DefaultRight + 0.1
			end

			if DefaultLeft < 2.0 then
				DefaultLeft = 2.0
			end

			if DefaultRight > -2.0 then
				DefaultRight = -2.0
			end

			if IsControlJustPressed(1,38) then
				local Number = #Markers + 1
				vSERVER.RaceConfig(Left,Center,Right,DefaultLeft * 0.80,NameRace)
				Markers[Number] = { ["Left"] = Left, ["Right"] = Right, ["Blip"] = nil }

				Markers[Number]["Blip"] = AddBlipForCoord(Center["x"],Center["y"],Center["z"])
				SetBlipSprite(Markers[Number]["Blip"],1)
				SetBlipColour(Markers[Number]["Blip"],2)
				SetBlipScale(Markers[Number]["Blip"],0.85)
				ShowNumberOnBlip(Markers[Number]["Blip"],Number)
				SetBlipAsShortRange(Markers[Number]["Blip"],true)
			end

			DrawMarker(1,Left["x"],Left["y"],Left["z"] - 100,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,200.0,88,101,242,175,0,0,0,0)
			DrawMarker(1,Right["x"],Right["y"],Right["z"] - 100,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,200.0,88,101,242,175,0,0,0,0)
			DrawMarker(1,Center["x"],Center["y"],Center["z"] -100,0.0,0.0,0.0,0.0,0.0,0.0,0.75,0.75,200.0,255,255,255,25,0,0,0,0)

			for _,v in pairs(Markers) do
				DrawMarker(1,v["Left"]["x"],v["Left"]["y"],v["Left"]["z"] - 100,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,200.0,0,255,0,100,0,0,0,0)
				DrawMarker(1,v["Right"]["x"],v["Right"]["y"],v["Right"]["z"] - 100,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,200.0,0,255,0,100,0,0,0,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)

		LocalPlayer["state"]:set("Spectate",true,false)
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		LocalPlayer["state"]:set("Spectate",false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Quake",nil,function(Name,Key,Value)
	ShakeGameplayCam("SKY_DIVING_SHAKE",1.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Limparea(Coords)
	ClearAreaOfPeds(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfCops(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfObjects(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearAreaOfProjectiles(Coords["x"],Coords["y"],Coords["z"],100.0,0)
	ClearArea(Coords["x"],Coords["y"],Coords["z"],100.0,true,false,false,false)
	ClearAreaOfVehicles(Coords["x"],Coords["y"],Coords["z"],100.0,false,false,false,false,false)
	ClearAreaLeaveVehicleHealth(Coords["x"],Coords["y"],Coords["z"],100.0,false,false,false,false)
end