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
Tunnel.bindInterface("propertys",Hensa)
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lock = {}
local Inside = {}
local Actived = {}
local Robbery = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Markers"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Robbery(Name,Number)
	local source = source

	if not Robbery[Name] then
		Robbery[Name] = {}
	end

	if not Robbery[Name][Number] then
		Robbery[Name][Number] = 0
	end

	if Robbery[Name] and os.time() < Robbery[Name][Number] then
		TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Robbery[Name][Number] - os.time())..".","amarelo",5000)

		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Police(Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		exports["vrp"]:CallPolice({
			["Source"] = source,
			["Passport"] = Passport,
			["Coords"] = Coords,
			["Permission"] = "Policia",
			["Name"] = "Roubo a Propriedade",
			["Wanted"] = 300,
			["Code"] = 31,
			["Color"] = 44
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYBERRY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Paybbery(Name,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Robbery[Name] and os.time() >= Robbery[Name][Number] then
		local Result = RandPercentage(IlegalItens)
		if exports["inventory"]:Buffs("Luck",Passport) then
			Result["Valuation"] = Result["Valuation"] + (Result["Valuation"] * 0.5)
		end

		if not vRP.MaxItens(Passport,Result["Item"],Result["Valuation"]) and vRP.CheckWeight(Passport,Result["Item"],Result["Valuation"]) then
			vRP.GenerateItem(Passport,Result["Item"],Result["Valuation"],true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","roxo",5000)
			exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Valuation"])
		end

		TriggerClientEvent("player:Residuals",source,"Resquício de Línter")
		Robbery[Name][Number] = os.time() + 3600
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Propertys(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			local Consult = vRP.Query("propertys/Count",{ Passport = Passport })
			if Consult[1] then
				local Count = Consult[1]["COUNT(Passport)"]
				if Count <= 0 then
					return "Hotel"
				end
			end
		else
			local Consult = vRP.Query("propertys/Exist",{ Name = Name })
			if Consult[1] then
				if Consult[1]["Passport"] == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) or Lock[Name] then
					local Tax = CompleteTimers(Consult[1]["Tax"] - os.time())

					if os.time() > Consult[1]["Tax"] then
						Tax = "Efetue o pagamento do <b>Iptu</b>."
						local Price = Informations[Consult[1]["Interior"]]["Price"] * 0.15

						if vRP.Request(source,"Propriedades","Hipoteca atrasada, deseja pagar por <b>$"..Dotted(Price).."</b>?") and vRP.PaymentFull(Passport,Price) then
							TriggerClientEvent("Notify",source,"Propriedades","Pagamento concluído.","verde",5000)
							vRP.Query("propertys/Tax",{ Name = Name })
							Tax = CompleteTimers(2592000)
						else
							return false
						end
					end

					return {
						["Interior"] = Consult[1]["Interior"],
						["Tax"] = Tax
					}
				end
			else
				return "Nothing"
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Toggle(Name,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Exit" then
			Inside[Passport] = nil
			TriggerEvent("vRP:BucketServer",source,"Exit")
		else
			Inside[Passport] = Name

			if Name == "Hotel" then
				TriggerEvent("vRP:BucketServer",source,"Enter",Passport)
			else
				TriggerEvent("vRP:BucketServer",source,"Enter",Route(Name))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Buy")
AddEventHandler("propertys:Buy",function(Name)
	local source = source
	local Split = splitString(Name)
	local Passport = vRP.Passport(source)
	if Passport and not exports["bank"]:CheckFines(Passport) then
		local Name,Interior,Mode = Split[1],Split[2],Split[3]

		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if not Consult[1] then
			TriggerClientEvent("dynamic:Close",source)

			if vRP.Request(source,"Propriedades","Deseja comprar a propriedade?") then
				local Serial = PropertysSerials()

				if Mode == "Dollar" then
					if vRP.PaymentFull(Passport,Informations[Interior]["Price"]) then
						local Markers = GlobalState["Markers"]
						Markers[Name] = true
						GlobalState:set("Markers",Markers,true)

						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						TriggerClientEvent("Notify",source,"Propriedades","Compra concluída.","verde",5000)
						exports["bank"]:AddTaxs(Passport,source,"Propriedades",Informations[Interior]["Price"],"Compra de propriedade.")
						vRP.Query("propertys/Buy",{ Name = Name, Interior = Interior, Passport = Passport, Serial = Serial, Vault = Informations[Interior]["Vault"], Fridge = Informations[Interior]["Fridge"], Tax = os.time() + 2592000 })
					else
						TriggerClientEvent("Notify",source,"Propriedades","<b>Dólares</b> insuficientes.","amarelo",5000)
					end
				elseif Mode == "Gemstone" then
					if vRP.PaymentGemstone(Passport,Informations[Interior]["Gemstone"]) then
						local Markers = GlobalState["Markers"]
						Markers[Name] = true
						GlobalState:set("Markers",Markers,true)

						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						TriggerClientEvent("Notify",source,"Propriedades","Compra concluída.","verde",5000)
						vRP.Query("propertys/Buy",{ Name = Name, Interior = Interior, Passport = Passport, Serial = Serial, Vault = Informations[Interior]["Vault"], Fridge = Informations[Interior]["Fridge"], Tax = os.time() + 31104000 })
					else
						TriggerClientEvent("Notify",source,"Propriedades","<b>Diamantes</b> insuficientes.","amarelo",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Lock")
AddEventHandler("propertys:Lock",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	local Consult = vRP.Query("propertys/Exist",{ Name = Name })
	if Passport and Consult[1] and (vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) or Consult[1]["Passport"] == Passport) then
		if Lock[Name] then
			Lock[Name] = nil
			TriggerClientEvent("Notify",source,"Aviso","Propriedade trancada.","default",5000)
		else
			Lock[Name] = true
			TriggerClientEvent("Notify",source,"Aviso","Propriedade destrancada.","default",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Sell")
AddEventHandler("propertys:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] then
		Actived[Passport] = true

		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			TriggerClientEvent("dynamic:Close",source)
			local Price = Informations[Consult[1]["Interior"]]["Price"] * 0.75

			if vRP.Request(source,"Propriedades","Vender por <b>$"..Dotted(Price).."</b>?") then
				if GlobalState["Markers"][Name] then
					local Markers = GlobalState["Markers"]
					Markers[Name] = nil
					GlobalState:set("Markers",Markers,true)
				end

				vRP.GiveBank(Passport,Price)
				vRP.RemoveServerData("Vault:"..Name)
				vRP.RemoveServerData("Fridge:"..Name)
				vRP.Query("propertys/Sell",{ Name = Name })
				TriggerClientEvent("garages:Clean",-1,Name)
				TriggerClientEvent("Notify",source,"Propriedades","Venda concluída.","verde",5000)
			end
		end

		Actived[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Transfer")
AddEventHandler("propertys:Transfer",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] and not exports["bank"]:CheckFines(Passport) then
		Actived[Passport] = true

		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			TriggerClientEvent("dynamic:Close",source)

			local Keyboard = vKEYBOARD.Primary(source,"Passaporte")
			if Keyboard and vRP.Identity(Keyboard[1]) and vRP.Request(source,"Propriedades","Deseja trasnferir a propriedade para passaporte <b>"..Keyboard[1].."</b>?") then
				vRP.Query("propertys/Transfer",{ Name = Name, Passport = Keyboard[1] })
				TriggerClientEvent("Notify",source,"Propriedades","Transferência concluída.","verde",5000)
			end
		end

		Actived[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CREDENTIALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Credentials")
AddEventHandler("propertys:Credentials",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	local Consult = vRP.Query("propertys/Exist",{ Name = Name })
	if Passport and Consult[1] and Consult[1]["Passport"] == Passport then
		TriggerClientEvent("dynamic:Close",source)

		if vRP.Request(source,"Propriedades","Lembre-se que ao prosseguir todos os cartões vão deixar de funcionar, deseja prosseguir?") then
			local Serial = PropertysSerials()
			vRP.Query("propertys/Credentials",{ Name = Name, Serial = Serial })
			vRP.GiveItem(Passport,"propertys-"..Serial,Consult[1]["Item"],true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Item")
AddEventHandler("propertys:Item",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	local Consult = vRP.Query("propertys/Exist",{ Name = Name })
	if Passport and Consult[1] and Consult[1]["Passport"] == Passport and Consult[1]["Item"] < 5 then
		TriggerClientEvent("dynamic:Close",source)

		if vRP.Request(source,"Propriedades","Comprar uma chave adicional por <b>$150.000</b> dólares?") then
			if vRP.PaymentFull(Passport,150000) then
				vRP.Query("propertys/Item",{ Name = Name })
				vRP.GiveItem(Passport,"propertys-"..Consult[1]["Serial"],1,true)
			else
				TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Clothes()
	local Clothes = {}
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.GetServerData("Wardrobe:"..Passport)

		for Table,_ in pairs(Consult) do
			Clothes[#Clothes + 1] = Table
		end
	end

	return Clothes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Clothes")
AddEventHandler("propertys:Clothes",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.GetServerData("Wardrobe:"..Passport)
		local Split = splitString(Mode)
		local Name = Split[2]

		if Split[1] == "save" then
			local Keyboard = vKEYBOARD.Primary(source,"Nome")
			if Keyboard then
				local Check = sanitizeString(Keyboard[1],"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")

				if not Consult[Check] then
					Consult[Check] = vSKINSHOP.Customization(source)
					vRP.SetServerData("Wardrobe:"..Passport,Consult)
					TriggerClientEvent("propertys:ClothesReset",source)
					TriggerClientEvent("Notify",source,"Propriedades","<b>"..Check.."</b> adicionado.","verde",5000)
				else
					TriggerClientEvent("Notify",source,"Propriedades","Nome escolhido já existe em seu armário.","amarelo",5000)
				end
			end
		elseif Split[1] == "delete" then
			if Consult[Name] then
				Consult[Name] = nil
				vRP.SetServerData("Wardrobe:"..Passport,Consult)
				TriggerClientEvent("propertys:ClothesReset",source)
				TriggerClientEvent("Notify",source,"Propriedades","<b>"..Name.."</b> removido.","verde",5000)
			else
				TriggerClientEvent("Notify",source,"Propriedades","A vestimenta salva não se encontra mais em seu armário.","amarelo",5000)
			end
		elseif Split[1] == "apply" then
			if Consult[Name] then
				TriggerClientEvent("skinshop:Apply",source,Consult[Name])
				TriggerClientEvent("Notify",source,"Propriedades","<b>"..Name.."</b> aplicado.","verde",5000)
			else
				TriggerClientEvent("Notify",source,"Propriedades","A vestimenta salva não se encontra mais em seu armário.","amarelo",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYSSERIALS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertysSerials()
	repeat
		Serial = GenerateString("LDLDLDLDLD")
		Consult = vRP.Query("propertys/Serial",{ Serial = Serial })
	until Serial and not Consult[1]

	return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Name)
	local source = source
	local Passport = vRP.Passport(source)
	local Consult = vRP.Query("propertys/Exist",{ Name = Name })
	if Passport and (Name == "Hotel" or Consult[1] and (vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) or Consult[1]["Passport"] == Passport)) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount(Name,Mode)
	local Weight = 25
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and Mode then
		if Name == "Hotel" then
			Name = "Hotel:"..Passport
		else
			Weight = vRP.Query("propertys/Exist",{ Name = Name })[1][Mode]
		end

		local Primary = {}
		local Inv = vRP.Inventory(Passport)
		local Consult = vRP.GetServerData(Mode..":"..Name)

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
		for Index,v in pairs(Consult) do
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

		return Primary,Secondary,vRP.GetWeight(Passport),Weight
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if (Mode == "Vault" and ItemFridge(Item)) or (Mode == "Fridge" and not ItemFridge(Item)) then
			TriggerClientEvent("inventory:Update",source)

			return false
		end

		if Name == "Hotel" then
			if vRP.StoreChest(Passport,Mode..":Hotel:"..Passport,Amount,25,Slot,Target) then
				TriggerClientEvent("inventory:Update",source)
			end
		else
			local Consult = vRP.Query("propertys/Exist",{ Name = Name })
			if Consult[1] then
				if Item == "diagram" then
					if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
						vRP.Query("propertys/"..Mode,{ Name = Name, Weight = 10 * Amount })
						TriggerClientEvent("inventory:Update",source)
					end
				else
					if vRP.StoreChest(Passport,Mode..":"..Name,Amount,Consult[1][Mode],Slot,Target) then
						TriggerClientEvent("inventory:Update",source)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			if vRP.TakeChest(Passport,Mode..":Hotel:"..Passport,Amount,Slot,Target) then
				TriggerClientEvent("inventory:Update",source)
			end
		else
			if vRP.TakeChest(Passport,Mode..":"..Name,Amount,Slot,Target) then
				TriggerClientEvent("inventory:Update",source)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount,Name,Mode)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			Name = "Hotel:"..Passport
		end

		if vRP.UpdateChest(Passport,Mode..":"..Name,Slot,Target,Amount) then
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Route(Name)
	local Split = splitString(Name,"ropertys")

	return parseInt(100000 + Split[2])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Inside[Passport] then
		vRP.InsidePropertys(Passport,Propertys[Inside[Passport]])
		Inside[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Markers = GlobalState["Markers"]
	for _,v in pairs(vRP.Query("propertys/All")) do
		local Name = v["Name"]
		if Propertys[Name] then
			Markers[Name] = true
		end
	end

	GlobalState:set("Markers",Markers,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSENCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("ChosenCharacter",function(Passport,source)
	local Increments = {}

	local Consult = vRP.Query("propertys/Count", { Passport = Passport })
	if Consult[1] then
		local Count = Consult[1]["COUNT(Passport)"]
		if Count <= 0 then
			Increments[#Increments + 1] = "Hotel"
		else
			local All = vRP.Query("propertys/AllUser",{ Passport = Passport })
			if All[1] then
				for _,v in pairs(All) do
					local Name = v["Name"]
					if Propertys[Name] then
						Increments[#Increments + 1] = Propertys[Name]
					end
				end
			end
		end
	end

	TriggerClientEvent("spawn:Increment",source,Increments)
end)