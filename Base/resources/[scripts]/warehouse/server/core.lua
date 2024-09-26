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
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ Name = Name })
		if Warehouse[1] and Warehouse[1]["Passport"] == Passport then
			local Keyboard = vKEYBOARD.Primary(source,"Passaporte")
			if Keyboard and vRP.Request(source,"Armazém","Deseja transferir o <b>Armazém</b> para o passaporte <b>"..Keyboard[1].."</b>?") then
				vRP.Query("warehouse/Transfer",{ Passport = Keyboard[1], Name = Name })
				TriggerClientEvent("Notify",source,"verde","Armazém transferido.","Sucesso",5000)
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
				local Password = sanitizeString(Keyboard[1],"0123456789",true)
				if string.len(Password) >= 4 and string.len(Password) <= 20 then
					vRP.Query("warehouse/Password",{ Name = Name, Password = Password })
					TriggerClientEvent("Notify",source,"verde","Senha atualizada.","Sucesso",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.","Atenção",5000)
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
	if Passport then
		local Consult = vRP.Query("warehouse/Informations",{ Name = Name })
		if Consult[1] then
			if Consult[1]["Tax"] < os.time() then
				if Consult[1]["Passport"] == Passport and vRP.Request(source,"Armazém","Deseja efetuar o pagamento do aluguel de <b>$30.000</b>?") then
					if vRP.PaymentFull(Passport,30000) then
						vRP.Query("warehouse/Tax",{ Name = Name })

						return true
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
						TriggerClientEvent("Notify",source,"vermelho","Senha incorreta.","Aviso",5000)
					end
				end
			end
		else
			if vRP.Request(source,"Armazém","Gostaria de comprar o armazém por <b>$100.000</b>?") then
				local Keyboard = vKEYBOARD.Password(source,"Senha")
				if Keyboard then
					local Password = sanitizeString(Keyboard[1],"0123456789",true)
					if string.len(Password) >= 4 and string.len(Password) <= 20 then
						if vRP.Request(source,"Armazém","Finalizar a compra usando a senha <b>"..Password.."</b>?") then
							if vRP.PaymentFull(Passport,100000) then
								local Warehouses = GlobalState["Warehouses"]
								Warehouses[Name] = true
								GlobalState:set("Warehouses",Warehouses,true)

								exports["bank"]:AddTaxs(Passport,source,"Prefeitura",100000,"Compra de armazém.")

								vRP.Query("warehouse/Buy",{ Name = Name, Passport = Passport, Password = Password })

								return true
							end
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.","Atenção",5000)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["name"] = ItemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>"..v["name"].."</item>"

			local Split = splitString(v["item"])
			local Description = ItemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Passport"] = Number
						v["Medic"] = "Inativo"
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Name"] = vRP.FullName(Number)
						v["Work"] = ClassWork(Identity["Work"])
						v["Blood"] = Sanguine(Identity["Blood"])

						if Identity["Gun"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["Premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
							end

							if Identity["Medic"] > os.time() then
								v["Medic"] = MinimalTimers(Identity["Medic"] - os.time())
							end

							if Identity["Rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
						else
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Emprego: <green>"..v["Work"].."</green><br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.<br>Plano Médico: <green>"..v["Medic"].."</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["Name"].." "..Identity["Lastname"]

						if Number == Passport then
							if Identity["Driver"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["Driver"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..Dotted(vRP.GetBank(source)).."</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if ItemType(Split[1]) == "Armamento" and Split[3] then
					v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
				end

				if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
					v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedclone2" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
				end
			end

			local Max = ItemMaxAmount(v["item"])
			if not Max then
				Max = "Ilimitado"
			end

			v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..ItemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

			if Split[2] then
				if ItemLoads(v["item"]) then
					v["charges"] = parseInt(Split[2] * 33)
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			Inventory[Index] = v
		end

		local myWarehouse = {}
		local Consult = vRP.GetServerData("Warehouse:"..Name)
		for Index,v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["peso"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["name"] = ItemName(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			v["desc"] = "<item>"..v["name"].."</item>"

			local Split = splitString(v["item"])
			local Description = ItemDescription(v["item"])

			if Description then
				v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
			else
				if Split[1] == "identity" or Split[1] == "fidentity" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)

					if Split[1] == "fidentity" then
						Identity = vRP.FalseIdentity(Number)
					end

					if Identity then
						v["Port"] = "Não"
						v["Passport"] = Number
						v["Medic"] = "Inativo"
						v["Premium"] = "Inativo"
						v["Rolepass"] = "Inativo"
						v["Name"] = vRP.FullName(Number)
						v["Work"] = ClassWork(Identity["Work"])
						v["Blood"] = Sanguine(Identity["Blood"])

						if Identity["Gun"] == 1 then
							v["Port"] = "Sim"
						end

						if Number == Passport and Split[1] == "identity" then
							if Identity["Premium"] > os.time() then
								v["Premium"] = MinimalTimers(Identity["Premium"] - os.time())
							end

							if Identity["Medic"] > os.time() then
								v["Medic"] = MinimalTimers(Identity["Medic"] - os.time())
							end

							if Identity["Rolepass"] > 0 then
								v["Rolepass"] = "Ativo"
							end
						end

						if Split[1] == "fidentity" then
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.</description>"
						else
							v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Emprego: <green>"..v["Work"].."</green><br>Tipo Sangüineo: <green>"..v["Blood"].."</green>.<br>Porte de Armas: <green>"..v["Port"].."</green>.<br>Passe Mensal: <green>"..v["Rolepass"].."</green>.<br>Premium: <green>"..v["Premium"].."</green>.<br>Plano Médico: <green>"..v["Medic"].."</green>.</description>"
						end
					end
				end

				if Split[1] == "cnh" then
					local Number = parseInt(Split[2])
					local Identity = vRP.Identity(Number)
					if Identity then
						v["Passport"] = Number
						v["Driverlicense"] = "Inativa"
						v["Name"] = Identity["Name"].." "..Identity["Lastname"]

						if Number == Passport then
							if Identity["Driver"] == 1 then
								v["Driverlicense"] = "Ativa"
							elseif Identity["Driver"] == 2 then
								v["Driverlicense"] = "Apreendida"
							end
						end

						v["desc"] = v["desc"].."<br><description>Número: <green>"..v["Passport"].."</green>.<br>Nome: <green>"..v["Name"].."</green>.<br>Habilitação: <green>"..v["Driverlicense"].."</green>.</description>"
					end
				end

				if Split[1] == "vehkey" then
					v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green>.</description>"
				end

				if Split[1] == "bankcard" then
					v["desc"] = v["desc"].."<br><description>Saldo bancário disponível: <green>$"..Dotted(vRP.GetBank(source)).."</green>.</description>"
				end

				if Split[1] == "notepad" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if Split[1] == "paper" and Split[2] then
					v["desc"] = v["desc"].."<br><description>"..vRP.GetServerData(v["item"])..".</description>"
				end

				if ItemType(Split[1]) == "Armamento" and Split[3] then
					v["desc"] = v["desc"].."<br><description>Nome de registro: <green>"..vRP.FullName(Split[3]).."</green>.</description>"
				end

				if Split[1] == "evidence01" or Split[1] == "evidence02" or Split[1] == "evidence03" or Split[1] == "evidence04" and Split[2] then
					v["desc"] = v["desc"].."<br><description>Tipo sanguíneo encontrado: <green>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</green>.</description>"
				end

				if Split[1] == "weedclone" or Split[1] == "weedclone2" or Split[1] == "weedbud" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedbud" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = v["desc"].."<br><description>A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>.</description>"
				end
			end

			local Max = ItemMaxAmount(v["item"])
			if not Max then
				Max = "Ilimitado"
			end

			v["desc"] = v["desc"].."<br><legenda>Economia: <r>"..ItemEconomy(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

			if Split[2] then
				if ItemLoads(v["item"]) then
					v["charges"] = parseInt(Split[2] * 33)
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			myWarehouse[Index] = v
		end

		local Warehouse = vRP.Query("warehouse/Informations",{ Name = Name })
		if Warehouse[1] then
			return Inventory,myWarehouse,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Consult),Warehouse[1]["Weight"]
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
		if ItemBlock(Item) then
			TriggerClientEvent("warehouse:Update",source)

			return false
		end

		local Consult = vRP.Query("warehouse/Informations",{ Name = Name })
		if Consult[1] then
			if Item == "diagram" then
				if vRP.TakeItem(Passport,Item,Amount,false) then
					vRP.Query("warehouse/Upgrade",{ Name = Name, Multiplier = Amount })
					TriggerClientEvent("warehouse:Update",source)
				end
			else
				if vRP.StoreChest(Passport,"Warehouse:"..Name,Amount,Consult[1]["Weight"],Slot,Target) then
					TriggerClientEvent("warehouse:Update",source)
				else
					local Result = vRP.GetServerData("Warehouse:"..Name)
					TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1]["Weight"])
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
				TriggerClientEvent("warehouse:Update",source)
			else
				local Result = vRP.GetServerData("Warehouse:"..Name)
				TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1]["Weight"])
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
		if vRP.UpdateChest(Passport,"Warehouse:"..Name,Slot,Target,Amount) then
			TriggerClientEvent("warehouse:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

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