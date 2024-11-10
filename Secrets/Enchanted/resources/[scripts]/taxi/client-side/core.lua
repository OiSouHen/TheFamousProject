-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("taxi")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Current = nil
local Passenger = nil
local Service = false
local Walking = false
local PaymentActive = false
local Lasted = math.random(#Locations)
local Selected = math.random(#Locations)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("WorkTaxi",Init["xyz"],0.75,0.75,{
		name = "WorkTaxi",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "taxi:Init",
				label = "Iniciar Expediente",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXI:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("taxi:Init",function()
	Walking = false
	PaymentActive = false

	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	if Current and DoesEntityExist(Current) then
		SetPedKeepTask(Current,false)
		SetEntityAsMissionEntity(Current,false,false)
		TriggerServerEvent("DeletePed",PedToNet(Current))
		Current = nil
	end

	if Passenger and DoesEntityExist(Passenger) then
		SetPedKeepTask(Passenger,false)
		SetEntityAsMissionEntity(Passenger,false,false)
		TriggerServerEvent("DeletePed",Passenger)
		Passenger = nil
	end

	if Service then
		TriggerEvent("Notify","Central de Empregos","Você acaba finalizar sua jornada de trabalho, esperamos que você tenha aprendido bastante hoje.","default",5000)
		exports["target"]:LabelText("WorkTaxi","Iniciar Expediente")
		SetDriveTaskDrivingStyle(PlayerPedId(),786603)
		Service = false
	else
		TriggerEvent("Notify","Central de Empregos","Você acaba de dar inicio a sua jornada de trabalho, lembrando que a sua vida não se resume só a isso.","default",5000)
		exports["target"]:LabelText("WorkTaxi","Finalizar Expediente")
		SetDriveTaskDrivingStyle(PlayerPedId(),1074528293)
		MarkedPassenger()
		Service = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Service and IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Distance = #(Coords - Locations[Selected]["Vehicle"])
			if Distance <= 100 and not Walking and GetEntityArchetypeName(Vehicle) == "taxi" then
				TimeDistance = 1

				DrawMarker(21,Locations[Selected]["Vehicle"]["x"],Locations[Selected]["Vehicle"]["y"],Locations[Selected]["Vehicle"]["z"],0,0,0,0,180.0,130.0,1.5,1.5,1.0,88,101,242,175,0,0,0,1)

				if IsControlJustPressed(1,38) and Distance <= 2.5 then
					if PaymentActive then
						FreezeEntityPosition(Vehicle,true)

						if DoesEntityExist(Current) then
							vSERVER.Payment(Selected)
							Passenger = PedToNet(Current)
							TaskLeaveVehicle(Current,Vehicle,1)
							TaskWanderStandard(Current,10.0,10)
						end

						FreezeEntityPosition(Vehicle,false)

						PaymentActive = false
						Lasted = Selected

						repeat
							if Lasted == Selected then
								Selected = math.random(#Locations)
							end

							Wait(1)
						until Lasted ~= Selected

						MarkedPassenger()

						SetTimeout(10000,function()
							if Passenger then
								SetPedKeepTask(Passenger,false)
								SetEntityAsMissionEntity(Passenger,false,false)
								TriggerServerEvent("DeletePed",Passenger)
								Passenger = nil
							end
						end)
					else
						CreatePassenger(Vehicle)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPASSENGER
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePassenger(Vehicle)
	if Current and DoesEntityExist(Current) then
		SetPedKeepTask(Current,false)
		SetEntityAsMissionEntity(Current,false,false)
		TriggerServerEvent("DeletePed",PedToNet(Current))
		Current = nil
	end

	if Passenger and DoesEntityExist(Passenger) then
		SetPedKeepTask(Passenger,false)
		SetEntityAsMissionEntity(Passenger,false,false)
		TriggerServerEvent("DeletePed",Passenger)
		Passenger = nil
	end

	local Rand = math.random(#Models)
	local Network = vRPS.CreateModels(Models[Rand],Locations[Selected]["Ped"]["x"],Locations[Selected]["Ped"]["y"],Locations[Selected]["Ped"]["z"])
	if Network then
		Walking = true

		SetTimeout(2500,function()
			Current = LoadNetwork(Network)
			if Current then
				LocalPlayer["state"]:set("BlockLocked",true,false)
				FreezeEntityPosition(Vehicle,true)
				SetVehicleDoorsLocked(Vehicle,1)

				SetTimeout(1000,function()
					SetBlockingOfNonTemporaryEvents(Current,true)
					SetEntityAsMissionEntity(Current,true,true)
					SetModelAsNoLongerNeeded(Models[Rand])
					SetEntityInvincible(Current,true)
					SetPedKeepTask(Current,true)

					while not IsPedSittingInVehicle(Current,Vehicle) do
						if not IsPedWalking(Current) then
							TaskEnterVehicle(Current,Vehicle,-1,2,1.0,8,0)
						end

						Wait(2500)
					end

					LocalPlayer["state"]:set("BlockLocked",false,false)
					FreezeEntityPosition(Vehicle,false)
					Lasted = Selected

					repeat
						if Lasted == Selected then
							Selected = math.random(#Locations)
						end

						Wait(1)
					until Lasted ~= Selected

					Walking = false
					MarkedPassenger()
					PaymentActive = true
				end)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKEDPASSENGER
-----------------------------------------------------------------------------------------------------------------------------------------
function MarkedPassenger()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["Vehicle"]["x"],Locations[Selected]["Vehicle"]["y"],Locations[Selected]["Vehicle"]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Taxista")
	EndTextCommandSetBlipName(Blip)
end