-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mount = nil
local Camera = nil
local LastModel = ""
local CamRoration = 294.81
local CamCoords = vec3(-49.14,-1099.56,26.92)
local TestDriveReturn = vec3(-58.03,-1096.94,26.42)
local VehicleCoords = vec4(-44.42,-1097.44,26.23,28.35)
local TestDriveCoords = vec4(-53.28,-1110.93,26.47,68.04)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,CamRoration)
	SetCamCoord(Camera,CamCoords)
	SetCamActive(Camera,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("pdm:Open")
AddEventHandler("pdm:Open",function()
	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	local Ped = PlayerPedId()
	if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and GetEntityHealth(Ped) > 100 and not exports["hud"]:Wanted() then
		CameraActive()
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("dynamic:Close")
		TriggerEvent("hud:Active",false)
		SendNUIMessage({ Action = "Open", Payload = { VehicleList(),vSERVER.Discount() } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("hud:Active",true)
	TriggerEvent("pdm:Close")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Vehicle = Data["vehicle"]
	if LoadModel(Vehicle) and LastModel ~= Vehicle then
		if DoesEntityExist(Mount) then
			DeleteEntity(Mount)
		end

		Mount = CreateVehicle(Vehicle,VehicleCoords,false,false)
		SetVehicleCustomSecondaryColour(Mount,88,101,242)
		SetVehicleCustomPrimaryColour(Mount,88,101,242)
		SetVehicleNumberPlateText(Mount,"PDMSPORT")
		SetEntityCollision(Mount,false,false)
		FreezeEntityPosition(Mount,true)
		SetEntityInvincible(Mount,true)
		SetVehicleDirtLevel(Mount,0.0)
		SetModelAsNoLongerNeeded(Vehicle)
		LastModel = Vehicle
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	local Return = false
	if vSERVER.Buy(Data["vehicle"]) then
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("hud:Active",true)
		TriggerEvent("pdm:Close")
		Return = true
	end

	Callback(Return)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	if DoesEntityExist(Mount) then
		if Data["direction"] == "Left" then
			SetEntityHeading(Mount,GetEntityHeading(Mount) - 5)
		else
			SetEntityHeading(Mount,GetEntityHeading(Mount) + 5)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive",function(Data,Callback)
	if vSERVER.Check() then
		if IsScreenFadedIn() then
			DoScreenFadeOut(0)
		end

		TriggerEvent("pdm:Close")
		SendNUIMessage({ Action = "Close" })

		if LoadModel(Data["vehicle"]) then
			if DoesEntityExist(Mount) then
				DeleteEntity(Mount)
			end

			Mount = CreateVehicle(Data["vehicle"],TestDriveCoords,false,false)

			SetVehicleModKit(Mount,0)
			SetVehicleDirtLevel(Mount,0.0)
			ToggleVehicleMod(Mount,18,true)
			SetEntityInvincible(Mount,true)
			SetPedIntoVehicle(PlayerPedId(),Mount,-1)
			SetVehicleNumberPlateText(Mount,"PDMSPORT")
			SetVehicleCustomPrimaryColour(Mount,88,101,242)
			SetVehicleCustomSecondaryColour(Mount,88,101,242)
			SetVehicleMod(Mount,11,GetNumVehicleMods(Mount,11) - 1,false)
			SetVehicleMod(Mount,12,GetNumVehicleMods(Mount,12) - 1,false)
			SetVehicleMod(Mount,13,GetNumVehicleMods(Mount,13) - 1,false)
			SetVehicleMod(Mount,15,GetNumVehicleMods(Mount,15) - 1,false)

			SetModelAsNoLongerNeeded(Data["vehicle"])

			LocalPlayer["state"]:set("Commands",true,true)
			LocalPlayer["state"]:set("TestDrive",true,false)

			SetTimeout(2500,function()
				if IsScreenFadedOut() then
					TriggerEvent("hud:Active",true)
					DoScreenFadeIn(2500)
				end
			end)

			while true do
				local Ped = PlayerPedId()
				if not IsPedInAnyVehicle(Ped) then
					if IsScreenFadedIn() then
						DoScreenFadeOut(0)
					end

					vSERVER.Remove()
					SetEntityCoords(Ped,TestDriveReturn["xyz"])
					LocalPlayer["state"]:set("Commands",false,true)
					LocalPlayer["state"]:set("TestDrive",false,false)

					if DoesEntityExist(Mount) then
						DeleteEntity(Mount)

						SetTimeout(2500,function()
							if IsScreenFadedOut() then
								DoScreenFadeIn(2500)
							end
						end)

						break
					end
				end

				Wait(1)
			end
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("pdm:Close",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)

	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		LastModel = ""
		Camera = nil
	end
end)