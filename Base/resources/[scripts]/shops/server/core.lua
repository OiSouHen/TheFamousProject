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
Tunnel.bindInterface("shops", Hensa)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MALENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local MaleName = { "James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas", "Christopher", "Daniel", "Paul", "Mark", "Donald", "George", "Kenneth", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin", "Jason", "Matthew", "Gary", "Timothy", "Jose", "Larry", "Jeffrey", "Frank", "Scott", "Eric", "Stephen", "Andrew", "Raymond", "Gregory", "Joshua", "Jerry", "Dennis", "Walter", "Patrick", "Peter", "Harold", "Douglas", "Henry", "Carl", "Arthur", "Ryan", "Roger", "Joe", "Juan", "Jack", "Albert", "Jonathan", "Justin", "Terry", "Gerald", "Keith", "Samuel", "Willie", "Ralph", "Lawrence", "Nicholas", "Roy", "Benjamin", "Bruce", "Brandon", "Adam", "Harry", "Fred", "Wayne", "Billy", "Steve", "Louis", "Jeremy", "Aaron", "Randy", "Howard", "Eugene", "Carlos", "Russell", "Bobby", "Victor", "Martin", "Ernest", "Phillip", "Todd", "Jesse", "Craig", "Alan", "Shawn", "Clarence", "Sean", "Philip", "Chris", "Johnny", "Earl", "Jimmy", "Antonio" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- FEMALENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local FemaleName = { "Mary", "Patricia", "Linda", "Barbara", "Elizabeth", "Jennifer", "Maria", "Susan", "Margaret", "Dorothy", "Lisa", "Nancy", "Karen", "Betty", "Helen", "Sandra", "Donna", "Carol", "Ruth", "Sharon", "Michelle", "Laura", "Sarah", "Kimberly", "Deborah", "Jessica", "Shirley", "Cynthia", "Angela", "Melissa", "Brenda", "Amy", "Anna", "Rebecca", "Virginia", "Kathleen", "Pamela", "Martha", "Debra", "Amanda", "Stephanie", "Carolyn", "Christine", "Marie", "Janet", "Catherine", "Frances", "Ann", "Joyce", "Diane", "Alice", "Julie", "Heather", "Teresa", "Doris", "Gloria", "Evelyn", "Jean", "Cheryl", "Mildred", "Katherine", "Joan", "Ashley", "Judith", "Rose", "Janice", "Kelly", "Nicole", "Judy", "Christina", "Kathy", "Theresa", "Beverly", "Denise", "Tammy", "Irene", "Jane", "Lori", "Rachel", "Marilyn", "Andrea", "Kathryn", "Louise", "Sara", "Anne", "Jacqueline", "Wanda", "Bonnie", "Julia", "Ruby", "Lois", "Tina", "Phyllis", "Norma", "Paula", "Diana", "Annie", "Lillian", "Emily", "Robin" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
local RandomName = { "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if exports["bank"]:CheckFines(Passport) or exports["bank"]:CheckTaxs(Passport) then
			TriggerClientEvent("Notify",source,"amarelo","Você está temporariamente proibido de utilizar esse sistema por pendências com o <b>Banco</b>.","Atenção",5000)
			return false
		end

		if List[Type] and List[Type]["Permission"] and not vRP.HasService(Passport,List[Type]["Permission"]) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Connecteds(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Service,Total = vRP.NumPermission(Permission)
		if Total == 0 then
			return true
		else
			TriggerClientEvent("Notify",source,"amarelo","Existem <b>"..Permission.."s</b> em serviço, você precisa procurar alguém para receber atendimento.","Atenção",5000)
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Name] then
			local Shop = {}
			local Slots = 20
			for Index,v in pairs(List[Name]["List"]) do
				Shop[#Shop + 1] = { key = Index, price = parseInt(v), name = ItemName(Index), index = ItemIndex(Index), peso = ItemWeight(Index) }
			end

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

			if parseInt(#Shop) > 20 then
				Slots = parseInt(#Shop)
			end

			return Shop,Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),Slots
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.ShopType(Type)
	if List[Type] and List[Type]["Mode"] then
		return List[Type]["Mode"]
	end

	return "Buy"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and List[Type] then
		if Amount > 1 and ItemUnique(Item) then
			Amount = 1
		end

		local Inv = vRP.Inventory(Passport)
		if (Inv[Slot] and Inv[Slot]["item"] == Item) or not Inv[Slot] then
			if List[Type]["Mode"] == "Buy" then
				if vRP.MaxItens(Passport,Item,Amount) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
					vCLIENT.Update(source,"Request")

					return false
				end

				if (vRP.InventoryWeight(Passport) + ItemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
					if List[Type]["Type"] == "Cash" then
						if List[Type]["List"][Item] then
							if vRP.PaymentFull(Passport,List[Type]["List"][Item] * Amount) then
								if ItemType(Item) == "Armamento" then
									vRP.GiveItem(Passport,Item.."-"..os.time().."-"..Passport,1,false,Slot)
									exports["bank"]:AddTaxs(Passport,source,"Prefeitura",List[Type]["List"][Item] * Amount,"Registro de Armamento.")
								-- elseif ItemMode(Item) == "Chest" then
									-- vRP.GiveItem(Passport,Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport),1,false,Slot)
								elseif Item == "identity" then
									vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)
									exports["bank"]:AddTaxs(Passport,source,"Prefeitura",List[Type]["List"][Item] * Amount,"Emissão de Identidade.")
								elseif Item == "fidentity" then
									local Identity = vRP.Identity(Passport)
									if Identity then
										if Identity["Sex"] == "M" then
											vRP.Query("fidentity/NewIdentity",{ Name = MaleName[math.random(#MaleName)], Lastname = RandomName[math.random(#RandomName)], Blood = math.random(4) })
										else
											vRP.Query("fidentity/NewIdentity",{ Name = FemaleName[math.random(#FemaleName)], Lastname = RandomName[math.random(#RandomName)], Blood = math.random(4) })
										end

										local Consult = vRP.Query("fidentity/GetIdentity")
										if Consult[1] then
											vRP.GiveItem(Passport,Item.."-"..Consult[1]["id"],Amount,false,Slot)
										end
									end
								elseif Item == "cnh" then
									vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)
									exports["bank"]:AddTaxs(Passport,source,"Prefeitura",List[Type]["List"][Item] * Amount,"Emissão de Habilitação.")
								elseif ItemNeed(Item) then
									if vRP.TakeItem(Passport,ItemNeed(Item),Amount,false) then
										vRP.GiveItem(Passport,Item,Amount,false,Slot)
									else
										TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>"..Dotted(Amount).."x "..ItemName(ItemNeed(Item)).."</b>.","Atenção",5000)
										return
									end
								else
									vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								end

								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,List[Type]["Item"],parseInt(List[Type]["List"][Item] * Amount)) then
							vRP.GenerateItem(Passport,Item,Amount,false,Slot)
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>"..ItemName(List[Type]["Item"]).."</b> insuficiente.","Atenção",5000)
						end
					elseif List[Type]["Type"] == "Premium" then
						if vRP.PaymentGems(Passport,List[Type]["List"][Item] * Amount) then
							TriggerClientEvent("sounds:Private",source,"cash",0.1)

							-- if ItemMode(Item) == "Chest" then
								-- vRP.GiveItem(Passport,Item.."-"..os.time().."-"..(math.random(1000,5000) + Passport),1,false,Slot)
							-- else
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
							-- end
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>" .. ItemName("gemstone") .. "</b> insuficientes.","Atenção",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.","Aviso",5000)
				end
			elseif List[Type]["Mode"] == "Sell" then
				local Split = splitString(Item)[1]

				if List[Type]["List"][Split] then
					local ItemPrice = List[Type]["List"][Split]

					if ItemPrice > 0 and vRP.CheckDamaged(Item) then
						TriggerClientEvent("Notify",source,"amarelo","Itens danificados não podem ser vendidos.","Atenção",5000)
						vCLIENT.Update(source,"Request")

						return false
					end

					if List[Type]["Type"] == "Cash" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if ItemPrice > 0 then
								vRP.GenerateItem(Passport,"dollars",parseInt(ItemPrice * Amount),false)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Illegal" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if ItemPrice > 0 then
								vRP.GenerateItem(Passport,"dollars2",parseInt(ItemPrice * Amount),false)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if ItemPrice > 0 then
								vRP.GenerateItem(Passport,List[Type]["Item"],parseInt(ItemPrice * Amount),false)
							end
						end
					end
				end
			end
		end

		vCLIENT.Update(source,"Request")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.Update(source,"Request")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		local Inv = vRP.Inventory(Passport)
		if Inv[Slot] and Inv[Target] and Inv[Slot]["item"] == Inv[Target]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		vCLIENT.Update(source,"Request")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyOxigen")
AddEventHandler("shops:BuyOxigen",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Loja de Oxigênio","Comprar a <b>"..ItemName("scuba").."</b> pagando <b>$975</b>?") then
			if vRP.PaymentFull(Passport,975) then
				vRP.GenerateItem(Passport,"scuba",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYCYLINDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyCylinder")
AddEventHandler("shops:BuyCylinder",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Loja de Oxigênio","Comprar o <b>"..ItemName("oxygencylinder").."</b> pagando <b>$2.550</b>?") then
			if vRP.PaymentFull(Passport,2550) then
				vRP.GenerateItem(Passport,"oxygencylinder",1,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BUYGASOLINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:BuyGasoline")
AddEventHandler("shops:BuyGasoline",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Posto de Gasolina", "Comprar <b>1x "..ItemName("WEAPON_PETROLCAN").."</b> com <b>4.500 Litros</b> pagando <b>$375 "..ItemName("dollars").."</b>?") then
			if vRP.PaymentFull(Passport,375) then
				vRP.GenerateItem(Passport,"WEAPON_PETROLCAN",1,true)
				vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SELLOIL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:SellOil")
AddEventHandler("shops:SellOil",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.Request(source,"Posto de Gasolina","Vender <b>1x "..ItemName("oilgallon").."</b> por <b>$875 "..ItemName("dollars").."</b>?") then
			if vRP.TakeItem(Passport,"oilgallon",1,true) then
				vRP.GenerateItem(Passport,"dollars",875,true)
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não tem <b>1x "..ItemName("oilgallon").."</b>.","Atenção",5000)
			end
		end
	end
end)