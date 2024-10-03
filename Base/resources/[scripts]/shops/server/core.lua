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
Tunnel.bindInterface("shops",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)

	return Passport and List[Name] and (not List[Name]["Permission"] or (List[Name]["Permission"] and vRP.HasService(Passport,List[Name]["Permission"]))) or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Name or not List[Name] or not List[Name]["List"] then
			exports["discord"]:Embed("Hackers","**Passaporte:** "..Passport.."\n**Função:** Request do shops",0xa3c846,source)
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
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Item and Target and List[Name] and List[Name]["Type"] and List[Name]["List"] and List[Name]["List"][Item] then
		if Amount > 1 and (ItemUnique(Item) or ItemLoads(Item)) then
			Amount = 1
		end

		local Inventory = vRP.Inventory(Passport)
		if not vRP.MaxItens(Passport,Item,Amount) and vRP.CheckWeight(Passport,Item,Amount) and (not Inventory[Target] or (Inventory[Target] and Inventory[Target]["item"] == Item)) then
			if List[Name]["Type"] == "Cash" then
				if vRP.PaymentFull(Passport,List[Name]["List"][Item] * Amount) then
					vRP.GenerateItem(Passport,Item,Amount,false,Target)

					if Item == "WEAPON_PETROLCAN" then
						vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500)
					end
				else
					TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
				end
			elseif List[Name]["Type"] == "Consume" and List[Name]["Item"] then
				if vRP.TakeItem(Passport,List[Name]["Item"],List[Name]["List"][Item] * Amount) then
					vRP.GenerateItem(Passport,Item,Amount,false,Target)
				else
					TriggerClientEvent("Notify",source,"Atenção","<b>"..ItemName(List[Name]["Item"]).."</b> insuficiente.","amarelo",5000)
				end
			end
		end
	end

	TriggerClientEvent("inventory:Update",source)
end
---------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Amount,Slot,Name)
	local source = source
	local Split = SplitOne(Item)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and List[Name] and List[Name]["List"] and List[Name]["Type"] and List[Name]["List"][Split] and not vRP.CheckDamaged(Item) then
		if List[Name]["Type"] == "Cash" then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GenerateItem(Passport,"dollar",List[Name]["List"][Split] * Amount,false)
			end
		elseif List[Name]["Type"] == "Consume" then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GenerateItem(Passport,List[Name]["Item"],List[Name]["List"][Split] * Amount,false)
			end
		end
	end

	TriggerClientEvent("inventory:Update",source)
end