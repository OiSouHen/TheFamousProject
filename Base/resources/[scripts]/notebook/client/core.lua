-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Information(Vehicle)
	return {
		boost = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce"),
		curve = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral"),
		lowspeed = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult"),
		trafront = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront"),
		clutchup = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift"),
		clutchdown = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift"),
		camberfront = GetVehicleHandlingFloat(Vehicle,"CCarHandlingData","fCamberFront"),
		camberrear = GetVehicleHandlingFloat(Vehicle,"CCarHandlingData","fCamberRear")
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped then
			TriggerEvent("Notify","Scanner Automotivo","Modificações aplicadas.","verde",5000)

			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral",Data["curve"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce",Data["boost"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult",Data["lowspeed"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront",Data["trafront"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift",Data["clutchup"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift",Data["clutchdown"] * 1.0)
			SetVehicleHandlingFloat(Vehicle,"CCarHandlingData","fCamberFront",Data["camberfront"] == 0.0 and -0.0 or (Data["camberfront"] * 1.0))
			SetVehicleHandlingFloat(Vehicle,"CCarHandlingData","fCamberRear",Data["camberrear"] == 0.0 and -0.0 or (Data["camberrear"] * 1.0))
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTEBOOK:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notebook:Open")
AddEventHandler("notebook:Open",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped then
			SetNuiFocus(true,true)
			SendNUIMessage({ type = "Close", state = true, data = Information(Vehicle) })
		end
	end
end)