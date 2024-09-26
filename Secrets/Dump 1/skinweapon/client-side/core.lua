-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = 1
local Camera = nil
local Gemstone = 0
local Objects = nil
local LastModel = nil
local WeaponRotation = nil
local Coords = vec3(235.86,-977.57,-98.80)
local Default = vec3(234.86,-977.57,-98.65)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
for Index = 1,#Weapons do
	local Hash = GetHashKey(Weapons[Index]["component"])
	local Weapon = GetWeaponComponentTypeModel(Hash)

	RequestModel(Weapon)
	while not HasModelLoaded(Weapon) do
		RequestModel(Weapon)
		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINWEAPON:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinweapon:Open")
AddEventHandler("skinweapon:Open",function()
	if Objects and DoesEntityExist(Objects) then
		DeleteEntity(Objects)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	NewLoadSceneStartSphere(Coords,100.0,0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,-90.0,2)
	SetCamCoord(Camera,Default)
	SetCamActive(Camera,true)
	SetCamFov(Camera,60.0)

	SendNUIMessage({ name = "Gemstone", payload = Gemstone })
	SendNUIMessage({ name = "Open" })
	TriggerEvent("hud:Active",false)
	SetNuiFocus(true,true)
	UserSkins()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("hud:Active",true)
	SetNuiFocus(false,false)

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	if Objects and DoesEntityExist(Objects) then
		DeleteEntity(Objects)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Page",function(Data,Callback)
	if Data["page"] == "skins" then
		UserSkins()
	elseif Data["page"] == "store" then
		for Number = 1,#Weapons do
			if Weapons[Number] and not Weapons[Number]["hide"] then
				CreateObjects(Number)
				break
			end
		end

		SendNUIMessage({ name = "Store", payload = Weapons })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Transfer",function(Data,Callback)
	local Number = Data["skin"]
	local Weapon = Weapons[Number]["weapon"]
	local Component = Weapons[Number]["component"]

	if vSERVER.TransferSkin(Data["passport"],Number,Weapon,Component) then
		SendNUIMessage({ name = "Gemstone", payload = Gemstone })
		UserSkins()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	local Number = Data["skin"]

	if vSERVER.BuySkin(Weapons[Number]) then
		SendNUIMessage({ name = "Gemstone", payload = Gemstone })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Active",function(Data,Callback)
	local Number = Data["skin"]
	local Weapon = Weapons[Number]["weapon"]
	local Component = Weapons[Number]["component"]

	Callback(vSERVER.ActiveSkin(Weapon,Component))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Inactive",function(Data,Callback)
	local Number = Data["skin"]
	local Weapon = Weapons[Number]["weapon"]
	local Component = Weapons[Number]["component"]

	Callback(vSERVER.InactiveSkin(Weapon,Component))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mouse",function(Data,Callback)
	if Weapons[Active]["rotate"] and WeaponRotation then
		SetEntityRotation(Objects,WeaponRotation[1] + (Data["y"] / 200),WeaponRotation[2],WeaponRotation[3] - (Data["x"] / 200))
		WeaponRotation = GetEntityRotation(Objects)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Selected",function(Data,Callback)
	CreateObjects(Data["skin"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERSKINS
-----------------------------------------------------------------------------------------------------------------------------------------
function UserSkins()
	local Skins = {}
	local Selected = false
	local Consult = vSERVER.UserSkins()
	if Consult then
		for Number,v in pairs(Consult["List"]) do
			local Save = #Skins + 1
			local Number = parseInt(Number)

			Skins[Save] = Weapons[Number]

			local Weapon = Weapons[Number]["weapon"]
			if Consult[Weapon] and Weapons[Number]["component"] == Consult[Weapon] then
				Skins[Save]["active"] = true
			else
				Skins[Save]["active"] = false
			end

			if not Selected then
				Selected = Skins[Save]["id"]
			end
		end
	end

	if Selected then
		CreateObjects(Selected)
	elseif Objects and DoesEntityExist(Objects) then
		DeleteEntity(Objects)
	end

	SendNUIMessage({ name = "Skins", payload = Skins })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateObjects(Number)
	if Objects and DoesEntityExist(Objects) then
		DeleteEntity(Objects)
	end

	local Offset = Weapons[Number]["offset"]
	local Hash = GetHashKey(Weapons[Number]["component"])
	local Weapon = GetWeaponComponentTypeModel(Hash)
	local oCoords = vec3(Coords["x"] - Offset["x"],Coords["y"] - Offset["y"],Coords["z"] - Offset["z"])
	Objects = CreateObject(Weapon,oCoords,false,false,false)

	SetEntityRotation(Objects,Weapons[Number]["rotation"])
	FreezeEntityPosition(Objects,true)

	WeaponRotation = GetEntityRotation(Objects)
	Active = Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ADDGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:AddGemstone")
AddEventHandler("hud:AddGemstone",function(Number)
	Gemstone = Gemstone + Number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveGemstone")
AddEventHandler("hud:RemoveGemstone",function(Number)
	Gemstone = Gemstone - Number

	if Gemstone < 0 then
		Gemstone = 0
	end
end)