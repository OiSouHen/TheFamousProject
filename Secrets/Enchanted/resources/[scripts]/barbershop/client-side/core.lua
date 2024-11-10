-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lasted = {}
local Camera = nil
local Default = nil
local Barbershop = {}
local Creation = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	if Creation then
		DoScreenFadeOut(0)
		FreezeEntityPosition(PlayerPedId(),false)

		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
	else
		TriggerEvent("hud:Active",true)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	vSERVER.Update(Barbershop,Creation)
	SetNuiFocus(false,false)
	Creation = false
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Reset",function(Data,Callback)
	if Creation then
		DoScreenFadeOut(0)
		FreezeEntityPosition(PlayerPedId(),false)

		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
	else
		TriggerEvent("hud:Active",true)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["barbershop"]:Apply(Lasted)
	vSERVER.Update(Lasted,Creation)
	SetNuiFocus(false,false)
	Creation = false
	vRP.Destroy()
	Lasted = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	exports["barbershop"]:Apply(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply",function(Data)
	exports["barbershop"]:Apply(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Data,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Data then
		Barbershop = Data
	end

	for Number = 1,46 do
		if not Barbershop[Number] then
			if Number >= 6 and Number <= 9 then
				Barbershop[Number] = -1
			else
				Barbershop[Number] = 0
			end
		end
	end

	SetPedHeadBlendData(Ped,Barbershop[1],Barbershop[2],0,Barbershop[5],Barbershop[5],0,Barbershop[3] + 0.0,0,0,false)

	SetPedEyeColor(Ped,Barbershop[4])

	SetPedComponentVariation(Ped,2,Barbershop[10],0,0)
	SetPedHairColor(Ped,Barbershop[11],Barbershop[12])

	SetPedHeadOverlay(Ped,0,Barbershop[7],1.0)
	SetPedHeadOverlayColor(Ped,0,0,0,0)

	SetPedHeadOverlay(Ped,1,Barbershop[22],Barbershop[23] + 0.0)
	SetPedHeadOverlayColor(Ped,1,1,Barbershop[24],Barbershop[24])

	SetPedHeadOverlay(Ped,2,Barbershop[19],Barbershop[20] + 0.0)
	SetPedHeadOverlayColor(Ped,2,1,Barbershop[21],Barbershop[21])

	SetPedHeadOverlay(Ped,3,Barbershop[9],1.0)
	SetPedHeadOverlayColor(Ped,3,0,0,0)

	SetPedHeadOverlay(Ped,4,Barbershop[13],Barbershop[14] + 0.0)
	SetPedHeadOverlayColor(Ped,4,0,0,0)

	SetPedHeadOverlay(Ped,5,Barbershop[25],Barbershop[26] + 0.0)
	SetPedHeadOverlayColor(Ped,5,2,Barbershop[27],Barbershop[27])

	SetPedHeadOverlay(Ped,6,Barbershop[6],1.0)
	SetPedHeadOverlayColor(Ped,6,0,0,0)

	SetPedHeadOverlay(Ped,8,Barbershop[16],Barbershop[17] + 0.0)
	SetPedHeadOverlayColor(Ped,8,2,Barbershop[18],Barbershop[18])

	SetPedHeadOverlay(Ped,9,Barbershop[8],1.0)
	SetPedHeadOverlayColor(Ped,9,0,0,0)

	SetPedFaceFeature(Ped,0,Barbershop[28] + 0.0)
	SetPedFaceFeature(Ped,1,Barbershop[29] + 0.0)
	SetPedFaceFeature(Ped,2,Barbershop[30] + 0.0)
	SetPedFaceFeature(Ped,3,Barbershop[31] + 0.0)
	SetPedFaceFeature(Ped,4,Barbershop[32] + 0.0)
	SetPedFaceFeature(Ped,5,Barbershop[33] + 0.0)
	SetPedFaceFeature(Ped,6,Barbershop[44] + 0.0)
	SetPedFaceFeature(Ped,7,Barbershop[34] + 0.0)
	SetPedFaceFeature(Ped,8,Barbershop[36] + 0.0)
	SetPedFaceFeature(Ped,9,Barbershop[35] + 0.0)
	SetPedFaceFeature(Ped,10,Barbershop[45] + 0.0)
	SetPedFaceFeature(Ped,11,Barbershop[15] + 0.0)
	SetPedFaceFeature(Ped,12,Barbershop[42] + 0.0)
	SetPedFaceFeature(Ped,13,Barbershop[46] + 0.0)
	SetPedFaceFeature(Ped,14,Barbershop[37] + 0.0)
	SetPedFaceFeature(Ped,15,Barbershop[38] + 0.0)
	SetPedFaceFeature(Ped,16,Barbershop[40] + 0.0)
	SetPedFaceFeature(Ped,17,Barbershop[39] + 0.0)
	SetPedFaceFeature(Ped,18,Barbershop[41] + 0.0)
	SetPedFaceFeature(Ped,19,Barbershop[43] + 0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop(Mode)
	for Number = 1,46 do
		if not Barbershop[Number] then
			if Number >= 6 and Number <= 9 then
				Barbershop[Number] = -1
			else
				Barbershop[Number] = 0
			end
		end
	end

	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	LocalPlayer["state"]:set("Hoverfy",false,false)
	TriggerEvent("hud:Active",false)
	Lasted = Barbershop

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,-0.05,0.7,0.5)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"])
	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,Heading + 200)
	SetEntityHeading(Ped,Heading)
	SetCamActive(Camera,true)
	Default = Coords["z"]

	if Creation then
		Wait(2500)

		if IsScreenFadedOut() then
			DoScreenFadeIn(2500)
		end
	end

	SendNUIMessage({ Action = "Open", Payload = { Barbershop,GetNumberOfPedDrawableVariations(Ped,2) - 1,Mode } })
	SetNuiFocus(true,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	vec3(-813.37,-183.85,37.57),
	vec3(138.13,-1706.46,29.3),
	vec3(-1280.92,-1117.07,7.0),
	vec3(1930.54,3732.06,32.85),
	vec3(1214.2,-473.18,66.21),
	vec3(-33.61,-154.52,57.08),
	vec3(-276.65,6226.76,31.7)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Number = 1,#Locations do
		Tables[#Tables + 1] = { Locations[Number],2.5,"E","Pressione","para abrir" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Number = 1,#Locations do
				if #(Coords - Locations[Number]) <= 2.5 then
					TimeDistance = 1

					if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() then
						OpenBarbershop(vSERVER.Mode())
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATION
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Creation",function(Heading)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityHeading(PlayerPedId(),Heading)
	Creation = true

	OpenBarbershop(true)
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