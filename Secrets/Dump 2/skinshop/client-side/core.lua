-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("skinshop",Creative)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lasted = {}
local Init = "hat"
local Camera = nil
local Default = nil
local Skinshop = {}
local Animation = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCLUDE
-----------------------------------------------------------------------------------------------------------------------------------------
local Exclude = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXVALUER
-----------------------------------------------------------------------------------------------------------------------------------------
local MaxValuer = {
	["pants"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 4 },
	["arms"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 3 },
	["tshirt"] = { min = 1, item = 0, texture = 0, mode = "variation", id = 8 },
	["torso"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 11 },
	["vest"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 9 },
	["shoes"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 6 },
	["mask"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 1 },
	["backpack"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 5 },
	["hat"] = { min = -1, item = 0, texture = 0, mode = "prop", id = 0 },
	["glass"] = { min = 0, item = 0, texture = 0, mode = "prop", id = 1 },
	["ear"] = { min = -1, item = 0, texture = 0, mode = "prop", id = 2 },
	["watch"] = { min = -1, item = 0, texture = 0, mode = "prop", id = 6 },
	["bracelet"] = { min = -1, item = 0, texture = 0, mode = "prop", id = 7 },
	["accessory"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 7 },
	["decals"] = { min = 0, item = 0, texture = 0, mode = "variation", id = 10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	vec3(71.29,-1398.68,29.37),
	vec3(-708.56,-160.5,37.41),
	vec3(-158.76,-296.94,39.73),
	vec3(-829.08,-1073.27,11.32),
	vec3(-1192.23,-771.74,17.32),
	vec3(-1456.98,-241.17,49.81),
	vec3(11.87,6513.59,31.88),
	vec3(1696.92,4829.24,42.06),
	vec3(122.93,-221.48,54.56),
	vec3(617.77,2761.81,42.09),
	vec3(1190.79,2714.29,38.22),
	vec3(-3173.28,1046.04,20.86),
	vec3(-1108.61,2709.59,19.11),
	vec3(429.67,-800.14,29.49),
	vec3(480.78,-1009.08,30.68),
	vec3(474.41,-992.92,30.68)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATASET
-----------------------------------------------------------------------------------------------------------------------------------------
local Dataset = {
	["pants"] = { item = 0, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Apply")
AddEventHandler("skinshop:Apply",function(Table,Save)
	for Index,v in pairs(Dataset) do
		if not Table[Index] then
			Table[Index] = v
		end
	end

	Skinshop = Table
	exports["skinshop"]:Apply()

	if not Save then
		vSERVER.Update(Skinshop)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Number = 1,#Locations do
		Tables[#Tables + 1] = { Locations[Number],2.0,"E","Pressione","para abrir" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
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

					if IsControlJustPressed(0,38) and not exports["hud"]:Wanted() and not exports["hud"]:Repose() then
						OpenSkinshop()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Open")
AddEventHandler("skinshop:Open",function()
	TriggerEvent("dynamic:Close")

	if not exports["hud"]:Wanted() and not exports["hud"]:Repose() then
		OpenSkinshop()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function MaxValues()
	local Ped = PlayerPedId()
	local NewValues = MaxValuer
	for Index,v in pairs(NewValues) do
		if v["mode"] == "variation" then
			v["item"] = GetNumberOfPedDrawableVariations(Ped,v["id"]) - 1
			v["texture"] = GetNumberOfPedTextureVariations(Ped,v["id"],GetPedDrawableVariation(Ped,v["id"])) - 1
		elseif v["mode"] == "prop" then
			v["item"] = GetNumberOfPedPropDrawableVariations(Ped,v["id"]) - 1
			v["texture"] = GetNumberOfPedPropTextureVariations(Ped,v["id"],GetPedPropIndex(Ped,v["id"])) - 1
		end

		if v["texture"] < 0 then
			v["texture"] = 0
		end
	end

	return NewValues
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenSkinshop()
	Lasted = Skinshop
	SetNuiFocus(true,true)
	TriggerEvent("hud:Active",false)
	LocalPlayer["state"]:set("Hoverfy",false,false)
	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	SendNUIMessage({ Action = "Open", Payload = { Skinshop,MaxValues(),Exclude } })

	CameraActive()
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

	if Init == "hat" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.45)
	elseif Init == "shirt" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.25)
	elseif Init == "pants" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] - 0.45)
	elseif Init == "clock" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.05)
	end

	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,Heading + 180)
	SetEntityHeading(Ped,Heading)
	SetCamActive(Camera,true)
	Default = Coords["z"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply",function(Data,Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Data then
		Skinshop = Data
	end

	for Index,v in pairs(Dataset) do
		if not Skinshop[Index] then
			Skinshop[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped,4,Skinshop["pants"]["item"],Skinshop["pants"]["texture"],GetPedPaletteVariation(Ped,4))
	SetPedComponentVariation(Ped,3,Skinshop["arms"]["item"],Skinshop["arms"]["texture"],GetPedPaletteVariation(Ped,3))
	SetPedComponentVariation(Ped,5,Skinshop["backpack"]["item"],Skinshop["backpack"]["texture"],GetPedPaletteVariation(Ped,5))
	SetPedComponentVariation(Ped,8,Skinshop["tshirt"]["item"],Skinshop["tshirt"]["texture"],GetPedPaletteVariation(Ped,8))
	SetPedComponentVariation(Ped,9,Skinshop["vest"]["item"],Skinshop["vest"]["texture"],GetPedPaletteVariation(Ped,9))
	SetPedComponentVariation(Ped,11,Skinshop["torso"]["item"],Skinshop["torso"]["texture"],GetPedPaletteVariation(Ped,11))
	SetPedComponentVariation(Ped,6,Skinshop["shoes"]["item"],Skinshop["shoes"]["texture"],GetPedPaletteVariation(Ped,6))
	SetPedComponentVariation(Ped,1,Skinshop["mask"]["item"],Skinshop["mask"]["texture"],GetPedPaletteVariation(Ped,1))
	SetPedComponentVariation(Ped,10,Skinshop["decals"]["item"],Skinshop["decals"]["texture"],GetPedPaletteVariation(Ped,10))
	SetPedComponentVariation(Ped,7,Skinshop["accessory"]["item"],Skinshop["accessory"]["texture"],GetPedPaletteVariation(Ped,7))

	if Skinshop["hat"]["item"] ~= -1 and Skinshop["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,Skinshop["hat"]["item"],Skinshop["hat"]["texture"],false)
	else
		ClearPedProp(Ped,0)
	end

	if Skinshop["glass"]["item"] ~= -1 and Skinshop["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,Skinshop["glass"]["item"],Skinshop["glass"]["texture"],false)
	else
		ClearPedProp(Ped,1)
	end

	if Skinshop["ear"]["item"] ~= -1 and Skinshop["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,Skinshop["ear"]["item"],Skinshop["ear"]["texture"],false)
	else
		ClearPedProp(Ped,2)
	end

	if Skinshop["watch"]["item"] ~= -1 and Skinshop["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,Skinshop["watch"]["item"],Skinshop["watch"]["texture"],false)
	else
		ClearPedProp(Ped,6)
	end

	if Skinshop["bracelet"]["item"] ~= -1 and Skinshop["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,Skinshop["bracelet"]["item"],Skinshop["bracelet"]["texture"],false)
	else
		ClearPedProp(Ped,7)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	Skinshop = Data["clothes"]
	exports["skinshop"]:Apply()

	local Texture = 0
	local Ped = PlayerPedId()
	local Index = Data["index"]
	local MaxValue = MaxValuer[Index]

	if MaxValue["mode"] == "variation" then
		Texture = GetNumberOfPedTextureVariations(Ped,MaxValue["id"],GetPedDrawableVariation(Ped,MaxValue["id"])) - 1
	elseif MaxValue["mode"] == "prop" then
		Texture = GetNumberOfPedPropTextureVariations(Ped,MaxValue["id"],GetPedPropIndex(Ped,MaxValue["id"])) - 1
	end

	if Texture < 0 then
		Texture = 0
	end

	Callback(Texture)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Setup",function(Data,Callback)
	Init = Data["value"]
	local Ped = PlayerPedId()
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.25,1.0,0.0)

	if Init == "hat" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.45)
	elseif Init == "shirt" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.25)
	elseif Init == "pants" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] - 0.45)
	elseif Init == "clock" then
		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 0.05)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	TriggerEvent("hud:Active",true)
	SetNuiFocus(false,false)
	vSERVER.Update(Skinshop)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Reset",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["skinshop"]:Apply(Lasted)
	TriggerEvent("hud:Active",true)
	SetNuiFocus(false,false)
	Skinshop = Lasted
	vRP.Destroy()
	Lasted = {}

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
-- CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkShoes()
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if Skinshop["shoes"]["item"] ~= Number then
		Skinshop["shoes"]["item"] = Number
		Skinshop["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped,6,Skinshop["shoes"]["item"],Skinshop["shoes"]["texture"],GetPedPaletteVariation(Ped,6))

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Customization()
	return Skinshop
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandsUp",function(Data,Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
		StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
		vRP.AnimActive()
	else
		vRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,1) == Skinshop["mask"]["item"] then
		SetPedComponentVariation(Ped,1,0,0,GetPedPaletteVariation(Ped,1))
	else
		SetPedComponentVariation(Ped,1,Skinshop["mask"]["item"],Skinshop["mask"]["texture"],GetPedPaletteVariation(Ped,1))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	local Ped = PlayerPedId()
	if GetPedPropIndex(Ped,0) == Skinshop["hat"]["item"] then
		ClearPedProp(Ped,0)
	else
		SetPedPropIndex(Ped,0,Skinshop["hat"]["item"],Skinshop["hat"]["texture"],false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	local Ped = PlayerPedId()
	if GetPedPropIndex(Ped,1) == Skinshop["glass"]["item"] then
		ClearPedProp(Ped,1)
	else
		SetPedPropIndex(Ped,1,Skinshop["glass"]["item"],Skinshop["glass"]["texture"],false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPANTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setPants")
AddEventHandler("skinshop:setPants",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,4) == Skinshop["pants"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped,4,17,0,GetPedPaletteVariation(Ped,4))
		else
			SetPedComponentVariation(Ped,4,61,0,GetPedPaletteVariation(Ped,4))
		end
	else
		SetPedComponentVariation(Ped,4,Skinshop["pants"]["item"],Skinshop["pants"]["texture"],2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHIRT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShirt")
AddEventHandler("skinshop:setShirt",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,8) == Skinshop["tshirt"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped,8,7,0,GetPedPaletteVariation(Ped,8))
		else
			SetPedComponentVariation(Ped,8,15,0,GetPedPaletteVariation(Ped,8))
		end
	else
		SetPedComponentVariation(Ped,8,Skinshop["tshirt"]["item"],Skinshop["tshirt"]["texture"],2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTORSO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setTorso")
AddEventHandler("skinshop:setTorso",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,11) == Skinshop["torso"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped,11,18,0,2)
		else
			SetPedComponentVariation(Ped,11,15,0,2)
		end
	else
		SetPedComponentVariation(Ped,11,Skinshop["torso"]["item"],Skinshop["torso"]["texture"],2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETVEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setVest")
AddEventHandler("skinshop:setVest",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,9) == Skinshop["vest"]["item"] then
		SetPedComponentVariation(Ped,9,-1,0,GetPedPaletteVariation(Ped,9))
	else
		SetPedComponentVariation(Ped,9,Skinshop["vest"]["item"],Skinshop["vest"]["texture"],GetPedPaletteVariation(Ped,9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShoes")
AddEventHandler("skinshop:setShoes",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,6) == Skinshop["shoes"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped,6,35,0,GetPedPaletteVariation(Ped,6))
		else
			SetPedComponentVariation(Ped,6,34,0,GetPedPaletteVariation(Ped,6))
		end
	else
		SetPedComponentVariation(Ped,6,Skinshop["shoes"]["item"],Skinshop["shoes"]["texture"],2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,3) == Skinshop["arms"]["item"] then
		SetPedComponentVariation(Ped,3,15,0,GetPedPaletteVariation(Ped,3))
	else
		SetPedComponentVariation(Ped,3,Skinshop["arms"]["item"],Skinshop["arms"]["texture"],GetPedPaletteVariation(Ped,3))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACCESSORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setAccessory")
AddEventHandler("skinshop:setAccessory",function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped,7) == Skinshop["accessory"]["item"] then
		SetPedComponentVariation(Ped,7,-1,0,GetPedPaletteVariation(Ped,7))
	else
		SetPedComponentVariation(Ped,7,Skinshop["accessory"]["item"],Skinshop["accessory"]["texture"],GetPedPaletteVariation(Ped,7))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:BACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Backpack")
AddEventHandler("skinshop:Backpack",function(Table)
	local Ped = PlayerPedId()
	if Table["mp_f_freemode_01"] and GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Skinshop["backpack"]["item"] = Table["mp_f_freemode_01"]["Model"]
		Skinshop["backpack"]["texture"] = Table["mp_f_freemode_01"]["Texture"]
	elseif Table["mp_m_freemode_01"] and GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") then
		Skinshop["backpack"]["item"] = Table["mp_m_freemode_01"]["Model"]
		Skinshop["backpack"]["texture"] = Table["mp_m_freemode_01"]["Texture"]
	end

	SetPedComponentVariation(Ped,5,Skinshop["backpack"]["item"],Skinshop["backpack"]["texture"],GetPedPaletteVariation(Ped,5))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:BACKPACKREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:BackpackRemove")
AddEventHandler("skinshop:BackpackRemove",function()
	local Ped = PlayerPedId()
	Skinshop["backpack"]["item"] = -1
	Skinshop["backpack"]["texture"] = 0
	SetPedComponentVariation(Ped,5,Skinshop["backpack"]["item"],Skinshop["backpack"]["texture"],GetPedPaletteVariation(Ped,5))
end)