-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("trucker")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Position = 1
local Package = false
local Service = "Vehicles"
local Init = vec4(1239.87,-3257.2,7.09,274.97)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
local Delivery = {
	["Vehicles"] = {
		["Trailer"] = "tr4",
		["Coords"] = {
			vec3(1256.59,-3239.63,5.17),
			vec3(1725.68,4701.59,41.91),
			vec3(2793.5,4346.1,49.23),
			vec3(583.97,-267.48,43.32),
			vec3(712.87,-3198.19,18.89),
			vec3(1256.59,-3239.63,5.17)
		}
	},
	["Diesel"] = {
		["Trailer"] = "armytanker",
		["Coords"] = {
			vec3(1256.59,-3239.63,5.17),
			vec3(1682.1,4923.7,41.45),
			vec3(2793.5,4346.1,49.23),
			vec3(583.97,-267.48,43.32),
			vec3(712.87,-3198.19,18.89),
			vec3(1256.59,-3239.63,5.17)
		}
	},
	["Fuel"] = {
		["Trailer"] = "tanker",
		["Coords"] = {
			vec3(1256.59,-3239.63,5.17),
			vec3(154.75,6612.86,31.27),
			vec3(2793.5,4346.1,49.23),
			vec3(583.97,-267.48,43.32),
			vec3(712.87,-3198.19,18.89),
			vec3(1256.59,-3239.63,5.17)
		}
	},
	["Wood"] = {
		["Trailer"] = "trailerlogs",
		["Coords"] = {
			vec3(1256.59,-3239.63,5.17),
			vec3(-576.72,5329.59,69.61),
			vec3(2793.5,4346.1,49.23),
			vec3(583.97,-267.48,43.32),
			vec3(712.87,-3198.19,18.89),
			vec3(1256.59,-3239.63,5.17)
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("trucker:Vehicles",function()
	if not Package then
		Position = 1
		Package = true
		Service = "Vehicles"
		TriggerEvent("Notify","Central de Empregos","Dirija-se ao caminhão e buzine o mesmo<br>para receber a carga responsável pelo transporte.","default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:DIESEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("trucker:Diesel",function()
	if not Package then
		Position = 1
		Package = true
		Service = "Diesel"
		TriggerEvent("Notify","Central de Empregos","Dirija-se ao caminhão e buzine o mesmo<br>para receber a carga responsável pelo transporte.","default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("trucker:Fuel",function()
	if not Package then
		Position = 1
		Package = true
		Service = "Fuel"
		TriggerEvent("Notify","Central de Empregos","Dirija-se ao caminhão e buzine o mesmo<br>para receber a carga responsável pelo transporte.","default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:WOOD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("trucker:Wood",function()
	if not Package then
		Position = 1
		Package = true
		Service = "Wood"
		TriggerEvent("Notify","Central de Empregos","Dirija-se ao caminhão e buzine o mesmo<br>para receber a carga responsável pelo transporte.","default",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	exports["target"]:AddBoxZone("Trucker",Init["xyz"],0.75,0.75,{
		name = "Trucker",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "trucker:Vehicles",
				label = "Entrega de Veículos",
				tunnel = "client"
			},{
				event = "trucker:Diesel",
				label = "Entrega de Diesel",
				tunnel = "client"
			},{
				event = "trucker:Fuel",
				label = "Entrega de Gasolina",
				tunnel = "client"
			},{
				event = "trucker:Wood",
				label = "Entrega de Madeira",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Package then
			local Vehicle = GetPlayersLastVehicle()
			if IsEntityAVehicle(Vehicle) and GetEntityArchetypeName(Vehicle) == "packer" then
				local Ped = PlayerPedId()
				local Coords = GetEntityCoords(Ped)
				local Distance = #(Coords - Delivery[Service]["Coords"][Position])

				if Distance <= 200 then
					TimeDistance = 1
					DrawMarker(1,Delivery[Service]["Coords"][Position]["x"],Delivery[Service]["Coords"][Position]["y"],Delivery[Service]["Coords"][Position]["z"] - 3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
					DrawMarker(21,Delivery[Service]["Coords"][Position]["x"],Delivery[Service]["Coords"][Position]["y"],Delivery[Service]["Coords"][Position]["z"] + 1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,88,101,242,175,0,0,0,1)

					if Distance <= 10 then
						if Position >= #Delivery[Service]["Coords"] then
							Package = false
							vSERVER.Payment()

							if DoesBlipExist(Blip) then
								RemoveBlip(Blip)
								Blip = nil
							end
						else
							if Position == 1 then
								if IsControlJustPressed(1,38) then
									local Heading = GetEntityHeading(Vehicle)
									local Coords = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-12.0,0.0)
									local Exist,Networked = vGARAGE.ServerVehicle(Delivery[Service]["Trailer"],vec4(Coords["x"],Coords["y"],Coords["z"],Heading),nil,0,nil,1000,0,false)

									if Networked then
										local Network = LoadNetwork(Networked)
										if Network then
											SetVehicleOnGroundProperly(Network)
										end
									end

									Position = Position + 1
									BlipMarked()
								end
							else
								if Position == 2 then
									if not IsPedInAnyVehicle(Ped) and IsControlJustPressed(1,38) then
										local Vehicle,Network,Plate,Model = vRP.VehicleList(10)
										if Vehicle and Model == Delivery[Service]["Trailer"] then
											TriggerEvent("Notify","Aviso","Volte para receber o pagamento.","amarelo",5000)
											TriggerServerEvent("garages:Delete",Network,Plate)
											Position = Position + 1
											BlipMarked()
										end
									end
								else
									Position = Position + 1
									BlipMarked()
								end
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
-- BLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function BlipMarked()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Delivery[Service]["Coords"][Position]["x"],Delivery[Service]["Coords"][Position]["y"],Delivery[Service]["Coords"][Position]["z"])
	SetBlipSprite(Blip,12)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.9)
	SetBlipRoute(Blip,true)
	SetBlipAsShortRange(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Caminhoneiro")
	EndTextCommandSetBlipName(Blip)
end