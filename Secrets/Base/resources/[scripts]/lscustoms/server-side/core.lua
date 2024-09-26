-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inVehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:PURCHASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:Purchase")
AddEventHandler("lscustoms:Purchase",function(Mode,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "engines" or Mode == "brakes" or Mode == "transmission" or Mode == "suspension" or Mode == "shield" then
			local Name = vRPC.VehicleName(source)
			local Price = VehiclePrice(Name)

			if Price then
				Payments["engines"] = { 999999, parseInt(Price * 0.05), parseInt(Price * 0.10), parseInt(Price * 0.20), parseInt(Price * 0.30), parseInt(Price * 0.40), parseInt(Price * 0.50) }
				Payments["brakes"] = { 999999, parseInt(Price * 0.05), parseInt(Price * 0.10), parseInt(Price * 0.20), parseInt(Price * 0.30), parseInt(Price * 0.40), parseInt(Price * 0.50) }
				Payments["transmission"] = { 999999, parseInt(Price * 0.05), parseInt(Price * 0.10), parseInt(Price * 0.20), parseInt(Price * 0.30), parseInt(Price * 0.40), parseInt(Price * 0.50) }
				Payments["suspension"] = { 999999, parseInt(Price * 0.05), parseInt(Price * 0.10), parseInt(Price * 0.20), parseInt(Price * 0.30), parseInt(Price * 0.40), parseInt(Price * 0.50) }
				Payments["shield"] = { 999999, parseInt(Price * 0.05), parseInt(Price * 0.10), parseInt(Price * 0.20), parseInt(Price * 0.30), parseInt(Price * 0.40), parseInt(Price * 0.50) }
			end

			if Payments[Mode][Number] == 999999 and inVehicle[Passport] and vRP.Query("vehicles/PlateOwner",{ Passport = Passport, Vehicle = inVehicle[Passport][3], Plate = inVehicle[Passport][2] })[1] then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				if vRP.PaymentFull(Passport,Payments[Mode][Number]) then
					TriggerClientEvent("lscustoms:purchaseSuccessful",source)
				else
					TriggerClientEvent("lscustoms:purchaseFailed",source)
				end
			end
		else
			if vRP.PaymentFull(Passport,Payments[Mode]) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:Vehicle")
AddEventHandler("lscustoms:Vehicle",function(Mods,Plate,Name)
	local Passport = vRP.PassportPlate(Plate)
	if Passport then
		vRP.Query("entitydata/SetData",{ Name = "Mods:"..Passport["Passport"]..":"..Name, Information = json.encode(Mods) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LSCUSTOMS:INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:inVehicle")
AddEventHandler("lscustoms:inVehicle",function(Network,Plate,Model)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Network then
			if inVehicle[Passport] then
				inVehicle[Passport] = nil
			end
		else
			inVehicle[Passport] = { Network,Plate,Model }
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if inVehicle[Passport] then
		SetTimeout(2500,function()
			TriggerEvent("garages:Delete",inVehicle[Passport][1],inVehicle[Passport][2])
			inVehicle[Passport] = nil
		end)
	end
end)