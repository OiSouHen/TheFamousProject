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
Tunnel.bindInterface("pdm",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Name then
		Active[Passport] = true

		local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Name })
		if Vehicle[1] then
			TriggerClientEvent("Notify",source,"Aviso","Já possui um <b>"..VehicleName(Name).."</b>.","amarelo",5000)
		else
			if VehicleStock(Name) and vRP.Scalar("vehicles/Count",{ Vehicle = Name }) >= VehicleStock(Name) then
				TriggerClientEvent("Notify",source,"Aviso","Estoque insuficiente.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if VehicleMode(Name) == "Rental" then
				local VehiclePrice = VehicleGemstone(Name)
				if vRP.PaymentGems(Passport,VehiclePrice) then
					local Plate = vRP.GeneratePlate()

					Active[Passport] = nil
					TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","verde",5000)
					vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Weight = VehicleWeight(Name), Work = 0 })

					return true
				else
					TriggerClientEvent("Notify",source,"Aviso","Diamante insuficiente.","amarelo",5000)
				end
			else
				if VehicleClass(Name) == "Exclusivos" then
					local VehiclePrice = VehicleGemstone(Name)
					if vRP.TakeItem(Passport,"platinum",VehiclePrice) then
						local Plate = vRP.GeneratePlate()

						Active[Passport] = nil
						TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","verde",5000)
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Weight = VehicleWeight(Name), Work = 0 })

						return true
					else
						TriggerClientEvent("Notify",source,"Aviso","Platina insuficiente.","amarelo",5000)
					end
				else
					if not exports["bank"]:CheckFines(Passport) then
						local VehiclePrice = VehiclePrice(Name)
						if vRP.PaymentFull(Passport,VehiclePrice) then
							local Plate = vRP.GeneratePlate()

							Active[Passport] = nil
							TriggerClientEvent("Notify",source,"Sucesso","Compra concluída.","verde",5000)
							exports["bank"]:AddTaxs(Passport,source,"Concessionária",VehiclePrice,"Compra do veículo "..VehicleName(Name)..".")
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Weight = VehicleWeight(Name), Work = 0 })

							return true
						else
							TriggerClientEvent("Notify",source,"Aviso","Dinheiro insuficiente.","amarelo",5000)
						end
					else
						TriggerClientEvent("Notify",source,"Aviso","Você possui débitos bancários.","amarelo",5000)
					end
				end
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Check()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("DebugWeapons",Passport,source)
		exports["vrp"]:Bucket(source,"Enter",100000 + Passport)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Discount()
	return { 1.0,1.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Remove()
	local source = source

	exports["vrp"]:Bucket(source,"Exit")
	TriggerEvent("vRP:ReloadWeapons",source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)