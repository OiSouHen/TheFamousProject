-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Camera = nil
local Opened = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Locate = {
	{ ["Coords"] = vec3(-206.9,-1015.09,30.13), ["Name"] = "" },
	{ ["Coords"] = vec3(-206.9,-1015.09,30.13), ["Name"] = "" },
	{ ["Coords"] = vec3(-537.04,-1277.97,26.89), ["Name"] = "" },
	{ ["Coords"] = vec3(-853.34,-126.61,37.68), ["Name"] = "" },
	{ ["Coords"] = vec3(-1040.43,-2742.4,13.92), ["Name"] = "" },
	{ ["Coords"] = vec3(343.1,2636.34,44.48), ["Name"] = "" },
	{ ["Coords"] = vec3(-83.81,6316.94,31.49), ["Name"] = "" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMS
-----------------------------------------------------------------------------------------------------------------------------------------
local Anims = {
	{ ["Dict"] = "rcmbarry", ["Name"] = "base" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spawn:Opened", function()
	local Pid = PlayerId()
	local Ped = PlayerPedId()
	if Ped and Ped ~= -1 and Pid and NetworkIsPlayerActive(Pid) and not Opened then
		Opened = true

		Wait(5000)

		SetEntityCoords(Ped,233.85,-1387.59,29.55,false,false,false,false)
		LocalPlayer["state"]:set("Blastoise", true, false)
		FreezeEntityPosition(Ped,true)
		SetEntityInvincible(Ped,true)
		SetEntityHeading(Ped,136.07)
		SetEntityHealth(Ped,100)
		SetPedArmour(Ped,0)

		Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		RenderScriptCams(true,false,0,false,false)
		SetCamCoord(Camera,232.0,-1388.64,30.45)
		SetCamRot(Camera,0.0,0.0,320.0,2)
		SetCamActive(Camera,true)

		Characters = vSERVER.Characters()
		if parseInt(#Characters) > 0 then
			Customization(Characters[1])
		else
			LocalPlayer["state"]:set("Invisible",true,false)
			SetEntityVisible(Ped,false,0)
		end

		SetTimeout(5000,function()
			SendNUIMessage({ Action = "Spawn", Payload = Characters })
			SetNuiFocus(true,true)

			if IsScreenFadedOut() then
				DoScreenFadeIn(2500)
			end
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen", function(Data, Callback)
	if vSERVER.ChosenCharacter(Data["Passport"]) then
		SendNUIMessage({ Action = "Close" })
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter", function(Data, Callback)
	Callback(vSERVER.NewCharacter(Data["name"], Data["lastname"], Data["gender"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SwitchCharacter", function(Data, Callback)
	for _, v in pairs(Characters) do
		if v["Passport"] == Data["Passport"] then
			Customization(v, true)
			break
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Finish")
AddEventHandler("spawn:Finish",function(Coords,Creation)
	if Coords then
		Locate[1] = { ["Coords"] = Coords, ["Name"] = "" }

		for Number,v in pairs(Locate) do
			local Road = GetStreetNameAtCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])
			Locate[Number]["Name"] = GetStreetNameFromHashKey(Road)
		end

		SetCamCoord(Camera,Locate[1]["Coords"]["x"],Locate[1]["Coords"]["y"],Locate[1]["Coords"]["z"] + 1)
		SendNUIMessage({ Action = "Location", Payload = Locate })
		SetCamRot(Camera,0.0,0.0,0.0,2)
	else
		if Creation then
			SetEntityVisible(PlayerPedId(),true,0)
			exports["barbershop"]:Creation(Creation)
			LocalPlayer["state"]:set("Invisible",false,false)
		else
			TriggerEvent("hud:Active",true)
		end

		-- TriggerServerEvent("vRP:WaitCharacters",Creation)
		SendNUIMessage({ Action = "Close" })
		SetNuiFocus(false,false)

		if DoesCamExist(Camera) then
			RenderScriptCams(false,false,0,false,false)
			SetCamActive(Camera,false)
			DestroyCam(Camera,false)
			Camera = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn", function(Data, Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false, false, 0, false, false)
		SetCamActive(Camera, false)
		DestroyCam(Camera, false)
		Camera = nil
	end

	SetEntityVisible(PlayerPedId(), true, 0)
	LocalPlayer["state"]:set("Invisible", false, false)
	TriggerServerEvent("vRP:BucketClient", "Exit")
	TriggerServerEvent("vRP:OnlyObjects")
	SendNUIMessage({ Action = "Close" })
	TriggerEvent("hud:Active", true)
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen", function(Data, Callback)
	local Ped = PlayerPedId()
	local Index = Data["index"]

	SetEntityCoords(Ped, Locate[Index]["Coords"]["x"], Locate[Index]["Coords"]["y"], Locate[Index]["Coords"]["z"] - 1)
	SetCamCoord(Camera, Locate[Index]["Coords"]["x"], Locate[Index]["Coords"]["y"], Locate[Index]["Coords"]["z"] + 1)
	SetCamRot(Camera, 0.0, 0.0, 0.0, 2)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Table, Check)
	if LoadModel(Table["Skin"]) then
		if Check then
			if GetEntityModel(PlayerPedId()) ~= GetHashKey(Table["Skin"]) then
				SetPlayerModel(PlayerId(), Table["Skin"])
				SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
			end
		else
			SetPlayerModel(PlayerId(), Table["Skin"])
			SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 1)
		end

		local Ped = PlayerPedId()
		local Random = math.random(#Anims)
		if LoadAnim(Anims[Random]["Dict"]) then
			TaskPlayAnim(Ped, Anims[Random]["Dict"], Anims[Random]["Name"], 8.0, 8.0, -1, 1, 1, 0, 0, 0)
		end

		exports["skinshop"]:Apply(Table["Clothes"], Ped)
		exports["barbershop"]:Apply(Table["Barber"], Ped)
		exports["tattooshop"]:Apply(Table["Tattoos"], Ped)

		SetEntityVisible(Ped, true, 0)
		LocalPlayer["state"]:set("Invisible", false, false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:INCREMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Increment")
AddEventHandler("spawn:Increment",function(Tables)
	for Name,v in pairs(Tables) do
		Locate[#Locate + 1] = { ["Coords"] = v, ["Name"] = "" }

		if Name ~= "Hotel" then
			local Blip = AddBlipForCoord(v["x"],v["y"],v["z"])
			SetBlipSprite(Blip,411)
			SetBlipDisplay(Blip,4)
			SetBlipAsShortRange(Blip,true)
			SetBlipColour(Blip,5)
			SetBlipScale(Blip,0.6)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Propriedade")
			EndTextCommandSetBlipName(Blip)
		end
	end
end)