-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Price = 0
local Lasted = 0
local Display = false
local VehicleFuel = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event ~= "CEventNetworkPlayerEnteredVehicle" then
		return
	end

	local Vehicle = Message[2]
	if Message[1] == PlayerId() then
		local Ped = PlayerPedId()
		if not Entity(Vehicle)["state"]["Fuel"] then
			Entity(Vehicle)["state"]:set("Fuel",100,true)
		end

		SetPedConfigFlag(Ped,35,false)

		if not IsPedInAnyHeli(Ped) then
			TriggerEvent("inventory:CleanWeapons")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:FUELADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:FuelAdmin")
AddEventHandler("engine:FuelAdmin",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		Entity(Vehicle)["state"]:set("Fuel",100,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = {
	[13] = 0.0,
	[14] = 0.0,
	[15] = 1.5,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
local Consume = {
	[1.0] = 0.575,
	[0.9] = 0.525,
	[0.8] = 0.475,
	[0.7] = 0.425,
	[0.6] = 0.375,
	[0.5] = 0.325,
	[0.4] = 0.275,
	[0.3] = 0.225,
	[0.2] = 0.175,
	[0.1] = 0.125,
	[0.0] = 0.000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(Number)
	local Mult = 10 ^ 1
	return math.floor(Number * Mult + 0.5) / Mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local ClassVehicle = GetVehicleClass(Vehicle)
			if not Class[ClassVehicle] or Class[ClassVehicle] ~= 0.0 then
				if GetVehicleFuelLevel(Vehicle) >= 1 then
					if (GetEntitySpeed(Vehicle) * 2.236936) >= 1 and GetPedInVehicleSeat(Vehicle,-1) == Ped then
						if not Entity(Vehicle)["state"]["Fuel"] then
							Entity(Vehicle)["state"]:set("Fuel",100,true)
						end

						local Calculate = (Entity(Vehicle)["state"]["Fuel"] - (Consume[floor(GetVehicleCurrentRpm(Vehicle))] or 1.0) * (Class[ClassVehicle] or 1.0) / 10)

						Entity(Vehicle)["state"]:set("Fuel",Calculate + 0.0,true)
						SetVehicleFuelLevel(Vehicle,Calculate + 0.0)
					end
				else
					SetVehicleEngineOn(Vehicle,false,true,true)
					TimeDistance = 1
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SUPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Supply",function(Entitys)
	if VehicleFuel then
		return false
	end

	local Vehicle = Entitys[3]
	if not Entity(Vehicle)["state"]["Fuel"] then
		Entity(Vehicle)["state"]:set("Fuel",100,true)
	end

	Lasted = Entity(Vehicle)["state"]["Fuel"]

	if Lasted <= 99.975 then
		local Ped = PlayerPedId()
		local Gallons = Entitys[6]
		local Coords = GetEntityCoords(Vehicle)

		if not Display and not Gallons then
			SendNUIMessage({ Action = "Open" })
			TriggerEvent("hud:Active",false)
			Display = true
		end

		if not VehicleFuel then
			TaskTurnPedToFaceEntity(Ped,Vehicle,5000)
			VehicleFuel = Entity(Vehicle)["state"]["Fuel"]
		end

		while VehicleFuel do
			DisableControlAction(0,18,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,30,true)
			DisableControlAction(0,31,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)

			if not Gallons then
				Price = Price + 0.150
				VehicleFuel = VehicleFuel + 0.025
				SendNUIMessage({ Action = "Tank", Payload = { floor(VehicleFuel),Price,0.150 * 4 } })
			else
				if (GetAmmoInPedWeapon(Ped,883325847) - 0.025 * 100) > 1 then
					SetPedAmmo(Ped,883325847,math.floor(GetAmmoInPedWeapon(Ped,883325847) - 0.025 * 100))
					VehicleFuel = VehicleFuel + 0.025
				end
			end

			SetDrawOrigin(Coords["x"],Coords["y"],Coords["z"])
			DrawSprite("Textures","E",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
			ClearDrawOrigin()

			if not IsEntityPlayingAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) and LoadAnim("timetable@gardener@filling_can") then
				TaskPlayAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",8.0,8.0,-1,50,1,0,0,0)
			end

			if VehicleFuel >= 100.0 or GetEntityHealth(Ped) <= 100 or (Gallons and GetAmmoInPedWeapon(Ped,883325847) - 0.025 * 100 <= 1) or IsControlJustPressed(1,38) then
				if not Gallons and not vSERVER.RechargeFuel(Price) then
					Entity(Vehicle)["state"]:set("Fuel",Lasted + 0.0,true)
				else
					Entity(Vehicle)["state"]:set("Fuel",VehicleFuel + 0.0,true)

					if Display then
						SendNUIMessage({ Action = "Close" })
						TriggerEvent("hud:Active",true)
					end
				end

				VehicleFuel = false
				Display = false
				vRP.Destroy()
				Lasted = 0
				Price = 0
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:VEHRIFY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Vehrify",function(Entitys)
	local Vehicle = Entitys[3]
	local Brake = GetVehicleMod(Vehicle,12)
	local Engine = GetVehicleMod(Vehicle,11)
	local Shielding = GetVehicleMod(Vehicle,16)
	local Suspension = GetVehicleMod(Vehicle,15)
	local Transmission = GetVehicleMod(Vehicle,13)

	if Engine ~= -1 then
		exports["dynamic"]:AddButton("Motor","Modificação atual instalada: <rare>"..(Engine + 1).."</rare> / "..GetNumVehicleMods(Vehicle,11),"","",false,false)
	end

	if Brake ~= -1 then
		exports["dynamic"]:AddButton("Freios","Modificação atual instalada: <rare>"..(Brake + 1).."</rare> / "..GetNumVehicleMods(Vehicle,12),"","",false,false)
	end

	if Transmission ~= -1 then
		exports["dynamic"]:AddButton("Transmissão","Modificação atual instalada: <rare>"..(Transmission + 1).."</rare> / "..GetNumVehicleMods(Vehicle,13),"","",false,false)
	end

	if Suspension ~= -1 then
		exports["dynamic"]:AddButton("Suspensão","Modificação atual instalada: <rare>"..(Suspension + 1).."</rare> / "..GetNumVehicleMods(Vehicle,15),"","",false,false)
	end

	if Shielding ~= -1 then
		exports["dynamic"]:AddButton("Blindagem","Modificação atual instalada: <rare>"..(Shielding + 1).."</rare> / "..GetNumVehicleMods(Vehicle,16),"","",false,false)
	end

	local Force = GetVehicleEngineHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Potência","Potência do motor se encontra em <rare>"..parseInt(Force).."%</rare>.","","",false,false)

	local Body = GetVehicleBodyHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Lataria","Qualidade da lataria se encontra em <rare>"..parseInt(Body).."%</rare>.","","",false,false)

	local Health = GetEntityHealth(Vehicle) / 10
	exports["dynamic"]:AddButton("Chassi","Rigidez do chassi se encontra em <rare>"..parseInt(Health).."%</rare>.","","",false,false)

	exports["dynamic"]:Open()
end)