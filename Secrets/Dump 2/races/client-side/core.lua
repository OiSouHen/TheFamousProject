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
local Save = 0
local Object = {}
local Markers = {}
local Runners = {}
local Mode = false
local Checkpoint = 1
local Selected = false
local ExplodeTimers = false
local Points = GetGameTimer()
local ExplodeCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Races",false,false)
LocalPlayer["state"]:set("Checkpoints",1,true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadModel(PropTyre)
	LoadModel(PropFlags)
	SetGhostedEntityAlpha(254)

	while true do
		local TimeDistance = 999
		if not LocalPlayer["state"]["TestDrive"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetPlayersLastVehicle()

			if LocalPlayer["state"]["Races"] and Mode and Races[Mode] and Selected then
				TimeDistance = 1

				if not Races[Mode]["Global"] or (Races[Mode]["Global"] and GlobalState[Mode..":"..Selected]) then
					Points = GetGameTimer() - Save

					if ExplodeTimers and GetGameTimer() >= ExplodeCooldown then
						ExplodeTimers = ExplodeTimers - 1
						ExplodeCooldown = GetGameTimer() + 1000
					end

					SendNUIMessage({ Action = "Racing", Payload = { 1, Races[Mode]["Routes"][Selected]["Runners"], Runners, Points, ExplodeTimers, "1/"..Races[Mode]["Routes"][Selected]["Runners"], Checkpoint.."/"..Races[Mode]["Routes"][Selected]["Checkpoints"] } })

					local Distance = #(Coords - Races[Mode]["Routes"][Selected]["Coords"][Checkpoint]["Center"])
					if Distance <= (Races[Mode]["Routes"][Selected]["Coords"][Checkpoint]["Distance"] + 1.0) then
						if Checkpoint >= #Races[Mode]["Routes"][Selected]["Coords"] then
							SendNUIMessage({ Action = "Close" })
							vSERVER.Finish(Mode,Selected,Points)
							CleanObjects()
							CleanMarker()

							Save = 0
							Checkpoint = 1
							ExplodeTimers = false
							SetLocalPlayerAsGhost(false)
							SetNetworkVehicleAsGhost(Vehicle,false)
							LocalPlayer["state"]:set("Races",false,false)
							LocalPlayer["state"]:set("Checkpoints",1,true)
							SendNUIMessage({ Action = "Results", Payload = vSERVER.Ranking(Mode,Selected,ResultFinish) })
							Selected = false
							Mode = false

							SetTimeout(SecondsResult,function()
								SendNUIMessage({ Action = "Close" })
							end)
						else
							if DoesBlipExist(Markers[Checkpoint]) then
								RemoveBlip(Markers[Checkpoint])
								Markers[Checkpoint] = nil
							end

							Checkpoint = Checkpoint + 1
							LocalPlayer["state"]:set("Checkpoints",Checkpoint,true)
							SetBlipRoute(Markers[Checkpoint],true)
							CreatedTyres()
						end
					end

					if not IsPedInAnyVehicle(Ped) or GetPedInVehicleSeat(Vehicle,-1) ~= Ped or (ExplodeTimers and ExplodeTimers <= 0) then
						SetNetworkVehicleAsGhost(Vehicle,false)
						SetLocalPlayerAsGhost(false)
						StopCircuit()
					end
				else
					SendNUIMessage({ Action = "Racing", Payload = { 1, Races[Mode]["Routes"][Selected]["Runners"], Runners, 0, ExplodeTimers, "1/"..Races[Mode]["Routes"][Selected]["Runners"], Checkpoint.."/"..Races[Mode]["Routes"][Selected]["Checkpoints"] } })

					if IsControlJustPressed(1,38) then
						vSERVER.GlobalState(Mode,Selected)
					end
				end
			else
				if IsPedInAnyVehicle(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) and GetPedInVehicleSeat(Vehicle,-1) == Ped and Mode and Selected and Races[Mode] and Races[Mode]["Routes"][Selected] then
					local Distance = #(Coords - Races[Mode]["Routes"][Selected]["Init"])
					if Distance <= 25 then
						DrawMarker(23,Races[Mode]["Routes"][Selected]["Init"]["x"],Races[Mode]["Routes"][Selected]["Init"]["y"],Races[Mode]["Routes"][Selected]["Init"]["z"] - 0.35,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,10.0,88,101,242,175,0,0,0,0)
						TimeDistance = 1

						if Distance <= 5 and IsControlJustPressed(1,38) then
							if Races[Mode]["Explode"] then
								local Consult = vSERVER.Start(Mode,Selected)
								if Consult then
									ExplodeTimers = Consult
									ExplodeCooldown = GetGameTimer() + 1000
								else
									goto Ignore
								end
							end

							Runners = {{
								["Name"] = LocalPlayer["state"]["Name"]
							}}

							if Races[Mode]["Global"] then
								SendNUIMessage({ Action = "Message", Payload = { "E","Pressione","para iniciar a corrida" } })
							end

							SetNetworkVehicleAsGhost(Vehicle,true)
							SetLocalPlayerAsGhost(true)

							Save = GetGameTimer()
							Checkpoint = 1

							LocalPlayer["state"]:set("Checkpoints",1,true)
							LocalPlayer["state"]:set("Races",true,false)
							CreatedTyres()
							InitCircuit()
						end
					end

					::Ignore::
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
	for Number = 1,#Races[Mode]["Routes"][Selected]["Coords"] do
		Markers[Number] = AddBlipForCoord(Races[Mode]["Routes"][Selected]["Coords"][Number]["Center"])
		SetBlipSprite(Markers[Number],1)
		SetBlipScale(Markers[Number],0.85)
		SetBlipColour(Markers[Number],ColourMarker)
		ShowNumberOnBlip(Markers[Number],Number)
		SetBlipAsShortRange(Markers[Number],true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEDTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatedTyres()
	CleanObjects()

	local Prop = PropTyre
	if Checkpoint >= #Races[Mode]["Routes"][Selected]["Coords"] then
		Prop = PropFlags
	end

	local Coords = Races[Mode]["Routes"][Selected]["Coords"][Checkpoint]
	Object["Left"] = CreateObjectNoOffset(Prop,Coords["Left"]["x"],Coords["Left"]["y"],Coords["Left"]["z"],false,false,false)
	Object["Right"] = CreateObjectNoOffset(Prop,Coords["Right"]["x"],Coords["Right"]["y"],Coords["Right"]["z"],false,false,false)

	SetEntityLodDist(Object["Left"],0xFFFF)
	PlaceObjectOnGroundProperly(Object["Left"])
	SetEntityCollision(Object["Left"],false,false)

	SetEntityLodDist(Object["Right"],0xFFFF)
	PlaceObjectOnGroundProperly(Object["Right"])
	SetEntityCollision(Object["Right"],false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANMARKER
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanMarker()
	for Index,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end

		Markers[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanObjects()
	for Index,v in pairs(Object) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end

		Object[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function StopCircuit()
	LocalPlayer["state"]:set("Checkpoints",1,true)
	LocalPlayer["state"]:set("Races",false,false)
	SendNUIMessage({ Action = "Close" })
	vSERVER.Cancel()
	CleanObjects()
	CleanMarker()

	Mode = false
	Selected = false

	if ExplodeTimers then
		ExplodeTimers = false

		SetTimeout(SecondsExplode,function()
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Start")
AddEventHandler("races:Start",function(Modez,Selectedz)
	if Mode and Mode == Modez and Selected and Selected == Selectedz and Races[Mode] then
		SendNUIMessage({ Action = "Message", Payload = false })
		SendNUIMessage({ Action = "Countdown" })

		SetTimeout(3000,function()
			Points = GetGameTimer()
			Save = GetGameTimer()
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Open")
AddEventHandler("races:Open",function()
	if not LocalPlayer["state"]["Races"] then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		TriggerEvent("hud:Active",false)
		SendNUIMessage({ Action = "Open", Payload = { Races,LocalPlayer["state"]["Name"] } })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Run",function(Data,Callback)
	Mode = Data["Mode"]
	Selected = Data["Route"]

	if Mode and Selected and Races[Mode] and Races[Mode] and Races[Mode]["Routes"][Selected] and Races[Mode]["Routes"][Selected]["Init"] then
		SetNewWaypoint(Races[Mode]["Routes"][Selected]["Init"]["x"] + 0.0001,Races[Mode]["Routes"][Selected]["Init"]["y"] + 0.0001)
	end

	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	TriggerEvent("hud:Active",true)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Ranking",function(Data,Callback)
	Callback(vSERVER.Ranking(Data["Mode"],Data["Route"],RankingTablet))
end)