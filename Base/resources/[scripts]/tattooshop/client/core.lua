 -----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tattooshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Camera = nil
local Default = nil
local Tattooshop = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TATTOOSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tattooshop:Apply")
AddEventHandler("tattooshop:Apply",function(Table)
	Tattooshop = Table
	exports["tattooshop"]:Apply()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Table,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Table then
		Tattooshop = Table
	end

	ClearPedDecorations(Ped)

	for Index,Overlay in pairs(Tattooshop) do
		AddPedDecorationFromHashes(Ped,Overlay,Index)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENTATTOOSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenTattooshop()
	CameraActive()
	SetNuiFocus(true,true)

	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Active = Dataset["mp_f_freemode_01"]

		Clothes(Ped,"mp_f_freemode_01")
	else
		Active = Dataset["mp_m_freemode_01"]

		Clothes(Ped,"mp_m_freemode_01")
	end

	ClearAllPedProps(Ped)

	LocalPlayer["state"]:set("Hoverfy",false,false)
	vRP.PlayAnim(true,{"mp_sleep","bind_pose_180"},true)

	SendNUIMessage({ shop = Active, tattoo = Tattooshop })
end
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

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.25,1.0,0.0)

	SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"])

	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,Heading + 180)
	SetEntityHeading(Ped,Heading)
	SetCamActive(Camera,true)
	Default = Coords["z"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["skinshop"]:Apply()
	vSERVER.Update(Tattooshop)
	SetNuiFocus(false,false)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	local Tables = {}
	for Number = 1,#Locations do
		Tables[#Tables + 1] = { Locations[Number],2.0,"E","Tatuagem","Pressione para abrir" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1,#Locations do
				if #(Coords - Locations[Number]) <= 2.0 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() then
						OpenTattooshop()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Change",function(Data,Callback)
	local Ped = PlayerPedId()
	local Number = Data["id"]
	local Types = Data["type"]

	if Active[Types] and Active[Types][Number] then
		local Name = Active[Types][Number]["name"]

		if Tattooshop[Name] then
			Tattooshop[Name] = nil
		else
			Tattooshop[Name] = Active[Types][Number]["part"]
		end

		ClearPedDecorations(Ped)

		for Index,Overlay in pairs(Tattooshop) do
			AddPedDecorationFromHashes(Ped,Overlay,Index)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Clean",function(Data,Callback)
	ClearPedDecorations(PlayerPedId())
	Tattooshop = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()

	if Data["direction"] == "Left" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) - 5)
	elseif Data["direction"] == "Right" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) + 5)
	elseif Data["direction"] == "Top" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] + 0.05 <= Default + 0.50 then
			SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.05)
		end
	elseif Data["direction"] == "Bottom" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] - 0.05 >= Default - 0.50 then
			SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] - 0.05)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandsUp",function(Data,Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
		StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
		vRP.AnimActive()
	else
		vRP.PlayAnim(true,{"random@mugging3","handsup_standing_base"},true)
	end

	Callback("Ok")
end)