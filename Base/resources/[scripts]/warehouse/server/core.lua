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
Tunnel.bindInterface("warehouse",Hensa)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Warehouses"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Transfer")
AddEventHandler("warehouse:Transfer",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["bank"]:CheckFines(Passport) then
		local Warehouse = vRP.Query("warehouse/Informations",{ Name = Name })
		if Warehouse[1] and Warehouse[1]["Passport"] == Passport then
			local Keyboard = vKEYBOARD.Primary(source,"Passaporte")
			if Keyboard and vRP.Request(source,"Armazém","Deseja transferir o <b>Armazém</b> para o passaporte <b>"..Keyboard[1].."</b>?") then
				vRP.Query("warehouse/Transfer",{ Passport = Keyboard[1], Name = Name })
				TriggerClientEvent("Notify",source,"Sucesso","Armazém transferido.","verde",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Password")
AddEventHandler("warehouse:Password",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ Name = Name })
		if Warehouse[1] and Warehouse[1]["Passport"] == Passport then
			local Keyboard = vKEYBOARD.Password(source,"Nova Senha")
			if Keyboard then
				local Password = sanitizeString(Keyboard[1],"0123456789")
				if string.len(Password) >= 4 and string.len(Password) <= 20 then
					vRP.Query("warehouse/Password",{ Name = Name, Password = Password })
					TriggerClientEvent("Notify",source,"Sucesso","Senha atualizada.","amarelo",5000)
				else
					TriggerClientEvent("Notify",source,"Atenção","Necessário possuir entre <b>4</b> e <b>20</b> números.","amarelo",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Warehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and not exports["bank"]:CheckFines(Passport) then
		local Consult = vRP.Query("warehouse/Informations",{ Name = Name })
		if Consult[1] then
			if Consult[1]["Tax"] < os.time() then
				if Consult[1]["Passport"] == Passport and vRP.Request(source,"Armazém","Deseja efetuar o pagamento do aluguel de <b>$30.000</b>?") then
					if vRP.PaymentFull(Passport,30000) then
						vRP.Query("warehouse/Tax",{ Name = Name })

						return true
					else
						TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
					end
				end

				return false
			end

			if Consult[1]["Passport"] == Passport then
				return true
			else
				local Keyboard = vKEYBOARD.Password(source,"Senha")
				if Keyboard then
					local Warehouse = vRP.Query("warehouse/Acess",{ Name = Name, Password = Keyboard[1] })
					if Warehouse[1] then
						return true
					else
						TriggerClientEvent("Notify",source,"Aviso","Senha incorreta.","vermelho",5000)
					end
				end
			end
		else
			if vRP.Request(source,"Armazém","Gostaria de comprar o armazém por <b>$100.000</b>?") then
				local Keyboard = vKEYBOARD.Password(source,"Senha")
				if Keyboard then
					local Password = sanitizeString(Keyboard[1],"0123456789")
					if string.len(Password) >= 4 and string.len(Password) <= 20 then
						if vRP.Request(source,"Armazém","Finalizar a compra usando a senha <b>"..Password.."</b>?") then
							if vRP.PaymentFull(Passport,100000) then
								local Warehouses = GlobalState["Warehouses"]
								Warehouses[Name] = true
								GlobalState:set("Warehouses",Warehouses,true)

								exports["bank"]:AddTaxs(Passport,source,"Armazém",100000,"Compra de armazém.")
								vRP.Query("warehouse/Buy",{ Name = Name, Passport = Passport, Password = Password })

								return true
							else
								TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"Aviso","Necessário possuir entre <b>4</b> e <b>20</b> números.","amarelo",5000)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name then
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
		local Consult = vRP.GetServerData("Warehouse:"..Name)
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

		local Warehouse = vRP.Query("warehouse/Informations",{ Name = Name })
		if Warehouse[1] then
			return Primary,Secondary,vRP.GetWeight(Passport),Warehouse[1]["Weight"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("warehouse/Informations",{ Name = Name })
		if Consult[1] then
			if Item == "diagram" then
				if vRP.TakeItem(Passport,Item,Amount) then
					vRP.Query("warehouse/Upgrade",{ Name = Name, Multiplier = Amount })
					TriggerClientEvent("inventory:Update",source)
				end
			else
				if vRP.StoreChest(Passport,"Warehouse:"..Name,Amount,Consult[1]["Weight"],Slot,Target,true) then
					TriggerClientEvent("inventory:Update",source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("warehouse/Informations",{ Name = Name })
		if Consult[1] then
			if vRP.TakeChest(Passport,"Warehouse:"..Name,Amount,Slot,Target,true) then
				TriggerClientEvent("inventory:Update",source)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount,Name)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.UpdateChest(Passport,"Warehouse:"..Name,Slot,Target,Amount,true) then
			TriggerClientEvent("inventory:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Warehouses = {}
	local Consult = vRP.Query("warehouse/All")

	for _,v in pairs(Consult) do
		local Name = v["Name"]
		if (v["Tax"] + 604800) <= os.time() then
			vRP.Query("warehouse/Sell",{ Name = Name })
			vRP.Query("entitydata/RemoveData",{ Name = "Warehouse:"..Name })
		else
			Warehouses[Name] = true
		end
	end

	GlobalState:set("Warehouses",Warehouses,true)
end)