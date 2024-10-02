-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("garages", Hensa)
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawn = {}
local Signal = {}
local Searched = {}
local Propertys = {}
local SpawnVehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Plates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Verify(Number)
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport then
		return false
	end

	if BankVerification then
		if exports["bank"]:CheckFines(Passport) or exports["bank"]:CheckTaxs(Passport) then
			TriggerClientEvent("Notify",source,"amarelo","Você está temporariamente proibido de utilizar esse sistema por pendências com o <b>Banco</b>.","Atenção",5000)
			return false
		end
	end

	if Garages[Number]["license"] then
		local driverLicense = vRP.GetDriverLicense(Passport)
		if driverLicense == 0 then
			TriggerClientEvent("Notify", source, "amarelo", "Você não possui <b>Carteira de Habilitação</b>.", "Atenção", 5000)
			return false
		elseif driverLicense == 2 then
			TriggerClientEvent("Notify", source, "amarelo", "Sua <b>Carteira de Habilitação</b> está <b>apreendida</b>.", "Atenção", 5000)
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentStore(Number)
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport then
		return false
	end

	TriggerClientEvent("garages:Close", source)

	if Garages[Number]["payment"] then
		if vRP.HasGroup(Passport, "Emergencia") then
			return true
		else
			local Price = StoreVehiclePrice
			if vRP.HasPermission(Passport, "Premium") then
				Price = Premium[vRP.GetUserHierarchy(Passport, "Premium")]
			end

			if vRP.Request(source, "Garagem", "Guardar um veículo por <b>$"..Price.."</b> dólares?") then
				if vRP.PaymentFull(Passport, Price) then
					return true
				end
			end
		end
	else
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ServerVehicle(Model, x, y, z, Heading, Plate, Nitrox, Doors, Body, Fuel)
	local VehicleSpawned = 0
	local VehicleHash = GetHashKey(Model)
	local Vehicle = CreateVehicle(VehicleHash, x, y, z, Heading, true, true)

	while not DoesEntityExist(Vehicle) and VehicleSpawned <= 10 do
		VehicleSpawned = VehicleSpawned + 1

		Wait(200)
	end

	if not DoesEntityExist(Vehicle) then
		return false
	end

	if not Plate then
		Plate = vRP.GeneratePlate()
	end

	SetVehicleNumberPlateText(Vehicle, Plate)
	SetVehicleBodyHealth(Vehicle, Body + 0.0)

	if Doors then
		local DoorsStatus = json.decode(Doors)
		if DoorsStatus then
			for Number, Status in pairs(DoorsStatus) do
				if Status then
					SetVehicleDoorBroken(Vehicle, parseInt(Number), true)
				end
			end
		end
	end

	local Network = NetworkGetNetworkIdFromEntity(Vehicle)
	local Networked = NetworkGetEntityFromNetworkId(Network)

	if not Fuel then
		Entity(Networked)["state"]:set("Fuel", 100, true)
	end

	if Model ~= "wheelchair" then
		SetVehicleDoorsLocked(Networked, 2)

		local Nitro = GlobalState["Nitro"]
		Nitro[Plate] = Nitrox or 0
		GlobalState:set("Nitro", Nitro, true)
	elseif Model == "taxi" or Model == "pbus" then
		SetVehicleDoorsLocked(Networked, 1)
	end

	return true, Network, Vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("signalRemove", function(Plate)
	if not Signal[Plate] then
		Signal[Plate] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateReveryone", function(Plate)
	if GlobalState["Plates"][Plate] then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = nil
		GlobalState:set("Plates", Plates, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateEveryone", function(Plate)
	local Plates = GlobalState["Plates"]
	Plates[Plate] = true
	GlobalState:set("Plates", Plates, true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("platePlayers", function(Plate, Passport)
	if not vRP.PassportPlate(Plate) then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = Passport
		GlobalState:set("Plates", Plates, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Vehicles(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Garages[Number]["perm"] then
			if not vRP.HasGroup(Passport, Garages[Number]["perm"]) then
				return false
			end
		end

		if string.sub(Number, 1, 9) == "Propertys" then
			local Consult = vRP.Query("propertys/Exist", { name = Number })
			if Consult[1] then
				if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport, "propertys-" .. Consult[1]["Serial"]) then
					if os.time() > Consult[1]["Tax"] then
						TriggerClientEvent("Notify", source, "amarelo", "Aluguel atrasado, procure um <b>Corretor de Imóveis</b>.", "Atenção", 5000)
						return false
					end
				else
					return false
				end
			end
		end

		local Vehicle = {}
		local Garage = Garages[Number]["name"]
		if Works[Garage] then
			for _, v in pairs(Works[Garage]) do
				local VehicleResult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = v })

				if VehicleExist(v) then
					if VehicleResult[1] then
						Vehicle[#Vehicle + 1] = {
							["model"] = v,
							["name"] = VehicleName(v),
							["type"] = VehicleMode(v),
							["engine"] = VehicleResult[1]["Engine"],
							["chassi"] = VehicleResult[1]["Health"],
							["body"] = VehicleResult[1]["Body"],
							["gas"] = VehicleResult[1]["Fuel"],
							["chest"] = Dotted(VehicleWeight(v)),
							["tax"] = Dotted(VehiclePrice(v) * 0.10)
						}
					else
						Vehicle[#Vehicle + 1] = {
							["model"] = v,
							["name"] = VehicleName(v),
							["type"] = VehicleMode(v),
							["engine"] = 1000,
							["chassi"] = 1000,
							["body"] = 1000,
							["gas"] = 100,
							["chest"] = Dotted(VehicleWeight(v)),
							["tax"] = Dotted(VehiclePrice(v) * 0.10)
						}
					end
				end
			end
		else
			local Consult = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
			for _, v in pairs(Consult) do
				if VehicleExist(v["Vehicle"]) then
					if v["Mode"] == "dismantle" and v["Dismantle"] <= os.time() then
						TriggerClientEvent("Progress", source, "Removendo veículo", 10000)
						vRP.Query("vehicles/removeVehicles", { Passport = Passport, Vehicle = v["Vehicle"] })
						TriggerClientEvent("Notify", source, "azul", "Estamos recuperando o veículo <b>" .. VehicleName(v["Vehicle"]) .. "</b>, espere um pouco para abrir a garagem.", "Jimmy Jango", 10000)
						return false
					end

					if v["Work"] == "false" then
						Vehicle[#Vehicle + 1] = {
							["model"] = v["Vehicle"],
							["name"] = VehicleName(v["Vehicle"]),
							["type"] = VehicleMode(v["Vehicle"]),
							["engine"] = v["Engine"],
							["chassi"] = v["Health"],
							["body"] = v["Body"],
							["gas"] = v["Fuel"],
							["chest"] = Dotted(VehicleWeight(v["Vehicle"])),
							["tax"] = Dotted(VehiclePrice(v["Vehicle"]) * 0.10)
						}
					end
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicles = {}
		local Vehicle = vRP.Query("vehicles/UserVehicles", { Passport = Passport })

		for Number,v in ipairs(Vehicle) do
			if v["Arrest"] >= os.time() then
				Vehicles[#Vehicles + 1] = {
					["Model"] = Vehicle[Number]["Vehicle"],
					["Name"] = VehicleName(Vehicle[Number]["Vehicle"])
				}
			end
		end

		return Vehicles
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound", function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local VehiclePrice = VehiclePrice(Name) * PercentageArrest
		TriggerClientEvent("dynamic:Close", source)

		if vRP.Request(source, "Garagem", "A liberação do veículo tem o custo de <b>$" .. Dotted(VehiclePrice) .. "</b> dólares, deseja prosseguir com a liberação do mesmo?") then
			if vRP.PaymentFull(Passport, VehiclePrice) then
				vRP.Query("vehicles/paymentArrest", { Passport = Passport, Vehicle = Name })
				TriggerClientEvent("Notify", source, "verde", "Veículo liberado.", "Sucesso", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
local Premium = {
	[0] = 0.10,
	[1] = 0.07,
	[2] = 0.05,
	[3] = 0.03
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAX
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Tax(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
		if Consult[1] then
			if Consult[1]["Tax"] <= os.time() then
				local Price = VehiclePrice(Name) * 0.10
				if vRP.HasPermission(Passport, "Premium") then
					Price = VehiclePrice(Name) * Premium[vRP.GetUserHierarchy(Passport, "Premium")]
				end

				if vRP.Request(source, "Garagem", "As taxas do veículo estão em <b>$" .. Dotted(Price) .. " dólares, deseja prosseguir com a liberação do mesmo?") then
					if vRP.PaymentFull(Passport, Price) then
						vRP.Query("vehicles/updateVehiclesTax", { Passport = Passport, Vehicle = Name })
						TriggerClientEvent("Notify", source, "verde", "Pagamento concluído.", "Sucesso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "O veículo ainda não venceu.", "Atenção", 5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Sell(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == "rental" or Mode == "work" then
			return
		end

		local Consult = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
		if Consult[1] then
			if Consult[1]["Mode"] == "dismantle" then
				TriggerClientEvent("Notify", source, "amarelo", "Jimmy Jango contratou você para o resgate, você não pode vender o veículo dele.", "Atenção", 5000)
				return
			end

			local Price = VehiclePrice(Name) * PercetageSelling
			if vRP.Request(source, "Garagem", "Vender o veículo <b>" .. VehicleName(Name) .. "</b> por <b>$" .. Dotted(Price) .. "</b>?") then
				local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Name })
				if Consult[1] then
					vRP.GiveBank(Passport, Price)
					vRP.Query("vehicles/removeVehicles",{ Passport = Passport, Vehicle = Name })
					vRP.Query("entitydata/RemoveData",{ Name = "Mods:"..Passport..":"..Name })
					vRP.Query("entitydata/RemoveData",{ Name = "Chest:"..Passport..":"..Name })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Transfer(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == "work" then
			return
		end

		local MyVehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
		if MyVehicle[1] then
			if MyVehicle[1]["Mode"] == "dismantle" then
				TriggerClientEvent("Notify", source, "amarelo", "Jimmy Jango contratou você para o resgate, você não pode transferir o veículo dele.", "Atenção", 5000)
				return
			end

			local Keyboard = vKEYBOARD.Primary(source, "Passaporte:")
			if Keyboard then
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity and OtherPassport then
					if OtherPassport == Passport then
						TriggerClientEvent("Notify", source, "vermelho", "Você não pode transferir para você mesmo.", "Aviso", 5000)
					else
						if vRP.Request(source, "Garagem", "Transferir o veículo <b>" .. VehicleName(Name) .. "</b> para <b>" .. Identity["Name"] .. " " .. Identity["Lastname"] .. "</b>?") then
							local Vehicle = vRP.Query("vehicles/selectVehicles", { Passport = parseInt(OtherPassport), Vehicle = Name })
							if Vehicle[1] then
								TriggerClientEvent("Notify", source, "amarelo", "<b>" .. Identity["Name"] .. " " .. Identity["Lastname"] .. "</b> já possui este modelo de veículo.", "Atenção", 5000)
							else
								vRP.Query("vehicles/moveVehicles", { Passport = Passport, OtherPassport = parseInt(OtherPassport), Vehicle = Name })

								local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..Passport..":"..Name })
								if parseInt(#Datatable) > 0 then
									vRP.Query("entitydata/SetData",{ Name = "Mods:" .. OtherPassport .. ":" .. Name, Information = Datatable[1]["Information"] })
									vRP.Query("entitydata/RemoveData",{ Name = "Mods:" .. Passport .. ":" .. Name })
								end

								local Datatable = vRP.GetServerData("Chest:" .. Passport .. ":" .. Name)
								vRP.SetServerData("Chest:" .. OtherPassport .. ":" .. Name, Datatable)
								vRP.RemoveServerData("Chest:" .. Passport .. ":" .. Name)

								TriggerClientEvent("Notify", source, "verde", "Transferência concluída.", "Sucesso", 5000)
							end
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Spawn(Name, Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if SpawnVehicle[Number] then
			if os.time() >= SpawnVehicle[Number] then
				SpawnVehicle[Number] = os.time() + 5
			else
				TriggerClientEvent("garages:Close", source)

				local Cooldown = MinimalTimers(SpawnVehicle[Number] - os.time())
				TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. Cooldown .. "</b>.", false, 5000)
				return
			end
		else
			SpawnVehicle[Number] = os.time() + 5
		end

		local Gemstone = VehicleGemstone(Name)
		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })

		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				TriggerClientEvent("garages:Close", source)

				if vRP.Request(source, "Garagem", "Alugar o veículo <b>" .. VehicleName(Name) .. "</b> por <b>" .. Gemstone .. "</b> "..ItemName(DefaultSpecialMoney).."?") then
					if vRP.PaymentGems(Passport, Gemstone) then
						vRP.Query("vehicles/rentalVehicles", { Passport = Passport, Vehicle = Name, Plate = vRP.GeneratePlate(), Work = "true" })
						TriggerClientEvent("Notify", source, "verde", "Aluguel do veículo <b>" .. VehicleName(Name) .. "</b> concluído.", "Sucesso", 5000)
						vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
					else
						TriggerClientEvent("Notify", source, "vermelho", "<b>"..ItemName(DefaultSpecialMoney).."</b> insuficientes.", "Aviso", 5000)
						return
					end
				else
					return
				end
			else
				TriggerClientEvent("garages:Close", source)

				local VehiclePrice = VehiclePrice(Name)
				if parseInt(VehiclePrice) > 0 then
					if vRP.Request(source, "Garagem", "Comprar <b>" .. VehicleName(Name) .. "</b> por <b>$" .. Dotted(VehiclePrice) .. "</b> dólares?") then
						if vRP.PaymentFull(Passport, VehiclePrice) then
							vRP.Query("vehicles/addVehicles", { Passport = Passport, Vehicle = Name, Plate = vRP.GeneratePlate(), Work = "true" })
							vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
						end
					else
						return
					end
				else
					vRP.Query("vehicles/addVehicles", { Passport = Passport, Vehicle = Name, Plate = vRP.GeneratePlate(), Work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Name })
				end
			end
		end

		if vehicle[1] then
			local Plates = GlobalState["Plates"]
			local Plate = vehicle[1]["Plate"]

			if Spawn[Plate] then
				if not Signal[Plate] then
					if not Searched[Passport] then
						Searched[Passport] = os.time()
					end

					if os.time() >= parseInt(Searched[Passport]) then
						Searched[Passport] = os.time() + 60

						local Network = Spawn[Plate][3]
						local Network = NetworkGetEntityFromNetworkId(Network)
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							vCLIENT.SearchBlip(source, GetEntityCoords(Network))
							TriggerClientEvent("Notify", source, "default", "Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.", false, 10000)
						else
							if Spawn[Plate] then
								Spawn[Plate] = nil
							end

							if Plates[Plate] then
								Plates[Plate] = nil
								GlobalState:set("Plates", Plates, true)
							end

							TriggerClientEvent("Notify", source, "verde", "A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.", "Sucesso", 5000)
						end
					else
						TriggerClientEvent("Notify", source, "azul", "Rastreador só pode ser ativado a cada <b>60</b> segundos.", "Observação", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "Rastreador está desativado.", "Atenção", 5000)
				end
			else
				if vehicle[1]["Tax"] <= os.time() then
					TriggerClientEvent("Notify", source, "amarelo", "Taxa do veículo atrasada.", "Atenção", 5000)
					TriggerClientEvent("garages:Close", source)
				elseif vehicle[1]["Arrest"] >= os.time() then
					TriggerClientEvent("Notify", source, "amarelo", "Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.", "Atenção", 10000)
					TriggerClientEvent("garages:Close", source)
				else
					if vehicle[1]["Rental"] ~= 0 then
						if vehicle[1]["Rental"] <= os.time() then
							TriggerClientEvent("garages:Close", source)

							if vRP.Request(source, "Garagem", "Atualizar o aluguel do veículo <b>" .. VehicleName(Name) .. "</b> por <b>" .. Dotted( Gemstone ) .. " "..ItemName(DefaultSpecialMoney).."</b>?") then
								if vRP.PaymentGems(Passport, Gemstone) then
									vRP.Query("vehicles/rentalVehiclesUpdate", { Passport = Passport, Vehicle = Name })
									TriggerClientEvent("Notify", source, "verde", "Aluguel do veículo <b>" .. VehicleName(Name) .. "</b> atualizado.", "Sucesso", 5000)
								else
									TriggerClientEvent("Notify", source, "vermelho", "<b>"..ItemName(DefaultSpecialMoney).."</b> insuficientes.", "Aviso", 5000)
									return
								end
							else
								return
							end
						end
					end

					local Coords = vCLIENT.SpawnPosition(source, Number)
					if Coords then
						local Mods = nil
						local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..Passport..":"..Name })
						if parseInt(#Datatable) > 0 then
							Mods = Datatable[1]["Information"]
						end

						if Garages[Number]["payment"] then
							if vRP.UserPremium(Passport) then
								TriggerClientEvent("garages:Close", source)

								local Exist, Network = Hensa.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["Nitro"], vehicle[1]["Doors"], vehicle[1]["Body"])

								if Exist then
									local Networked = NetworkGetEntityFromNetworkId(Network)

									vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["Engine"], vehicle[1]["Health"], Mods, vehicle[1]["Windows"], vehicle[1]["Tyres"], vehicle[1]["Brakes"])
									TriggerClientEvent("Notify", source, "azul", CompleteTimers(vehicle[1]["Tax"] - os.time()), "Próximo pagamento", 5000)
									Entity(Networked)["state"]:set("Fuel", vehicle[1]["Fuel"], true)
									TriggerEvent("engine:InsertBrakes", Network, vehicle[1]["Brakes"])
									Spawn[Plate] = { Passport, Name, Network }

									Plates[Plate] = Passport
									GlobalState:set("Plates", Plates, true)

									if vehicle[1]["Drift"] then
										Entity(Networked)["state"]:set("Drift", true, true)
									end
								end
							else
								if vehicle[1]["Mode"] == "dismantle" then
									TriggerClientEvent("garages:Close", source)

									local Exist, Network = Hensa.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["Nitro"], vehicle[1]["Doors"], vehicle[1]["Body"])

									if Exist then
										local Networked = NetworkGetEntityFromNetworkId(Network)

										vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["Engine"], vehicle[1]["Health"], Mods, vehicle[1]["Windows"], vehicle[1]["Tyres"], vehicle[1]["Brakes"])
										TriggerClientEvent("Notify", source, "azul", CompleteTimers(vehicle[1]["Dismantle"] - os.time()), "Vencimento", 5000)
										Entity(Networked)["state"]:set("Fuel", vehicle[1]["Fuel"], true)
										TriggerEvent("engine:InsertBrakes", Network, vehicle[1]["Brakes"])
										Spawn[Plate] = { Passport, Name, Network }

										Plates[Plate] = Passport
										GlobalState:set("Plates", Plates, true)
										Entity(Networked)["state"]:set("Lockpick", true, true)

										if vehicle[1]["Drift"] then
											Entity(Networked)["state"]:set("Drift", true, true)
										end
									end
								elseif vehicle[1]["Mode"] == "normal" then
									TriggerClientEvent("garages:Close", source)

									local VehiclePrice = VehiclePrice(Name)
									if vRP.HasGroup(Passport, "Premium") then
										TriggerClientEvent("dynamic:Close", source)
										local Exist, Network = Hensa.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["Nitro"], vehicle[1]["Doors"], vehicle[1]["Body"])

										if Exist then
											local Networked = NetworkGetEntityFromNetworkId(Network)

											vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["Engine"], vehicle[1]["Health"], Mods, vehicle[1]["Windows"], vehicle[1]["Tyres"], vehicle[1]["Brakes"])
											TriggerClientEvent("Notify", source, "azul", CompleteTimers(vehicle[1]["Tax"] - os.time()), "Próximo pagamento", 5000)
											Entity(Networked)["state"]:set("Fuel", vehicle[1]["Fuel"], true)
											TriggerEvent("engine:InsertBrakes", Network, vehicle[1]["Brakes"])
											Spawn[Plate] = { Passport, Name, Network }

											Plates[Plate] = Passport
											GlobalState:set("Plates", Plates, true)

											if vehicle[1]["Drift"] then
												Entity(Networked)["state"]:set("Drift", true, true)
											end
										end
									else
										if vRP.Request(source, "Garagem", "Retirar o veículo por <b>$" .. Dotted(VehiclePrice * 0.05) .. "</b> dólares?") then
											if vRP.PaymentFull(Passport, VehiclePrice * 0.05) then
												TriggerClientEvent("dynamic:Close", source)
												local Exist, Network = Hensa.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["Nitro"], vehicle[1] ["Doors"], vehicle[1]["Body"])

												if Exist then
													local Networked = NetworkGetEntityFromNetworkId(Network)

													vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["Engine"], vehicle[1]["Health"], Mods, vehicle[1]["Windows"], vehicle[1]["Tyres"], vehicle[1]["Brakes"])
													TriggerClientEvent("Notify", source, "azul", CompleteTimers(vehicle[1]["Tax"] - os.time()), "Próximo pagamento", 5000)
													Entity(Networked)["state"]:set("Fuel", vehicle[1]["Fuel"], true)
													TriggerEvent("engine:InsertBrakes", Network, vehicle[1]["Brakes"])
													Spawn[Plate] = { Passport, Name, Network }

													Plates[Plate] = Passport
													GlobalState:set("Plates", Plates, true)

													if vehicle[1]["Drift"] then
														Entity(Networked)["state"]:set("Drift", true, true)
													end
												end
											end
										end
									end
								end
							end
						else
							TriggerClientEvent("dynamic:Close", source)
							local Exist, Network = Hensa.ServerVehicle(Name, Coords[1], Coords[2], Coords[3], Coords[4], Plate, vehicle[1]["Nitro"], vehicle[1]["Doors"], vehicle[1]["Body"])

							if Exist then
								local Networked = NetworkGetEntityFromNetworkId(Network)

								vCLIENT.CreateVehicle(-1, Name, Network, vehicle[1]["Engine"], vehicle[1]["Health"], Mods, vehicle[1]["Windows"], vehicle[1]["Tyres"], vehicle[1]["Brakes"])
								TriggerClientEvent("Notify", source, "azul", CompleteTimers(vehicle[1]["Tax"] - os.time()), "Próximo pagamento", 5000)
								Entity(Networked)["state"]:set("Fuel", vehicle[1]["Fuel"], true)
								TriggerEvent("engine:InsertBrakes", Network, vehicle[1]["Brakes"])
								Spawn[Plate] = { Passport, Name, Network }

								Plates[Plate] = Passport
								GlobalState:set("Plates", Plates, true)

								if vehicle[1]["Drift"] then
									Entity(Networked)["state"]:set("Drift", true, true)
								end
							end
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin") and Message[1] then
			local VehicleName = Message[1]
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			local Plate = "VEH"..(math.random(10000,90000) + Passport)

			local Exist, Network, Vehicle = Hensa.ServerVehicle(VehicleName, Coords["x"], Coords["y"], Coords["z"], Heading, Plate, 2000, nil, 1000)
			if not Exist then
				return
			end

			local Networked = NetworkGetEntityFromNetworkId(Network)

			vCLIENT.CreateVehicle(-1, VehicleName, Network, 1000, 1000, nil, false, false, { 1.25, 0.75, 0.95 })
			Spawn[Plate] = { Passport, VehicleName, Network }
			TriggerEvent("engine:InsertBrakes", Network, "")
			Entity(Networked)["state"]:set("Fuel", 100, true)
			SetPedIntoVehicle(Ped, Vehicle, -1)

			local Plates = GlobalState["Plates"]
			Plates[Plate] = Passport
			GlobalState:set("Plates", Plates, true)

			Entity(Networked)["state"]:set("Drift", true, true)

			if Logs then
				exports["vrp"]:Embed("Garages","**Passaporte:** "..Passport.."\n**Spawnou:** "..VehicleName.."\n**Coords:** "..Coords,3042892)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv", function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport, "Admin", 2) then
		TriggerClientEvent("garages:Delete", source)

		if Logs then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)

			exports["vrp"]:Embed("Garages","**Passaporte:** "..Passport.."\n**Deletou:** "..VehicleName.."\n**Coords:** "..Coords,3042892)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Key")
