-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("towed",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Service = {}
local Vehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {
	{ ["Item"] = "plastic", ["Chance"] = 75, ["Min"] = 25, ["Max"] = 45, ["Addition"] = 0.050 },
	{ ["Item"] = "glass", ["Chance"] = 75, ["Min"] = 25, ["Max"] = 45, ["Addition"] = 0.050 },
	{ ["Item"] = "rubber", ["Chance"] = 75, ["Min"] = 25, ["Max"] = 45, ["Addition"] = 0.050 },
	{ ["Item"] = "aluminum", ["Chance"] = 25, ["Min"] = 15, ["Max"] = 25, ["Addition"] = 0.025 },
	{ ["Item"] = "copper", ["Chance"] = 25, ["Min"] = 15, ["Max"] = 25, ["Addition"] = 0.025 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Service()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Service[Passport] = (not Service[Passport] and source or nil)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicle(Model,Destiny)
	local source = source
	local Vehicle = CreateVehicle(Model,Locations[Destiny],true,true)

	while not DoesEntityExist(Vehicle) do
		Wait(1)
	end

	if DoesEntityExist(Vehicle) then
		local Plate = vRP.GeneratePlate()
		local Network = NetworkGetNetworkIdFromEntity(Vehicle)

		SetVehicleBodyHealth(Vehicle,10.0)
		SetVehicleNumberPlateText(Vehicle,Plate)
		SetEntityIgnoreRequestControlFilter(Vehicle,true)

		Entity(Vehicle)["state"]:set("Fuel",0,true)
		Entity(Vehicle)["state"]:set("Nitro",0,true)

		Vehicles[Plate] = {
			["Source"] = source,
			["Network"] = Network,
			["Impound"] = false
		}

		return Network,Plate
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Network,Plate)
	if Network and Plate and Vehicles[Plate] then
		if not Vehicles[Plate]["Impound"] and vRP.Passport(Vehicles[Plate]["Source"]) then
			TriggerClientEvent("towed:Inative",Vehicles[Plate]["Source"],Plate)
		end

		Vehicles[Plate] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towed:Payment")
AddEventHandler("towed:Payment",function(Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Vehicles[Plate] then
		Active[Passport] = true

		local GainExperience = 2
		local Result = RandPercentage(Drops)
		local Experience,Level = vRP.GetExperience(Passport,"Towed")
		local Valuation = Result["Valuation"] + Result["Valuation"] * (Result["Addition"] * Level)

		if exports["inventory"]:Buffs("Dexterity",Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if vRP.UserPremium(Passport) then
			local Hierarchy = vRP.LevelPremium(source)
			local Bonification = (Hierarchy == 1 and 0.100) or (Hierarchy == 2 and 0.075) or (Hierarchy >= 3 and 0.050)

			Valuation = Valuation + (Valuation * Bonification)
			GainExperience = GainExperience + 3
		end

		TriggerEvent("garages:Deleted",Vehicles[Plate]["Network"],Plate)
		vRP.GenerateItem(Passport,Result["Item"],Valuation,true)
		vRP.PutExperience(Passport,"Towed",GainExperience)
		vRP.RolepassPoints(Passport,GainExperience,true)
		vRP.GenerateItem(Passport,"dollar",250,true)
		vRP.UpgradeStress(Passport,5)

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towed:Impound")
AddEventHandler("towed:Impound",function(Table)
	local source = source
	local Passport = vRP.Passport(source)
	local Plate,Model,Network = Table[1],Table[2],Table[4]
	if Passport and not Active[Passport] and not Vehicles[Plate] and vRP.HasService(Passport,"Policia") then
		Active[Passport] = true

		Vehicles[Plate] = {
			["Source"] = source,
			["Network"] = Network,
			["Impound"] = true
		}

		TriggerClientEvent("Notify",source,"Departamento Policial","Registro encaminhado aos trabalhadores.","policia",5000)

		local Coords = vRP.GetEntityCoords(source)
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Impound Solicitado", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(Model).." - "..Plate, color = 44 })
			end)
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Service[Passport] then
		Service[Passport] = nil
	end
end)