-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
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
		if IsPedInAnyPoliceVehicle(Ped) and policeRadar and not policeFreeze and CheckPolice() then
			TimeDistance = 100

			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Dimension = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,1.0,1.0)

			local VehicleFront = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,105.0,0.0)
			local VehicleFrontShape = StartShapeTestCapsule(Dimension,VehicleFront,3.0,10,Vehicle,7)
			local _,_,_,_,Front = GetShapeTestResult(VehicleFrontShape)

			if IsEntityAVehicle(Front) then
				local Model = vRP.VehicleModel(Front)
				local Speed = GetEntitySpeed(Front) * 2.236936
				local Plate = GetVehicleNumberPlateText(Front)

				SendNUIMessage({ radar = "top", plate = Plate, Model = VehicleName(Model), speed = Speed })
			end

			local VehicleBack = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-105.0,0.0)
			local VehicleBackShape = StartShapeTestCapsule(Dimension,VehicleBack,3.0,10,Vehicle,7)
			local _,_,_,_,Back = GetShapeTestResult(VehicleBackShape)

			if IsEntityAVehicle(Back) then
				local Model = vRP.VehicleModel(Back)
				local Speed = GetEntitySpeed(Back) * 2.236936
				local Plate = GetVehicleNumberPlateText(Back)

				SendNUIMessage({ radar = "bot", plate = Plate, Model = VehicleName(Model), speed = Speed })
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
RegisterCommand("toggleRadar",function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and not IsPauseMenuActive() and CheckPolice() then
		if policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		else
			policeRadar = true
			SendNUIMessage({ radar = true })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEFREEZE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleFreeze",function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and not IsPauseMenuActive() and CheckPolice() then
		policeFreeze = not policeFreeze
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("toggleRadar","Ativar/Desativar radar das viaturas.","keyboard","N")
RegisterKeyMapping("toggleFreeze","Travar/Destravar radar das viaturas.","keyboard","M")