-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("player",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
local inTrash = false
local BoostFPS = false
local Residuals = false
local DeathUpdate = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function()
	if exports["chat"]:Open() then
		BoostFPS = not BoostFPS

		if BoostFPS then
			SetTimecycleModifier("cinema")
			TriggerEvent("Notify","Otimização","Sistema ativado.","amarelo",5000)
		else
			ClearTimecycleModifier()
			TriggerEvent("Notify","Otimização","Sistema desativado.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROPE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Carry"] or LocalPlayer["state"]["Handcuff"] or IsEntityPlayingAnim(Ped,"missfinale_c2mcs_1","fin_c2_mcs_1_camman",3) then
			TimeDistance = 1
			DisableControlAction(0,18,true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,55,true)
			DisableControlAction(0,76,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,102,true)
			DisableControlAction(0,179,true)
			DisableControlAction(0,203,true)
			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			TimeDistance = 100

			local Vehicle = GetVehiclePedIsIn(Ped)
			if GetPedInVehicleSeat(Vehicle,0) == Ped and not GetIsTaskActive(Ped,164) and GetIsTaskActive(Ped,165) then
				SetPedIntoVehicle(Ped,Vehicle,0)
				SetPedConfigFlag(Ped,184,true)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:VEHICLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:VehicleHood")
AddEventHandler("player:VehicleHood",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,4,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:VEHICLEDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:VehicleDoors")
AddEventHandler("player:VehicleDoors",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,5,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINDOWS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("player:Windows",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		Entity(Vehicle)["state"]:set("Windows",not Entity(Vehicle)["state"]["Windows"],true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Windows",nil,function(Name,Key,Value)
	local Network = parseInt(Name:gsub("entity:",""))
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToVeh(Network)
		if DoesEntityExist(Vehicle) then
			if Value then
				RollDownWindow(Vehicle,0)
				RollDownWindow(Vehicle,1)
				RollDownWindow(Vehicle,2)
				RollDownWindow(Vehicle,3)
			else
				RollUpWindow(Vehicle,0)
				RollUpWindow(Vehicle,1)
				RollUpWindow(Vehicle,2)
				RollUpWindow(Vehicle,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
local DoorNumber = {
	["1"] = 0,
	["2"] = 1,
	["3"] = 2,
	["4"] = 3,
	["5"] = 5,
	["6"] = 4
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(Network,Active)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) and GetVehicleDoorLockStatus(Vehicle) <= 1 then
			if DoorNumber[Active] then
				if GetVehicleDoorAngleRatio(Vehicle,DoorNumber[Active]) == 0 then
					SetVehicleDoorOpen(Vehicle,DoorNumber[Active],0,0)
				else
					SetVehicleDoorShut(Vehicle,DoorNumber[Active],0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(Index)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		if Index == "0" then
			if IsVehicleSeatFree(Vehicle,-1) then
				SetPedIntoVehicle(Ped,Vehicle,-1)
			end
		elseif Index == "1" then
			if IsVehicleSeatFree(Vehicle,0) then
				SetPedIntoVehicle(Ped,Vehicle,0)
			end
		else
			for Seat = 1,10 do
				if IsVehicleSeatFree(Vehicle,Seat) then
					SetPedIntoVehicle(Ped,Vehicle,Seat)
					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 and not LocalPlayer["state"]["Carry"] and not IsEntityPlayingAnim(Ped,"mp_arresting","idle",3) then
			if LoadAnim("mp_arresting") then
				TaskPlayAnim(Ped,"mp_arresting","idle",8.0,8.0,-1,49,1,0,0,0)
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDUALS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Residuals()
	return Residuals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RESIDUALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Residual")
AddEventHandler("player:Residual",function(Informations)
	if Informations then
		if not Residuals then
			Residuals = {}
		end

		Residuals[Informations] = true
	else
		Residuals = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveVehicle()
	if not LocalPlayer["state"]["Bennys"] then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			TaskLeaveVehicle(Ped,GetVehiclePedIsUsing(Ped),0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PlaceVehicle(Network)
	if not LocalPlayer["state"]["Bennys"] and NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			local Seating = 10
			local Ped = PlayerPedId()

			repeat
				Seating = Seating - 1

				if IsVehicleSeatFree(Vehicle,Seating) then
					SetPedIntoVehicle(Ped,Vehicle,Seating)
					Seating = true
					vRP.Destroy()
				end
			until Seating == true or Seating == 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,Message)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) and exports["chat"]:Open() then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped and not IsEntityInAir(Vehicle) and (GetEntitySpeed(Vehicle) * 2.236936) >= 10 then
			if not Message[1] then
				SetEntityMaxSpeed(Vehicle,GetVehicleEstimatedMaxSpeed(Vehicle))
				TriggerEvent("Notify","Sucesso","Controle de cruzeiro desativado.","verde",5000)
			else
				if parseInt(Message[1]) > 10 then
					SetEntityMaxSpeed(Vehicle,0.45 * Message[1])
					TriggerEvent("Notify","Sucesso","Controle de cruzeiro ativado.","verde",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEATHUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("player:DeathUpdate",function(Status)
	DeathUpdate = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	local Victim,Attacker,Index = Message[1],Message[2],NetworkGetPlayerIndexFromPed(Message[2])
	if Event == "CEventNetworkEntityDamage" and not DeathUpdate and Victim == PlayerPedId() and IsEntityAPed(Victim) and GetEntityHealth(Victim) <= 100 and NetworkIsPlayerConnected(Index) then
		TriggerServerEvent("player:Death",GetPlayerServerId(Index))
		DeathUpdate = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(Entity)
	local Ped = PlayerPedId()
	if not inTrunk and GetEntityHealth(Ped) > 100 then
		AttachEntityToEntity(Ped,Entity[3],-1,0.0,-2.2,0.5,0.0,0.0,0.0,true,true,false,true,2,true)
		LocalPlayer["state"]:set("Commands",true,true)
		SetEntityVisible(Ped,false,0)
		inTrunk = true

		while inTrunk do
			local Ped = PlayerPedId()
			local Vehicle = GetEntityAttachedTo(Ped)
			if DoesEntityExist(Vehicle) then
				DisablePlayerFiring(Ped,true)
				DisableControlAction(0,23,true)

				if IsEntityVisible(Ped) then
					SetEntityVisible(Ped,false,0)
				end

				if IsControlJustPressed(1,38) then
					TriggerEvent("player:checkTrunk")
				end
			else
				TriggerEvent("player:checkTrunk")
			end

			if GetEntityHealth(Ped) <= 100 then
				TriggerEvent("player:checkTrunk")
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	if inTrunk then
		local Ped = PlayerPedId()
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,-1.25,-0.25)

		SetEntityVisible(Ped,true,0)
		DetachEntity(Ped,false,false)
		LocalPlayer["state"]:set("Commands",false,true)
		SetEntityCoords(Ped,Coords,false,false,false,false)

		inTrunk = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash",function(Entity)
	if not inTrash then
		local Ped = PlayerPedId()

		LocalPlayer["state"]:set("Commands",true,true)
		SetEntityCoords(Ped,Entity[4],false,false,false,false)
		FreezeEntityPosition(Ped,true)
		SetEntityVisible(Ped,false,0)

		inTrash = GetOffsetFromEntityInWorldCoords(Entity[1],0.0,-1.5,0.0)

		while inTrash do
			local Ped = PlayerPedId()

			if GetFollowPedCamViewMode() ~= 2 then
				SetFollowPedCamViewMode(2)
			end

			DisablePlayerFiring(Ped,true)
			DisableControlAction(0,23,true)

			if IsControlJustPressed(1,38) or GetEntityHealth(Ped) <= 100 then
				TriggerEvent("player:checkTrash")
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	if inTrash then
		local Ped = PlayerPedId()

		SetEntityVisible(Ped,true,0)
		FreezeEntityPosition(Ped,false)
		LocalPlayer["state"]:set("Commands",false,true)
		SetEntityCoords(Ped,inTrash,false,false,false,false)

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Policia",("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
	SetRelationshipBetweenGroups(1,GetHashKey("COP"),GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("COP"))

	SetRelationshipBetweenGroups(1,GetHashKey("ARMY"),GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("ARMY"))

	SetRelationshipBetweenGroups(1,GetHashKey("PRISONER"),GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("PRISONER"))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar",function()
	local Ped = PlayerPedId()
	if IsPedInAnyBoat(Ped) and exports["chat"]:Open() then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if CanAnchorBoatHere(Vehicle) then
			SetBoatAnchor(Vehicle,false)
			SetBoatFrozenWhenAnchored(Vehicle,false)
			SetForcedBoatLocationWhenAnchored(Vehicle,false)
			TriggerEvent("Notify","Sucesso","Embarcação desancorada.","verde",5000)
		else
			SetBoatAnchor(Vehicle,true)
			SetBoatFrozenWhenAnchored(Vehicle,true)
			SetForcedBoatLocationWhenAnchored(Vehicle,true)
			TriggerEvent("Notify","Sucesso","Embarcação ancorada.","verde",5000)
		end
	end
end)