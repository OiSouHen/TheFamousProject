-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Max,Min = 80.0,10.0
local VehicleCamera = false
local FieldView = (Max + Min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			TimeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			SetVehicleRadioEnabled(Vehicle,false)

			if IsControlJustPressed(1,51) then
				TriggerEvent("hud:Active",false)
				VehicleCamera = true
			end

			if IsControlJustPressed(1,154) and (GetPedInVehicleSeat(Vehicle,1) == Ped or GetPedInVehicleSeat(Vehicle,2) == Ped) then
				TaskRappelFromHeli(Ped,1)
			end

			if VehicleCamera then
				SetTimecycleModifierStrength(0.3)
				SetTimecycleModifier("heliGunCam")

				local Scaleform = RequestScaleformMovie("HELI_CAM")
				while not HasScaleformMovieLoaded(Scaleform) do
					Wait(1)
				end

				local Heading = GetEntityHeading(Vehicle)
				local Camera = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(Camera,Vehicle,0.0,0.0,-1.5,true)
				SetCamRot(Camera,0.0,0.0,Heading)
				SetCamFov(Camera,FieldView)

				RenderScriptCams(true,false,0,false,false)
				PushScaleformMovieFunction(Scaleform,"SET_CAM_LOGO")
				PushScaleformMovieFunctionParameterInt(0)
				PopScaleformMovieFunctionVoid()

				while VehicleCamera do
					if IsControlJustPressed(1,51) then
						TriggerEvent("hud:Active",true)
						VehicleCamera = false
					end

					local Zoom = (1.0 / (Max - Min)) * (FieldView - Min)
					CheckInputRotation(Camera,Zoom)
					HandleZoom(Camera)
					HideHudAndRadarThisFrame()
					HideHudComponentThisFrame(19)
					PushScaleformMovieFunction(Scaleform,"SET_ALT_FOV_HEADING")
					PushScaleformMovieFunctionParameterFloat(GetEntityCoords(Vehicle).z)
					PushScaleformMovieFunctionParameterFloat(Zoom)
					PushScaleformMovieFunctionParameterFloat(GetCamRot(Camera,2).z)
					PopScaleformMovieFunctionVoid()
					DrawScaleformMovieFullscreen(Scaleform,255,255,255,255)

					Wait(1)
				end

				ClearTimecycleModifier()
				FieldView = (Max + Min) * 0.5
				RenderScriptCams(false,false,0,false,false)
				SetScaleformMovieAsNoLongerNeeded(Scaleform)
				DestroyCam(Camera,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end

		Citizen.Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(Camera,Zoom)
	local Rotation = GetCamRot(Camera,2)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		local ResultZ = Rotation["z"] + rightAxisX * -1.0 * 3.0 * (Zoom + 0.1)
		local ResultX = math.max(math.min(20.0,Rotation["x"] + rightAxisY * -1.0 * 3.0 * (Zoom + 0.1)),-89.5)
		SetCamRot(Camera,ResultX,0.0,ResultZ,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(Camera)
	if IsControlJustPressed(1,241) then
		FieldView = math.max(FieldView - 2.0,Min)
	end

	if IsControlJustPressed(1,242) then
		FieldView = math.min(FieldView + 2.0,Max)
	end

	local Current = GetCamFov(Camera)
	if math.abs(FieldView - Current) < 0.1 then
		FieldView = Current
	end

	SetCamFov(Camera,Current + (FieldView - Current) * 0.05)
end