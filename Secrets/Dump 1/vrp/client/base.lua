-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Proxy.addInterface("vRP",tvRP)
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Theme",function(Data,Callback)
	Callback(Theme)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local YTD = CreateRuntimeTxd("Textures")
	local Textures = vRPS.FilesDirectory("resources/vrp/config/textures/target")

	for _,Name in pairs(Textures) do
		local TEXTURE = CreateRuntimeTexture(YTD,Name,512,512)
		local PNG = LoadResourceFile("vrp","config/textures/target/"..Name..".png")
		local DICT = "data:image/png;base64,"..Base64(PNG)

		SetRuntimeTextureImage(TEXTURE,DICT)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blipmin = false
local Information = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local Selected = {}
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			if #(Coords - GetEntityCoords(Entity)) <= Radius then
				Selected[#Selected + 1] = GetPlayerServerId(Index)
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	if not Radius then
		Radius = 2.0
	end

	local Selected = false
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and Entity ~= PlayerPedId() and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			local EntityCoords = GetEntityCoords(Entity)
			local EntityDistance = #(Coords - EntityCoords)

			if EntityDistance < Radius then
				Selected = GetPlayerServerId(Index)
				Radius = EntityDistance
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[Entity] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	return GetPlayers()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Blipmin then
			TimeDistance = 0

			for Entitys,v in pairs(GetPlayers()) do
				if Entitys ~= PlayerPedId() and Player(v)["state"]["Passport"] then
					local Armour = GetPedArmour(Entitys)
					local Coords = GetEntityCoords(Entitys)
					local Healths = GetEntityHealth(Entitys)
					local Passport = Player(v)["state"]["Passport"]
					local Name = Player(v)["state"]["Name"] or "Loading"

					DrawText3D(Coords,Name.."~w~  |  ~o~"..Passport.."~w~  |  ~g~"..Healths.."~w~  |  ~y~"..Armour,0.275)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.BlipAdmin()
	if Blipmin then
		Blipmin = false
	else
		Blipmin = true
	end
	
	return Blipmin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict,Name)
	PlaySoundFrontend(-1,Dict,Name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportEnable()
	if not Information and not IsPauseMenuActive() then
		Information = true

		while Information do
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Entitys,v in pairs(GetPlayers()) do
				local OtherCoords = GetEntityCoords(Entitys)
				if Entitys ~= PlayerPedId() and Player(v)["state"]["Passport"] and HasEntityClearLosToEntity(Ped,Entitys,17) and #(Coords - OtherCoords) <= 5 then
					DrawText3D(OtherCoords,"~w~"..Player(v)["state"]["Passport"],0.45,true)
				end
			end

			Wait(0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportDisable()
	Information = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+Information",PassportEnable)
RegisterCommand("-Information",PassportDisable)
RegisterKeyMapping("+Information","Visualizar passaportes.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text,Weight,Background)
	local onScreen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"] + 1.10)

	if onScreen then
		SetTextFont(4)
		SetTextDropShadow()
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		if Background then
			local Width = string.len(Text) / 160 * Weight
			DrawRect(x,y + 0.0125,Width,0.03,15,15,15,175)
		end
	end
end