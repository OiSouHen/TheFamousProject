-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 100
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) and IsPedJumping(Ped) then
			TimeDistance = 1

			if IsControlJustReleased(1,51) then
				local Tackle = {}
				local Coords = GetEntityForwardVector(Ped)

				SetPedToRagdollWithFall(Ped,2500,1500,0,Coords,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

				while IsPedRagdoll(Ped) do
					for _,v in ipairs(GetPlayers()) do
						if not Tackle[v] then
							Tackle[v] = true
							TriggerServerEvent("inventory:Cancel")
							TriggerServerEvent("tackle:Update",GetPlayerServerId(v),Coords)
						end
					end

					Wait(1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function(Coords)
	SetPedToRagdollWithFall(PlayerPedId(),5000,5000,0,Coords["x"],Coords["y"],Coords["z"],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
	TriggerServerEvent("inventory:Cancel")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Players = {}
	local Ped = PlayerPedId()

	for _,v in ipairs(GetActivePlayers()) do
		local OtherPed = GetPlayerPed(v)
		if IsEntityTouchingEntity(Ped,OtherPed) and not IsPedInAnyVehicle(OtherPed) and not IsEntityPlayingAnim(OtherPed,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
			Players[#Players + 1] = v
		end
	end

	return Players
end