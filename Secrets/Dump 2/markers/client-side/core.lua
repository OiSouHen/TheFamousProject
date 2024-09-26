-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("markers")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Markers = {}
local Players = {}
local Pause = false
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATION
-----------------------------------------------------------------------------------------------------------------------------------------
local Information = {
	["LSPD"] = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	["BCSO"] = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	["BCPR"] = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	["Paramedico"] = {
		["Chefe"] = 1,
		["Médico"] = 6,
		["Enfermeiro"] = 59,
		["Residente"] = 76
	},
	["Corredor"] = {
		["Corredor"] = 8
	},
	["Traficante"] = {
		["Traficante"] = 5
	},
	["Boosting"] = {
		["Boosting"] = 47
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Index,_ in pairs(Information) do
		AddStateBagChangeHandler(Index,("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
			Active = Key

			if not Value then
				Active = false
				CleanMarkers()
			end
		end)
	end

	while true do
		local TimeDistance = 10000
		if LocalPlayer["state"]["Active"] and Active and Information[Active] then
			TimeDistance = 2500

			if IsPauseMenuActive() then
				if not Pause then
					Pause = true
					CleanMarkers()
				end

				local Users = vSERVER.Users()
				for Index,v in pairs(Users) do
					if Markers[Index] then
						async(function()
							MoveBlipSmooth(Markers[Index],v["Coords"])
						end)
					else
						local Level = v["Level"]
						local Permission = v["Permission"]
						if Information[Permission] and Information[Permission][Level] and not Markers[Index] and ((not LocalPlayer["state"]["Paramedico"] and Permission ~= "Paramedico") or (LocalPlayer["state"]["Paramedico"] and Permission == "Paramedico")) then
							Markers[Index] = AddBlipForCoord(v["Coords"])
							SetBlipSprite(Markers[Index],1)
							SetBlipDisplay(Markers[Index],4)
							SetBlipAsShortRange(Markers[Index],false)
							SetBlipColour(Markers[Index],Information[Permission][Level])
							SetBlipScale(Markers[Index],0.7)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("! "..Permission.." : "..Level)
							EndTextCommandSetBlipName(Markers[Index])
						end
					end
				end
			else
				if Pause then
					Pause = false
					CleanMarkers()
				end

				local Ped = PlayerPedId()
				if IsPedInAnyVehicle(Ped) then
					local List = GetPlayers()
					for Index,v in pairs(Players) do
						if List[Index] then
							local Level = v["Level"]
							local Permission = v["Permission"]
							if Information[Permission] and Information[Permission][Level] and not Markers[Index] and ((not LocalPlayer["state"]["Paramedico"] and Permission ~= "Paramedico") or (LocalPlayer["state"]["Paramedico"] and Permission == "Paramedico")) then
								Markers[Index] = AddBlipForEntity(List[Index])
								SetBlipSprite(Markers[Index],1)
								SetBlipDisplay(Markers[Index],4)
								SetBlipAsShortRange(Markers[Index],false)
								SetBlipColour(Markers[Index],Information[Permission][Level])
								SetBlipScale(Markers[Index],0.7)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("! "..Permission.." : "..Level)
								EndTextCommandSetBlipName(Markers[Index])
							end
						else
							if Markers[Index] then
								if DoesBlipExist(Markers[Index]) then
									RemoveBlip(Markers[Index])
								end

								Markers[Index] = nil
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}

	for _,Entity in pairs(GetGamePool("CPed")) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[GetPlayerServerId(Index)] = Entity
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanMarkers()
	for _,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end

	Markers = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEBLIPSMOOTH
-----------------------------------------------------------------------------------------------------------------------------------------
function MoveBlipSmooth(Blip,Coords)
	local Timer = 0.0
	local Delay = GetGameTimer()
	local Start = GetBlipCoords(Blip)

	while Timer < 1.0 do
		if GetTimeDifference(GetGameTimer(),Delay) > 10 then
			Delay = GetGameTimer()
			Timer = Timer + 0.01

			if DoesBlipExist(Blip) then
				SetBlipCoords(Blip,Start - (Timer * (Start - Coords)))
			else
				Timer = 1.0
			end
		end

		Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Add")
AddEventHandler("markers:Add",function(Source,Table)
	Players[Source] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:FULL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Full")
AddEventHandler("markers:Full",function(Table)
	Players = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Remove")
AddEventHandler("markers:Remove",function(Source)
	if Players[Source] then
		if Markers[Source] then
			if DoesBlipExist(Markers[Source]) then
				RemoveBlip(Markers[Source])
			end

			Markers[Source] = nil
		end

		Players[Source] = nil
	end
end)