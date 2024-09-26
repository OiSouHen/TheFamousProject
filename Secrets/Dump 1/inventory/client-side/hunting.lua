-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Model = nil
local Entity = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
local Animals = {
	"deer","boar","mtlion","coyote"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckRation()
	if not Entity or not DoesEntityExist(Entity) then
		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Animals()
	return Entity,Model
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:RATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Ration")
AddEventHandler("inventory:Ration",function(Coords)
	local Cooldown = 0
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	Model = Animals[math.random(#Animals)]
	local SpawnX = Coords["x"] + math.random(-75,75)
	local SpawnY = Coords["y"] + math.random(-75,75)
	local HitZ,GroundZ = GetGroundZFor_3dCoord(SpawnX,SpawnY,Coords["z"],true)
	local HitSafe,SafeCoords = GetSafeCoordForPed(SpawnX,SpawnY,GroundZ,false,16)

	repeat
		Cooldown = Cooldown + 1
		SpawnX = Coords["x"] + math.random(-75,75)
		SpawnY = Coords["y"] + math.random(-75,75)
		HitZ,GroundZ = GetGroundZFor_3dCoord(SpawnX,SpawnY,Coords["z"],true)
		HitSafe,SafeCoords = GetSafeCoordForPed(SpawnX,SpawnY,GroundZ,false,16)
	until (HitZ and HitSafe) or Cooldown >= 100

	if HitZ and HitSafe then
		local Network = vRPS.CreateModels("a_c_"..Model,SafeCoords["x"],SafeCoords["y"],SafeCoords["z"])
		if Network then
			SetTimeout(2500,function()
				Entity = LoadNetwork(Network)
				if Entity then
					SetPedAlertness(Entity,3)
					SetPedPathAvoidFire(Entity,1)
					DisablePedPainAudio(Entity,true)
					SetPedFleeAttributes(Entity,0,0)
					SetPedPathCanUseLadders(Entity,1)
					SetPedSeeingRange(Entity,10000.0)
					SetPedHearingRange(Entity,10000.0)
					SetPedDiesWhenInjured(Entity,true)
					SetPedPathCanUseClimbovers(Entity,1)
					SetPedPathCanDropFromHeight(Entity,1)
					SetPedCombatAttributes(Entity,5,true)
					SetPedCombatAttributes(Entity,2,true)
					SetPedCombatAttributes(Entity,1,true)
					SetPedCombatAttributes(Entity,16,true)
					SetPedCombatAttributes(Entity,46,true)
					SetPedCombatAttributes(Entity,26,true)
					SetPedCombatAttributes(Entity,3,false)
					SetCanAttackFriendly(Entity,false,true)
					SetPedSuffersCriticalHits(Entity,false)
					SetPedEnableWeaponBlocking(Entity,true)
					SetPedDropsWeaponsWhenDead(Entity,false)
					SetBlockingOfNonTemporaryEvents(Entity,true)
					SetModelAsNoLongerNeeded(Model)

					TaskGoStraightToCoord(Entity,Coords["x"],Coords["y"],Coords["z"],1.0,-1,0.0,0.0)

					local Blip = AddBlipForEntity(Entity)
					SetBlipSprite(Blip,141)
					SetBlipAsShortRange(Blip,true)
				end
			end)
		end
	end
end)