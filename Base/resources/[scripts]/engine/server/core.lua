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
Tunnel.bindInterface("engine", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Brakes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.RechargeFuel(Price)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.PaymentFull(Passport,Price) then
		exports["bank"]:AddTaxs(Passport,source,"Posto de Gasolina",Price,"Gastos com combustível.")

		return false
	else
		TriggerClientEvent("Notify",source,"Aviso","<b>"..ItemName(DefaultMoneyOne).."</b> insuficientes.","amarelo",5000)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.VehicleBrakes(Vehicle)
	if Brakes[Vehicle] == nil then
		Brakes[Vehicle] = { 0.55, 0.35, 0.45 }
	end

	return Brakes[Vehicle]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:TryBrakes")
AddEventHandler("engine:TryBrakes",function(Vehicle,Status,PlayerAround)
	Brakes[Vehicle] = Status

	if PlayerAround then
		for _,v in ipairs(PlayerAround) do
			async(function()
				TriggerClientEvent("engine:SyncBrakes",v,Vehicle,Status)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:InsertBrakes")
AddEventHandler("engine:InsertBrakes",function(Vehicle,Brake)
	if Brake == "" then
		Brakes[Vehicle] = { 0.90, 0.55, 0.75 }
	else
		Brakes[Vehicle] = json.decode(Brake)

		if Brakes[Vehicle][1] > 0.90 then
			Brakes[Vehicle][1] = 0.90
		end

		if Brakes[Vehicle][2] > 0.55 then
			Brakes[Vehicle][2] = 0.55
		end

		if Brakes[Vehicle][3] > 0.75 then
			Brakes[Vehicle][3] = 0.75
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYBRAKES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:ApplyBrakes")
AddEventHandler("engine:ApplyBrakes",function(Item,Vehicle,Brake,PlayerAround)
	if Brakes[Vehicle] then
		if Item == "graphite01" then
			Brakes[Vehicle][1] = Brakes[Vehicle][1] + (Brake * 0.0090) + 0.0
		elseif Item == "graphite02" then
			Brakes[Vehicle][2] = Brakes[Vehicle][2] + (Brake * 0.0055) + 0.0
		elseif Item == "graphite03" then
			Brakes[Vehicle][3] = Brakes[Vehicle][3] + (Brake * 0.0075) + 0.0
		end

		if Brakes[Vehicle][1] >= 0.90 then
			Brakes[Vehicle][1] = 0.90
		end

		if Brakes[Vehicle][2] >= 0.55 then
			Brakes[Vehicle][2] = 0.55
		end

		if Brakes[Vehicle][3] >= 0.75 then
			Brakes[Vehicle][3] = 0.75
		end

		for _,v in ipairs(PlayerAround) do
			async(function()
				TriggerClientEvent("engine:SyncBrakes",v,Vehicle,Brakes[Vehicle])
			end)
		end
	end
end)