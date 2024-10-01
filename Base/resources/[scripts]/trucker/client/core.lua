-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("trucker",Hensa)
vSERVER = Tunnel.getInterface("trucker")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Position = 1
local Status = false
local Package = false
local Service = "Vehicles"
local ServiceStatus = "Iniciar"
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
-- TRUCKER:VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Verify")
AddEventHandler("trucker:Verify",function()
	if vSERVER.CheckWork("Trucker") and not vSERVER.CheckDelay() then
		if not Status then
			exports["dynamic"]:AddButton("Iniciar","Clique aqui para <b>Iniciar</b> o serviço.","trucker:Status",false,false,false)
		else
			exports["dynamic"]:AddButton("Finalizar","Clique aqui para <b>Finalizar</b> o serviço.","trucker:Status",false,false,false)

			exports["dynamic"]:SubMenu("Cargas","Clique para mais ações.","trucker")
			exports["dynamic"]:AddButton("Entrega de Veículos","Clique aqui para selecionar esta carga.","trucker:Vehicles",false,"trucker",false)
			exports["dynamic"]:AddButton("Entrega de Diesel","Clique aqui para selecionar esta carga.","trucker:Diesel",false,"trucker",false)
			exports["dynamic"]:AddButton("Entrega de Gasolina","Clique aqui para selecionar esta carga.","trucker:Fuel",false,"trucker",false)
			exports["dynamic"]:AddButton("Entrega de Madeira","Clique aqui para selecionar esta carga.","trucker:Wood",false,"trucker",false)
		end

		exports["dynamic"]:openMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:STATUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Status")
AddEventHandler("trucker:Status",function()
	if not Status then
		Status = true
		ServiceStatus = "Finalizar"
		TriggerEvent("dynamic:Close")
		TriggerEvent("Notify","amarelo","Converse novamente e selecione sua carga.","Atenção",5000)
	else
		Status = false
		Package = false
		ServiceStatus = "Iniciar"
		TriggerEvent("dynamic:Close")
		TriggerEvent("Notify","amarelo","Serviço finalizado.","Atenção",5000)

		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Vehicles")
AddEventHandler("trucker:Vehicles",function()
	if vSERVER.CheckWork("Trucker") and not vSERVER.CheckDelay() then
		if not Package then
			if not Status then
				TriggerEvent("Notify","amarelo","Inicie o serviço antes de escolher uma carga.","Atenção",5000)
			else
				Position = 1
				Package = true
				Service = "Vehicles"
				TriggerEvent("dynamic:Close")
				TriggerEvent("Notify","amarelo","Dirija-se até a Garagem, remova o seu caminhão e buzine o mesmo para receber a carga responsável pelo transporte selecionado.","Atenção",10000)
			end
		else
			TriggerEvent("Notify","azul","Você já possúi uma entrega em andamento.",false,5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:DIESEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Diesel")
AddEventHandler("trucker:Diesel",function()
	if vSERVER.CheckWork("Trucker") and not vSERVER.CheckDelay() then
		if not Package then
			if not Status then
				TriggerEvent("Notify","amarelo","Inicie o serviço antes de escolher uma carga.","Atenção",5000)
			else
				Position = 1
				Package = true
				Service = "Diesel"
				TriggerEvent("dynamic:Close")
				TriggerEvent("Notify","amarelo","Dirija-se até a Garagem, remova o seu caminhão e buzine o mesmo para receber a carga responsável pelo transporte selecionado.","Atenção",10000)
			end
		else
			TriggerEvent("Notify","azul","Você já possúi uma entrega em andamento.",false,5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Fuel")
AddEventHandler("trucker:Fuel",function()
	if vSERVER.CheckWork("Trucker") and not vSERVER.CheckDelay() then
		if not Package then
			if not Status then
				TriggerEvent("Notify","amarelo","Inicie o serviço antes de escolher uma carga.","Atenção",5000)
			else
				Position = 1
				Package = true
				Service = "Fuel"
				TriggerEvent("dynamic:Close")
				TriggerEvent("Notify","amarelo","Dirija-se até a Garagem, remova o seu caminhão e buzine o mesmo para receber a carga responsável pelo transporte selecionado.","Atenção",10000)
			end
		else
			TriggerEvent("Notify","azul","Você já possúi uma entrega em andamento.",false,5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUCKER:WOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trucker:Wood")
AddEventHandler("trucker:Wood",function()
	if vSERVER.CheckWork("Trucker") and not vSERVER.CheckDelay() then
		if not Package then
			if not Status then
				TriggerEvent("Notify","amarelo","Inicie o serviço antes de escolher uma carga.","Atenção",5000)
			else
				Position = 1
				Package = true
				Service = "Wood"
				TriggerEvent("dynamic:Close")
				TriggerEvent("Notify","amarelo","Dirija-se até a Garagem, remova o seu caminhão e buzine o mesmo para receber a carga responsável pelo transporte selecionado.","Atenção",10000)
			end
		else
			TriggerEvent("Notify","azul","Você já possúi uma entrega em andamento.",false,5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	exports["target"]:AddCircleZone("Trucker",vec3(1239.87,-3257.2,7.09),0.5,{
		name = "Trucker",
		heading = 0.0
	},{
		Distance = 1.0,
		options = {
			{
				event = "trucker:Verify",
				label = "Conversar",
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
					DrawMarker(21,Delivery[Service]["Coords"][Position]["x"],Delivery[Service]["Coords"][Position]["y"],Delivery[Service]["Coords"][Position]["z"] + 1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,65,130,226,100,0,0,0,1)

					if Distance <= 10 then
						if Position >= #Delivery[Service]["Coords"] then
							Package = false
							vSERVER.Payment(Service)

							if DoesBlipExist(Blip) then
								RemoveBlip(Blip)
								Blip = nil
							end
						else
							if Position == 1 then
								if IsControlJustPressed(1,38) then
									local Heading = GetEntityHeading(Vehicle)
									local Coords = GetOffsetFromEntityInWorldCoords(Vehicle,0.0,-12.0,0.0)
									local Trailer = vGARAGE.ServerVehicle(Delivery[Service]["Trailer"],Coords["x"],Coords["y"],Coords["z"],Heading,nil,0,nil,1000,0)

									if NetworkDoesNetworkIdExist(Trailer) then
										local Network = NetToEnt(Trailer)
										if NetworkDoesNetworkIdExist(Network) then
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
											TriggerEvent("Notify","amarelo","Volte para receber o pagamento.","Atenção",5000)
											TriggerServerEvent("garages:DeleteVehicle",Network,Plate)
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