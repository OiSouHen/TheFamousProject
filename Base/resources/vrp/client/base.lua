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

	for _, Entity in pairs(GamePool) do
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

	for _, Entity in pairs(GamePool) do
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

	for _, Entity in pairs(GamePool) do
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
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.BlipAdmin()
	Blipmin = not Blipmin

	while Blipmin do
		for Entitys,v in pairs(GetPlayers()) do
			if Entitys ~= PlayerPedId() and Player(v)["state"]["Passport"] then
				local Armour = GetPedArmour(Entitys)
				local Coords = GetEntityCoords(Entitys)
				local Healths = GetEntityHealth(Entitys)
				local Passport = Player(v)["state"]["Passport"]

				local One = GetOffsetFromEntityInWorldCoords(Entitys,0.3,0.3,0.8)
				local Two = GetOffsetFromEntityInWorldCoords(Entitys,-0.3,0.3,0.8)
				local Three = GetOffsetFromEntityInWorldCoords(Entitys,0.3,-0.3,0.8)
				local Four = GetOffsetFromEntityInWorldCoords(Entitys,-0.3,-0.3,0.8)
				local Five = GetOffsetFromEntityInWorldCoords(Entitys,-0.3,0.3,-0.9)
				local Six = GetOffsetFromEntityInWorldCoords(Entitys,0.3,0.3,-0.9)
				local Seven = GetOffsetFromEntityInWorldCoords(Entitys,0.3,-0.3,-0.9)
				local Eight = GetOffsetFromEntityInWorldCoords(Entitys,-0.3,-0.3,-0.9)

				DrawLine(Two["x"],Two["y"],Two["z"],Five["x"],Five["y"],Five["z"],255,255,255,255)
				DrawLine(One["x"],One["y"],One["z"],Six["x"],Six["y"],Six["z"],255,255,255,255)
				DrawLine(Four["x"],Four["y"],Four["z"],Eight["x"],Eight["y"],Eight["z"],255,255,255,255)
				DrawLine(Three["x"],Three["y"],Three["z"],Seven["x"],Seven["y"],Seven["z"],255,255,255,255)
				DrawLine(Eight["x"],Eight["y"],Eight["z"],Seven["x"],Seven["y"],Seven["z"],255,255,255,255)
				DrawLine(Seven["x"],Seven["y"],Seven["z"],Six["x"],Six["y"],Six["z"],255,255,255,255)
				DrawLine(Six["x"],Six["y"],Six["z"],Five["x"],Five["y"],Five["z"],255,255,255,255)
				DrawLine(Five["x"],Five["y"],Five["z"],Eight["x"],Eight["y"],Eight["z"],255,255,255,255)
				DrawLine(Four["x"],Four["y"],Four["z"],Three["x"],Three["y"],Three["z"],255,255,255,255)
				DrawLine(Three["x"],Three["y"],Three["z"],One["x"],One["y"],One["z"],255,255,255,255)
				DrawLine(One["x"],One["y"],One["z"],Two["x"],Two["y"],Two["z"],255,255,255,255)
				DrawLine(Two["x"],Two["y"],Two["z"],Four["x"],Four["y"],Four["z"],255,255,255,255)

				DrawText3D(Coords,"~o~S:~w~ "..v.."     ~o~I:~w~ "..Passport.."     ~g~H:~w~ "..Healths.."     ~y~A:~w~ "..Armour,0.275)
			end
		end

		Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict, Name)
	PlaySoundFrontend(-1, Dict, Name, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportEnable()
	if UsableF7 then
		if not Information and not IsPauseMenuActive() then
			Information = true

			while Information do
				local Ped = PlayerPedId()
				local Coords = GetEntityCoords(Ped)

				for Entitys, _ in pairs(GetPlayers()) do
					local OtherCoords = GetEntityCoords(Entitys)
					if Entitys ~= PlayerPedId() and Entity(Entitys)["state"]["Passport"] and not UseF7[Entity(Entitys)["state"]["Passport"]] and HasEntityClearLosToEntity(Ped, Entitys, 17) and #(Coords - OtherCoords) <= 5 then
						DrawText3D(OtherCoords, "~w~" .. Entity(Entitys)["state"]["Passport"], 0.45)
					end
				end

				Wait(0)
			end
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
RegisterCommand("+Information", PassportEnable)
RegisterCommand("-Information", PassportDisable)
RegisterKeyMapping("+Information", "Visualizar passaportes.", "keyboard", "F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords, Text, Weight)
	local onScreen, x, y = World3dToScreen2d(Coords["x"], Coords["y"], Coords["z"] + 1.10)

	if onScreen then
		SetTextFont(4)
		SetTextDropShadow()
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(255,255,255,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x, y)

		local Width = string.len(Text) / 160 * Weight
		DrawRect(x, y + 0.0125, Width, 0.03, 15, 15, 15, 175)
	end
end