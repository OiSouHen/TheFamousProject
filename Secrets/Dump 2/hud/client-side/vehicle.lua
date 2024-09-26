-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Rpm = 0
local Fuel = 0
local Speed = 0
local Nitro = 0
local Spike = {}
local LastSpeed = 0
local Locked = false
local Loadout = false
local EngineHealth = 0
local ActualVehicle = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local NitroFuel = 0
local NitroActive = false
local NitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local SeatbeltSpeed = 0
local SeatbeltLock = false
local SeatbeltVelocity = vec3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tyres = {
	{ ["Bone"] = "wheel_lf", ["Index"] = 0 },
	{ ["Bone"] = "wheel_rf", ["Index"] = 1 },
	{ ["Bone"] = "wheel_lm", ["Index"] = 2 },
	{ ["Bone"] = "wheel_rm", ["Index"] = 3 },
	{ ["Bone"] = "wheel_lr", ["Index"] = 4 },
	{ ["Bone"] = "wheel_rr", ["Index"] = 5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadPtfxAsset("veh_xs_vehicle_mods")

	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				TimeDistance = 100

				if not Loadout then
					if LoadTexture("circleminimap") then
						AddReplaceTexture("platform:/textures/graphics","radarmasksm","circleminimap","radarmasksm")

						SetMinimapComponentPosition("minimap","L","B",0.005,-0.025,0.175,0.225)
						SetMinimapComponentPosition("minimap_mask","L","B",0.02,0.39,0.1135,0.5)
						SetMinimapComponentPosition("minimap_blur","L","B",-0.02,-0.01,0.265,0.225)

						SetBigmapActive(true,false)

						repeat
							Wait(100)

							SetMinimapClipType(1)
							SetBigmapActive(false,false)
						until not IsBigmapActive()

						SetRadarZoom(1100)
						Loadout = true
					end
				end

				if Display and not IsMinimapRendering() then
					SetBigmapActive(false,false)
					DisplayRadar(true)
				end

				local Vehicle = GetVehiclePedIsUsing(Ped)
				local VRpm = GetVehicleCurrentRpm(Vehicle)
				local EntitySpeed = GetEntitySpeed(Vehicle)
				local VLocked = GetVehicleDoorLockStatus(Vehicle)
				local VFuel = Entity(Vehicle)["state"]["Fuel"] or 0
				local VEngineHealth = GetVehicleEngineHealth(Vehicle)
				local VSpeed = math.ceil(EntitySpeed * 2.236936)

				if GetPedInVehicleSeat(Vehicle,-1) == Ped then
					if GetVehicleDirtLevel(Vehicle) > 0.0 then
						SetVehicleDirtLevel(Vehicle,0.0)
					end

					if Entity(Vehicle)["state"]["Drift"] then
						local Class = GetVehicleClass(Vehicle)
						if (Class >= 0 and Class <= 7) or Class == 9 then
							if IsControlPressed(1,21) then
								if VSpeed <= 75.0 and not GetDriftTyresEnabled(Vehicle) then
									SetDriftTyresEnabled(Vehicle,true)
									SetVehicleReduceGrip(Vehicle,true)
									SetReduceDriftVehicleSuspension(Vehicle,true)
								end
							else
								if GetDriftTyresEnabled(Vehicle) then
									SetDriftTyresEnabled(Vehicle,false)
									SetVehicleReduceGrip(Vehicle,false)
									SetReduceDriftVehicleSuspension(Vehicle,false)
								end
							end
						end
					end

					if not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
						if not LocalPlayer["state"]["Races"] and VSpeed ~= LastSpeed then
							if (LastSpeed - VSpeed) >= (Entity(Vehicle)["state"]["Seatbelt"] and 125 or 100) then
								VehicleTyreBurst(Vehicle)
							end

							LastSpeed = VSpeed
						end

						local Roll = GetEntityRoll(Vehicle)
						if (Roll > 75.0 or Roll < -75.0) and math.random(100) <= 50 then
							VehicleTyreBurst(Vehicle)
						end
					end

					for Number,v in pairs(Spike) do
						if #(GetEntityCoords(Vehicle) - v["Coords"]) <= 10 then
							for Index = 1,#Tyres do
								local BoneIndex = GetEntityBoneIndexByName(Vehicle,Tyres[Index]["Bone"])
								local TirePosition = GetWorldPositionOfEntityBone(Vehicle,BoneIndex)

								if IsPointInAngledArea(TirePosition,v["Min"],v["Max"],0.45,false,false) then
									TriggerServerEvent("inventory:StoreObjects",Number)
									VehicleTyreBurst(Vehicle)
								end
							end
						end
					end
				end

				if ActualVehicle ~= Vehicle then
					SendNUIMessage({ Action = "Vehicle", Payload = true })
					ActualVehicle = Vehicle
				end

				if VEngineHealth ~= EngineHealth then
					SendNUIMessage({ Action = "EngineHealth", Payload = VEngineHealth })
					VEngineHealth = EngineHealth
				end

				if Locked ~= VLocked then
					SendNUIMessage({ Action = "Locked", Payload = VLocked })
					Locked = VLocked
				end

				if LocalPlayer["state"]["Nitro"] then
					SendNUIMessage({ Action = "Nitro", Payload = NitroFuel })
					Nitro = NitroFuel
				else
					if (Entity(Vehicle)["state"]["Nitro"] or 0) ~= Nitro then
						SendNUIMessage({ Action = "Nitro", Payload = Entity(Vehicle)["state"]["Nitro"] or 0 })
						Nitro = Entity(Vehicle)["state"]["Nitro"] or 0
					end
				end

				if Fuel ~= VFuel then
					SendNUIMessage({ Action = "Fuel", Payload = VFuel })
					Fuel = VFuel
				end

				if Speed ~= VSpeed then
					SendNUIMessage({ Action = "Speed", Payload = VSpeed })
					Speed = VSpeed
				end

				if not GetIsVehicleEngineRunning(Vehicle) then
					VRpm = 0.0
				end

				if Rpm ~= VRpm then
					SendNUIMessage({ Action = "Rpm", Payload = VRpm })
					Rpm = VRpm
				end
			else
				if IsMinimapRendering() then
					DisplayRadar(false)
				end

				if ActualVehicle then
					ActualVehicle = nil
					SendNUIMessage({ Action = "Vehicle", Payload = false })

					Locked = false
					SendNUIMessage({ Action = "Locked", Payload = false })

					Nitro = 0
					SendNUIMessage({ Action = "Nitro", Payload = 0 })

					Speed = 0
					SendNUIMessage({ Action = "Speed", Payload = 0 })
				end

				if LastSpeed ~= 0 then
					LastSpeed = 0
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleTyreBurst(Vehicle)
	local WheelAffect = 0
	local NumWheels = GetVehicleNumberOfWheels(Vehicle)

	if NumWheels == 2 then
		WheelAffect = (math.random(2) - 1) * 4
	elseif NumWheels == 4 then
		WheelAffect = (math.random(4) - 1)

		if WheelAffect > 1 then
			WheelAffect = WheelAffect + 2
		end
	elseif NumWheels == 6 then
		WheelAffect = (math.random(6) - 1)
	end

	if GetTyreHealth(Vehicle,WheelAffect) == 1000.0 then
		SetVehicleTyreBurst(Vehicle,WheelAffect,true,1000.0)
	end

	if math.random(100) <= 25 then
		VehicleTyreBurst(Vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroEnable()
	if GetGameTimer() >= NitroButton and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			NitroButton = GetGameTimer() + 1000

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped and GetVehicleTopSpeedModifier(Vehicle) < 50.0 then
				NitroFuel = Entity(Vehicle)["state"]["Nitro"] or 0

				if NitroFuel >= 1 and Speed > 10 then
					NitroActive = true

					while NitroActive do
						if NitroFuel >= 1 then
							NitroFuel = NitroFuel - 1

							if not LocalPlayer["state"]["Nitro"] then
								LocalPlayer["state"]:set("Nitro",true,false)
								Entity(Vehicle)["state"]:set("NitroFlame",true,true)

								SetVehicleRocketBoostActive(Vehicle,true)
								SetVehicleBoostActive(Vehicle,true)
								ModifyVehicleTopSpeed(Vehicle,50.0)
							end
						else
							if LocalPlayer["state"]["Nitro"] then
								LocalPlayer["state"]:set("Nitro",false,false)
								Entity(Vehicle)["state"]:set("NitroFlame",false,true)
								Entity(Vehicle)["state"]:set("Nitro",NitroFuel,true)
							end

							SetVehicleRocketBoostActive(Vehicle,false)
							SetVehicleBoostActive(Vehicle,false)
							ModifyVehicleTopSpeed(Vehicle,0.0)
							NitroActive = false
						end

						Wait(1)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroDisable()
	if LocalPlayer["state"]["Nitro"] then
		LocalPlayer["state"]:set("Nitro",false,false)

		local Vehicle = GetLastDrivenVehicle()
		if DoesEntityExist(Vehicle) then
			Entity(Vehicle)["state"]:set("Nitro",NitroFuel,true)
			Entity(Vehicle)["state"]:set("NitroFlame",false,true)

			SetVehicleRocketBoostActive(Vehicle,false)
			SetVehicleBoostActive(Vehicle,false)
			ModifyVehicleTopSpeed(Vehicle,0.0)
		end
	end

	NitroActive = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("NitroFlame",nil,function(Name,Key,Value)
	local Network = parseInt(Name:gsub("entity:",""))
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToVeh(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleNitroEnabled(Vehicle,Value)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",NitroEnable)
RegisterCommand("-activeNitro",NitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				if not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
					TimeDistance = 1

					if SeatbeltLock then
						DisableControlAction(0,75,true)
						DisableControlAction(27,75,true)
					end

					if Speed ~= SeatbeltSpeed then
						local Vehicle = GetVehiclePedIsUsing(Ped)
						if not Entity(Vehicle)["state"]["Seatbelt"] and not SeatbeltLock and (SeatbeltSpeed - Speed) >= 100 then
							ApplyDamageToPed(Ped,25,false)

							SetEntityNoCollisionEntity(Ped,Vehicle,false)
							SetEntityNoCollisionEntity(Vehicle,Ped,false)
							TriggerServerEvent("hud:VehicleEject",SeatbeltVelocity)

							SetTimeout(500,function()
								SetEntityNoCollisionEntity(Ped,Vehicle,true)
								SetEntityNoCollisionEntity(Vehicle,Ped,true)
							end)
						end

						SeatbeltVelocity = GetEntityVelocity(Vehicle)
						SeatbeltSpeed = Speed
					end
				end
			else
				if SeatbeltSpeed ~= 0 then
					SeatbeltSpeed = 0
				end

				if SeatbeltLock then
					SendNUIMessage({ Action = "Seatbelt", Payload = false })
					SeatbeltLock = false
				end

				if LocalPlayer["state"]["Nitro"] then
					NitroDisable()
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELTZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Seatbeltz",function(source)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
		if SeatbeltLock then
			TriggerEvent("sounds:Private","beltoff",0.5)
			SendNUIMessage({ Action = "Seatbelt", Payload = false })
			SeatbeltLock = false
		else
			TriggerEvent("sounds:Private","belton",0.5)
			SendNUIMessage({ Action = "Seatbelt", Payload = true })
			SeatbeltLock = true

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if Entity(Vehicle)["state"]["Seatbelt"] then
				TriggerEvent("Notify","Cinto de Segurança","Cinto de Corrida colocado.","azul",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Seatbeltz","Colocar/Retirar o cinto.","keyboard","G")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKES:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spikes:Adicionar",function(Number,Coords,Min,Max)
	Spike[Number] = {
		["Min"] = Min, ["Max"] = Max,
		["Coords"] = vec3(Coords[1],Coords[2],Coords[3])
	}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKES:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spikes:Remover",function(Number)
	if Spike[Number] then
		Spike[Number] = nil
	end
end)