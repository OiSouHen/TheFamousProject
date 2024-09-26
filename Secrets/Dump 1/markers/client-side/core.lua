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
	["PMERJ"] = {
		["Comando Geral"] = 3,
		["Tenente Coronel"] = 3,
		["Major"] = 3,
		["Capitão"] = 3,
		["Tenente"] = 3,
		["Sargento"] = 3,
		["Cabo"] = 3,
		["Soldado"] = 3,
		["Recruta"] = 3
	},
	["BOPE"] = {
		["Comando Geral"] = 5,
		["Sub-Comandante"] = 5,
		["Major"] = 5,
		["Capitão"] = 5,
		["Tenente"] = 5,
		["Sargento"] = 5,
		["Cabo"] = 5,
		["Soldado"] = 5,
		["Recruta"] = 5
	},
	["PCERJ"] = {
		["Delegado"] = 39,
		["Delegado Adjunto"] = 39,
		["Perito"] = 39,
		["Escrivão"] = 39,
		["Investigador"] = 39,
		["Agente"] = 39
	},
	["PRF"] = {
		["Diretor Geral"] = 7,
		["Sub-Diretor"] = 7,
		["Coordenador"] = 7,
		["Espetor"] = 7,
		["Agente Especial"] = 7,
		["Estagiario"] = 7
	},
	["PF"] = {
		["Delegado"] = 11,
		["Delegado Adjunto"] = 11,
		["Perito"] = 11,
		["Escrivão"] = 11,
		["Investigador"] = 11,
		["Agente"] = 11
	},
	["BPCHQ"] = {
		["Comando Geral"] = 9,
		["Sub-Comandante"] = 9,
		["Major"] = 9,
		["Capitão"] = 9,
		["Tenente"] = 9,
		["Sargento"] = 9,
		["Cabo"] = 9,
		["Soldado"] = 9,
		["Recruta"] = 9
	},
	["Paramedico"] = {
		["Chefe"] = 6,
		["Médico"] = 6,
		["Enfermeiro"] = 6,
		["Residente"] = 6
	},
	["Corredor"] = {
		["Corredor"] = 8
	},
	["Traficante"] = {
		["Traficante"] = 15
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