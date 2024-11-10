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
Tunnel.bindInterface("crafting",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and List[Name] and (not List[Name]["Permission"] or (List[Name]["Permission"] and vRP.HasService(Passport,List[Name]["Permission"]))) or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and List[Name] then
		local Primary = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			if (v["amount"] <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],v["amount"],false)
			else
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
					if Split[1] == "vehiclekey" and Split[3] then
						v["desc"] = "Placa do Veículo: <common>"..Split[3].."</common>"
					elseif ItemNamed(Split[1]) and Split[2] then
						if Split[1] == "identity" then
							v["desc"] = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Telefone: <rare>"..vRP.Phone(Passport).."</rare>"
						else
							v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
						end
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
		end

		return Primary,vRP.GetWeight(Passport)
	end
end
---------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Amount,Target,Name)
	local source = source
	local Target = tostring(Target)
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
		if not vRP.MaxItens(Passport,Item,Multiplier) and vRP.CheckWeight(Passport,Item,Multiplier) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target]["item"] == Item)) then
			for Index,Value in pairs(List[Name]["List"][Item]["Required"]) do
				if not vRP.ConsultItem(Passport,Index,Value * Amount) then
					TriggerClientEvent("inventory:Notify",source,"Atenção","Precisa de <default>"..Dotted(Value * Amount).."x "..ItemName(Index).."</default>.","vermelho")

					return false
				end
			end

			for Index,Value in pairs(List[Name]["List"][Item]["Required"]) do
				local Consult = vRP.InventoryItemAmount(Passport,Index)
				vRP.RemoveItem(Passport,Consult[2],Value * Amount)
			end

			vRP.GenerateItem(Passport,Item,Multiplier,false,Target)
		end
	end

	TriggerClientEvent("inventory:Update",source)
end