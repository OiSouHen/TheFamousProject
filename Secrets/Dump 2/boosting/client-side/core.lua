-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("boosting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOSTING
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = 1
local Model = nil
local Selected = 1
local Vehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {
	"g_m_y_mexgang_01","g_m_y_lost_01","u_m_o_finguru_01","g_m_y_salvagoon_01","g_f_y_lost_01","a_m_y_business_02","s_m_m_postal_01",
	"g_m_y_korlieut_01","s_m_m_trucker_01","g_m_m_armboss_01","mp_m_shopkeep_01","ig_dale","u_m_y_baygor","cs_gurk","ig_casey",
	"s_m_y_garbage","a_m_o_ktown_01","a_f_y_eastsa_03"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local Locates = {
	vec4(-625.45,-1657.5,25.63,243.78),
	vec4(-820.02,-1273.31,4.8,167.25),
	vec4(-819.41,-1199.15,6.74,138.9),
	vec4(-1048.27,-864.63,4.8,56.7),
	vec4(-699.77,-988.89,20.2,300.48),
	vec4(-477.73,-764.71,40.02,269.3),
	vec4(-276.35,-771.75,38.59,68.04),
	vec4(-323.24,-945.7,30.89,249.45),
	vec4(-318.42,-1112.96,22.76,340.16),
	vec4(145.06,-1145.18,29.1,184.26),
	vec4(240.51,-1413.74,30.4,328.82),
	vec4(400.88,-1648.56,29.1,320.32),
	vec4(571.65,-1922.32,24.52,119.06),
	vec4(1446.51,-2614.0,48.21,345.83),
	vec4(1278.73,-1796.5,43.64,107.72),
	vec4(862.91,-1383.57,25.95,34.02),
	vec4(156.73,-1451.26,28.95,138.9),
	vec4(88.01,-195.89,54.31,158.75),
	vec4(62.68,260.59,109.22,68.04),
	vec4(-469.97,542.25,120.68,357.17),
	vec4(-669.89,752.33,173.86,0.0),
	vec4(-1535.05,890.15,181.62,201.26),
	vec4(-3150.55,1096.16,20.52,283.47),
	vec4(-3249.57,987.82,12.3,2.84),
	vec4(-3052.24,600.0,7.16,289.14),
	vec4(-2139.52,-380.26,13.01,348.67),
	vec4(-1855.42,-623.86,10.99,48.19),
	vec4(-1703.92,-933.34,7.48,294.81),
	vec4(-1576.25,-1047.58,12.82,73.71),
	vec4(-891.67,-2059.35,9.12,42.52),
	vec4(-621.52,-2152.62,5.8,5.67),
	vec4(-363.52,-2273.8,7.41,14.18),
	vec4(-259.06,-2651.38,5.81,314.65),
	vec4(128.47,-2626.56,5.9,167.25),
	vec4(781.92,-2957.77,5.61,68.04),
	vec4(915.41,-2195.35,30.14,172.92),
	vec4(728.43,-2033.73,29.1,354.34),
	vec4(1145.1,-475.1,66.19,257.96),
	vec4(935.39,-54.52,78.57,56.7),
	vec4(615.57,614.44,128.72,68.04),
	vec4(672.45,245.19,93.75,56.7),
	vec4(446.95,260.66,103.02,68.04),
	vec4(90.35,485.94,147.49,206.93),
	vec4(226.83,680.87,189.31,104.89),
	vec4(320.08,494.93,152.39,286.3),
	vec4(505.98,-1843.29,27.38,124.73),
	vec4(313.21,-1940.86,24.45,48.19),
	vec4(197.28,-2027.34,18.08,345.83),
	vec4(154.9,-1881.0,23.44,65.2),
	vec4(709.92,-1401.71,26.17,286.3)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOSTING:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("boosting:Open")
AddEventHandler("boosting:Open",function()
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ Action = "Open", Payload = vSERVER.Experience() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Active",function(Data,Callback)
	Callback(vSERVER.Actives())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PENDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Pending",function(Data,Callback)
	Callback(vSERVER.Pendings())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Accept",function(Data,Callback)
	Callback(vSERVER.Accept(Data["Number"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRATCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Scratch",function(Data,Callback)
	Callback(vSERVER.Scratch(Data["Number"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECLINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Decline",function(Data,Callback)
	Callback(vSERVER.Decline(Data["Number"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Transfer",function(Data,Callback)
	Callback(vSERVER.Transfer(Data["Number"],Data["Passport"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOSTING:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("boosting:Active")
AddEventHandler("boosting:Active",function(VehicleModel,Class)
	Class = Class
	Vehicle = false
	Model = VehicleModel
	Selected = math.random(#Locates)

	TriggerEvent("NotifyPush",{ code = 20, title = "Localização Veículo", x = Locates[Selected]["x"], y = Locates[Selected]["y"], z = Locates[Selected]["z"], vehicle = VehicleName(Model), color = 44 })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOSTING:RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("boosting:Reset")
AddEventHandler("boosting:Reset",function()
	Model = ""
	Vehicle = false
	SendNUIMessage({ Action = "Close" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if not Vehicle and Model ~= "" then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			if #(Coords - Locates[Selected]["xyz"]) <= 100 then
				local Networked = vSERVER.CreateVehicle(Model,Class,Locates[Selected])

				if Networked then
					local Network = LoadNetwork(Networked)
					if Network then
						Vehicle = Network
						SetVehicleHasBeenOwnedByPlayer(Vehicle,true)
						SetVehicleNeedsToBeHotwired(Vehicle,false)
						DecorSetInt(Vehicle,"Player_Vehicle",-1)
						SetVehicleOnGroundProperly(Vehicle)
						SetVehRadioStation(Vehicle,"OFF")

						SetVehicleModKit(Vehicle,0)
						ToggleVehicleMod(Vehicle,18,true)
						SetVehicleMod(Vehicle,11,GetNumVehicleMods(Vehicle,11) - 1,false)
						SetVehicleMod(Vehicle,12,GetNumVehicleMods(Vehicle,12) - 1,false)
						SetVehicleMod(Vehicle,13,GetNumVehicleMods(Vehicle,13) - 1,false)
						SetVehicleMod(Vehicle,15,GetNumVehicleMods(Vehicle,15) - 1,false)

						SetModelAsNoLongerNeeded(Model)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOSTING:DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("boosting:Dispatch")
AddEventHandler("boosting:Dispatch",function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	for Number = 1,5 do
		local Cooldown = 0
		local OtherPeds = math.random(#Peds)
		local SpawnX = Coords["x"] + math.random(-20,20)
		local SpawnY = Coords["y"] + math.random(-20,20)
		local HitZ,GroundZ = GetGroundZFor_3dCoord(SpawnX,SpawnY,Coords["z"],true)
		local HitSafe,SafeCoords = GetSafeCoordForPed(SpawnX,SpawnY,GroundZ,false,16)

		repeat
			Cooldown = Cooldown + 1
			SpawnX = Coords["x"] + math.random(-20,20)
			SpawnY = Coords["y"] + math.random(-20,20)
			HitZ,GroundZ = GetGroundZFor_3dCoord(SpawnX,SpawnY,Coords["z"],true)
			HitSafe,SafeCoords = GetSafeCoordForPed(SpawnX,SpawnY,GroundZ,false,16)
		until (HitZ and HitSafe) or Cooldown >= 100

		if HitZ and HitSafe then
			local Network = vRPS.CreateModels(Peds[OtherPeds],SafeCoords["x"],SafeCoords["y"],SafeCoords["z"])
			if Network then
				SetTimeout(2500,function()
					local Entity = LoadNetwork(Network)
					if Entity then
						SetPedArmour(Entity,100)
						SetPedAccuracy(Entity,75)
						SetPedAlertness(Entity,3)
						SetPedAsEnemy(Entity,true)
						SetPedMaxHealth(Entity,500)
						SetEntityHealth(Entity,500)
						SetPedKeepTask(Entity,true)
						SetPedCombatRange(Entity,2)
						StopPedSpeaking(Entity,true)
						SetPedCombatMovement(Entity,2)
						DisablePedPainAudio(Entity,true)
						SetPedPathAvoidFire(Entity,true)
						SetPedConfigFlag(Entity,208,true)
						SetPedSeeingRange(Entity,10000.0)
						SetPedCanEvasiveDive(Entity,false)
						SetPedHearingRange(Entity,10000.0)
						SetPedDiesWhenInjured(Entity,false)
						SetPedPathCanUseLadders(Entity,true)
						SetPedFleeAttributes(Entity,0,false)
						SetPedCombatAttributes(Entity,46,true)
						SetPedFiringPattern(Entity,0xC6EE6B4C)
						SetCanAttackFriendly(Entity,true,false)
						SetPedSuffersCriticalHits(Entity,false)
						SetPedPathCanUseClimbovers(Entity,true)
						SetPedDropsWeaponsWhenDead(Entity,false)
						SetPedEnableWeaponBlocking(Entity,false)
						SetPedPathCanDropFromHeight(Entity,false)
						RegisterHatedTargetsAroundPed(Entity,100.0)
						GiveWeaponToPed(Entity,"WEAPON_PISTOL_MK2",-1,false,true)
						SetCurrentPedWeapon(Entity,"WEAPON_PISTOL_MK2",true)
						SetPedInfiniteAmmo(Entity,true,"WEAPON_PISTOL_MK2")
						SetPedRelationshipGroupHash(Entity,GetHashKey("HATES_PLAYER"))
						SetEntityCanBeDamagedByRelationshipGroup(Entity,false,"HATES_PLAYER")
						SetRelationshipBetweenGroups(5,GetHashKey("HATES_PLAYER"),GetHashKey("PLAYER"))
						SetRelationshipBetweenGroups(5,GetHashKey("PLAYER"),GetHashKey("HATES_PLAYER"))
						TaskCombatPed(Entity,Ped,0,16)

						SetTimeout(1000,function()
							TaskWanderInArea(Entity,SafeCoords["x"],SafeCoords["y"],SafeCoords["z"],25.0,0.0,0.0)
							SetModelAsNoLongerNeeded(Peds[OtherPeds])
						end)
					end
				end)
			end
		end
	end
end)