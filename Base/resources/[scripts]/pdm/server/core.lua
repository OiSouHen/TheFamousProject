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
Tunnel.bindInterface("pdm", Hensa)
vCLIENT = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local PlateVeh = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Buy(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Name then
		if exports["bank"]:CheckFines(Passport) or exports["bank"]:CheckTaxs(Passport) then
			TriggerClientEvent("Notify",source,"amarelo","Você está temporariamente proibido de utilizar esse sistema por pendências com o <b>Banco</b>.","Atenção",5000)
		else
			Active[Passport] = true

			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Name })
			if Vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>"..VehicleName(Name).."</b>.","Atenção",5000)
			else
				if VehicleMode(Name) == "Rental" then
					local VehiclePrice = VehicleGemstone(Name)
					local Message = "Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>"..Dotted(VehiclePrice).."</b> diamantes?"

					if vRP.Request(source,"Concessionária",Message) then
						if vRP.TakeItem(Passport,"rentalveh",1,true) or vRP.PaymentGems(Passport,VehiclePrice) then
							local Plate = vRP.GeneratePlate()

							TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
							vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = "false" })
							TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","Sucesso",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.","Aviso",5000)
						end
					end
				else
					if VehicleClass(Name) == "Exclusivos" then
						local VehiclePrice = VehicleGemstone(Name)
						if vRP.Request(source,"Concessionária","Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>$"..Dotted(VehiclePrice).."</b> Platinas?") then
							if vRP.TakeItem(Passport,"platinum",VehiclePricel,true) then
								local Plate = vRP.GeneratePlate()

								TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
								vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = "false" })
								TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","Sucesso",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Platinas</b> insuficientes.","Aviso",5000)
							end
						end
					else
						local VehiclePrice = VehiclePrice(Name)
						if vRP.Request(source,"Concessionária","Comprar o veículo <b>"..VehicleName(Name).."</b> por <b>$"..Dotted(VehiclePrice).."</b> dólares?") then
							if vRP.PaymentFull(Passport,VehiclePrice) then
								local Plate = vRP.GeneratePlate()

								TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
								TriggerClientEvent("Notify",source,"verde","Compra concluída.","Sucesso",5000)
								vRP.Query("vehicles/addVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = "false" })
								exports["bank"]:AddTaxs(Passport,source,"Concessionária",VehiclePrice,"Compra do veículo "..VehicleName(Name)..".")
							end
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
local Premium = {
	[0] = 250,
	[1] = 25,
	[2] = 50,
	[3] = 100
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Check()
	local Return = true
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Price = 250
		if vRP.HasPermission(Passport, "Premium") then
			Price = Premium[vRP.GetUserHierarchy(Passport, "Premium")]
		end

		if vRP.Request(Passport, "Concessionária", "Realizar <b>Teste-Drive</b> por <b>$"..Price.."</b> dólares?") then
			if vRP.PaymentFull(Passport,Price) then
				PlateVeh[Passport] = "PDMSPORT"
				TriggerEvent("plateEveryone", PlateVeh[Passport])

				Player(source)["state"]["Route"] = Passport
				SetPlayerRoutingBucket(source, Passport)
			else
				Return = false
			end
		else
			Return = false
		end

		Active[Passport] = nil
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Remove()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("plateReveryone", PlateVeh[Passport])

		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source, 0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if PlateVeh[Passport] then
		PlateVeh[Passport] = nil
	end
end)