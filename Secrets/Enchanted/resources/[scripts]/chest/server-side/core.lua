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
Tunnel.bindInterface("chest",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local ChestItens = {
	["storage25"] = {
		["Slots"] = 25,
		["Weight"] = 25,
		["Block"] = true
	},
	["storage50"] = {
		["Slots"] = 25,
		["Weight"] = 50,
		["Block"] = true
	},
	["storage75"] = {
		["Slots"] = 25,
		["Weight"] = 75,
		["Block"] = true
	},
	["suitcase"] = {
		["Slots"] = 25,
		["Weight"] = 10,
		["Close"] = true,
		["Itens"] = {
			["dollar"] = true,
			["dirtydollar"] = true,
			["wetdollar"] = true,
			["promissory"] = true
		}
	},
	["ammobox"] = {
		["Slots"] = 25,
		["Weight"] = 12,
		["Close"] = true,
		["Itens"] = {
			["WEAPON_PISTOL_AMMO"] = true,
			["WEAPON_SMG_AMMO"] = true,
			["WEAPON_RIFLE_AMMO"] = true,
			["WEAPON_SHOTGUN_AMMO"] = true,
			["WEAPON_MUSKET_AMMO"] = true
		}
	},
	["weaponbox"] = {
		["Slots"] = 50,
		["Weight"] = 100,
		["Close"] = true,
		["Itens"] = {
			["WEAPON_STUNGUN"] = true,
			["WEAPON_PISTOL"] = true,
			["WEAPON_PISTOL_MK2"] = true,
			["WEAPON_COMPACTRIFLE"] = true,
			["WEAPON_APPISTOL"] = true,
			["WEAPON_HEAVYPISTOL"] = true,
			["WEAPON_MACHINEPISTOL"] = true,
			["WEAPON_MICROSMG"] = true,
			["WEAPON_RPG"] = true,
			["WEAPON_MINISMG"] = true,
			["WEAPON_SNSPISTOL"] = true,
			["WEAPON_SNSPISTOL_MK2"] = true,
			["WEAPON_VINTAGEPISTOL"] = true,
			["WEAPON_PISTOL50"] = true,
			["WEAPON_COMBATPISTOL"] = true,
			["WEAPON_CARBINERIFLE"] = true,
			["WEAPON_CARBINERIFLE_MK2"] = true,
			["WEAPON_ADVANCEDRIFLE"] = true,
			["WEAPON_BULLPUPRIFLE"] = true,
			["WEAPON_BULLPUPRIFLE_MK2"] = true,
			["WEAPON_SPECIALCARBINE"] = true,
			["WEAPON_SPECIALCARBINE_MK2"] = true,
			["WEAPON_PUMPSHOTGUN"] = true,
			["WEAPON_PUMPSHOTGUN_MK2"] = true,
			["WEAPON_MUSKET"] = true,
			["WEAPON_SAWNOFFSHOTGUN"] = true,
			["WEAPON_SMG"] = true,
			["WEAPON_SMG_MK2"] = true,
			["WEAPON_TACTICALRIFLE"] = true,
			["WEAPON_HEAVYRIFLE"] = true,
			["WEAPON_ASSAULTRIFLE"] = true,
			["WEAPON_ASSAULTRIFLE_MK2"] = true,
			["WEAPON_ASSAULTSMG"] = true,
			["WEAPON_GUSENBERG"] = true
		}
	},
	["medicbag"] = {
		["Slots"] = 25,
		["Weight"] = 10,
		["Close"] = true,
		["Itens"] = {
			["bandage"] = true,
			["gauze"] = true,
			["gdtkit"] = true,
			["medkit"] = true,
			["sinkalmy"] = true,
			["analgesic"] = true,
			["ritmoneury"] = true,
			["adrenaline"] = true
		}
	},
	["treasurebox"] = {
		["Slots"] = 25,
		["Weight"] = 50,
		["Close"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permissions(Name,Mode,Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Personal" then
			local Name = SplitOne(Name)
			if vRP.HasPermission(Passport,Name) then
				Open[Passport] = {
					["Name"] = "Personal:"..Passport,
					["Weight"] = 50,
					["Save"] = true,
					["Slots"] = 25
				}

				return true
			end
		elseif Mode == "Tray" then
			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 25,
				["Slots"] = 25
			}

			if Name == "Recycle" then
				Open[Passport]["Weight"] = 100
				Open[Passport]["Recycle"] = true
			end

			return true
		elseif Mode == "Custom" or Mode == "Trash" then
			if SplitBoolean(Name,"Helicrash",":") and Cooldown[Name] and Cooldown[Name] > os.time() then
				TriggerClientEvent("Notify",source,"Atenção","Aguarde até que esfrie o compartimento.","amarelo",10000)
				vRPC.DowngradeHealth(source,10)

				return false
			end

			if Mode == "Trash" then
				Name = "Trash:"..Name
			end

			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 50,
				["Slots"] = 25,
				["Mode"] = "Custom"
			}

			return true
		elseif Mode == "Item" then
			local Previous = SplitOne(Name,":")
			if ChestItens[Previous] then
				Open[Passport] = {
					["Name"] = Name,
					["Save"] = true,
					["Unique"] = Previous,
					["Slots"] = ChestItens[Previous]["Slots"],
					["Weight"] = ChestItens[Previous]["Weight"]
				}

				if Item then
					Open[Passport]["Item"] = Item
				end

				return true
			end
		else
			local Consult = vRP.Query("chests/GetChests",{ Name = Name })
			if not Consult[1] then
				vRP.Query("chests/AddChests",{ Name = Name })
				Consult = vRP.Query("chests/GetChests",{ Name = Name })
			end

			if Consult[1] and vRP.HasService(Passport,Consult[1]["Permission"]) then
				Open[Passport] = {
					["Slots"] = Consult[1]["Slots"],
					["Weight"] = Consult[1]["Weight"],
					["NameLogs"] = Name,
					["Name"] = "Chest:"..Name,
					["Logs"] = Consult[1]["Logs"],
					["Permission"] = Consult[1]["Permission"],
					["Save"] = true
				}

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Mount()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
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

				local Item = Split[1]
				if ChestItens[Item] and ChestItens[Item]["Close"] then
					v["block"] = true
				end

				if not v["desc"] then
					if Item == "vehiclekey" and Split[3] then
						v["desc"] = "Placa do Veículo: <common>"..Split[3].."</common>"
					elseif ItemNamed(Item) and Split[2] then
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
		end

		local Secondary = {}
		local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
		for Index,v in pairs(Result) do
			if (v["amount"] <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveChest(Open[Passport]["Name"],Index,Open[Passport]["Save"])
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

				Secondary[Index] = v
			end
		end

		return Primary,Secondary,vRP.GetWeight(Passport),Open[Passport]["Weight"],Open[Passport]["Slots"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target,Inactived)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and not Inactived then
		if Open[Passport]["Recycle"] then
			local Recycled = ItemRecycle(Item)
			if Recycled then
				if vRP.TakeItem(Passport,Item,Amount) then
					for Index,Number in pairs(Recycled) do
						vRP.GenerateItem(Passport,Index,Number * Amount)
					end

					TriggerClientEvent("inventory:Update",source)
				end
			else
				TriggerClientEvent("inventory:Notify",source,"Atenção",ItemName(Item).." não pode ser reciclado.","amarelo")
				TriggerClientEvent("inventory:Update",source)
			end
		elseif Item == "diagram" and Open[Passport]["NameLogs"] then
			if vRP.TakeItem(Passport,Item,Amount) then
				vRP.Query("chests/UpdateWeight",{ Name = Open[Passport]["NameLogs"], Multiplier = Amount })
				TriggerClientEvent("inventory:Notify",source,"Sucesso","Armazenamento melhorado.","verde")
				Open[Passport]["Weight"] = Open[Passport]["Weight"] + (10 * Amount)
				TriggerClientEvent("inventory:Update",source)
			end
		else
			local Item = SplitOne(Item)
			local Unique = Open[Passport]["Unique"]
			if (ChestItens[Item] and ChestItens[Item]["Block"]) or (Unique and ChestItens[Unique] and ChestItens[Unique]["Itens"] and not ChestItens[Unique]["Itens"][Item]) then
				if Unique and Item == Unique then
					TriggerClientEvent("inventory:Open",source,{
						Type = "Inventory",
						Resource = "inventory"
					},true)
				else
					TriggerClientEvent("inventory:Update",source)
				end
			else
				if vRP.StoreChest(Passport,Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target,Open[Passport]["Save"],ChestItens[Unique]) then
					TriggerClientEvent("inventory:Update",source)
				elseif Open[Passport]["Logs"] then
					exports["discord"]:Embed(Open[Passport]["NameLogs"],"**[PASSAPORTE]:** "..Passport.."\n**[GUARDOU]:** "..Amount.."x "..ItemName(Item).."\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
				end
			end
		end
	else
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and not vRP.TakeChest(Passport,Open[Passport]["Name"],Amount,Slot,Target,Open[Passport]["Save"]) then
		local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
		if (Open[Passport]["Mode"] or Open[Passport]["Item"]) and json.encode(Result) == "[]" then
			if Open[Passport]["Item"] and vRP.TakeItem(Passport,Open[Passport]["Item"]) then
				TriggerClientEvent("inventory:Open",source,{
					Type = "Inventory",
					Resource = "inventory"
				},true)
			end

			if SplitBoolean(Open[Passport]["Name"],"Helicrash",":") then
				GlobalState["Helibox"] = GlobalState["Helibox"] - 1
			end
		elseif Open[Passport]["Logs"] then
			exports["discord"]:Embed(Open[Passport]["NameLogs"],"**[PASSAPORTE]:** "..Passport.."\n**[RETIROU]:** "..Amount.."x "..ItemName(Item).."\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"))
		end
	else
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and vRP.UpdateChest(Passport,Open[Passport]["Name"],Slot,Target,Amount,Open[Passport]["Save"]) then
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Cooldown",function(Name)
	Cooldown[Name] = os.time() + 600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:ARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Armour")
AddEventHandler("chest:Armour",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") then
		vRP.SetArmour(source,100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)