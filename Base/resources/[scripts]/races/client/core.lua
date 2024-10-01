-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Saved = 0
local Objects = {}
local Selected = 1
local Markers = {}
local Checkpoint = 1
local Rankings = false
local ExplodeTimers = false
local ExplodeCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)

	for _,Info in pairs(Races) do
		local Blip = AddBlipForCoord(Info["Init"]["x"],Info["Init"]["y"],Info["Init"]["z"])
		SetBlipSprite(Blip,38)
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,22)
		SetBlipScale(Blip,0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Circuito de Corrida")
		EndTextCommandSetBlipName(Blip)
	end

	while true do
		local TimeDistance = 999
		if not LocalPlayer["state"]["TestDrive"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetPlayersLastVehicle()

			if LocalPlayer["state"]["Races"] then
				TimeDistance = 1
				local Points = GetGameTimer() - Saved

				if ExplodeTimers and GetGameTimer() >= ExplodeCooldown then
					ExplodeTimers = ExplodeTimers - 1
					ExplodeCooldown = GetGameTimer() + 1000
				end

				SendNUIMessage({ name = "Progress", payload = { Points,ExplodeTimers } })

				if not IsPedInAnyVehicle(Ped) or GetPedInVehicleSeat(Vehicle,-1) ~= Ped or (ExplodeTimers and ExplodeTimers <= 0) then
					StopCircuit()
				end

				local Distance = #(Coords - Races[Selected]["Coords"][Checkpoint]["Center"])
				if Distance <= (Races[Selected]["Coords"][Checkpoint]["Distance"] + 1.0) then
					if Checkpoint >= #Races[Selected]["Coords"] then
						SendNUIMessage({ name = "Display", payload = { false } })
						vSERVER.Finish(Selected,Points)

						CleanCircuit()

						Saved = 0
						Checkpoint = 1
						ExplodeTimers = false
						LocalPlayer["state"]:set("Races",false,false)
						SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Selected) } })
						Selected = 1

						SetTimeout(5000,function()
							SendNUIMessage({ name = "Ranking", payload = { false } })
						end)
					else
						if DoesBlipExist(Markers[Checkpoint]) then
							RemoveBlip(Markers[Checkpoint])
							Markers[Checkpoint] = nil
						end

						Checkpoint = Checkpoint + 1
						SetBlipRoute(Markers[Checkpoint],true)
						SendNUIMessage({ name = "Checkpoint" })
					end
				end
			else
				if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
					for Number,v in pairs(Races) do
						local Distance = #(Coords - v["Init"])
						if Distance <= 25 and GetPedInVehicleSeat(Vehicle,-1) == Ped then
							DrawMarker(23,v["Init"]["x"],v["Init"]["y"],v["Init"]["z"] - 0.35,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,10.0,65,130,226,100,0,0,0,0)
							TimeDistance = 1

							if Distance <= 5 then
								if IsControlJustPressed(1,47) then
									if not Rankings then
										Rankings = true
										SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Number) } })
									else
										Rankings = false
										SendNUIMessage({ name = "Ranking", payload = { false } })
									end
								end

								if IsControlJustPressed(1,38) then
									ExplodeTimers = vSERVER.Start(Number)
									SendNUIMessage({ name = "Display", payload = { true,#Races[Number]["Coords"],ExplodeTimers } })

									if ExplodeTimers then
										ExplodeCooldown = GetGameTimer() + 1000
									end

									Saved = GetGameTimer()
									Selected = Number
									Checkpoint = 1

									LocalPlayer["state"]:set("Races",true,false)
									InitCircuit()
								end
							else
								if Rankings then
									Rankings = false
									SendNUIMessage({ name = "Ranking", payload = { false } })
								end
							end
						end
					end
				else
					if Rankings then
						Rankings = false
						SendNUIMessage({ name = "Ranking", payload = { false } })
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function InitCircuit()
	LoadModel("prop_beachflag_01")
	LoadModel("prop_offroad_tyres02")

	for Number = 1,#Races[Selected]["Coords"] do
		Markers[Number] = AddBlipForCoord(Races[Selected]["Coords"][Number]["Center"]["x"],Races[Selected]["Coords"][Number]["Center"]["y"],Races[Selected]["Coords"][Number]["Center"]["z"])
		SetBlipSprite(Markers[Number],1)
		SetBlipColour(Markers[Number],77)
		SetBlipScale(Markers[Number],0.85)
		ShowNumberOnBlip(Markers[Number],Number)
		SetBlipAsShortRange(Markers[Number],true)

		local Prop = "prop_offroad_tyres02"
		if Number == #Races[Selected]["Coords"] then
			Prop = "prop_beachflag_01"
		end

		local LeftObject = CreateObjectNoOffset(Prop,Races[Selected]["Coords"][Number]["Left"]["x"],Races[Selected]["Coords"][Number]["Left"]["y"],Races[Selected]["Coords"][Number]["Left"]["z"],false,false,false)
		local RightObject = CreateObjectNoOffset(Prop,Races[Selected]["Coords"][Number]["Right"]["x"],Races[Selected]["Coords"][Number]["Right"]["y"],Races[Selected]["Coords"][Number]["Right"]["z"],false,false,false)

		SetEntityLodDist(LeftObject,0xFFFF)
		PlaceObjectOnGroundProperly(LeftObject)
		SetEntityCollision(LeftObject,false,false)

		SetEntityLodDist(RightObject,0xFFFF)
		PlaceObjectOnGroundProperly(RightObject)
		SetEntityCollision(RightObject,false,false)

		Objects[#Objects + 1] = LeftObject
		Objects[#Objects + 1] = RightObject
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanCircuit()
	for _,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end

	for _,v in pairs(Objects) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

	Markers = {}
	Objects = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function StopCircuit()
	SendNUIMessage({ name = "Display", payload = { false } })
	LocalPlayer["state"]:set("Races",false,false)
	vSERVER.Cancel()
	CleanCircuit()

	if ExplodeTimers then
		ExplodeTimers = false

		SetTimeout(3000,function()
			local Vehicle = GetPlayersLastVehicle()

			if Vehicle == 0 then
				local Ped = PlayerPedId()
				local Coords = GetEntityCoords(Ped)

				AddExplosion(Coords,2,0.5,false,false,false)
			else
				NetworkExplodeVehicle(Vehicle,true,false,true)
			end
		end)
	end
end