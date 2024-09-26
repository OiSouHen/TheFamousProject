-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("evidence",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADEVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_FLASHLIGHT") and IsPlayerFreeAiming(PlayerId()) then
			local Coords = GetEntityCoords(Ped)
			local gridZone = getGridzone(Coords["x"], Coords["y"])

			if GlobalState["Evidences"][gridZone] then
				for k,v in pairs(GlobalState["Evidences"][gridZone]) do
					local Distance = #(Coords - vec3(v[1]["x"], v[1]["y"], v[1]["z"]))
					if Distance <= 5 then
						TimeDistance = 1

						DrawMarker(28, v[1]["x"], v[1]["y"], v[1]["z"] + 0.05, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.045, 0.045, 0.045, v[3][1], v[3][2], v[3][3], 200, 0, 0, 0, 0)

						if Distance <= 1.2 and IsControlJustPressed(1,38) then
							TriggerServerEvent("evidence:Pickup", k, gridZone)
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPOSITIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.GetPostions()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local gridZone = getGridzone(Coords["x"], Coords["y"])
	local _,cdz = GetGroundZFor_3dCoord(Coords["x"], Coords["y"], Coords["z"])

	return vec3(Coords["x"], Coords["y"], cdz), gridZone
end