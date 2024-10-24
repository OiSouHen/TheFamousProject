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
Hensa = {}
Tunnel.bindInterface("trunkchest",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		local Primary = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["name"] = ItemName(v["item"])
			v["weight"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["amount"] = parseInt(v["amount"])
			v["rarity"] = ItemRarity(v["item"])
			v["economy"] = ItemEconomy(v["item"])
			v["desc"] = ItemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"])

			if not v["desc"] then
				if Split[1] == "vehkey" and Split[2] then
					v["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
				elseif ItemNamed(Split[1]) and Split[2] then
					v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
				end
			end

			if Split[2] then
				local Loaded = ItemLoads(v["item"])
				if Loaded then
					v["charges"] = parseInt(Split[2] * (100 / Loaded))
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			Primary[Index] = v
		end

		local Secondary = {}
		local Result = vRP.GetServerData(Vehicle[Passport]["Data"])
		for Index,v in pairs(Result) do
			v["name"] = ItemName(v["item"])
			v["weight"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["amount"] = parseInt(v["amount"])
			v["rarity"] = ItemRarity(v["item"])
			v["economy"] = ItemEconomy(v["item"])
			v["desc"] = ItemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"])

			if not v["desc"] then
				if Split[1] == "vehkey" and Split[2] then
					v["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
				elseif ItemNamed(Split[1]) and Split[2] then
					v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
				end
			end

			if Split[2] then
				local Loaded = ItemLoads(v["item"])
				if Loaded then
					v["charges"] = parseInt(Split[2] * (100 / Loaded))
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			Secondary[Index] = v
		end

		return Primary,Secondary,vRP.GetWeight(Passport),Vehicle[Passport]["Weight"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
local Store = {
	["ratloader"] = {
		["woodlog"] = true
	},
	["stockade"] = {
		["pouch"] = true
	},
	["trash"] = {
		["plastic"] = true,
		["glass"] = true,
		["rubber"] = true,
		["aluminum"] = true,
		["copper"] = true
	},
	["flatbed"] = {
		["plastic"] = true,
		["glass"] = true,
		["rubber"] = true,
		["aluminum"] = true,
		["copper"] = true,
		["tyres"] = true,
		["toolbox"] = true,
		["advtoolbox"] = true
	},
	["boxville2"] = {
		["package"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKED
-----------------------------------------------------------------------------------------------------------------------------------------
local Blocked = {
	["dollar"] = true,
	["dirtydollar"] = true,
	["wetdollar"] = true,
	["promissory"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if vRP.UpdateChest(Passport,Vehicle[Passport]["Data"],Slot,Target,Amount) then
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		local Name = Vehicle[Passport]["Model"]

		if (Store[Name] and not Store[Name][Item]) or Blocked[Item] then
			TriggerClientEvent("Notify",source,"Atenção","Armazenamento proibido.","amarelo",5000)
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if Item == "diagram" then
			if vRP.TakeItem(Passport,Item,Amount) then
				Vehicle[Passport]["Weight"] = Vehicle[Passport]["Weight"] + (10 * Amount)

				local Result = vRP.GetServerData(Vehicle[Passport]["Data"])
				vRP.Query("vehicles/UpdateWeight",{ Passport = Vehicle[Passport]["User"], Vehicle = Vehicle[Passport]["Model"], Multiplier = Amount })
				TriggerClientEvent("inventory:Update",source)
			end
		else
			if vRP.StoreChest(Passport,Vehicle[Passport]["Data"],Amount,Vehicle[Passport]["Weight"],Slot,Target) then
				TriggerClientEvent("inventory:Update",source)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if vRP.TakeChest(Passport,Vehicle[Passport]["Data"],Amount,Slot,Target) then
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Close()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] and Vehicle[Passport]["Net"] then
		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				if Vehicle[Passport] and Vehicle[Passport]["Net"] then
					TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"close")
				end
			end)
		end

		Vehicle[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local PassportPlate = vRP.PassportPlate(Entity[1])

		if PassportPlate then
			local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = PassportPlate["Passport"], Vehicle = Entity[2] })
			if Consult[1]["Weight"] > 0 then

				Vehicle[Passport] = {
					["Net"] = Entity[4],
					["Plate"] = Entity[1],
					["Model"] = Entity[2],
					["Weight"] = Consult[1]["Weight"],
					["User"] = PassportPlate["Passport"],
					["Data"] = "Trunkchest:"..PassportPlate["Passport"]..":"..Entity[2]
				}

				TriggerClientEvent("trunkchest:Open",source)

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						if Vehicle[Passport] and Vehicle[Passport]["Net"] then
							TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"open")
						end
					end)
				end
			else
				TriggerClientEvent("Notify",source,"Aviso","O veículo não possuí <b>Porta-Malas</b>.","vermelho",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Vehicle[Passport] then
		Vehicle[Passport] = nil
	end
end)