local CameraMoviments = { x = 0, y = 0, z = 0, fov = 0 }
local cam,cam2,camera,TrackedEntity,offsetEnd,offsetStart = nil,nil,nil,nil,nil,nil
local SavedPictures = {}
local Actived = false

function RenderCamMode(Status)
	if Status then
		TrackedEntity = PlayerPedId()
		offsetEnd = GetOffsetFromEntityInWorldCoords(TrackedEntity,vector3(0.0,5.0,-0.6))
		offsetStart = GetOffsetFromEntityInWorldCoords(TrackedEntity,vector3(2.20,2.0,2.20))

		FreezeEntityPosition(TrackedEntity,true)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetStart,0.0,0.0,0,60.00,true,0)
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd,0.0,0.0,0,60.00,false,0)
		PointCamAtEntity(cam2,TrackedEntity,0,0,0,true)
		SetCamFov(cam2,20.0)
		SetCamActiveWithInterp(cam2,cam,0,true,true)
		RenderScriptCams(true,false,0,false,false)

		CreateThread(function()
			Wait(400)

			if DoesCamExist(cam) then
				DestroyCam(cam,true)
			end
		end)
	else
		if DoesCamExist(cam) then
			DestroyCam(cam,true)
		end

		if DoesCamExist(cam2) then
			DestroyCam(cam2,true)
		end

		RenderScriptCams(false,false,0,false,false)
		FreezeEntityPosition(TrackedEntity,false)
	end

	if Status then
		Wait(400)
	end
end

RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	RenderCamMode(false)
end)

RegisterNUICallback("getCamsData",function(_,cb)
	Wait(1000)

	local Screenshots = GetResourceKvpString("CreativeCamera")
	if Screenshots then
		SavedPictures = json.decode(Screenshots)
	end

	local data = {
		Settings = Shared,
		Pictures = SavedPictures
	}

	cb(data)
end)

RegisterNUICallback("SetUpCameraMovement",function(data)
	TriggerScreenblurFadeOut()
	CameraMoviments = { x = 0, y = 0, z = 0, fov = 0 }
	camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd,0.0,40.0,0,20.00 + CameraMoviments["fov"],false,0)
	SetCamActiveWithInterp(camera)
	PointCamAtEntity(camera,TrackedEntity,0,0,0,true)
	RenderScriptCams(true,false,0,false,false)
	ClearTimecycleModifier("helicamfirst",4.2)
end)

RegisterNUICallback("Movecamera",function(data)
	DestroyAllCams(true)

	if data["move"]["type"] == "x" then
		CameraMoviments["x"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd["x"] + data["move"]["value"],offsetEnd["y"] + CameraMoviments["y"],offsetEnd["z"] + CameraMoviments["z"],0.0,40.0,0,20.00 + CameraMoviments["fov"],false,0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "y" then
		CameraMoviments["y"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd["x"] + CameraMoviments["x"],offsetEnd["y"] + data["move"]["value"],offsetEnd["z"] + CameraMoviments["z"],0.0,0.0,0,20.00 + CameraMoviments["fov"],false,0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "z" then
		CameraMoviments["z"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd["x"] + CameraMoviments["x"],offsetEnd["y"] + CameraMoviments["y"],offsetEnd["z"] + data["move"]["value"],0.0,0.0,0,20.00 + CameraMoviments["fov"],false,0)
		SetCamActiveWithInterp(camera)
	elseif data["move"]["type"] == "fov" then
		CameraMoviments["fov"] = data["move"]["value"]
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offsetEnd["x"] + CameraMoviments["x"],offsetEnd["y"] + CameraMoviments["y"],offsetEnd["z"] + CameraMoviments["z"],0.0,0.0,0,20.00 + data["move"]["value"],false,0)
		SetCamActiveWithInterp(camera)
	end

	PointCamAtEntity(camera,TrackedEntity,0,0,0,true)
	RenderScriptCams(true,false,0,false,false)
end)

RegisterNUICallback("Blurcamera",function(data)
	if data["blur"] then
		TriggerScreenblurFadeIn()
	else
		TriggerScreenblurFadeOut()
	end
end)

RegisterNUICallback("SetFilterStrength",function(data)
	FilterStrength = json.decode(data["Strength"])

	SetTimecycleModifierStrength(FilterStrength)
end)

RegisterNUICallback("SetFilter",function(data)
	if not data["filter"] then
		ClearTimecycleModifier("",4.2)
	else
		SetTransitionTimecycleModifier(data["filter"],0)
		SetTimecycleModifierStrength(FilterStrength)
	end
end)

RegisterNUICallback("SavePicture",function(data)
	SavedPictures[tostring(data["Saving"]["id"])] = {
		id = data["Saving"]["id"],
		image = data["Saving"]["image"],
		name = data["Saving"]["name"]
	}

	SetResourceKvp("CreativeCamera",json.encode(SavedPictures))
end)

RegisterNUICallback("DeletePicture",function(data)
	SavedPictures[tostring(data["SelectedId"])] = nil

	SetResourceKvp("CreativeCamera",json.encode(SavedPictures))
end)

RegisterNUICallback("TakeScreenShot",function()
	local Webhook = "https://discord.com/api/webhooks/1236099633932140564/Q6Ojt1Unopc3h8oLrHx8GZ56NkEmNey3Rh_hFFHSLn28MLlYvuHz3UeXoCDK2uvDoXVy"
	exports["screenshot-basic"]:requestScreenshotUpload(Webhook,"files[]",function(data)
		local image = json.decode(data)

		SendNUIMessage({
			action = "CopyScreenshotUrl",
			url = image["attachments"][1]["proxy_url"]
		})
	end)
end)

RegisterNetEvent("freecam:Active",function(Message)
	if Message[1] then
		if not Actived then
			LocalPlayer["state"]:set("Freecam",false,false)
			SendNUIMessage({ action = "Close" })
			Actived = true
		else
			SendNUIMessage({ action = "Resume" })
			Actived = false
		end
	else
		LocalPlayer["state"]:set("Freecam",true,false)
		SendNUIMessage({ action = "Open" })
		SetNuiFocus(true,true)
		RenderCamMode(true)
	end
end)