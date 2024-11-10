-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) and IsPedArmed(Ped,6) and IsPlayerFreeAiming(Pid) then
			local Progress = 1000
			local Entitys = ClosestPed(2)
			if Entitys and GetGameTimer() >= Timer and GetVehiclePedIsIn(Entitys,true) == 0 and not Entity(Entitys)["state"]["Steal"] then
				Timer = GetGameTimer() + 5000

				ClearPedTasks(Entitys)
				ClearPedSecondaryTask(Entitys)
				ClearPedTasksImmediately(Entitys)

				while not NetworkHasControlOfEntity(Entitys) do
					NetworkRequestControlOfEntity(Entitys)
					Wait(1)
				end

				TaskSetBlockingOfNonTemporaryEvents(Entitys,true)
				SetBlockingOfNonTemporaryEvents(Entitys,true)
				SetEntityAsMissionEntity(Entitys,true,true)
				SetPedDropsWeaponsWhenDead(Entitys,false)
				SetPedSuffersCriticalHits(Entitys,false)
				TaskTurnPedToFaceEntity(Entitys,Ped,0.0)

				LocalPlayer["state"]:set("Buttons",true,true)
				LocalPlayer["state"]:set("Commands",true,true)
				Entity(Entitys)["state"]:set("Steal",true,true)

				SetTimeout(100,function()
					if LoadAnim("random@mugging3") then
						TaskPlayAnim(Entitys,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,1,0,0,0)
					end
				end)

				while true do
					local Pid = PlayerId()
					local Ped = PlayerPedId()
					local Coords = GetEntityCoords(Ped)
					local EntityCoords = GetEntityCoords(Entitys)

					if #(Coords - EntityCoords) <= 2 and IsPlayerFreeAiming(Pid) then
						Progress = Progress - 1

						if not IsEntityPlayingAnim(Entitys,"random@mugging3","handsup_standing_base",3) then
							TaskPlayAnim(Entitys,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,1,0,0,0)
						end

						if Progress <= 0 and LoadModel("prop_paper_bag_small") then
							local Object = CreateObjectNoOffset("prop_paper_bag_small",Coords["x"],Coords["y"],Coords["z"],false,false,false)
							AttachEntityToEntity(Object,Entitys,GetPedBoneIndex(Entitys,28422),0.0,-0.05,0.05,180.0,0.0,0.0,true,true,false,true,2,true)

							if LoadAnim("mp_safehouselost@") then
								TaskPlayAnim(Entitys,"mp_safehouselost@","package_dropoff",8.0,8.0,-1,16,1,0,0,0)
							end

							Wait(3000)

							if DoesEntityExist(Object) then
								DeleteEntity(Object)
							end

							LocalPlayer["state"]:set("Buttons",false,true)
							LocalPlayer["state"]:set("Commands",false,true)
							TaskWanderStandard(Entitys,10.0,10)
							SetPedAsNoLongerNeeded(Entitys)
							vSERVER.StealPeds()
							vRP.Destroy()

							break
						end
					else
						LocalPlayer["state"]:set("Buttons",false,true)
						LocalPlayer["state"]:set("Commands",false,true)
						TaskWanderStandard(Entitys,10.0,10)
						SetPedAsNoLongerNeeded(Entitys)

						break
					end

					Wait(1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)