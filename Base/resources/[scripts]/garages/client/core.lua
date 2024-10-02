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
Tunnel.bindInterface("garages", Hensa)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECORATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("Player_Vehicle", 3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Opened = "1"
local Searched = nil
local Hotwired = false
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMods(Vehicle, Customize)
	if Customize then
		SetVehicleModKit(Vehicle, 0)

		if Customize["wheeltype"] ~= nil then
			SetVehicleWheelType(Vehicle, Customize["wheeltype"])
		end

		if Customize["mods"] then
			for i = 0, 16 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end

			for i = 17, 22 do
				if Customize["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end

			for i = 23, 24 do
				if Customize["mods"][tostring(i)] ~= nil then
					if not Customize["var"] then
						Customize["var"] = {}
						Customize["var"][tostring(i)] = 0
					end

					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)], Customize["var"][tostring(i)])
				end
			end

			for i = 25, 48 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle, i, Customize["mods"][tostring(i)])
				end
			end
		end

		if Customize["neon"] ~= nil then
			for i = 0, 3 do
				SetVehicleNeonLightEnabled(Vehicle, i, Customize["neon"][tostring(i)])
			end
		end

		if Customize["extras"] ~= nil then
			for i = 1, 12 do
				local onoff = tonumber(Customize["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(Vehicle, i, 0)
				else
					SetVehicleExtra(Vehicle, i, 1)
				end
			end
		end

		if Customize["liverys"] ~= nil and Customize["liverys"] ~= 24 then
			SetVehicleLivery(Vehicle, Customize["liverys"])
		end

		if Customize["plateIndex"] ~= nil and Customize["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(Vehicle, Customize["plateIndex"])
		end

		SetVehicleXenonLightsColour(Vehicle, Customize["xenonColor"])
		SetVehicleColours(Vehicle, Customize["colors"][1], Customize["colors"][2])
		SetVehicleExtraColours(Vehicle, Customize["extracolors"][1], Customize["extracolors"][2])
		SetVehicleNeonLightsColour(Vehicle, Customize["lights"][1], Customize["lights"][2], Customize["lights"][3])
		SetVehicleTyreSmokeColor(Vehicle, Customize["smokecolor"][1], Customize["smokecolor"][2], Customize["smokecolor"][3])

		if Customize["tint"] ~= nil then
			SetVehicleWindowTint(Vehicle, Customize["tint"])
		end

		if Customize["dashColour"] ~= nil then
			SetVehicleInteriorColour(Vehicle, Customize["dashColour"])
		end

		if Customize["interColour"] ~= nil then
			SetVehicleDashboardColour(Vehicle, Customize["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.SpawnPosition(Select)
	local Slot = "0"
	local Checks = 0
	local Selected = {}
	local Position = nil

	repeat
		Checks = Checks + 1

		Slot = tostring(Checks)
		if GaragesCoords[Select] and GaragesCoords[Select][Slot] then
			local _, CoordsZ = GetGroundZFor_3dCoord(GaragesCoords[Select][Slot][1], GaragesCoords[Select][Slot][2], GaragesCoords[Select][Slot][3])
			Selected = { GaragesCoords[Select][Slot][1], GaragesCoords[Select][Slot][2], CoordsZ, GaragesCoords[Select][Slot][4] }
			Position = GetClosestVehicle(Selected[1], Selected[2], Selected[3], 2.5, 0, 71)
		end
	until not DoesEntityExist(Position) or not GaragesCoords[Select][Slot]

	if not GaragesCoords[Select][tostring(Checks)] then
		TriggerEvent("Notify", "amarelo", "Vagas estão ocupadas.", "Atenção", 5000)
		return false
	end

	SendNUIMessage({ name = "Close" })

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CreateVehicle(Model, Network, Engine, Health, Customize, Windows, Tyres, Brakes, Owner)
	local Count = 0

	if Owner then
		while not NetworkDoesNetworkIdExist(Network) do
			Count = Count + 1

			if Count >= 1000 then
				Count = 0
				break
			end

			Wait(10)
		end

		local Vehicle = NetToEnt(Network)
		while not DoesEntityExist(Vehicle) do
			Count = Count + 1

			if Count >= 1000 then
				Count = 0
				break
			end

			Wait(10)
		end
	end

	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Customize ~= nil then
				local Mods = json.decode(Customize)
				VehicleMods(Vehicle, Mods)
			end

			if Brakes[1] ~= nil then
				if Brakes[1] > 0.90 then
					Brakes[1] = 0.90
				end
			end

			if Brakes[2] ~= nil then
				if Brakes[2] > 0.55 then
					Brakes[2] = 0.55
				end
			end

			if Brakes[3] ~= nil then
				if Brakes[3] > 0.75 then
					Brakes[3] = 0.75
				end
			end

			SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeForce", Brakes[1] or 0.90)
			SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeBiasFront", Brakes[2] or 0.55)
			SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fHandBrakeForce", Brakes[3] or 0.75)

			SetVehicleEngineHealth(Vehicle, Engine + 0.0)
			SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
			SetVehicleNeedsToBeHotwired(Vehicle, false)
			DecorSetInt(Vehicle, "Player_Vehicle", -1)
			SetVehicleOnGroundProperly(Vehicle)
			SetVehRadioStation(Vehicle, "OFF")
			SetEntityHealth(Vehicle, Health)

			if Windows then
				local Windows = json.decode(Windows)
				if Windows ~= nil then
					for Index, v in pairs(Windows) do
						if not v then
							RemoveVehicleWindow(Vehicle, parseInt(Index))
						end
					end
				end
			end

			if Tyres then
				local Tyres = json.decode(Tyres)
				if Tyres ~= nil then
					for Index, Burst in pairs(Tyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle, parseInt(Index), true, 1000.0)
						end
					end
				end
			end

			if not DecorExistOn(Vehicle, "Player_Vehicle") then
				DecorSetInt(Vehicle, "Player_Vehicle", -1)
			end

			if GetVehicleClass(Vehicle) == 14 then
				SetBoatAnchor(Vehicle, true)
			end

			SetModelAsNoLongerNeeded(Model)
		end
	end

	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete", function(Vehicle)
	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) and (not Entity(Vehicle)["state"]["Tow"] or LocalPlayer["state"]["Admin"]) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0, 5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle, i)
		end

		for i = 0, 5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle, i)
		end

		for i = 0, 7 do
			local Status = false

			if GetTyreHealth(Vehicle, i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		if DecorExistOn(Vehicle, "Player_Vehicle") then
			DecorRemove(Vehicle, "Player_Vehicle")
		end

		vSERVER.Delete(VehToNet(Vehicle), GetEntityHealth(Vehicle), GetVehicleEngineHealth(Vehicle), GetVehicleBodyHealth(Vehicle), GetVehicleFuelLevel(Vehicle), Doors, Windows, Tyres, GetVehicleNumberPlateText(Vehicle), { GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeForce"), GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fBrakeBiasFront"), GetVehicleHandlingFloat(Vehicle, "CHandlingData", "fHandBrakeForce") })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.SearchBlip(Coords)
	if DoesBlipExist(Searched) then
		RemoveBlip(Searched)
		Searched = nil
	end

	Searched = AddBlipForCoord(Coords["x"], Coords["y"], Coords["z"])
	SetBlipSprite(Searched, 225)
	SetBlipColour(Searched, 77)
	SetBlipScale(Searched, 0.6)
	SetBlipAsShortRange(Searched, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(Searched)

	SetTimeout(30000, function()
		RemoveBlip(Searched)
		Searched = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StartHotwired()
	Hotwired = true

	if LoadAnim(Dict) then
		TaskPlayAnim(PlayerPedId(), Dict, Anim, 8.0, 8.0, -1, 49, 1, 0, 0, 0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.StopHotwired(Vehicle)
	Hotwired = false

	if LoadAnim(Dict) then
		StopAnimTask(PlayerPedId(), Dict, Anim, 8.0)
	end

	if Vehicle then
		SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
		SetVehicleNeedsToBeHotwired(Vehicle, false)
		DecorSetInt(Vehicle, "Player_Vehicle", -1)
		SetVehRadioStation(Vehicle, "OFF")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.UpdateHotwired(Status)
	Hotwired = Status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERDECORS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RegisterDecors(Vehicle)
	SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
	SetVehicleNeedsToBeHotwired(Vehicle, false)
	DecorSetInt(Vehicle, "Player_Vehicle", -1)
	SetVehRadioStation(Vehicle, "OFF")
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
			if GetPedInVehicleSeat(Vehicle, -1) == Ped and Plate ~= "PDMSPORT" and not GlobalState["Plates"][Plate] and not Entity(Vehicle)["state"]["Lockpick"] then
				SetVehicleEngineOn(Vehicle, false, true, true)
				DisablePlayerFiring(Ped, true)
				TimeDistance = 1
			end

			if Hotwired and Vehicle then
				DisableControlAction(0, 75, true)
				DisableControlAction(0, 20, true)
				TimeDistance = 1
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound", function()
	local Impound = vSERVER.Impound()
	if parseInt(#Impound) > 0 then
		for k,v in pairs(Impound) do
			exports["dynamic"]:AddButton(v["Name"], "Clique para efetuar a liberação.", "garages:Impound", v["Model"], false, true)
		end

		exports["dynamic"]:Open()
	else
		TriggerEvent("Notify", "amarelo", "Você não possui veículos apreendidos.", "Atenção", 5000)
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
            local isNearGarage = false

            for Number, v in pairs(GaragesCoords) do
                local Distance = #(Coords - vec3(v["x"], v["y"], v["z"]))
                
                if Distance <= 5.0 then
                    isNearGarage = true
                    TimeDistance = 1
                    DrawMarker(27, v["x"], v["y"], v["z"] - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.30, 1.30, 0.0, 224, 29, 99, 100, 0, 0, 0, 0)

                    if Distance <= 1.25 and IsControlJustPressed(1, 38) then
                        if not exports["hud"]:Wanted() and not LocalPlayer["state"]["usingPhone"] and not LocalPlayer["state"]["Target"] then
                            if vSERVER.Verify(Number) then
                                local Vehicles = vSERVER.Vehicles(Number)
                                
                                if Vehicles then
                                    Opened = Number
                                    SetNuiFocus(true, true)
                                    TriggerEvent("target:Debug")
                                    SendNUIMessage({ action = "Visible", data = true })
                                    SendNUIMessage({ action = "OpenGarage", data = Vehicles })
                                end
                            end
                        end
                    end
                end
            end

            if not isNearGarage then
                TimeDistance = 999
            end
        end

        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Close")
AddEventHandler("garages:Close", function()
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close", function(Data, Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeVehicle", function(Data, Callback)
	vSERVER.Spawn(Data["model"], Opened)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeVehicle", function(Data, Callback)
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	for Number, v in pairs(GaragesCoords) do
		local Distance = #(Coords - vec3(v["x"], v["y"], v["z"]))
		if Distance <= StoreVehiclesDistance then
			if vSERVER.PaymentStore(Number) then
				TriggerEvent("garages:Delete")
			end
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellVehicle", function(Data, Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)

	vSERVER.Sell(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("transferVehicle", function(Data, Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)

	vSERVER.Transfer(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("taxVehicle", function(Data, Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false, false)

	vSERVER.Tax(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Propertys")
AddEventHandler("garages:Propertys", function(Table)
	for Name, v in pairs(Table) do
		GaragesCoords[Name] = {
			["x"] = v["x"],
			["y"] = v["y"],
			["z"] = v["z"],
			["1"] = v["1"]
		}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:CLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Clean")
AddEventHandler("garages:Clean", function(Name)
	if GaragesCoords[Name] then
		GaragesCoords[Name] = nil
	end
end)