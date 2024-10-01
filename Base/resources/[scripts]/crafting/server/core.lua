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
Tunnel.bindInterface("crafting", Hensa)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Type]["Permission"] ~= nil then
			if vRP.HasGroup(Passport, List[Type]["Permission"]) then
				return true
			end
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckReputation()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local UnLikes = vRP.GetUnLikes(Passport)
		if UnLikes > 0 then
			return true
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não possúi reputação suficiente.", "Atenção", 5000)
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRADEREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.TradeReputation()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local UnLikes = vRP.GetUnLikes(Passport)
		if UnLikes > 0 then
			if vRP.Request(source, "Reputação", "Deseja trocar seus <b>"..Dotted(UnLikes).."x Votos Negativos</b> por <b>"..Dotted(UnLikes * 2).."x "..ItemName(DefaultDollars2).."</b>?") then
				vRP.RemoveUnlikes(Passport, UnLikes)
				vRP.GenerateItem(Passport, DefaultDollars2, (UnLikes * 2), true)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você não possúi reputação suficiente.", "Atenção", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Crafting(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local CraftingInventory = {}
		for Item,v in pairs(List[Type]["List"]) do
			local KeyList = {}

			for Required,Amount in pairs(v["Required"]) do
				KeyList[#KeyList + 1] = { index = Required, amount = Amount }
			end

			CraftingInventory[#CraftingInventory + 1] = { id = Type, name = ItemName(Item), index = ItemIndex(Item), type = ItemType(Item), economy = Dotted(ItemEconomy(Item)), key = Item, weight = ItemWeight(Item), amount = parseInt(v["Amount"]), craftable = v["Craftable"], recipeItems = KeyList, time = v["Time"] }
		end

		local UserInventory = {}
		local inventory = vRP.Inventory(Passport)
		for Index,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = ItemName(v["item"])
			v["weight"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["max"] = ItemMaxAmount(v["item"])
			v["economy"] = Dotted(ItemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

			local splitName = splitString(v["item"], "-")
			if splitName[2] ~= nil then
				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = ItemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			UserInventory[Index] = v
		end

		return CraftingInventory, UserInventory, vRP.InventoryWeight(Passport), vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.FunctionCrafting(Type, Item, Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if List[Type]["List"][Item] then
			if vRP.MaxItens(Passport, Item, List[Type]["List"][Item]["Amount"] * Amount) then
				TriggerClientEvent("Notify", source, "amarelo", "Limite atingido.", "Atenção", 5000)
				return
			end

			if (vRP.InventoryWeight(Passport) + (ItemWeight(Item) * List[Type]["List"][Item]["Amount"]) * Amount) <= vRP.GetWeight(Passport) then
				for Index,v in pairs(List[Type]["List"][Item]["Required"]) do
					local ConsultItem = vRP.InventoryItemAmount(Passport, Index)
					if ConsultItem[1] < parseInt(v * Amount) then
						return
					end

					if vRP.CheckDamaged(ConsultItem[2]) then
						TriggerClientEvent("Notify", source, "vermelho", "Item danificado.", "Aviso", 5000)
						return
					end
				end

				for Index,v in pairs(List[Type]["List"][Item]["Required"]) do
					local ConsultItem = vRP.InventoryItemAmount(Passport, Index)
					vRP.RemoveItem(Passport, ConsultItem[2], parseInt(v * Amount), CraftingNotify)
				end

				vRP.GenerateItem(Passport, Item, List[Type]["List"][Item]["Amount"] * Amount, CraftingNotify)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Owned(Type, Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Type]["List"][Item] then
			local ItemList = {}
			for Item,_ in pairs(List[Type]["List"][Item]["Required"]) do
				table.insert(ItemList, { index = Item, amount = vRP.ItemAmount(Passport, Item) })
			end

			return ItemList
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot", function(Item, Slot, Target, Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport, Item, Amount, false, Slot) then
			vRP.GiveItem(Passport, Item, Amount, false, Target)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot", function(Item, Slot, Target, Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local Inventory = vRP.Inventory(Passport)
		if Inventory[tostring(Slot)] and Inventory[tostring(Target)] and Inventory[tostring(Slot)]["item"] == Inventory[tostring(Target)]["item"] then
			if vRP.TakeItem(Passport, Item, Amount, false, Slot) then
				vRP.GiveItem(Passport, Item, Amount, false, Target)
			end
		else
			vRP.SwapSlot(Passport, Slot, Target)
		end
	end
end)