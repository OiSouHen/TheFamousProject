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
Tunnel.bindInterface("crafting",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and List[Name] and (not List[Name]["Permission"] or (List[Name]["Permission"] and vRP.HasPermission(Passport,List[Name]["Permission"]))) or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Name or not List[Name] or not List[Name]["List"] then
			exports["discord"]:Embed("Hackers","**Passaporte:** "..Passport.."\n**Função:** Request do crafting",0xa3c846)
		end

		if List[Name] then
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

			return Primary,vRP.GetWeight(Passport)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Item,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Item and Target and List[Name] and List[Name]["List"] and List[Name]["List"][Item] then
		if Amount > 1 and (ItemUnique(Item) or ItemLoads(Item)) then
			Amount = 1
		end

		if ItemBlueprint(Item) and not exports["inventory"]:Blueprint(Passport,Item) then
			TriggerClientEvent("inventory:Notify",source,"Aviso","Aprendizado não encontrado.","amarelo")

			return false
		end

		local Inventory = vRP.Inventory(Passport)
		local Multiplier = List[Name]["List"][Item]["Amount"] * Amount
		if not vRP.MaxItens(Passport,Item,Multiplier) and vRP.GetWeight(Passport) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target]["item"] == Item)) then
			for Index,Value in pairs(List[Name]["List"][Item]["Required"]) do
				if not vRP.ConsultItem(Passport,Index,Value * Amount) then
					TriggerClientEvent("inventory:Notify",source,"Atenção","Precisa de <default>"..Dotted(Value * Amount).."x "..ItemName(Index).."</default>.","vermelho")

					return false
				end
			end

			for Index,Value in pairs(List[Name]["List"][Item]["Required"]) do
				local Consult = vRP.InventoryItemAmount(Passport,Index)
				vRP.RemoveItem(Passport,Consult[2],Value * Amount,false)
			end

			vRP.GenerateItem(Passport,Item,Multiplier,false,Target)
		end
	end

	TriggerClientEvent("inventory:Update",source)
end