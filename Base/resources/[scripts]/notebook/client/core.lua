-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Informations(Vehicle)
	local Boost = {
		boost = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fInitialDriveForce"),
		curve = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fTractionCurveLateral"),
		lowspeed = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fLowSpeedTractionLossMult"),
		trafront = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fTractionBiasFront"),
		clutchup = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift"),
		clutchdown = GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift")
	}

	return Boost
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Vehicle, Data)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fInitialDriveForce", Data["boost"] * 1.0)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fTractionBiasFront", Data["trafront"] * 1.0)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fTractionCurveLateral", Data["curve"] * 1.0)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fLowSpeedTractionLossMult", Data["lowspeed"] * 1.0)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", Data["clutchup"] * 1.0)
	SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", Data["clutchdown"] * 1.0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	SetNuiFocus(false, false)

	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle, -1) == Ped then
			Customization(Vehicle, Data)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save", function(Data, Callback)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle, -1) == Ped then
			TriggerEvent("Notify", "verde", "Modificações aplicadas.", "Sucesso", 5000)
			Customization(Vehicle, Data)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTEBOOK:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notebook:Open")
AddEventHandler("notebook:Open", function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle, -1) == Ped then
			SetNuiFocus(true, true)
			SendNUIMessage({ Action = "Open", state = true, data = Informations(Vehicle) })
		end
	end
end)
