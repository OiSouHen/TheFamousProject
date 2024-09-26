-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
local policeRadar = false
local policeFreeze = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRADAR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyPoliceVehicle(Ped) and LocalPlayer["state"]["Policia"] then
			if policeRadar then
				if not policeFreeze then
					TimeDistance = 100

					local vehicle = GetVehiclePedIsUsing(Ped)
					local vehicleDimension = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.0, 1.0)

					local vehicleFront = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 105.0, 0.0)
					local vehicleFrontShape = StartShapeTestCapsule(vehicleDimension, vehicleFront, 3.0, 10, vehicle, 7)
					local _, _, _, _, vehFront = GetShapeTestResult(vehicleFrontShape)

					if IsEntityAVehicle(vehFront) then
						local Model = GetEntityModel(vehFront)
						local Plate = GetVehicleNumberPlateText(vehFront)
						local Speed = GetEntitySpeed(vehFront) * 2.236936
						local Name = GetDisplayNameFromVehicleModel(Model)

						SendNUIMessage({ radar = "top", plate = Plate, Model = Name, speed = Speed })
					end

					local vehicleBack = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -105.0, 0.0)
					local vehicleBackShape = StartShapeTestCapsule(vehicleDimension, vehicleBack, 3.0, 10, vehicle, 7)
					local _, _, _, _, vehBack = GetShapeTestResult(vehicleBackShape)

					if IsEntityAVehicle(vehBack) then
						local Model = GetEntityModel(vehBack)
						local Plate = GetVehicleNumberPlateText(vehBack)
						local Speed = GetEntitySpeed(vehBack) * 2.236936
						local Name = GetDisplayNameFromVehicleModel(Model)

						SendNUIMessage({ radar = "bot", plate = Plate, Model = Name, speed = Speed })
					end
				end
			end
		end

		if not IsPedInAnyVehicle(Ped) and policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLERADAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleRadar", function()
	if not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyPoliceVehicle(Ped) and LocalPlayer["state"]["Policia"] then
			if policeRadar then
				policeRadar = false
				SendNUIMessage({ radar = false })
			else
				policeRadar = true
				SendNUIMessage({ radar = true })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEFREEZE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleFreeze", function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and LocalPlayer["state"]["Policia"] and not IsPauseMenuActive() then
		policeFreeze = not policeFreeze
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("toggleRadar", "Ativar/Desativar radar das viaturas.", "keyboard", "N")
RegisterKeyMapping("toggleFreeze", "Travar/Destravar radar das viaturas.", "keyboard", "M")
