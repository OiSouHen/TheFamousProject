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
		SendNUIMessage({ name = "Open", payload = VehicleList() })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
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

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	if LoadModel(Data) and LastModel ~= Data then
		if DoesEntityExist(Mount) then
			DeleteEntity(Mount)
		end

		Mount = CreateVehicle(Data,SpawnCoords,false,false)
		SetVehicleCustomSecondaryColour(Mount,19,114,191)
		SetVehicleCustomPrimaryColour(Mount,19,114,191)
		SetVehicleNumberPlateText(Mount,"PDMSPORT")
		SetEntityCollision(Mount,false,false)
		FreezeEntityPosition(Mount,true)
		SetEntityInvincible(Mount,true)
		SetVehicleDirtLevel(Mount,0.0)
		SetModelAsNoLongerNeeded(Data)
		LastModel = Data
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	vSERVER.Buy(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	if DoesEntityExist(Mount) then
		if Data == "Left" then
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

		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)

		if LoadModel(Data) then
			if DoesEntityExist(Mount) then
				DeleteEntity(Mount)
			end

			Mount = CreateVehicle(Data,TestDriveCoords,false,false)

			SetVehicleModKit(Mount,0)
			SetVehicleDirtLevel(Mount,0.0)
			ToggleVehicleMod(Mount,18,true)
			SetEntityInvincible(Mount,true)
			SetPedIntoVehicle(PlayerPedId(),Mount,-1)
			SetVehicleNumberPlateText(Mount,"PDMSPORT")
			SetVehicleCustomPrimaryColour(Mount,19,114,191)
			SetVehicleCustomSecondaryColour(Mount,19,114,191)
			SetVehicleMod(Mount,11,GetNumVehicleMods(Mount,11) - 1,false)
			SetVehicleMod(Mount,12,GetNumVehicleMods(Mount,12) - 1,false)
			SetVehicleMod(Mount,13,GetNumVehicleMods(Mount,13) - 1,false)
			SetVehicleMod(Mount,15,GetNumVehicleMods(Mount,15) - 1,false)

			SetModelAsNoLongerNeeded(Data)

			LocalPlayer["state"]:set("Commands",true,true)
			LocalPlayer["state"]:set("TestDrive",true,false)

			SetTimeout(2500,function()
				if IsScreenFadedOut() then
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