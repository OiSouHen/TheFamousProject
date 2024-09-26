-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local FovMin = 10.0
local FovMax = 70.0
local Camera = false
local Binoculars = false
local Total = (FovMax + FovMin) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Camera")
AddEventHandler("inventory:Camera",function(Action)
	if not Camera then
		Binoculars = Action
		local Ped = PlayerPedId()
		local Heading = GetEntityHeading(Ped)

		if Binoculars then
			Scaleform = RequestScaleformMovie("BINOCULARS")
			while not HasScaleformMovieLoaded(Scaleform) do
				Wait(1)
			end
		end

		Camera = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
		AttachCamToEntity(Camera,Ped,0.0,0.0,1.0,true)
		LocalPlayer["state"]:set("Camera",true,true)
		RenderScriptCams(true,false,0,false,false)
		SetCamRot(Camera,0.0,0.0,Heading)
		TriggerEvent("hud:Active",false)
		SetCamActive(Camera,true)
		SetCamFov(Camera,Total)

		while Camera do
			Wait(1)

			local Zoom = (1.0 / (FovMax - FovMin)) * (Total - FovMin)
			CheckInputRotation(Zoom)
			HandleZoom()

			if Binoculars then
				DrawScaleformMovieFullscreen(Scaleform,255,255,255,255)
			end

			local Ped = PlayerPedId()
			if IsPedArmed(Ped,7) then
				RemoveCamera()
			end
		end
	else
		RemoveCamera()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RemoveCamera()
	Total = (FovMax + FovMin) * 0.5

	LocalPlayer["state"]:set("Camera",false,true)

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	TriggerEvent("hud:Active",true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(Zoom)
	local AxisX = GetDisabledControlNormal(0,220)
	local AxisY = GetDisabledControlNormal(0,221)
	local Rotation = GetCamRot(Camera,2)
	if AxisX ~= 0.0 or AxisY ~= 0.0 then
		local NewZ = Rotation["z"] + AxisX * -1.0 * 8.0 * (Zoom + 0.1)
		local NewX = math.max(math.min(20.0,Rotation["x"] + AxisY * -1.0 * 8.0 * (Zoom + 0.1)),-89.5)
		SetCamRot(Camera,NewX,0.0,NewZ,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom()
	if IsControlJustPressed(1,241) then
		Total = math.max(Total - 10.0,FovMin)
	end

	if IsControlJustPressed(1,242) then
		Total = math.min(Total + 10.0,FovMax)
	end

	local Current = GetCamFov(Camera)
	if math.abs(Total - Current) < 0.1 then
		Total = Current
	end

	SetCamFov(Camera,Current + (Total - Current) * 0.05)
end