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
-- GLOBALSTATES
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
		TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..CompleteTimers(Robbery[Name][Number] - os.time()).."</b>.",false,5000)

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
		TriggerEvent("Wanted",source,Passport,300)

		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
				TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a Propriedade", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 44 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.PaymentRobbery(Name, Number)
	local source = source
	local playerPassport = vRP.Passport(source)
	if playerPassport and Robbery[Name] and os.time() >= Robbery[Name][Number] then
		local randomIndex = math.random(#RobberyItem)
		local robberyItem = RobberyItem[randomIndex]
		local valuation = math.random(robberyItem["Min"], robberyItem["Max"])

		local totalWeight = vRP.InventoryWeight(playerPassport) + ItemWeight(robberyItem["Item"]) * valuation
		local maxWeight = vRP.GetWeight(playerPassport)

		if totalWeight <= maxWeight then
			local buffs = exports["inventory"]:Buffs("Luck", playerPassport)

			if buffs and buffs > os.time() and math.random(100) >= 90 then
				valuation = valuation * 2
			end

			vRP.GenerateItem(playerPassport, robberyItem["Item"], valuation, true)
			vRP.UpgradeStress(playerPassport, math.random(3, 6))
			Robbery[Name][Number] = os.time() + 3600
		else
			TriggerClientEvent("Notify", source, "vermelho", "Mochila cheia.", "Aviso", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Propertys(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if exports["bank"]:CheckFines(Passport) or exports["bank"]:CheckTaxs(Passport) then
			TriggerClientEvent("Notify",source,"amarelo","Você está temporariamente proibido de utilizar esse sistema por pendências com o <b>Banco</b>.","Atenção",5000)
			return false
		end

		if Name == "Hotel" then
			local Consult = vRP.Query("propertys/Count",{ Passport = Passport })
			if Consult[1] then
				local Count = Consult[1]["COUNT(Passport)"]
				if Count == 0 then
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
							TriggerClientEvent("Notify",source,"verde","Pagamento concluído.","Sucesso",5000)
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
	if Passport then
		local Name,Interior,Mode = Split[1],Split[2],Split[3]

		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if not Consult[1] then
			TriggerClientEvent("dynamic:Close",source)

			if vRP.Request(source,"Propriedades","Deseja comprar a propriedade?") then
				local Serial = PropertysSerials()

				if Mode == "Dollars" then
					if vRP.PaymentFull(Passport,Informations[Interior]["Price"]) then
						local Markers = GlobalState["Markers"]
						Markers[Name] = true
						GlobalState:set("Markers",Markers,true)

						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						TriggerClientEvent("Notify",source,"verde","Compra concluída.","Sucesso",5000)
						exports["bank"]:AddTaxs(Passport,source,"Propriedades",Informations[Interior]["Price"],"Compra de propriedade.")
						vRP.Query("propertys/Buy",{ Name = Name, Interior = Interior, Passport = Passport, Serial = Serial, Vault = Informations[Interior]["Vault"], Fridge = Informations[Interior]["Fridge"], Tax = os.time() + 2592000 })
					end
				elseif Mode == "Gemstone" then
					if vRP.PaymentGems(Passport,Informations[Interior]["Gemstone"]) then
						local Markers = GlobalState["Markers"]
						Markers[Name] = true
						GlobalState:set("Markers",Markers,true)

						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						TriggerClientEvent("Notify",source,"verde","Compra concluída.","Sucesso",5000)
						vRP.Query("propertys/Buy",{ Name = Name, Interior = Interior, Passport = Passport, Serial = Serial, Vault = Informations[Interior]["Vault"], Fridge = Informations[Interior]["Fridge"], Tax = os.time() + 31104000 })
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.","Aviso",5000)
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
			TriggerClientEvent("Notify",source,"verde","Propriedade trancada.","Sucesso",5000)
		else
			Lock[Name] = true
			TriggerClientEvent("Notify",source,"vermelho","Propriedade destrancada.","Aviso",5000)
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
				vRP.RemoveServerData("Vault:"..Name,true)
				vRP.RemoveServerData("Fridge:"..Name,true)
				vRP.Query("propertys/Sell",{ Name = Name })
				TriggerClientEvent("garages:Clean",-1,Name)
				TriggerClientEvent("Notify",source,"verde","Venda concluída.","Sucesso",5000)
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
	if Passport and not Actived[Passport] then
		Actived[Passport] = true

		local Consult = vRP.Query("propertys/Exist",{ Name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			TriggerClientEvent("dynamic:Close",source)

			local Keyboard = vKEYBOARD.Primary(source,"Passaporte")
			if Keyboard and vRP.Identity(Keyboard[1]) and vRP.Request(source,"Propriedades","Deseja trasnferir a propriedade para passaporte <b>"..Keyboard[1].."</b>?") then
				vRP.Query("propertys/Transfer",{ Name = Name, Passport = Keyboard[1] })
				TriggerClientEvent("Notify",source,"verde","Transferência concluída.","Sucesso",5000)
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
		local Consult = vRP.GetServerData("Wardrobe:"..Passport,true)

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
		local Consult = vRP.GetServerData("Wardrobe:"..Passport,true)
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
					TriggerClientEvent("Notify",source,"verde","<b>"..Check.."</b> adicionado.","Sucesso",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Nome escolhido já existe em seu armário.","Atenção",5000)
				end
			end
		elseif Split[1] == "delete" then
			if Consult[Name] then
				Consult[Name] = nil
				vRP.SetServerData("Wardrobe:"..Passport,Consult)
				TriggerClientEvent("propertys:ClothesReset",source)
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> removido.","Sucesso",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","A vestimenta salva não se encontra mais em seu armário.","Aviso",5000)
			end
		elseif Split[1] == "apply" then
			if Consult[Name] then
				TriggerClientEvent("skinshop:Apply",source,Consult[Name])
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> aplicado.","Sucesso",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","A vestimenta salva não se encontra mais em seu armário.","Aviso",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYSSERIALS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertysSerials()
	local Serial = vRP.GenerateString("LDLDLDLDLD")
	local Consult = vRP.Query("propertys/Serial",{ Serial = Serial })
	if Consult[1] then
		PropertysSerials()
	end

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
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request(Name,Mode)
	local Weight = 25
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			Name = "Hotel:"..Passport
		else
			Weight = vRP.Query("propertys/Exist",{ Name = Name })[1][Mode]
		end

		local Chest = {}
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		local Consult = vRP.GetServerData(Mode..":"..Name)

		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
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
									v["Premium"] = CompleteTimers(Identity["Premium"] - os.time())
								end

								if Identity["Medic"] > os.time() then
									v["Medic"] = CompleteTimers(Identity["Medic"] - os.time())
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
		end

		for Index,v in pairs(Consult) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				TriggerClientEvent("Notify", source, "vermelho", "Problema encontrado.", "Aviso", 5000)
			else
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
							v["Medic"] = "Inativo"
							v["Passport"] = Number
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
									v["Premium"] = CompleteTimers(Identity["Premium"] - os.time())
								end

								if Identity["Medic"] > os.time() then
									v["Medic"] = CompleteTimers(Identity["Medic"] - os.time())
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

				Chest[Index] = v
			end
		end

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Consult),Weight
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			if vRP.StoreChest(Passport,Mode..":Hotel:"..Passport,Amount,25,Slot,Target,true) then
				TriggerClientEvent("propertys:Update",source)
			else
				local Result = vRP.GetServerData(Mode..":Hotel:"..Passport,true)
				TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),25)
			end
		else
			local Consult = vRP.Query("propertys/Exist",{ Name = Name })
			if Consult[1] then
				if Item == "diagram" then
					if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
						vRP.Query("propertys/"..Mode,{ Name = Name, Weight = 10 * Amount })
						TriggerClientEvent("propertys:Update",source)
					end
				else
					if vRP.StoreChest(Passport,Mode..":"..Name,Amount,Consult[1][Mode],Slot,Target,true) then
						TriggerClientEvent("propertys:Update",source)
					else
						local Result = vRP.GetServerData(Mode..":"..Name,true)
						TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])
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
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			if vRP.TakeChest(Passport,Mode..":Hotel:"..Passport,Amount,Slot,Target,true) then
				TriggerClientEvent("propertys:Update",source)
			else
				local Result = vRP.GetServerData(Mode..":Hotel:"..Passport,true)
				TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),25)
			end
		else
			if vRP.TakeChest(Passport,Mode..":"..Name,Amount,Slot,Target,true) then
				TriggerClientEvent("propertys:Update",source)
			else
				local Consult = vRP.Query("propertys/Exist",{ Name = Name })
				if Consult[1] then
					local Result = vRP.GetServerData(Mode..":"..Name,true)
					TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Name == "Hotel" then
			Name = "Hotel:"..Passport
		end

		if vRP.UpdateChest(Passport,Mode..":"..Name,Slot,Target,Amount,true) then
			TriggerClientEvent("propertys:Update",source)
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
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	local Markers = {}
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