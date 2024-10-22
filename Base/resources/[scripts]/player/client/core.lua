-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("player",Hensa)
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
	local Ped = PlayerPedId()
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
function Hensa.Residuals()
	return Residuals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RESIDUAL
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
function Hensa.RemoveVehicle()
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
function Hensa.PlaceVehicle(Network)
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
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped and not IsEntityInAir(Vehicle) and (GetEntitySpeed(Vehicle) * 3.6) >= 10 then
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
-- HASHWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local HashWeapons = {
	[-1075685676] = "WEAPON_PISTOL_MK2",
	[126349499] = "WEAPON_SNOWBALL",
	[-270015777] = "WEAPON_ASSAULTSMG",
	[615608432] = "WEAPON_MOLOTOV",
	[2024373456] = "WEAPON_SMG_MK2",
	[-1810795771] = "WEAPON_POOLCUE",
	[-1813897027] = "WEAPON_GRENADE",
	[-598887786] = "WEAPON_MARKSMANPISTOL",
	[-1654528753] = "WEAPON_BULLPUPSHOTGUN",
	[-72657034] = "GADGET_PARACHUTE",
	[-102323637] = "WEAPON_BOTTLE",
	[2144741730] = "WEAPON_COMBATMG",
	[-1121678507] = "WEAPON_MINISMG",
	[-1652067232] = "WEAPON_SWEEPERSHOTGUN",
	[961495388] = "WEAPON_ASSAULTRIFLE_MK2",
	[-86904375] = "WEAPON_CARBINERIFLE_MK2",
	[-1786099057] = "WEAPON_BAT",
	[177293209] = "WEAPON_HEAVYSNIPER_MK2",
	[600439132] = "WEAPON_BALL",
	[1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
	[-1951375401] = "WEAPON_FLASHLIGHT",
	[171789620] = "WEAPON_COMBATPDW",
	[1593441988] = "WEAPON_COMBATPISTOL",
	[-2009644972] = "WEAPON_SNSPISTOL_MK2",
	[2138347493] = "WEAPON_FIREWORK",
	[1649403952] = "WEAPON_COMPACTRIFLE",
	[-619010992] = "WEAPON_MACHINEPISTOL",
	[-952879014] = "WEAPON_MARKSMANRIFLE",
	[317205821] = "WEAPON_AUTOSHOTGUN",
	[-1420407917] = "WEAPON_PROXMINE",
	[-1045183535] = "WEAPON_REVOLVER",
	[94989220] = "WEAPON_COMBATSHOTGUN",
	[-1658906650] = "WEAPON_MILITARYRIFLE",
	[1198256469] = "WEAPON_RAYCARBINE",
	[2132975508] = "WEAPON_BULLPUPRIFLE",
	[1627465347] = "WEAPON_GUSENBERG",
	[984333226] = "WEAPON_HEAVYSHOTGUN",
	[1233104067] = "WEAPON_FLARE",
	[-1716189206] = "WEAPON_KNIFE",
	[940833800] = "WEAPON_STONE_HATCHET",
	[1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
	[727643628] = "WEAPON_CERAMICPISTOL",
	[-1074790547] = "WEAPON_ASSAULTRIFLE",
	[-1169823560] = "WEAPON_PIPEBOMB",
	[324215364] = "WEAPON_MICROSMG",
	[-1834847097] = "WEAPON_DAGGER",
	[-1466123874] = "WEAPON_MUSKET",
	[-1238556825] = "WEAPON_RAYMINIGUN",
	[-1063057011] = "WEAPON_SPECIALCARBINE",
	[1470379660] = "WEAPON_GADGETPISTOL",
	[584646201] = "WEAPON_APPISTOL",
	[-494615257] = "WEAPON_ASSAULTSHOTGUN",
	[-771403250] = "WEAPON_HEAVYPISTOL",
	[1672152130] = "WEAPON_HOMINGLAUNCHER",
	[338557568] = "WEAPON_PIPEWRENCH",
	[1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
	[-1355376991] = "WEAPON_RAYPISTOL",
	[101631238] = "WEAPON_FIREEXTINGUISHER",
	[1119849093] = "WEAPON_MINIGUN",
	[883325847] = "WEAPON_PETROLCAN",
	[-102973651] = "WEAPON_HATCHET",
	[-275439685] = "WEAPON_DBSHOTGUN",
	[-1746263880] = "WEAPON_DOUBLEACTION",
	[-879347409] = "WEAPON_REVOLVER_MK2",
	[125959754] = "WEAPON_COMPACTLAUNCHER",
	[911657153] = "WEAPON_STUNGUN",
	[-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
	[-538741184] = "WEAPON_SWITCHBLADE",
	[100416529] = "WEAPON_SNIPERRIFLE",
	[-656458692] = "WEAPON_KNUCKLE",
	[-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
	[1737195953] = "WEAPON_NIGHTSTICK",
	[2017895192] = "WEAPON_SAWNOFFSHOTGUN",
	[-2067956739] = "WEAPON_CROWBAR",
	[-1312131151] = "WEAPON_RPG",
	[-1568386805] = "WEAPON_GRENADELAUNCHER",
	[205991906] = "WEAPON_HEAVYSNIPER",
	[1834241177] = "WEAPON_RAILGUN",
	[-1716589765] = "WEAPON_PISTOL50",
	[736523883] = "WEAPON_SMG",
	[1317494643] = "WEAPON_HAMMER",
	[453432689] = "WEAPON_PISTOL",
	[1141786504] = "WEAPON_GOLFCLUB",
	[-1076751822] = "WEAPON_SNSPISTOL",
	[-2084633992] = "WEAPON_CARBINERIFLE",
	[487013001] = "WEAPON_PUMPSHOTGUN",
	[-1168940174] = "WEAPON_HAZARDCAN",
	[-38085395] = "WEAPON_DIGISCANNER",
	[-1853920116] = "WEAPON_NAVYREVOLVER",
	[-37975472] = "WEAPON_SMOKEGRENADE",
	[-1600701090] = "WEAPON_BZGAS",
	[-1357824103] = "WEAPON_ADVANCEDRIFLE",
	[-581044007] = "WEAPON_MACHETE",
	[741814745] = "WEAPON_STICKYBOMB",
	[-608341376] = "WEAPON_COMBATMG_MK2",
	[137902532] = "WEAPON_VINTAGEPISTOL",
	[-1660422300] = "WEAPON_MG",
	[1198879012] = "WEAPON_FLAREGUN"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	local Victim,Attacker,Index,Weapon = Message[1],Message[2],NetworkGetPlayerIndexFromPed(Message[2]),Message[7]
	if Event == "CEventNetworkEntityDamage" and not DeathUpdate and Victim == PlayerPedId() and IsEntityAPed(Victim) and GetEntityHealth(Victim) <= 100 and NetworkIsPlayerConnected(Index) then
		TriggerServerEvent("player:Death",GetPlayerServerId(Index),HashWeapons[Weapon] or "Desconhecido")
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
		LocalPlayer["state"]:set("Invisible",true,false)
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
					LocalPlayer["state"]:set("Invisible",true,false)
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
		LocalPlayer["state"]:set("Invisible",false,false)
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
		LocalPlayer["state"]:set("Invisible",true,false)
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
		LocalPlayer["state"]:set("Invisible",false,false)
		LocalPlayer["state"]:set("Commands",false,true)
		SetEntityCoords(Ped,inTrash,false,false,false,false)

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Policia",("player:%s"):format(LocalPlayer["state"]["Player"]),function(Name,Key,Value)
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