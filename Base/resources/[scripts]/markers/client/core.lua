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
-- COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
local Colors = {
	["Policia"] = 18, -- Azul
	["Paramedico"] = 1, -- Vermelho
	["Corredor"] = 7, -- Roxo
	["Traficante"] = 5, -- Amarelo
	["Boosting"] = 2 -- Verde
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORSTART
-----------------------------------------------------------------------------------------------------------------------------------------
for Index,_ in pairs(Colors) do
	AddStateBagChangeHandler(Index,("player:%s"):format(LocalPlayer["state"]["Player"]),function(Name,Key,Value)
		Active = Key

		if not Value then
			Active = false
			CleanMarkers()
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] and Colors[Active] then
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
						local Permission = v["Permission"]
						if Colors[Permission] and not Markers[Index] then
							Markers[Index] = AddBlipForCoord(v["Coords"])
							SetBlipSprite(Markers[Index],1)
							SetBlipDisplay(Markers[Index],4)
							SetBlipAsShortRange(Markers[Index],false)
							SetBlipColour(Markers[Index],Colors[Permission])
							SetBlipScale(Markers[Index],0.7)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("! "..Permission)
							EndTextCommandSetBlipName(Markers[Index])
						end
					end
				end
			else
				local Ped = PlayerPedId()
				if IsPedInAnyVehicle(Ped) then
					if Pause then
						Pause = false
						CleanMarkers()
					end

					local List = GetPlayers()
					for Index,v in pairs(Players) do
						if List[Index] then
							local Permission = v["Permission"]
							if Colors[Permission] and not Markers[Index] then
								local Source = GetPlayerFromServerId(Index)
								local Ped = GetPlayerPed(Source)

								Markers[Index] = AddBlipForEntity(Ped)
								SetBlipSprite(Markers[Index],1)
								SetBlipDisplay(Markers[Index],4)
								SetBlipAsShortRange(Markers[Index],false)
								SetBlipColour(Markers[Index],Colors[Permission])
								SetBlipScale(Markers[Index],0.7)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("! "..Permission)
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

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}local GamePool = GetGamePool("CPed")

	for _,Entity in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entity)

		if Index and IsPedAPlayer(Entity) and NetworkIsPlayerConnected(Index) then
			Selected[GetPlayerServerId(Index)] = true
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanMarkers()
	for Index,v in pairs(Markers) do
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
AddEventHandler("markers:Add",function(Source,Permission)
	Players[Source] = Permission
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