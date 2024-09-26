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
Hensa = {}
Tunnel.bindInterface("trunkchest",Hensa)
vINVENTORY = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicle = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
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

		local Vehicles = {}
		local Result = vRP.GetServerData(Vehicle[Passport]["Data"],true)
		for Index,v in pairs(Result) do
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

			Vehicles[Index] = v
		end

		return Inventory,Vehicles,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
local Store = {
	["ratloader"] = {
		["woodlog"] = true
	},
	["stockade"] = {
		["pouch"] = true
	},
	["trash"] = {
		["recyclable"] = true
	},
	["towtruck"] = {
		["tyres"] = true,
		["toolbox"] = true,
		["advtoolbox"] = true
	},
	["towtruck2"] = {
		["tyres"] = true,
		["toolbox"] = true,
		["advtoolbox"] = true
	},
	["flatbed"] = {
		["tyres"] = true,
		["toolbox"] = true,
		["advtoolbox"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKED
-----------------------------------------------------------------------------------------------------------------------------------------
local Blocked = {
	["foodbox"] = true,
	["dollars"] = true,
	["dollars2"] = true,
	["dollars3"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if vRP.UpdateChest(Passport,Vehicle[Passport]["Data"],Slot,Target,Amount) then
			TriggerClientEvent("trunkchest:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		local Name = Vehicle[Passport]["Model"]

		if (Store[Name] and not Store[Name][Item]) or Blocked[Item] or ItemBlock(Item) then
			TriggerClientEvent("trunkchest:Update",source)
			TriggerClientEvent("Notify",source,"Aviso","Armazenamento proibido.","amarelo",5000)
			return
		end

		if vRP.StoreChest(Passport,Vehicle[Passport]["Data"],Amount,Vehicle[Passport]["Weight"],Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source)
		else
			if Vehicle[Passport] then
				local Result = vRP.GetServerData(Vehicle[Passport]["Data"])
				TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if vRP.TakeChest(Passport,Vehicle[Passport]["Data"],Amount,Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source)
		else
			if Vehicle[Passport] then
				local Result = vRP.GetServerData(Vehicle[Passport]["Data"])
				TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Close()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] and Vehicle[Passport]["Net"] then
		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				if Vehicle[Passport] and Vehicle[Passport]["Net"] then
					TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"close")
				end
			end)
		end

		Vehicle[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and VehicleWeight(Entity[2]) > 0 then
		local PassportPlate = vRP.PassportPlate(Entity[1])
		if PassportPlate and (vRP.HasService(Passport,"Policia") or PassportPlate["Passport"] == Passport or vRP.InventoryFull(Passport,"vehkey-"..Entity[1])) then
			Vehicle[Passport] = {
				["Net"] = Entity[4],
				["Plate"] = Entity[1],
				["Model"] = Entity[2],
				["User"] = PassportPlate["Passport"],
				["Weight"] = VehicleWeight(Entity[2]),
				["Data"] = "Trunkchest:"..PassportPlate["Passport"]..":"..Entity[2]
			}

			local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])

			if GetVehicleDoorLockStatus(Network) <= 1 then
				TriggerClientEvent("trunkchest:Open",source)

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						if Vehicle[Passport] and Vehicle[Passport]["Net"] then
							TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"open")
						end
					end)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Veículo trancado.","Atenção",5000)
				Vehicle[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORCETRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:forceTrunk")
AddEventHandler("trunkchest:forceTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and VehicleWeight(Entity[2]) > 0 then
		local PassportPlate = vRP.PassportPlate(Entity[1])
		if PassportPlate then
			local Service,Total = vRP.NumPermission("Policia")
			if Total >= 2 then
				if not vINVENTORY.CheckWeapon(source,"WEAPON_CROWBAR") then
					TriggerClientEvent("Notify",source,"amarelo","Você precisa colocar o <b>"..ItemName("WEAPON_CROWBAR").."</b> em mãos.","Atenção",5000)
					return
				end

				Vehicle[Passport] = {
					["Net"] = Entity[4],
					["Plate"] = Entity[1],
					["Model"] = Entity[2],
					["User"] = PassportPlate["Passport"],
					["Weight"] = VehicleWeight(Entity[2]),
					["Data"] = "Trunkchest:"..PassportPlate["Passport"]..":"..Entity[2]
				}

				local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])

				if GetVehicleDoorLockStatus(Network) == 2 then
					vRPC.PlayAnim(source,false,{ "amb@prop_human_bum_bin@base", "base" },true)
					
					if vRP.Task(source,10,75000) then
						TriggerClientEvent("trunkchest:Open",source)

						local Coords = vRP.GetEntityCoords(source)
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo a Porta-malas", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 22 })
							end)
						end

						local Players = vRPC.Players(source)
						for _,v in pairs(Players) do
							async(function()
								if Vehicle[Passport] and Vehicle[Passport]["Net"] then
									TriggerClientEvent("player:VehicleDoors",v,Vehicle[Passport]["Net"],"open")
								end
							end)
						end
					else
						vRPC.StopAnim(source,false)
					end
				else
					Vehicle[Passport] = nil
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Contingente indisponível.","Atenção",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Vehicle[Passport] then
		Vehicle[Passport] = nil
	end
end)