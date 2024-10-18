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
Tunnel.bindInterface("inspect",Hensa)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
local Sourcers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inspect:Player")
AddEventHandler("inspect:Player",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and not Players[OtherPassport] and (vRP.HasService(Passport,"Policia") or vRP.GetHealth(OtherSource) <= 100 or (vRP.GetHealth(OtherSource) > 100 and vRP.Request(OtherSource,"Revistar","Você aceita ser revistado?"))) then
		if #(vRP.GetEntityCoords(source) - vRP.GetEntityCoords(OtherSource)) <= 2 then
			Sourcers[Passport] = OtherSource
			Players[Passport] = OtherPassport

			TriggerEvent("inventory:ServerCarry",source,Passport,OtherSource,true)
			TriggerClientEvent("inventory:Close",OtherSource)
			TriggerClientEvent("inspect:Open",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
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
		local Inv = vRP.Inventory(Players[Passport])
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

			Secondary[Index] = v
		end

		return Primary,Secondary,vRP.GetWeight(Passport),vRP.GetWeight(Players[Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Reset()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Sourcers[Passport] then
			TriggerEvent("inventory:ServerCarry",source,Passport,Sourcers[Passport])

			Sourcers[Passport] = nil
		end

		if Players[Passport] then
			Players[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] then
		if BlockDelete(Item) or vRP.MaxItens(Players[Passport],Item,Amount) then
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if (vRP.InventoryWeight(Players[Passport]) + ItemWeight(Item) * Amount) <= vRP.GetWeight(Players[Passport]) then
			if vRP.TakeItem(Passport,Item,Amount,true) then
				vRP.GiveItem(Players[Passport],Item,Amount,true,Target)

				TriggerClientEvent("inventory:Update",source)
				TriggerClientEvent("inventory:Update",Sourcers[Passport])
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Item,Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] then
		if BlockDelete(Item) or vRP.MaxItens(Passport,Item,Amount) then
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if vRP.CheckWeight(Passport,Item,Amount) then
			if vRP.TakeItem(Players[Passport],Item,Amount,true) then
				vRP.GiveItem(Passport,Item,Amount,true,Target)

				TriggerClientEvent("inventory:Update",source)
				TriggerClientEvent("inventory:Update",Sourcers[Passport])
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
			TriggerClientEvent("inventory:Update",source)
		end
	end
end