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
Tunnel.bindInterface("garages",Creative)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECORATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("Player_Vehicle",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Opened = "1"
local Respawns = {}
local Searched = nil
local Hotwired = false
local Spam = GetGameTimer()
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { x = 55.44, y = -876.17, z = 30.67,
		["1"] = { 60.44,-866.47,30.23,340.16 },
		["2"] = { 57.26,-865.35,30.25,340.16 },
		["3"] = { 54.03,-864.21,30.25,340.16 },
		["4"] = { 50.73,-863.01,30.26,340.16 },
		["5"] = { 60.52,-866.53,30.14,340.16 },
		["6"] = { 50.73,-873.28,30.11,158.75 },
		["7"] = { 47.36,-872.07,30.13,158.75 },
		["8"] = { 44.15,-870.9,30.13,158.75 }
	},
	["2"] = { x = 599.04, y = 2745.33, z = 42.04,
		["1"] = { 604.82,2738.27,41.64,187.09 },
		["2"] = { 601.75,2738.08,41.65,184.26 },
		["3"] = { 598.63,2737.85,41.69,184.26 },
		["4"] = { 595.59,2737.55,41.7,184.26 }
	},
	["3"] = { x = -136.8, y = 6356.84, z = 31.49,
		["1"] = { -133.72,6349.01,31.16,42.52 },
		["2"] = { -136.1,6346.53,31.16,42.52 }
	},
	["4"] = { x = 275.23, y = -345.56, z = 45.17,
		["1"] = { 266.06,-332.07,44.58,252.29 },
		["2"] = { 267.18,-328.9,44.58,252.29 },
		["3"] = { 268.32,-325.67,44.58,252.29 },
		["4"] = { 269.53,-322.4,44.58,252.29 },
		["5"] = { 270.77,-319.14,44.58,252.29 }
	},
	["5"] = { x = 596.43, y = 90.68, z = 93.13,
		["1"] = { 599.82,102.03,92.57,249.45 },
		["2"] = { 598.69,98.42,92.57,249.45 }
	},
	["6"] = { x = -340.57, y = 266.04, z = 85.68,
		["1"] = { -349.47,272.54,84.77,272.13 },
		["2"] = { -349.5,275.91,84.69,272.13 },
		["3"] = { -349.56,279.3,84.62,272.13 },
		["4"] = { -349.67,282.6,84.59,274.97 },
		["5"] = { -349.74,286.16,84.59,272.13 },
		["6"] = { -349.8,289.76,84.6,272.13 },
		["7"] = { -349.85,293.28,84.6,272.13 },
		["8"] = { -349.87,296.72,84.6,272.13 }
	},
	["7"] = { x = -2030.03, y = -465.99, z = 11.59,
		["1"] = { -2037.4,-461.02,11.07,138.9 },
		["2"] = { -2039.78,-459.07,11.07,138.9 },
		["3"] = { -2042.12,-457.1,11.07,138.9 },
		["4"] = { -2044.47,-455.11,11.07,138.9 },
		["5"] = { -2046.85,-453.09,11.07,138.9 },
		["6"] = { -2049.12,-451.17,11.07,138.9 },
		["7"] = { -2051.51,-449.23,11.07,138.9 }
	},
	["8"] = { x = -1184.94, y = -1509.99, z = 4.65,
		["1"] = { -1183.29,-1495.81,4.04,121.89 },
		["2"] = { -1185.23,-1493.28,4.04,121.89 },
		["3"] = { -1186.87,-1490.71,4.04,121.89 },
		["4"] = { -1188.69,-1488.27,4.04,121.89 }
	},
	["9"] = { x = 101.23, y = -1073.64, z = 29.37,
		["1"] = { 105.9,-1063.14,28.88,246.62 },
		["2"] = { 107.42,-1059.61,28.88,246.62 },
		["3"] = { 108.88,-1056.23,28.88,246.62 },
		["4"] = { 110.27,-1052.86,28.88,246.62 }
	},
	["10"] = { x = 213.97, y = -808.43, z = 31.0,
		["1"] = { 221.93,-804.11,30.35,249.45 },
		["2"] = { 222.9,-801.61,30.33,249.45 },
		["3"] = { 223.92,-799.2,30.33,249.45 },
		["4"] = { 224.85,-796.69,30.33,249.45 }
	},
	["11"] = { x = -348.89, y = -874.02, z = 31.31,
		["1"] = { -343.62,-875.51,30.75,167.25 },
		["2"] = { -339.98,-876.27,30.75,167.25 },
		["3"] = { -336.35,-876.98,30.75,167.25 },
		["4"] = { -332.72,-877.71,30.75,167.25 }
	},
	["12"] = { x = 67.72, y = 12.3, z = 69.22,
		["1"] = { 63.87,16.5,68.87,340.16 },
		["2"] = { 60.78,17.6,68.92,340.16 },
		["3"] = { 57.76,18.76,69.03,340.16 },
		["4"] = { 54.8,19.92,69.25,340.16 }
	},
	["13"] = { x = 361.96, y = 297.8, z = 103.88,
		["1"] = { 371.06,284.68,102.94,340.16 },
		["2"] = { 374.8,283.39,102.85,340.16 },
		["3"] = { 378.62,282.06,102.78,340.16 }
	},
	["14"] = { x = 1035.84, y = -763.87, z = 58.0,
		["1"] = { 1046.56,-774.55,57.69,90.71 },
		["2"] = { 1046.56,-778.24,57.68,90.71 },
		["3"] = { 1046.55,-782.0,57.68,90.71 },
		["4"] = { 1046.54,-785.65,57.66,90.71 }
	},
	["15"] = { x = -796.69, y = -2022.85, z = 9.17,
		["1"] = { -779.77,-2040.03,8.56,314.65 },
		["2"] = { -777.36,-2042.58,8.56,314.65 },
		["3"] = { -774.92,-2044.9,8.56,314.65 }
	},
	["16"] = { x = 453.28, y = -1146.77, z = 29.5,
		["1"] = { 467.33,-1151.89,28.96,85.04 },
		["2"] = { 467.16,-1154.75,28.96,85.04 },
		["3"] = { 467.1,-1157.73,28.96,87.88 }
	},
	["17"] = { x = 528.65, y = -146.25, z = 58.37,
		["1"] = { 540.99,-136.2,59.13,178.59 },
		["2"] = { 544.84,-136.25,59.01,178.59 },
		["3"] = { 548.83,-136.31,59.01,181.42 },
		["4"] = { 552.81,-136.41,58.99,178.59 }
	},
	["18"] = { x = -1159.56, y = -739.39, z = 19.88,
		["1"] = { -1144.95,-745.49,19.34,104.89 },
		["2"] = { -1142.76,-748.44,19.19,107.72 },
		["3"] = { -1140.18,-751.41,19.06,107.72 },
		["4"] = { -1137.99,-754.36,18.91,107.72 },
		["5"] = { -1135.43,-757.3,18.75,107.72 },
		["6"] = { -1133.12,-760.4,18.59,107.72 },
		["7"] = { -1130.59,-763.27,18.43,107.72 }
	},
	["19"] = { x = -791.48, y = 336.48, z = 85.7,
		["1"] = { -791.64,331.67,85.38,181.42 }
	},
	["20"] = { x = -800.45, y = 336.61, z = 85.7,
		["1"] = { -800.38,331.9,85.38,181.42 }
	},
	["21"] = { x = 935.95, y = 0.36, z = 78.76,
		["1"] = { 933.29,-3.74,78.44,147.41 }
	},
	["22"] = { x = 1725.21, y = 4711.77, z = 42.11,
		["1"] = { 1722.82,4700.38,42.28,87.88 }
	},
	["23"] = { x = 1624.05, y = 3566.14, z = 35.15,
		["1"] = { 1633.27,3563.91,34.91,303.31 }
	},
	["24"] = { x = 1143.8, y = 2667.46, z = 38.15,
		["1"] = { 1137.41,2674.26,37.83,0.0 }
	},
	["25"] = { x = -73.35, y = -2004.6, z = 18.27,
		["1"] = { -59.61,-1990.85,17.69,155.91 },
		["2"] = { -63.69,-1989.71,17.69,167.25 },
		["3"] = { -67.6,-1989.01,17.69,170.08 },
		["4"] = { -71.34,-1988.57,17.69,172.92 },
		["5"] = { -74.96,-1988.07,17.69,170.08 },
		["6"] = { -78.64,-1987.63,17.69,170.08 },
		["7"] = { -82.27,-1987.19,17.69,170.08 }
	},
	["26"] = { x = 1200.52, y = -1276.06, z = 35.22,
		["1"] = { 1206.23,-1270.21,35.03,175.75 }
	},
	["41"] = { x = 294.77, y = -1447.93, z = 29.96,
		["1"] = { 298.09,-1442.67,29.57,232.45 }
	},
	["42"] = { x = 318.85, y = -1457.86, z = 46.51,
		["1"] = { 313.3,-1465.02,46.89,138.9 }
	},
	["51"] = { x = 442.05, y = -984.13, z = 25.7,
		["1"] = { 438.57,-991.75,25.51,87.88 },
		["2"] = { 438.52,-995.3,25.51,87.88 },
		["3"] = { 438.52,-998.76,25.51,87.88 }
	},
	["52"] = { x = 471.34, y = -997.95, z = 45.92,
		["1"] = { 476.6,-1003.3,46.27,272.13 }
	},
	["53"] = { x = 456.11, y = -1017.34, z = 28.07,
		["1"] = { 441.99,-1016.71,28.34,87.88 }
	},
	["121"] = { x = -1728.06, y = -1050.69, z = 1.7,
		["1"] = { -1734.05,-1057.01,0.94,133.23 }
	},
	["122"] = { x = -776.63, y = -1494.93, z = 2.29,
		["1"] = { -786.5,-1498.89,-0.57,110.56 }
	},
	["123"] = { x = -895.04, y = 5687.46, z = 3.03,
		["1"] = { -907.5,5684.52,0.76,102.05 }
	},
	["124"] = { x = 1509.64, y = 3788.7, z = 33.51,
		["1"] = { 1493.4,3797.23,29.89,50.19 }
	},
	["131"] = { x = -1896.42, y = -3032.01, z = 13.93,
		["1"] = { -1890.65,-3045.12,14.61,150.24 }
	},
	["141"] = { x = 1961.97, y = 5181.03, z = 47.95,
		["1"] = { 1967.33,5179.34,47.06,158.75 }
	},
	["142"] = { x = 453.74, y = -600.6, z = 28.59,
		["1"] = { 462.81,-606.03,28.49,212.6 },
		["2"] = { 461.54,-612.34,28.49,215.44 },
		["3"] = { 460.98,-619.81,28.49,215.44 }
	},
	["143"] = { x = -341.45, y = -1567.52, z = 25.22,
		["1"] = { -346.4,-1560.42,24.95,93.55 }
	},
	["144"] = { x = 355.15, y = 275.79, z = 103.15,
		["1"] = { 359.95,272.31,102.72,340.16 },
		["2"] = { 364.05,270.74,102.68,340.16 },
		["3"] = { 368.1,269.31,102.67,340.16 }
	},
	["145"] = { x = 283.93, y = 2849.5, z = 43.64,
		["1"] = { 277.34,2840.0,43.29,28.35 }
	},
	["146"] = { x = -412.39, y = 6171.06, z = 31.48,
		["1"] = { -401.19,6167.31,31.24,317.49 }
	},
	["147"] = { x = 1241.65, y = -3262.85, z = 5.53,
		["1"] = { 1271.56,-3287.96,6.10,91.00 },
		["2"] = { 1271.82,-3282.63,6.10,91.00 },
		["3"] = { 1271.95,-3271.04,6.10,91.00 },
		["4"] = { 1272.11,-3266.03,6.10,91.00 }
	},
	["148"] = { x = 905.6, y = -165.08, z = 74.11,
		["1"] = { 916.21,-170.61,74.04,99.22 },
		["2"] = { 918.35,-167.18,74.22,99.22 },
		["3"] = { 920.64,-163.54,74.43,99.22 }
	},
	["149"] = { x = 68.21, y = 124.82, z = 79.18,
		["1"] = { 72.19,120.91,79.08,158.75 },
		["2"] = { 61.84,124.32,79.09,158.75 }
	},
	["150"] = { x = -223.09, y = -1370.69, z = 31.26,
		["1"] = { -220.45,-1361.2,31.34,209.77 }
	},
	["151"] = { x = 977.78, y = -2220.77, z = 31.54,
		["1"] = { 972.99,-2220.39,30.53,85.04 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMods(Vehicle,Customize)
	if Customize then
		SetVehicleModKit(Vehicle,0)

		if Customize["wheeltype"] ~= nil then
			SetVehicleWheelType(Vehicle,Customize["wheeltype"])
		end

		if Customize["mods"] then
			for i = 0,16 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 17,22 do
				if Customize["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 23,24 do
				if Customize["mods"][tostring(i)] ~= nil then
					if not Customize["var"] then
						Customize["var"] = {}
						Customize["var"][tostring(i)] = 0
					end

					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)],Customize["var"][tostring(i)])
				end
			end

			for i = 25,48 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end
		end

		if Customize["neon"] ~= nil then
			for i = 0,3 do
				SetVehicleNeonLightEnabled(Vehicle,i,Customize["neon"][tostring(i)])
			end
		end

		if Customize["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(Customize["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(Vehicle,i,0)
				else
					SetVehicleExtra(Vehicle,i,1)
				end
			end
		end

		if Customize["liverys"] ~= nil and Customize["liverys"] ~= 24  then
			SetVehicleLivery(Vehicle,Customize["liverys"])
		end

		if Customize["plateIndex"] ~= nil and Customize["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(Vehicle,Customize["plateIndex"])
		end

		SetVehicleXenonLightsColour(Vehicle,Customize["xenonColor"])
		SetVehicleColours(Vehicle,Customize["colors"][1],Customize["colors"][2])
		SetVehicleExtraColours(Vehicle,Customize["extracolors"][1],Customize["extracolors"][2])
		SetVehicleNeonLightsColour(Vehicle,Customize["lights"][1],Customize["lights"][2],Customize["lights"][3])
		SetVehicleTyreSmokeColor(Vehicle,Customize["smokecolor"][1],Customize["smokecolor"][2],Customize["smokecolor"][3])

		if Customize["tint"] ~= nil then
			SetVehicleWindowTint(Vehicle,Customize["tint"])
		end

		if Customize["dashColour"] ~= nil then
			SetVehicleInteriorColour(Vehicle,Customize["dashColour"])
		end

		if Customize["interColour"] ~= nil then
			SetVehicleDashboardColour(Vehicle,Customize["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SpawnPosition(Select)
	local Slot = "0"
	local Checks = 0
	local Selected = {}
	local Position = nil

	repeat
		Checks = Checks + 1

		Slot = tostring(Checks)
		if Garages[Select] and Garages[Select][Slot] then
			Selected = vec4(Garages[Select][Slot][1],Garages[Select][Slot][2],Garages[Select][Slot][3],Garages[Select][Slot][4])
			Position = GetClosestVehicle(Garages[Select][Slot][1],Garages[Select][Slot][2],Garages[Select][Slot][3],2.75,0,127)
		end
	until not DoesEntityExist(Position) or not Garages[Select][Slot]

	if not Garages[Select][tostring(Checks)] then
		TriggerEvent("Notify","Atenção","Todas as vagas estão ocupadas.","default",5000)

		return false
	end

	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateVehicle(Model,Network,Engine,Health,Customize,Windows,Tyres)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Customize ~= nil then
				local Mods = json.decode(Customize)
				VehicleMods(Vehicle,Mods)
			end

			SetVehicleEngineHealth(Vehicle,Engine + 0.0)
			SetVehicleHasBeenOwnedByPlayer(Vehicle,true)
			SetVehicleNeedsToBeHotwired(Vehicle,false)
			DecorSetInt(Vehicle,"Player_Vehicle",-1)
			SetVehicleOnGroundProperly(Vehicle)
			SetVehRadioStation(Vehicle,"OFF")
			SetEntityHealth(Vehicle,Health)

			if Windows then
				local Windows = json.decode(Windows)
				if Windows ~= nil then
					for Index,v in pairs(Windows) do
						if not v then
							RemoveVehicleWindow(Vehicle,parseInt(Index))
						end
					end
				end
			end

			if Tyres then
				local Tyres = json.decode(Tyres)
				if Tyres ~= nil then
					for Index,Burst in pairs(Tyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle,parseInt(Index),true,1000.0)
						end
					end
				end
			end

			SetModelAsNoLongerNeeded(Model)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle)
	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) and (not Entity(Vehicle)["state"]["Tow"] or LocalPlayer["state"]["Admin"]) then
		local Doors = {}
		for Number = 0,5 do
			Doors[Number] = IsVehicleDoorDamaged(Vehicle,Number)
		end

		local Tyres = {}
		for Number = 0,7 do
			Tyres[Number] = (GetTyreHealth(Vehicle,i) ~= 1000.0 and true or false)
		end

		local Windows = {}
		for Number = 0,5 do
			Windows[Number] = IsVehicleWindowIntact(Vehicle,Number)
		end

		vSERVER.Delete(VehToNet(Vehicle),GetEntityHealth(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle),Opened)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SearchBlip(Coords)
	if DoesBlipExist(Searched) then
		RemoveBlip(Searched)
		Searched = nil
	end

	if type(Coords) == "string" then
		Coords = vec3(Garages[Coords]["x"],Garages[Coords]["y"],Garages[Coords]["z"])
	end

	Searched = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])
	SetBlipSprite(Searched,225)
	SetBlipColour(Searched,77)
	SetBlipScale(Searched,0.6)
	SetBlipAsShortRange(Searched,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(Searched)

	SetTimeout(30000,function()
		RemoveBlip(Searched)
		Searched = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StartHotwired()
	local Ped = PlayerPedId()
	if not Hotwired and LoadAnim(Dict) then
		TaskPlayAnim(Ped,Dict,Anim,8.0,8.0,-1,49,1,0,0,0)
		Hotwired = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StopHotwired()
	local Ped = PlayerPedId()
	if Hotwired and LoadAnim(Dict) then
		StopAnimTask(Ped,Dict,Anim,8.0)
		Hotwired = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UpdateHotwired(Status)
	Hotwired = Status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERDECORS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RegisterDecors(Vehicle)
	SetVehicleHasBeenOwnedByPlayer(Vehicle,true)
	SetVehicleNeedsToBeHotwired(Vehicle,false)
	DecorSetInt(Vehicle,"Player_Vehicle",-1)
	SetVehRadioStation(Vehicle,"OFF")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Plate = GetVehicleNumberPlateText(Vehicle)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped and Plate ~= "PDMSPORT" and not Entity(Vehicle)["state"]["Lockpick"] then
				SetVehicleEngineOn(Vehicle,false,true,true)
				DisablePlayerFiring(Ped,true)
				TimeDistance = 1
			end

			if Hotwired and Vehicle then
				DisableControlAction(0,75,true)
				DisableControlAction(0,20,true)
				TimeDistance = 1
			end
		end

		Wait(TimeDistance)
	end
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

			for Number,v in pairs(Garages) do
				local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
				if Distance <= 5.0 then
					TimeDistance = 1
					DrawMarker(23,v["x"],v["y"],v["z"] - 0.95,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,0.0,88,101,242,175,0,0,0,0)

					if Distance <= 1.25 and IsControlJustPressed(1,38) and not exports["hud"]:Wanted() and not exports["lb-phone"]:IsOpen() then
						local Vehicles = vSERVER.Vehicles(Number)
						if Vehicles then
							Opened = Number
							SetNuiFocus(true,true)
							TriggerEvent("target:Debug")
							SendNUIMessage({ Action = "Open", Payload = Vehicles })
						end
					end
				end
			end

			for Plate,v in pairs(Respawns) do
				local Distance = #(Coords - v["xyz"])
				if Distance <= 25.0 then
					TimeDistance = 1
					DrawMarker(36,v["x"],v["y"],v["z"],0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,1.75,88,101,242,175,0,0,0,1)

					if Distance <= 1.25 and IsControlJustPressed(1,38) and Spam <= GetGameTimer() then
						Spam = GetGameTimer() + 5000
						TriggerServerEvent("garages:Respawns",Plate)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn",function(Data,Callback)
	TriggerServerEvent("garages:Spawn",Data["Model"],Opened)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Delete",function(Data,Callback)
	TriggerEvent("garages:Delete")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Tax",function(Data,Callback)
	TriggerServerEvent("garages:Tax",Data["Model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Sell",function(Data,Callback)
	TriggerServerEvent("garages:Sell",Data["Model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Transfer",function(Data,Callback)
	TriggerServerEvent("garages:Transfer",Data["Model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Close")
AddEventHandler("garages:Close",function()
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(GaragesTable,RespawnsTable)
	for Name,v in pairs(GaragesTable) do
		Garages[Name] = {
			["x"] = v["x"],
			["y"] = v["y"],
			["z"] = v["z"],
			["1"] = v["1"]
		}
	end

	if RespawnsTable then
		Respawns = RespawnsTable
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Clean")
AddEventHandler("garages:Clean",function(Name)
	if Garages[Name] then
		Garages[Name] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Respawn")
AddEventHandler("garages:Respawn",function(Mode,Plate,Coords)
	if Mode == "Add" then
		Respawns[Plate] = Coords
	elseif Mode == "Remove" then
		Respawns[Plate] = nil
	end
end)