AddEventHandler("garages:Key", function(entity)
	local source = source
	local Plate = entity[1]
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Plates"][Plate] == Passport then
		vRP.GenerateItem(Passport, "vehkey-" .. Plate, 1, true, false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Lock")
AddEventHandler("garages:Lock", function(Network, Plate, Model)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Plates"][Plate] == Passport then
		if Player(source)["state"]["Taxi"] then
			if Model == "taxi" then
				TriggerEvent("garages:OnlyUnlockVehicle", source, Network)
				TriggerClientEvent("Notify", source, "amarelo", "Para a segurança de todos, durante o serviço de <b>Taxista</b> o veículo não pode ser trancado.", "Atenção", 5000)
			else
				TriggerEvent("garages:LockVehicle", source, Network)
			end
		elseif Player(source)["state"]["Corrections"] then
			if Model == "pbus" then
				TriggerEvent("garages:OnlyUnlockVehicle", source, Network)
				TriggerClientEvent("Notify", source, "amarelo", "Para a segurança de todos, durante o serviço de <b>Transporte de Prisioneiro</b> o veículo não pode ser trancado.", "Atenção", 5000)
			else
				TriggerEvent("garages:LockVehicle", source, Network)
			end
		else
			TriggerEvent("garages:LockVehicle", source, Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:LockVehicle", function(source, Network)
	local Network = NetworkGetEntityFromNetworkId(Network)
	local Doors = GetVehicleDoorLockStatus(Network)

	if parseInt(Doors) <= 1 then
		TriggerClientEvent("Notify", source, "verde", "O veículo foi <b>trancado</b>.", "Sucesso", 5000)
		TriggerClientEvent("sounds:Private", source, "locked", 0.7)
		SetVehicleDoorsLocked(Network, 2)
	else
		TriggerClientEvent("Notify", source, "amarelo", "O veículo foi <b>destrancado</b>.", "Atenção", 5000)
		TriggerClientEvent("sounds:Private", source, "unlocked", 0.7)
		SetVehicleDoorsLocked(Network, 1)
	end

	if not vRPC.InsideVehicle(source) then
		vRPC.PlayAnim(source, true, { "anim@mp_player_intmenu@key_fob@", "fob_click" }, false)
		Wait(350)
		vRPC.StopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:ONLYUNLOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:OnlyUnlockVehicle", function(source, Network)
	local Network = NetworkGetEntityFromNetworkId(Network)
	SetVehicleDoorsLocked(Network, 1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Delete(Network, Health, Engine, Body, Fuel, Doors, Windows, Tyres, Plate, Brake)
	if Spawn[Plate] then
		local Passport = Spawn[Plate][1]
		local Vehicle = Spawn[Plate][2]

		if parseInt(Engine) <= 100 then
			Engine = 100
		end

		if parseInt(Body) <= 100 then
			Body = 100
		end

		if parseInt(Fuel) >= 100 then
			Fuel = 100
		end

		if parseInt(Fuel) <= 0 then
			Fuel = 0
		end

		local vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Vehicle })
		if vehicle[1] ~= nil then
			vRP.Query("vehicles/updateVehicles",
				{
					Passport = Passport,
					Vehicle = Vehicle,
					Nitro = GlobalState["Nitro"][Plate] or 0,
					Engine = parseInt(Engine),
					Body = parseInt(Body),
					Health = parseInt(Health),
					Fuel = parseInt(Fuel),
					Doors = json.encode(Doors),
					Windows = json.encode(Windows),
					Tyres = json.encode(Tyres),
					Brakes = json.encode(Brake)
				})
		end
	end

	TriggerEvent("garages:DeleteVehicle", Network, Plate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:DeleteVehicle")
AddEventHandler("garages:DeleteVehicle", function(Network, Plate)
	if Network ~= nil and Plate ~= nil then
		if GlobalState["Plates"][Plate] then
			local Plates = GlobalState["Plates"]
			Plates[Plate] = nil
			GlobalState:set("Plates", Plates, true)
		end

		if GlobalState["Nitro"][Plate] then
			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = nil
			GlobalState:set("Nitro", Nitro, true)
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		if string.sub(Plate, 1, 4) == "DISM" then
			local Passport = parseInt(string.sub(Plate, 5, 8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				if Player(source)["state"]["Dismantle"] then
					local Vehicle = vRP.Query("vehicles/selectVehicles", { Passport = Passport, Vehicle = Player(source)["state"]["DismantleModel"] })
					if Vehicle[1] then
						TriggerClientEvent("Notify", source, "amarelo", "Este veículo não foi adicionado em sua garagem pois você já possui um <b>" .. VehicleName(Player(source)["state"]["DismantleModel"]) .. "</b>.", "Jimmy Jango", 10000)
					else
						TriggerClientEvent("Notify", source, "azul", "Você escondeu o veículo <b>" .. VehicleName(Player(source)["state"]["DismantleModel"]) .. "</b> em sua garagem, o mesmo pode ser usado durante um período de <b>24 Horas</b>.", "Jimmy Jango", 10000)
						vRP.Query("vehicles/dismantleVehicles", { Passport = Passport, Vehicle = Player(source)["state"]["DismantleModel"], Plate = vRP.GeneratePlate(), Work = "false" })
					end
				end

				TriggerClientEvent("target:DismantleReset", source)
			end
		end

		local Network = NetworkGetEntityFromNetworkId(Network)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DISMANTLEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:dismantleVehicle")
AddEventHandler("garages:dismantleVehicle", function(Network, Plate)
	if Network ~= nil and Plate ~= nil then
		if GlobalState["Plates"][Plate] then
			local Plates = GlobalState["Plates"]
			Plates[Plate] = nil
			GlobalState:set("Plates", Plates, true)
		end

		if GlobalState["Nitro"][Plate] then
			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = nil
			GlobalState:set("Nitro", Nitro, true)
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		if string.sub(Plate, 1, 4) == "DISM" then
			local Passport = parseInt(string.sub(Plate, 5, 8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				TriggerClientEvent("target:DismantleReset", source)
				TriggerClientEvent("Notify", source, "verde", "O seu serviço foi finalizado com sucesso, e você pode assinar um novo contrato quando quiser.", "Jimmy Jango", 10000)
			end
		end

		local Network = NetworkGetEntityFromNetworkId(Network)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys", function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:Close", source)
		TriggerClientEvent("Notify", source, "amarelo", "Selecione o local da garagem.", "Atenção", 5000)

		local Hash = "prop_offroad_tyres02"
		local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
		if Application then
			if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
				TriggerClientEvent("Notify", source, "amarelo", "Selecione o local do veículo.", "Atenção", 5000)

				local Open = Coords
				local Hash = "patriot"
				local Application, Coords, Heading = vRPC.ObjectControlling(source, Hash)
				if Application then
					if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
						local New = {
							["1"] = { mathLength(Open["x"]), mathLength(Open["y"]), mathLength(Open["z"] + 1) },
							["2"] = { mathLength(Coords["x"]), mathLength(Coords["y"]), mathLength(Coords["z"] + 1), mathLength(Heading) }
						}

						Garages[Name] = { name = "Garage", payment = false, license = false }

						Propertys[Name] = {
							["x"] = New["1"][1],
							["y"] = New["1"][2],
							["z"] = New["1"][3],
							["1"] = New["2"]
						}

						vRP.Query("propertys/Garage", { Name = Name, Garage = json.encode(New) })
						TriggerClientEvent("garages:Propertys", -1, Propertys)
					else
						TriggerClientEvent("Notify", source, "vermelho", "A garagem precisa ser próximo da entrada.", "Aviso", 5000)
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "A garagem precisa ser próximo da entrada.", "Aviso", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("propertys/Garages")
	for _,v in pairs(Consult) do
		local Name = v["Name"]
		if not Propertys[Name] and v["Garage"] ~= "{}" then
			local Table = json.decode(v["Garage"])
			Garages[Name] = { name = "Garage", payment = false, license = false }

			Propertys[Name] = {
				["x"] = Table["1"][1],
				["y"] = Table["1"][2],
				["z"] = Table["1"][3],
				["1"] = Table["2"]
			}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNED
-----------------------------------------------------------------------------------------------------------------------------------------
function Spawned(plate)
	if Spawn[plate] then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSPAWNED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("VehSpawned", Spawned)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function SpawnVeh(data, network)
	local Mods = nil
	local Datatable = vRP.Query("entitydata/GetData",{ Name = "Mods:"..data["passport"]..":"..data["model"] })
	if parseInt(#Datatable) > 0 then
		Mods = Datatable[1]["Information"]
	end

	vCLIENT.CreateVehicle(-1, data["model"], network, data["engine"], data["health"], Mods, data["windows"], data["tyres"], data["brakes"])
	TriggerEvent("engine:tryFuel", data["plate"], data["fuel"])
	TriggerEvent("engine:insertBrakes", network, data["brakes"])
	Spawn[data["plate"]] = { data["passport"], data["model"], network }

	local Plates = GlobalState["Plates"]
	Plates[data["plate"]] = data["passport"]

	GlobalState:set("Plates", Plates, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SpawnVeh", SpawnVeh)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Signal", function(Plate)
	return Signal[Plate]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("garages:Propertys", source, Propertys)
end)