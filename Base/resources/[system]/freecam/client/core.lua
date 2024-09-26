-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local CameraMoviments = { x = 0, y = 0, z = 0, fov = 0 }
local cam, cam2, camera, TrackedEntity, offsetEnd, offsetStart = nil, nil, nil, nil, nil, nil
local SavedPictures = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENDERCAMMODE
-----------------------------------------------------------------------------------------------------------------------------------------
function RenderCamMode(Status)
	if Status then
		TrackedEntity = PlayerPedId()
		offsetEnd = GetOffsetFromEntityInWorldCoords(TrackedEntity, vec3(0.0, 5.0, -0.6))
		offsetStart = GetOffsetFromEntityInWorldCoords(TrackedEntity, vec3(2.20, 2.0, 2.20))

		FreezeEntityPosition(TrackedEntity, true)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetStart, 0.0, 0.0, 0, 60.00, true, 0)
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd, 0.0, 0.0, 0, 60.00, false, 0)
		PointCamAtEntity(cam2, TrackedEntity, 0, 0, 0, true)
		SetCamFov(cam2, 20.0)
		SetCamActiveWithInterp(cam2, cam, 0, true, true)

		RenderScriptCams(true, false, 1, true, true)

		CreateThread(function()
			Wait(400)

			if DoesCamExist(cam) then
				DestroyCam(cam, true)
			end
		end)
	else
		if DoesCamExist(cam) then
			DestroyCam(cam, true)
		end

		if DoesCamExist(cam2) then
			DestroyCam(cam2, true)
		end

		RenderScriptCams(false, false, 1, true, true)
		FreezeEntityPosition(TrackedEntity, false)
	end

	if Status then
		Wait(400)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCAMERAMODE
-----------------------------------------------------------------------------------------------------------------------------------------
local function OpenCameraMode()
	SendNUIMessage({ action = "opencam" })
	LocalPlayer["state"]["Camera"] = true
	SetNuiFocus(true, true)
	RenderCamMode(true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(data)
	LocalPlayer["state"]["Camera"] = false
	SetNuiFocus(false, false)
	RenderCamMode(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCAMSDATA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getCamsData", function(_, cb)
	Wait(1000)

	local Screenshots = GetResourceKvpString("CreativeFreecam")
	if Screenshots then
		SavedPictures = json.decode(Screenshots)
	end

	local data = { Settings = Shared, Pictures = SavedPictures }

	cb(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAMODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CameraMode", function()

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAMERAMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SetUpCameraMovement", function(data)
	TriggerScreenblurFadeOut()
	CameraMoviments = { x = 0, y = 0, z = 0, fov = 0 }
	camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd, 0.0, 40.0, 0, 20.00 + CameraMoviments["fov"],
		false, 0)
	SetCamActiveWithInterp(camera)
	PointCamAtEntity(camera, TrackedEntity, 0, 0, 0, true)
	RenderScriptCams(1, 1, 0, 0, 0)
	ClearTimecycleModifier("helicamfirst", 4.2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVECAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Movecamera", function(data)
	DestroyAllCams(true)

	if data["move"]["type"] == "x" then
		CameraMoviments["x"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd["x"] + data["move"]["value"], offsetEnd["y"] + CameraMoviments["y"], offsetEnd["z"] + CameraMoviments["z"], 0.0, 40.0, 0, 20.00 + CameraMoviments["fov"], false, 0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "y" then
		CameraMoviments["y"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd["x"] + CameraMoviments["x"], offsetEnd["y"] + data["move"]["value"], offsetEnd["z"] + CameraMoviments["z"], 0.0, 0.0, 0, 20.00 + CameraMoviments["fov"], false, 0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "z" then
		CameraMoviments["z"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd["x"] + CameraMoviments["x"], offsetEnd["y"] + CameraMoviments["y"], offsetEnd["z"] + data["move"]["value"], 0.0, 0.0, 0, 20.00 + CameraMoviments["fov"], false, 0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "fov" then
		CameraMoviments["fov"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd["x"] + CameraMoviments["x"], offsetEnd["y"] + CameraMoviments["y"], offsetEnd["z"] + CameraMoviments["z"], 0.0, 0.0, 0, 20.00 + data["move"]["value"], false, 0)
		SetCamActiveWithInterp(camera)
	end

	PointCamAtEntity(camera, TrackedEntity, 0, 0, 0, true)
	RenderScriptCams(1, 1, 0, 0, 0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLURCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Blurcamera", function(data)
	if data["blur"] then
		TriggerScreenblurFadeIn()
	else
		TriggerScreenblurFadeOut()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFILTERSTRENGTH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SetFilterStrength", function(data)
	FilterStrength = json.decode(data["Strength"])

	SetTimecycleModifierStrength(FilterStrength)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFILTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SetFilter", function(data)
	if not data["filter"] then
		ClearTimecycleModifier("", 4.2)
	else
		SetTransitionTimecycleModifier(data["filter"], 0)
		SetTimecycleModifierStrength(FilterStrength)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEPICTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SavePicture", function(data)
	SavedPictures[tostring(data["Saving"]["id"])] = { id = data["Saving"]["id"], image = data["Saving"]["image"], name = data["Saving"]["name"] }

	SetResourceKvp("CreativeFreecam", json.encode(SavedPictures))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPICTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("DeletePicture", function(data)
	SavedPictures[tostring(data["SelectedId"])] = nil

	SetResourceKvp("CreativeFreecam", json.encode(SavedPictures))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKESCREENSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("TakeScreenShot", function()
	local Webhook = "https://discord.com/api/webhooks/1214249220580712478/fhMXYK-bF71zekwj88O5AHTbtRjHR_S_r9vVGzC2TeTgzjJgTwj1_CSX5hYGK7JdlbqM"
	exports["screenshot"]:requestScreenshotUpload(Webhook, "files[]", function(data)
		local image = json.decode(data)
		SendNUIMessage({ action = "CopyScreenshotUrl", url = image["attachments"][1]["proxy_url"] })
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FREECAM:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("freecam:Active", function()
	OpenCameraMode()
end)
