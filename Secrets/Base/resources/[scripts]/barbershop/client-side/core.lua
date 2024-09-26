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
local Barbershop = {}
local Creation = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Finish",function(Data,Callback)
	if Creation then
		DoScreenFadeOut(0)
		FreezeEntityPosition(PlayerPedId(),false)

		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["barbershop"]:Apply(Data)
	vSERVER.Update(Data,Creation)
	SetNuiFocus(false,false)
	Creation = false
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel",function(Data,Callback)
	if Creation then
		DoScreenFadeOut(0)
		FreezeEntityPosition(PlayerPedId(),false)

		SetTimeout(2500,function()
			TriggerEvent("hud:Active",true)
			DoScreenFadeIn(2500)
		end)
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
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)

	if Data == "Left" then
		SetEntityHeading(Ped,Heading - 10)
	else
		SetEntityHeading(Ped,Heading + 10)
	end

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
			Barbershop[Number] = 0
		end
	end

	SetPedHeadBlendData(Ped,Fathers[Barbershop[1] + 1],Mothers[Barbershop[2] + 1],0,Barbershop[5],0,0,Barbershop[3] + 0.0,0,0,false)

	SetPedEyeColor(Ped,Barbershop[4])

	SetPedComponentVariation(Ped,2,Barbershop[10],0,0)
	SetPedHairColor(Ped,Barbershop[11],Barbershop[12])

	SetPedHeadOverlay(Ped,0,Barbershop[7],1.0)
	SetPedHeadOverlayColor(Ped,0,0,0,0)

	SetPedHeadOverlay(Ped,1,Barbershop[22],Barbershop[23])
	SetPedHeadOverlayColor(Ped,1,1,Barbershop[24],Barbershop[24])

	SetPedHeadOverlay(Ped,2,Barbershop[19],Barbershop[20])
	SetPedHeadOverlayColor(Ped,2,1,Barbershop[21],Barbershop[21])

	SetPedHeadOverlay(Ped,3,Barbershop[9],1.0)
	SetPedHeadOverlayColor(Ped,3,0,0,0)

	SetPedHeadOverlay(Ped,4,Barbershop[13],Barbershop[14])
	SetPedHeadOverlayColor(Ped,4,0,0,0)

	SetPedHeadOverlay(Ped,5,Barbershop[25],Barbershop[26])
	SetPedHeadOverlayColor(Ped,5,2,Barbershop[27],Barbershop[27])

	SetPedHeadOverlay(Ped,6,Barbershop[6],1.0)
	SetPedHeadOverlayColor(Ped,6,0,0,0)

	SetPedHeadOverlay(Ped,8,Barbershop[16],Barbershop[17])
	SetPedHeadOverlayColor(Ped,8,2,Barbershop[18],Barbershop[18])

	SetPedHeadOverlay(Ped,9,Barbershop[8],1.0)
	SetPedHeadOverlayColor(Ped,9,0,0,0)

	SetPedFaceFeature(Ped,0,Barbershop[28])
	SetPedFaceFeature(Ped,1,Barbershop[29])
	SetPedFaceFeature(Ped,2,Barbershop[30])
	SetPedFaceFeature(Ped,3,Barbershop[31])
	SetPedFaceFeature(Ped,4,Barbershop[32])
	SetPedFaceFeature(Ped,5,Barbershop[33])
	SetPedFaceFeature(Ped,6,Barbershop[44])
	SetPedFaceFeature(Ped,7,Barbershop[34])
	SetPedFaceFeature(Ped,8,Barbershop[36])
	SetPedFaceFeature(Ped,9,Barbershop[35])
	SetPedFaceFeature(Ped,10,Barbershop[45])
	SetPedFaceFeature(Ped,11,Barbershop[15])
	SetPedFaceFeature(Ped,12,Barbershop[42])
	SetPedFaceFeature(Ped,13,Barbershop[46])
	SetPedFaceFeature(Ped,14,Barbershop[37])
	SetPedFaceFeature(Ped,15,Barbershop[38])
	SetPedFaceFeature(Ped,16,Barbershop[40])
	SetPedFaceFeature(Ped,17,Barbershop[39])
	SetPedFaceFeature(Ped,18,Barbershop[41])
	SetPedFaceFeature(Ped,19,Barbershop[43])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop()
	for Number = 1,46 do
		if not Barbershop[Number] then
			Barbershop[Number] = 0
		end
	end

	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	LocalPlayer["state"]:set("Hoverfy",false,false)
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

	if Creation then
		Wait(2500)

		if IsScreenFadedOut() then
			DoScreenFadeIn(2500)
		end
	end

	SendNUIMessage({ name = "Open", payload = { Barbershop, GetNumberOfPedDrawableVariations(Ped,2) - 1 } })
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
		Tables[#Tables + 1] = { Locations[Number],2.5,"E","Barbearia","Pressione para abrir" }
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
						OpenBarbershop()
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

	OpenBarbershop()
end)