-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("skinshop", Hensa)
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
AddEventHandler("skinshop:Apply", function(Table, Save)
	for Index, v in pairs(Dataset) do
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
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	local Tables = {}
	for Number = 1,#SkinLocations do
		Tables[#Tables + 1] = { SkinLocations[Number],2.0,"E","Roupas","Pressione para abrir" }
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

			for Number = 1, #SkinLocations do
				if #(Coords - SkinLocations[Number]) <= 2.0 then
					TimeDistance = 1

					if IsControlJustPressed(0, 38) and not exports["hud"]:Wanted() and not exports["hud"]:Reposed() then
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
AddEventHandler("skinshop:Open", function()
	TriggerEvent("dynamic:Close")

	if not exports["hud"]:Wanted() and not exports["hud"]:Reposed() then
		OpenSkinshop()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function MaxValues()
	local MaxValues = {
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

	local Ped = PlayerPedId()
	for Index, v in pairs(MaxValues) do
		if v["mode"] == "variation" then
			v["item"] = GetNumberOfPedDrawableVariations(Ped, v["id"]) - 1
			v["texture"] = GetNumberOfPedTextureVariations(Ped, v["id"], GetPedDrawableVariation(Ped, v["id"])) - 1
		elseif v["mode"] == "prop" then
			v["item"] = GetNumberOfPedPropDrawableVariations(Ped, v["id"]) - 1
			v["texture"] = GetNumberOfPedPropTextureVariations(Ped, v["id"], GetPedPropIndex(Ped, v["id"])) - 1
		end

		if v["texture"] < 0 then
			v["texture"] = 0
		end
	end

	return MaxValues
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSKINSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenSkinshop()
	Lasted = Skinshop
	LocalPlayer["state"]:set("Hoverfy",false,false)
	vRP.PlayAnim(true, { "mp_sleep", "bind_pose_180" }, true)
	SendNUIMessage({ name = "open", payload = { Current = Skinshop, Max = MaxValues() } })

	SetNuiFocus(true, true)
	CameraActive()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.25, 1.0, 0.0)

	if Init == "hat" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.45)
	elseif Init == "shirt" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.25)
	elseif Init == "pants" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] - 0.45)
	elseif Init == "clock" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.05)
	end

	RenderScriptCams(true, false, 0, false, false)
	SetCamRot(Camera, 0.0, 0.0, Heading + 180)
	SetEntityHeading(Ped, Heading)
	SetCamActive(Camera, true)
	Default = Coords["z"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Apply", function(Data, Ped)
	if not Ped then
		Ped = PlayerPedId()
	end

	if Data then
		Skinshop = Data
	end

	for Index, v in pairs(Dataset) do
		if not Skinshop[Index] then
			Skinshop[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped, 4, Skinshop["pants"]["item"], Skinshop["pants"]["texture"], GetPedPaletteVariation(Ped, 4))
	SetPedComponentVariation(Ped, 3, Skinshop["arms"]["item"], Skinshop["arms"]["texture"], GetPedPaletteVariation(Ped, 3))
	SetPedComponentVariation(Ped, 5, Skinshop["backpack"]["item"], Skinshop["backpack"]["texture"], GetPedPaletteVariation(Ped, 5))
	SetPedComponentVariation(Ped, 8, Skinshop["tshirt"]["item"], Skinshop["tshirt"]["texture"], GetPedPaletteVariation(Ped, 8))
	SetPedComponentVariation(Ped, 9, Skinshop["vest"]["item"], Skinshop["vest"]["texture"], GetPedPaletteVariation(Ped, 9))
	SetPedComponentVariation(Ped, 11, Skinshop["torso"]["item"], Skinshop["torso"]["texture"], GetPedPaletteVariation(Ped, 11))
	SetPedComponentVariation(Ped, 6, Skinshop["shoes"]["item"], Skinshop["shoes"]["texture"], GetPedPaletteVariation(Ped, 6))
	SetPedComponentVariation(Ped, 1, Skinshop["mask"]["item"], Skinshop["mask"]["texture"], GetPedPaletteVariation(Ped, 1))
	SetPedComponentVariation(Ped, 10, Skinshop["decals"]["item"], Skinshop["decals"]["texture"], GetPedPaletteVariation(Ped, 10))
	SetPedComponentVariation(Ped, 7, Skinshop["accessory"]["item"], Skinshop["accessory"]["texture"], GetPedPaletteVariation(Ped, 7))

	if Skinshop["hat"]["item"] ~= -1 and Skinshop["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped, 0, Skinshop["hat"]["item"], Skinshop["hat"]["texture"], false)
	else
		ClearPedProp(Ped, 0)
	end

	if Skinshop["glass"]["item"] ~= -1 and Skinshop["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped, 1, Skinshop["glass"]["item"], Skinshop["glass"]["texture"], false)
	else
		ClearPedProp(Ped, 1)
	end

	if Skinshop["ear"]["item"] ~= -1 and Skinshop["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped, 2, Skinshop["ear"]["item"], Skinshop["ear"]["texture"], false)
	else
		ClearPedProp(Ped, 2)
	end

	if Skinshop["watch"]["item"] ~= -1 and Skinshop["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped, 6, Skinshop["watch"]["item"], Skinshop["watch"]["texture"], false)
	else
		ClearPedProp(Ped, 6)
	end

	if Skinshop["bracelet"]["item"] ~= -1 and Skinshop["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped, 7, Skinshop["bracelet"]["item"], Skinshop["bracelet"]["texture"], false)
	else
		ClearPedProp(Ped, 7)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("update", function(Data, Callback)
	Skinshop = Data
	exports["skinshop"]:Apply()

	Callback(MaxValues())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Setup", function(Data, Callback)
	Init = Data["value"]
	local Ped = PlayerPedId()
	local Coords = GetOffsetFromEntityInWorldCoords(Ped, 0.25, 1.0, 0.0)

	if Init == "hat" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.45)
	elseif Init == "shirt" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.25)
	elseif Init == "pants" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] - 0.45)
	elseif Init == "clock" then
		SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.05)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	SetNuiFocus(false, false)
	vSERVER.Update(Skinshop)
	vRP.Destroy()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Reset", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	LocalPlayer["state"]:set("Hoverfy",true,false)
	exports["skinshop"]:Apply(Lasted)
	SetNuiFocus(false, false)
	Skinshop = Lasted
	vRP.Destroy()
	Lasted = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate", function(Data, Callback)
	local Ped = PlayerPedId()

	if Data == "Left" then
		SetEntityHeading(Ped, GetEntityHeading(Ped) - 5)
	elseif Data == "Right" then
		SetEntityHeading(Ped, GetEntityHeading(Ped) + 5)
	elseif Data == "Top" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] + 0.05 <= Default + 0.50 then
			SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] + 0.05)
		end
	elseif Data == "Bottom" then
		local Coords = GetCamCoord(Camera)
		if Coords["z"] - 0.05 >= Default - 0.50 then
			SetCamCoord(Camera, Coords["x"], Coords["y"], Coords["z"] - 0.05)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 1) == Skinshop["mask"]["item"] then
		SetPedComponentVariation(Ped, 1, 0, 0, GetPedPaletteVariation(Ped, 1))
	else
		SetPedComponentVariation(Ped, 1, Skinshop["mask"]["item"], Skinshop["mask"]["texture"], GetPedPaletteVariation(Ped, 1))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat", function()
	local Ped = PlayerPedId()
	if GetPedPropIndex(Ped, 0) == Skinshop["hat"]["item"] then
		ClearPedProp(Ped, 0)
	else
		SetPedPropIndex(Ped, 0, Skinshop["hat"]["item"], Skinshop["hat"]["texture"], false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses", function()
	local Ped = PlayerPedId()
	if GetPedPropIndex(Ped, 1) == Skinshop["glass"]["item"] then
		ClearPedProp(Ped, 1)
	else
		SetPedPropIndex(Ped, 1, Skinshop["glass"]["item"], Skinshop["glass"]["texture"], false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPANTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setPants")
AddEventHandler("skinshop:setPants", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 4) == Skinshop["pants"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped, 4, 17, 0, GetPedPaletteVariation(Ped, 4))
		else
			SetPedComponentVariation(Ped, 4, 61, 0, GetPedPaletteVariation(Ped, 4))
		end
	else
		SetPedComponentVariation(Ped, 4, Skinshop["pants"]["item"], Skinshop["pants"]["texture"], 2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHIRT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShirt")
AddEventHandler("skinshop:setShirt", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 8) == Skinshop["tshirt"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped, 8, 7, 0, GetPedPaletteVariation(Ped, 8))
		else
			SetPedComponentVariation(Ped, 8, 15, 0, GetPedPaletteVariation(Ped, 8))
		end
	else
		SetPedComponentVariation(Ped, 8, Skinshop["tshirt"]["item"], Skinshop["tshirt"]["texture"], 2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETTORSO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setTorso")
AddEventHandler("skinshop:setTorso", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 11) == Skinshop["torso"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped, 11, 18, 0, 2)
		else
			SetPedComponentVariation(Ped, 11, 15, 0, 2)
		end
	else
		SetPedComponentVariation(Ped, 11, Skinshop["torso"]["item"], Skinshop["torso"]["texture"], 2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETVEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setVest")
AddEventHandler("skinshop:setVest", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 9) == Skinshop["vest"]["item"] then
		SetPedComponentVariation(Ped, 9, -1, 0, GetPedPaletteVariation(Ped, 9))
	else
		SetPedComponentVariation(Ped, 9, Skinshop["vest"]["item"], Skinshop["vest"]["texture"], GetPedPaletteVariation(Ped, 9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShoes")
AddEventHandler("skinshop:setShoes", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 6) == Skinshop["shoes"]["item"] then
		if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(Ped, 6, 35, 0, GetPedPaletteVariation(Ped, 6))
		else
			SetPedComponentVariation(Ped, 6, 34, 0, GetPedPaletteVariation(Ped, 6))
		end
	else
		SetPedComponentVariation(Ped, 6, Skinshop["shoes"]["item"], Skinshop["shoes"]["texture"], 2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 3) == Skinshop["arms"]["item"] then
		SetPedComponentVariation(Ped, 3, 15, 0, GetPedPaletteVariation(Ped, 3))
	else
		SetPedComponentVariation(Ped, 3, Skinshop["arms"]["item"], Skinshop["arms"]["texture"], GetPedPaletteVariation(Ped, 3))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACCESSORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setAccessory")
AddEventHandler("skinshop:setAccessory", function()
	local Ped = PlayerPedId()
	if GetPedDrawableVariation(Ped, 7) == Skinshop["accessory"]["item"] then
		SetPedComponentVariation(Ped, 7, -1, 0, GetPedPaletteVariation(Ped, 7))
	else
		SetPedComponentVariation(Ped, 7, Skinshop["accessory"]["item"], Skinshop["accessory"]["texture"], GetPedPaletteVariation(Ped, 7))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.checkShoes()
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if Skinshop["shoes"]["item"] ~= Number then
		Skinshop["shoes"]["item"] = Number
		Skinshop["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped, 6, Skinshop["shoes"]["item"], Skinshop["shoes"]["texture"], GetPedPaletteVariation(Ped, 6))

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Customization()
	return Skinshop
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("HandsUp", function(Data, Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped, "random@mugging3", "handsup_standing_base", 3) then
		StopAnimTask(Ped, "random@mugging3", "handsup_standing_base", 8.0)
		vRP.AnimActive()
	else
		vRP.PlayAnim(true, { "random@mugging3", "handsup_standing_base" }, true)
	end

	Callback("Ok")
end)