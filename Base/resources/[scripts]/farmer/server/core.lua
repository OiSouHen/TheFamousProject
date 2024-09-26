-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Itens = {}
local Active = {}
local Coal = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
for Number,v in pairs(Objects) do
	GlobalState["Farmer:"..Number] = 0

	if v["Event"] == "farmer:Minerman" then
		local Rand = math.random(#Minerman)
		GlobalState["FarmerObjects:"..Number] = Minerman[Rand]["Model"]
		Itens[Number] = Minerman[Rand]["Item"]
	else
		GlobalState["FarmerObjects:"..Number] = v["Model"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	local Tasks = 8
	local source = source
	local Detectable = false
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.GetWork(Passport) == "Minerman" then
			if not Number or type(Number) == "table" then
				exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
				Active[Passport] = true
				return false
			end

			if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				Active[Passport] = true

				if vRP.ConsultItem(Passport,"WEAPON_PICKAXE",1) then
					Detectable = "WEAPON_PICKAXE"
				end

				if vRP.ConsultItem(Passport,"WEAPON_PICKAXE_PLUS",1) then
					Detectable = "WEAPON_PICKAXE_PLUS"
					Tasks = 5
				end

				if Detectable then
					local Valuation = math.random(2,3)

					vRPC.CreateObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					if vRP.Task(source,Tasks,15000) then
						if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
							GlobalState["Farmer:"..Number] = GlobalState["Work"] + math.random(36,48)

							if math.random(100) >= 75 then
								Coal = true
							end

							local Experience = vRP.GetExperience(Passport,"Minerman")
							local Level = ClassCategory(Experience)

							if Level == 3 or Level == 4 or Level == 5 then
								Valuation = Valuation + 1
							elseif Level == 6 or Level == 7 or Level == 8 then
								Valuation = Valuation + 2
							elseif Level == 9 or Level == 10 then
								Valuation = Valuation + 3
							end

							local Members = exports["vrp"]:Party(Passport,source,20)
							if parseInt(#Members) >= 2 then
								Valuation = Valuation + (Valuation * 0.1)
							end

							local Buffs = exports["inventory"]:Buffs("Luck",Passport)
							if Buffs and Buffs > os.time() and math.random(100) >= 75 then
								Valuation = Valuation * 2
							end

							if (vRP.InventoryWeight(Passport) + ItemWeight(Itens[Number]) * Valuation) <= vRP.GetWeight(Passport) then
								vRP.GenerateItem(Passport,Itens[Number],Valuation,true)

								if Coal then
									vRP.GenerateItem(Passport,"coal",Valuation,true)
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
								exports["inventory"]:Drops(Passport,source,Items[Number],Valuation)

								if Coal then
									exports["inventory"]:Drops(Passport,source,"coal",Valuation)
								end
							end

							vRP.PutExperience(Passport,"Minerman",1)
							vRP.UpgradeStress(Passport,5)

							vRP.GiveLikes(Passport, 1)
							TriggerClientEvent("Notify", source, "roxo", "Você conseguiu <b>+ 1</b> Voto <b>Positivo</b>.", "Reputação", 5000)

							local Rand = math.random(#Minerman)
							GlobalState["FarmerObjects:"..Number] = Minerman[Rand]["Model"]
							Itens[Number] = Minerman[Rand]["Item"]
						end
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Picareta</b> não encontrada.","Aviso",5000)
				end

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Minerman").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRUITMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruitman")
AddEventHandler("farmer:Fruitman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.GetWork(Passport) == "Fruitman" then
			if not Number or type(Number) == "table" then
				exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
				Active[Passport] = true
				return false
			end

			if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if DoesEntityExist(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
					local Select = math.random(#Items)
					local Valuation = math.random(3,5)

					vRPC.PlayAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Colhendo",11000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

						local Members = exports["vrp"]:Party(Passport,source,20)
						if parseInt(#Members) >= 2 then
							Valuation = Valuation + (Valuation * 0.1)
						end

						local Buffs = exports["inventory"]:Buffs("Luck",Passport)
						if Buffs and Buffs > os.time() and math.random(100) >= 90 then
							Valuation = Valuation * 2
						end

						if (vRP.InventoryWeight(Passport) + ItemWeight(Items[Select]) * Valuation) <= vRP.GetWeight(Passport) then
							vRP.GenerateItem(Passport,Items[Select],Valuation,true)
						else
							TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
							exports["inventory"]:Drops(Passport,source,Items[Select],Valuation)
						end

						vRP.UpgradeStress(Passport,math.random(2,4))
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>"..ItemName("WEAPON_HATCHET").."</b> não encontrado.","Aviso",5000)
				end

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Fruitman").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.GetWork(Passport) == "Lumberman" then
			if not Number or type(Number) == "table" then
				exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
				Active[Passport] = true
				return false
			end

			if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if DoesEntityExist(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Valuation = math.random(3,5)

					vRPC.PlayAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Cortando",11000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

						local Members = exports["vrp"]:Party(Passport,source,20)
						if parseInt(#Members) >= 2 then
							Valuation = Valuation + (Valuation * 0.1)
						end

						local Buffs = exports["inventory"]:Buffs("Luck",Passport)
						if Buffs and Buffs > os.time() and math.random(100) >= 90 then
							Valuation = Valuation * 2
						end

						if (vRP.InventoryWeight(Passport) + ItemWeight("woodlog") * Valuation) <= vRP.GetWeight(Passport) then
							vRP.GenerateItem(Passport,"woodlog",Valuation,true)
						else
							TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
							exports["inventory"]:Drops(Passport,source,"woodlog",Valuation)
						end

						vRP.UpgradeStress(Passport,math.random(2,4))
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>"..ItemName("WEAPON_HATCHET").."</b> não encontrado.","Aviso",5000)
				end

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Lumberman").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.GetWork(Passport) == "Transporter" then
			if not Number or type(Number) == "table" then
				exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
				Active[Passport] = true
				return false
			end

			if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				Active[Passport] = true

				vRPC.PlayAnim(source,false,{"pickup_object","pickup_low"},true)
				TriggerClientEvent("Progress",source,"Coletando",1000)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				Wait(1000)

				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 6

					local Valuation = 1
					local Members = exports["vrp"]:Party(Passport,source,20)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end

					local Buffs = exports["inventory"]:Buffs("Luck",Passport)
					if Buffs and Buffs > os.time() and math.random(100) >= 90 then
						Valuation = Valuation * 2
					end

					if (vRP.InventoryWeight(Passport) + ItemWeight("pouch")) <= vRP.GetWeight(Passport) then
						vRP.GenerateItem(Passport,"pouch",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
						exports["inventory"]:Drops(Passport,source,"pouch",Valuation)
					end

					vRP.UpgradeStress(Passport,math.random(2))
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Transporter").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Diver")
AddEventHandler("farmer:Diver",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.GetWork(Passport) == "Diver" then
			if not Number or type(Number) == "table" then
				exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
				Active[Passport] = true
				return false
			end

			if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				Active[Passport] = true

				vRPC.PlayAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)
				TriggerClientEvent("Progress",source,"Coletando",30000)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				Wait(30000)

				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + math.random(15,30)

					local Valuation = 1
					local Members = exports["vrp"]:Party(Passport,source,20)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end

					local Buffs = exports["inventory"]:Buffs("Luck",Passport)
					if Buffs and Buffs > os.time() and math.random(100) >= 90 then
						Valuation = Valuation * 2
					end

					if (vRP.InventoryWeight(Passport) + ItemWeight("woodenbarrel")) <= vRP.GetWeight(Passport) then
						vRP.GenerateItem(Passport,"woodenbarrel",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
						exports["inventory"]:Drops(Passport,source,"woodenbarrel",Valuation)
					end

					vRP.UpgradeStress(Passport,math.random(2,4))
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)

				Active[Passport] = nil
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Diver").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Farmer")
AddEventHandler("farmer:Farmer",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRPC.LastVehicle(source,"tractor2") then
			if vRP.GetWork(Passport) == "Farmer" then
				if not Number or type(Number) == "table" then
					exports["vrp"]:Embed("Payments","**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",3092790)
					Active[Passport] = true
					return false
				end

				if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					Active[Passport] = true

					vRPC.PlayAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer" },true)
					TriggerClientEvent("Progress",source,"Coletando",15000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					Wait(15000)

					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + math.random(10,20)

						local Valuation = 1
						local Members = exports["vrp"]:Party(Passport,source,20)
						if parseInt(#Members) >= 2 then
							Valuation = Valuation + (Valuation * 0.1)
						end

						local Buffs = exports["inventory"]:Buffs("Luck",Passport)
						if Buffs and Buffs > os.time() and math.random(100) >= 90 then
							Valuation = Valuation * 2
						end

						if (vRP.InventoryWeight(Passport) + ItemWeight("corn")) <= vRP.GetWeight(Passport) then
							vRP.GenerateItem(Passport,"corn",Valuation,true)
						else
							TriggerClientEvent("Notify",source,"amarelo","Sua recompensa caiu no chão.","Mochila Sobrecarregada",5000)
							exports["inventory"]:Drops(Passport,source,"corn",Valuation)
						end

						vRP.UpgradeStress(Passport,math.random(2,4))
					end

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)

					Active[Passport] = nil
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Você precisa ter a sua <b>Carteira de Trabalho</b> assinada no emprego de <b>"..ClassWork("Farmer").."</b> para conseguir trabalhar aqui.", "Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Para colher o <b>"..ItemName("corn").."</b> você precisa estar com o veículo do emprego de <b>"..ClassWork("Farmer").."</b>.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)