-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
Use = {
	["bandage"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Passando",5000)
				vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerClientEvent("sounds:Private",source,"bandage",0.5)
							Healths[Passport] = os.time() + 30
							vRP.UpgradeStress(Passport,10)
							vRPC.UpgradeHealth(source,15)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify",source,"Atenção","Não pode utilizar de vida cheia.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Healths[Passport] - os.time())..".","amarelo",5000)
		end
	end,

	["analgesic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",3000)
				vRPC.PlayAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 15
							vRP.UpgradeStress(Passport,5)
							vRPC.UpgradeHealth(source,8)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify",source,"Aviso","Não pode utilizar de vida cheia.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Healths[Passport] - os.time())..".","amarelo",5000)
		end
	end,

	["odb2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRPC.InsideVehicle(source) then
			TriggerClientEvent("notebook:Open",source)
			TriggerClientEvent("inventory:Close",source)
		end
	end,

	["vehkey"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Vehicle,Network,Plate = vRPC.VehicleList(source)
		if Vehicle and Plate == Split[2] then
			TriggerEvent("garages:LockVehicle",source,Network)
		end
	end,

	["camera"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Camera"] then
			local Ped = GetPlayerPed(source)
			if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
				return
			end

			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:Camera",source,false)
			vRPC.CreateObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
		end
	end,

	["binoculars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Camera"] then
			local Ped = GetPlayerPed(source)
			if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
				return
			end

			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:Camera",source,true)
			vRPC.CreateObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",49,28422)
		end
	end,

	["notepad"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			local Name = "notepad:"..Split[3]
			local Message = vRP.GetSrvData(Name,true)

			TriggerClientEvent("notepad:Open",source,Name,Message)
			TriggerClientEvent("inventory:Close",source)
		end
	end,

	["suitcase"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open",source,"suitcase:"..Split[3],"Item",false,false,true)
		end
	end,

	["treasurebox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open",source,"treasurebox:"..Split[3],"Item",Full,true,true)
		end
	end,

	["medicbag"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split and Split[3] then
			TriggerClientEvent("chest:Open",source,"medicbag:"..Split[3],"Item",false,false,true)
		end
	end,

	["newchars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,false,Slot) then
			vRP.UpgradeCharacters(source)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerClientEvent("Notify",source,"Sucesso","Personagem liberado.","verde",5000)
		end
	end,

	["gemstone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,Amount,false,Slot) then
			TriggerClientEvent("inventory:Update",source,"Backpack")
			vRP.UpgradeGemstone(Passport,Amount,false)
		end
	end,

	["namechange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.Secondary(source,"Nome","Sobrenome")
		if Keyboard then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("Notify",source,"Sucesso","Passaporte atualizado.","verde",5000)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				vRP.UpgradeNames(Passport,Keyboard[1],Keyboard[2])
			end
		end
	end,

	["soap"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPLAYER.Residuals(source) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Usando",10000)
			vRPC.PlayAnim(source,false,{"amb@world_human_bum_wash@male@high@base","base"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("player:Residual",source)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["joint"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport,"lighter",1) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Fumando",10000)
			vRPC.CreateObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.WeedTimer(Passport,120)
						vRP.DowngradeStress(Passport,20)
						TriggerClientEvent("Joint",source)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["metadone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",3000)
		vRPC.PlayAnim(source,true,{"mp_suicide","pill"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.ChemicalTimer(Passport,120)
					TriggerClientEvent("Metadone",source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["heroin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",15000)
		vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.ChemicalTimer(Passport,120)
					TriggerClientEvent("Heroin",source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["crack"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Fumando",15000)
		vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.ChemicalTimer(Passport,120)
					TriggerClientEvent("Crack",source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cocaine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Cheirando",5000)
		vRPC.PlayAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.ChemicalTimer(Passport,120)
					vRP.DowngradeStress(Passport,20)
					TriggerClientEvent("Cocaine",source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["meth"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] and os.time() < Armors[Passport] then
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Armors[Passport] - os.time())..".","amarelo",5000)
			return
		end

		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Inalando",15000)
		vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("Methamphetamine",source)
					Armors[Passport] = os.time() + 90
					vRP.ChemicalTimer(Passport,120)
					vRP.SetArmour(source,10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cigarette"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport,"lighter",1) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Fumando",10000)
			vRPC.CreateObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.DowngradeStress(Passport,10)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["vape"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 20
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Fumando",20000)
		vRPC.CreateObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				vRP.DowngradeStress(Passport,20)
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end,

	["medkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Passando",10000)
				vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 60
							vRPC.UpgradeHealth(source,40)
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify",source,"Aviso","Não pode utilizar de vida cheia.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Healths[Passport] - os.time())..".","amarelo",5000)
		end
	end,

	["gauze"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPARAMEDIC.Bleeding(source) > 0 then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Passando",3000)
			vRPC.PlayAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vPARAMEDIC.Bandage(source)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerClientEvent("Notify",source,"Aviso","Nenhum ferimento encontrado.","amarelo",5000)
		end
	end,

	["gsrkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source)
		if ClosestPed then
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Usando",5000)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Informations = vPLAYER.Residuals(ClosestPed)
						if Informations then
							local Number = 0
							local Message = ""

							for Value,v in pairs(Informations) do
								Number = Number + 1
								Message = Message.."<b>"..Number.."</b>: "..Value.."<br>"
							end

							TriggerClientEvent("Notify",source,"Informações",Message,"verde",10000)
						else
							TriggerClientEvent("Notify",source,"Aviso","Nenhum resultado encontrado.","amarelo",5000)
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["gdtkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source)
		if ClosestPed then
			local OtherPassport = vRP.Passport(ClosestPed)
			local Identity = vRP.Identity(OtherPassport)
			if OtherPassport and Identity then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Usando",5000)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local weed = vRP.WeedReturn(OtherPassport)
							local chemical = vRP.ChemicalReturn(OtherPassport)
							local alcohol = vRP.AlcoholReturn(OtherPassport)

							local chemStr = ""
							local alcoholStr = ""
							local weedStr = ""

							if chemical == 0 then
								chemStr = "Nenhum"
							elseif chemical == 1 then
								chemStr = "Baixo"
							elseif chemical == 2 then
								chemStr = "Médio"
							elseif chemical >= 3 then
								chemStr = "Alto"
							end

							if alcohol == 0 then
								alcoholStr = "Nenhum"
							elseif alcohol == 1 then
								alcoholStr = "Baixo"
							elseif alcohol == 2 then
								alcoholStr = "Médio"
							elseif alcohol >= 3 then
								alcoholStr = "Alto"
							end

							if weed == 0 then
								weedStr = "Nenhum"
							elseif weed == 1 then
								weedStr = "Baixo"
							elseif weed == 2 then
								weedStr = "Médio"
							elseif weed >= 3 then
								weedStr = "Alto"
							end

							TriggerClientEvent("Notify",source,"Informações","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,"roxo",8000)
						end
					end

					Wait(100)
				until not Active[Passport]
			end
		end
	end,

	["nitro"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source, 2)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Trocando",10000)
				vRPC.PlayAnim(source,false,{"mini@repair","fixing_a_player"},true)

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"open")
					end)
				end

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local Networked = NetworkGetEntityFromNetworkId(Network)
							if DoesEntityExist(Networked) then
								local Nitro = GlobalState["Nitro"]
								Nitro[Plate] = 2000
								GlobalState:set("Nitro", Nitro, true)
							end
						end
					end

					Wait(100)
				until not Active[Passport]

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"close")
					end)
				end
			end
		end
	end,

	["vest"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] and os.time() < Armors[Passport] then
			TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Armors[Passport] - os.time())..".","amarelo",5000)
			return
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Vestindo",10000)
		vRPC.PlayAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					Armors[Passport] = os.time() + 1800
					vRP.SetArmour(source,100)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["GADGET_PARACHUTE"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Usando",3000)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vCLIENT.Parachute(source)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["advtoolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source)
			if Vehicle then
				vRPC.AnimActive(source)
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source,false,{"mini@repair","fixing_a_player"},true)

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"open")
					end)
				end

				if vRP.Task(source,5,10000) then
					Active[Passport] = os.time() + 15
					TriggerClientEvent("Progress",source,"Reparando",15000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:RepairBoosts",v,Network,Plate)
									end)
								end

								local Number = parseInt(Split[2]) - 1
								if Number >= 1 then
									vRP.GiveItem(Passport,"advtoolbox-"..Number,1,false,Slot)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"close")
					end)
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)
			end
		end
	end,

	["toolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source)
			if Vehicle then
				vRPC.AnimActive(source)
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source,false,{"mini@repair","fixing_a_player"},true)

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"open")
					end)
				end

				if vRP.Task(source,5,10000) then
					Active[Passport] = os.time() + 15
					TriggerClientEvent("Progress",source,"Reparando",15000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:RepairBoosts",v,Network,Plate)
									end)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("player:VehicleHood",v,Network,"close")
					end)
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)
			end
		end
	end,

	["circuit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle,Network,Plate = vRPC.VehicleList(source)
			if Vehicle and Plate and (Boosting[Plate] and vRPC.InsideVehicle(source) and Boosting[Plate]["Amount"] < 10) then
				if (not Travel[Passport] or #(vRP.GetEntityCoords(source) - Travel[Passport]) >= 100) then
					TriggerClientEvent("inventory:Close",source)

					if vDEVICE.Device(source,30) then
						if Boosting[Plate]["Class"] >= 4 then
							exports["markers"]:Enter(source,"Boosting",Passport,60)
						end

						vRP.UpgradeStress(Passport,3)
						Travel[Passport] = vRP.GetEntityCoords(source)
						Boosting[Plate]["Amount"] = Boosting[Plate]["Amount"] + 1

						if Boosting[Plate]["Amount"] >= 10 then
							exports["boosting"]:Payment(source,Boosting[Plate]["Passport"])
							exports["boosting"]:Remove(Boosting[Plate]["Passport"],Plate)
						else
							TriggerClientEvent("Notify",source,"Boosting [ "..Boosting[Plate]["Amount"].." / 10 ]","Progresso atualizado com sucesso.","verde",5000)
						end
					else
						Boosting[Plate]["Amount"] = Boosting[Plate]["Amount"] - 3

						if Boosting[Plate]["Amount"] < 0 then
							Boosting[Plate]["Amount"] = 0
						end

						TriggerClientEvent("Notify",source,"Boosting [ "..Boosting[Plate]["Amount"].." / 10 ]","Progresso atualizado com sucesso.","amarelo",5000)
					end
				end
			else
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("boosting:Open",source)
			end
		end
	end,

	["lockpick"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle,Network,Plate,Model,Class = vRPC.VehicleList(source)
			if Vehicle then
				if Model == "stockade" or Class == 15 or Class == 16 or Class == 19 then
					return false
				end

				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Networked = NetworkGetEntityFromNetworkId(Network)

				if vRPC.InsideVehicle(source) then
					vGARAGE.StartHotwired(source)

					if vRP.Task(source,10,10000) then
						vGARAGE.RegisterDecors(source,Vehicle)
						TriggerClientEvent("player:Residual",source,"Resíduo de Alumínio")

						exports["vrp"]:CallPolice({
							["Source"] = source,
							["Passport"] = Passport,
							["Permission"] = "Policia",
							["Name"] = "Roubo de Veículo",
							["Percentage"] = 250,
							["Wanted"] = 300,
							["Code"] = 31,
							["Color"] = 44,
							["Vehicle"] = VehicleName(Model).." - "..Plate
						})

						if DoesEntityExist(Networked) then
							if not vRP.PassportPlate(Plate) then
								Entity(Networked)["state"]:set("Lockpick",Passport,true)
								Entity(Networked)["state"]:set("Fuel",100,true)
								Entity(Networked)["state"]:set("Nitro",0,true)
								SetVehicleDoorsLocked(Networked,1)
							elseif math.random(100) >= 75 then
								SetVehicleDoorsLocked(Networked,1)
							end
						end
					end

					vGARAGE.StopHotwired(source)
				else
					vRPC.PlayAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

					if vRP.Task(source,10,10000) then
						Active[Passport] = os.time() + 15
						vGARAGE.RegisterDecors(source,Vehicle)
						TriggerClientEvent("Progress",source,"Destravando",15000)
						TriggerClientEvent("player:Residual",source,"Resíduo de Alumínio")

						exports["vrp"]:CallPolice({
							["Source"] = source,
							["Passport"] = Passport,
							["Permission"] = "Policia",
							["Name"] = "Roubo de Veículo",
							["Percentage"] = 250,
							["Wanted"] = 300,
							["Code"] = 31,
							["Color"] = 44,
							["Vehicle"] = VehicleName(Model).." - "..Plate
						})

						if Dismantle[Plate] then
							TriggerClientEvent("dismantle:Dispatch",source)
						end

						if Boosting[Plate] then
							TriggerClientEvent("boosting:Dispatch",source)
						end

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil

								if Dismantle[Plate] then
									TriggerClientEvent("target:Dismantle",source,Model)
								end

								if DoesEntityExist(Networked) then
									if not vRP.PassportPlate(Plate) then
										if not Dismantle[Plate] then
											Entity(Networked)["state"]:set("Fuel",100,true)
											Entity(Networked)["state"]:set("Nitro",0,true)
										end

										Entity(Networked)["state"]:set("Lockpick",Passport,true)
										SetVehicleDoorsLocked(Networked,1)
									elseif math.random(100) >= 75 then
										SetVehicleDoorsLocked(Networked,1)
									end
								end
							end

							Wait(100)
						until not Active[Passport]
					end
				end

				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)

				if math.random(1000) >= 875 then
					vRP.RemoveItem(Passport,Full,1,true)
				end
			end
		else
			vRP.RemoveItem(Passport,Full,1,true)
			Player(source)["state"]["Handcuff"] = false
			Player(source)["state"]["Commands"] = false
			TriggerClientEvent("sounds:Private",source,"uncuff",0.5)
		end
	end,

	["blocksignal"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle,Network,Plate = vRPC.VehicleList(source)
			if Vehicle and vRPC.InsideVehicle(source) then
				if not exports["garages"]:Signal(Plate) then
					vRPC.AnimActive(source)
					vGARAGE.StartHotwired(source)
					Active[Passport] = os.time() + 100
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)

					if vRP.Task(source,3,10000) and vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("Notify",source,"Sucesso","<b>Bloqueador de Sinal</b> instalado.","verde",5000)
						TriggerEvent("SignalRemove",Plate)
					end

					Player(source)["state"]["Buttons"] = false
					vGARAGE.StopHotwired(source)
					Active[Passport] = nil
				else
					TriggerClientEvent("Notify",source,"Aviso","<b>Bloqueador de Sinal</b> já instalado.","amarelo",5000)
				end
			end
		end
	end,

	["postit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("postit:initPostit",source)
	end,

	["coffeemilk"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["water"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",5000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["applejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["orangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["passionjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)
					vRP.DowngradeStress(Passport,15)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["grapejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["lemonjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["strawberryjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["blueberryjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["bananajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["acerolajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["guaranajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["coffeecup"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC.CreateObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeStress(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sinkalmy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",5000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeStress(Passport,20)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["ritmoneury"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",5000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeStress(Passport,40)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cola"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",5000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["soda"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",5000)
		vRPC.CreateObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["fishingrod"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.Fishing(source) then
			Active[Passport] = os.time() + 100
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)

			if not vRPC.PlayingAnim(source,"amb@world_human_stand_fishing@idle_a","idle_c") then
				vRPC.AnimActive(source)
				vRPC.CreateObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
			end

			if vRP.TakeItem(Passport,"worm") then
				if vRP.Task(source,6,75000) then
					local Result = RandPercentage({
						{ ["Item"] = "sardine", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "smalltrout", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "orangeroughy", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "anchovy", ["Chance"] = 75, ["Amount"] = 1 },
						{ ["Item"] = "catfish", ["Chance"] = 75, ["Amount"] = 1 },
						{ ["Item"] = "herring", ["Chance"] = 50, ["Amount"] = 1 },
						{ ["Item"] = "yellowperch", ["Chance"] = 50, ["Amount"] = 1 },
						{ ["Item"] = "salmon", ["Chance"] = 25, ["Amount"] = 1 }
					})

					vRP.UpgradeStress(Passport,1)

					if vRP.CheckWeight(Passport,Result["Item"],1) then
						vRP.PutExperience(Passport,"Fisherman",1)
						vRP.GenerateItem(Passport,Result["Item"],Result["Amount"],true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","roxo",5000)
						exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Amount"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName("worm").."</b>.","amarelo",5000)
			end

			Player(source)["state"]["Buttons"] = false
			Active[Passport] = nil
		end
	end,

	["fishingrodplus"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.Fishing(source) then
			Active[Passport] = os.time() + 100
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)

			if not vRPC.PlayingAnim(source,"amb@world_human_stand_fishing@idle_a","idle_c") then
				vRPC.AnimActive(source)
				vRPC.CreateObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
			end

			if vRP.TakeItem(Passport,"worm") then
				if vRP.Task(source,3,75000) then
					local Result = RandPercentage({
						{ ["Item"] = "sardine", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "smalltrout", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "orangeroughy", ["Chance"] = 100, ["Amount"] = 1 },
						{ ["Item"] = "anchovy", ["Chance"] = 75, ["Amount"] = 1 },
						{ ["Item"] = "catfish", ["Chance"] = 75, ["Amount"] = 1 },
						{ ["Item"] = "herring", ["Chance"] = 50, ["Amount"] = 1 },
						{ ["Item"] = "yellowperch", ["Chance"] = 50, ["Amount"] = 1 },
						{ ["Item"] = "salmon", ["Chance"] = 50, ["Amount"] = 1 },
						{ ["Item"] = "smallshark", ["Chance"] = 25, ["Amount"] = 1 },
						{ ["Item"] = "treasurebox", ["Chance"] = 5, ["Amount"] = 1 }
					})

					if vRP.CheckWeight(Passport,Result["Item"],1) then
						vRP.PutExperience(Passport,"Fisherman",1)
						vRP.GenerateItem(Passport,Result["Item"],Result["Amount"],true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","roxo",5000)
						exports["inventory"]:Drops(Passport,source,Result["Item"],Result["Amount"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName("worm").."</b>.","amarelo",5000)
			end

			Player(source)["state"]["Buttons"] = false
			Active[Passport] = nil
		end
	end,

	["pizzamozzarella"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","knjgh_pizzaslice1",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["pizzabanana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","knjgh_pizzaslice2",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["pizzachocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","knjgh_pizzaslice3",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.PlayAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["nigirizushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.PlayAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["calzone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.PlayAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,25)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cookies"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.PlayAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["hamburger3"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,40)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["ration"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) and not vCLIENT.CheckRation(source) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Colocando",10000)
			vRPC.PlayAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					vRPC.Destroy(source)
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("inventory:Ration",source)
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end,

	["pistol_bench"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "gr_prop_gr_bench_02a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Craftings", Weight = 0.75, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["smg_bench"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "gr_prop_gr_bench_02b"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Craftings", Weight = 0.75, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["rifle_bench"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "xm3_prop_xm3_bench_04b"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Craftings", Weight = 0.75, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["drugs_bench"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_table_01b"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Craftings", Weight = 0.85, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["blueprint_bench"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_tool_bench02"
		local Application,Coords = vRPC.ObjectControlling(source,Hash,90.0)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Craftings", Weight = 0.85, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["spikestrips"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "p_ld_stinger_s"
		local Application,Coords = vRPC.ObjectControlling(source,Hash,0.0,2.5)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Active = "Spikes", Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["weedclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"weed",{ ["Min"] = 3, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["cokeclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"coke",{ ["Min"] = 3, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tomatoclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"tomato",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["passionclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"passion",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tangeclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"tange",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["orangeclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"orange",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["appleclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"apple",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["grapeclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"grape",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["lemonclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"lemon",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["bananaclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"banana",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["acerolaclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"acerola",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["strawberryclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"strawberry",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["blueberryclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"blueberry",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["coffeeclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			exports["plants"]:Plants(Hash,Coords,GetPlayerRoutingBucket(source),"coffee",{ ["Min"] = 4, ["Max"] = 6 })
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["barrier"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mp_barrier_02b"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Store", Weight = 0.75, Bucket = GetPlayerRoutingBucket(source) }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["storage25"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mb_cargo_04a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Chests", Weight = 1.0, Bucket = GetPlayerRoutingBucket(source)  }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["storage50"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mb_cargo_04a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Chests", Weight = 1.0, Bucket = GetPlayerRoutingBucket(source)  }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["storage75"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mb_cargo_04a"
		local Application,Coords = vRPC.ObjectControlling(source,Hash)
		if Application and Coords and not vCLIENT.ObjectExists(source,Coords,Hash) then
			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				repeat
					Selected = GenerateString("DDLLDDLL")
				until Selected and not Objects[Selected]

				Objects[Selected] = { Coords = Coords, Object = Hash, Item = Full, Mode = "Chests", Weight = 1.0, Bucket = GetPlayerRoutingBucket(source)  }
				SaveObjects[Selected] = Objects[Selected]

				TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["hotdog"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["sandwich"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["tacos"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["fries"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,7)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["milkshake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC.CreateObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,25)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cappuccino"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC.CreateObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,25)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["applelove"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,10)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["cupcake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)

					if vCLIENT.Restaurant(source) then
						TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["chocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,4)
					vRP.DowngradeStress(Passport,4)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["donut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",5000)
		vRPC.CreateObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.Destroy(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,5)
				end
			end

			Wait(100)
		until not Active[Passport]
	end,

	["dismantle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.Dismantle(source) and vRP.TakeItem(Passport,Full,1,true,Slot) then
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end
	end,

	["tyres"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			if not vCLIENT.CheckWeapon(source,"WEAPON_WRENCH") then
				TriggerClientEvent("Notify",source,"Atenção","<b>Chave Inglesa</b> não encontrada.","amarelo",5000)
				return
			end

			local Vehicle,Tyre,Network,Plate,Model = vCLIENT.Tyres(source)
			if Vehicle then
				TriggerClientEvent("inventory:Close",source)
				vRPC.PlayAnim(source,false,{"amb@medic@standing@kneel@idle_a","idle_a"},true)
				vRPC.CreateObjects(source,"anim@heists@box_carry@","idle","imp_prop_impexp_tyre_01a",49,28422,-0.02,-0.1,0.2,10.0,0.0,0.0)

				if vRP.Task(source,3,7500) then
					Active[Passport] = os.time() + 10
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Colocando",10000)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								if Model and VehicleMode(Model) == "Work" then
									Tyre = "All"
								end

								local Players = vRPC.Players(source)
								for _,v in pairs(Players) do
									async(function()
										TriggerClientEvent("inventory:RepairTyres",v,Network,Tyre,Plate)
									end)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				end

				vRPC.Destroy(source)
			end
		end
	end,

	["seatbelt"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRPC.InsideVehicle(source) then
			TriggerClientEvent("inventory:Close",source)

			local Model,Vehicle = vRPC.VehicleName(source)
			local Networked = NetworkGetEntityFromNetworkId(Vehicle)
			local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Model })
			if DoesEntityExist(Networked) and Consult[1] and vRP.TakeItem(Passport,Full,1,true,Slot) then
				Entity(Networked)["state"]:set("Seatbelt",true,true)
				TriggerClientEvent("Notify",source,"Sucesso","Cinto de Corrida ativado.","verde",5000)
				vRP.Query("vehicles/SeatbeltVehicles",{ Vehicle = Model, Plate = Consult[1]["Plate"] })
			end
		end
	end,

	["premiumplate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRPC.InsideVehicle(source) then
			TriggerClientEvent("inventory:Close",source)

			local Model = vRPC.VehicleName(source)
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Model })
			if Vehicle[1] then
				local Keyboard = vKEYBOARD.Primary(source,"Placa")
				if Keyboard then
					local Plate = sanitizeString(Keyboard[1],"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")

					if string.len(Plate) ~= 8 then
						TriggerClientEvent("Notify",source,"Aviso","Nome de definição inválido.","amarelo",5000)
						return
					else
						if vRP.PassportPlate(Plate) then
							TriggerClientEvent("Notify",source,"Aviso","Placa escolhida já existe no sistema.","amarelo",5000)
							return
						else
							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								vRP.Query("vehicles/plateVehiclesUpdate",{ Passport = Passport, Vehicle = Model, Plate = string.upper(Plate) })
								TriggerClientEvent("Notify",source,"Sucesso","Placa atualizada.","verde",5000)
							end
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"Aviso","Modelo de veículo não encontrado.","amarelo",5000)
			end
		end
	end,

	["radio"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("radio:Open",source)
		vRPC.AnimActive(source)
	end,

	["scuba"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Scuba",source)
	end,

	["handcuff"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			local ClosestPed = vRPC.ClosestPed(source)
			if ClosestPed and not vRP.IsEntityVisible(ClosestPed) then
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true

				if Player(ClosestPed)["state"]["Handcuff"] then
					Player(ClosestPed)["state"]["Handcuff"] = false
					Player(ClosestPed)["state"]["Commands"] = false
					TriggerClientEvent("sounds:Private",source,"uncuff",0.5)
					TriggerClientEvent("sounds:Private",ClosestPed,"uncuff",0.5)

					vRPC.Destroy(ClosestPed)
					vRPC.Destroy(source)
				else
					if vRP.GetHealth(ClosestPed) > 100 then
						TriggerEvent("inventory:ServerCarry",source,Passport,ClosestPed,true)
						vRPC.PlayAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
						vRPC.PlayAnim(ClosestPed,false,{"mp_arrest_paired","crook_p2_back_left"},false)

						SetTimeout(3500,function()
							TriggerEvent("inventory:ServerCarry",source,Passport)
							TriggerClientEvent("sounds:Private",source,"cuff",0.5)
							TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)

							vRPC.Destroy(ClosestPed)
							vRPC.Destroy(source)
						end)
					else
						TriggerClientEvent("sounds:Private",source,"cuff",0.5)
						TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)
					end

					Player(ClosestPed)["state"]["Handcuff"] = true
					Player(ClosestPed)["state"]["Commands"] = true
					TriggerClientEvent("inventory:Close",ClosestPed)
					TriggerClientEvent("radio:RadioClean",ClosestPed)
				end

				Player(source)["state"]["Cancel"] = false
				Player(source)["state"]["Buttons"] = false
			end
		end
	end,

	["hood"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local OtherSource = vRPC.ClosestPed(source)
		if OtherSource and Player(OtherSource)["state"]["Handcuff"] then
			TriggerClientEvent("hud:Hood",OtherSource)
			TriggerClientEvent("inventory:Close",OtherSource)
		end
	end,

	["rope"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRPC.InsideVehicle(source) then
			if not Carry[Passport] then
				local OtherSource = vRPC.ClosestPed(source)
				local OtherPassport = vRP.Passport(OtherSource)
				if OtherSource and not Carry[OtherPassport] and vRP.GetHealth(OtherSource) <= 100 and not vRP.IsEntityVisible(OtherSource) then
					Carry[Passport] = OtherSource
					Player(source)["state"]["Carry"] = true
					Player(OtherSource)["state"]["Carry"] = true
					TriggerClientEvent("inventory:Carry",OtherSource,source,"Attach")
				end
			else
				if vRP.DoesEntityExist(Carry[Passport]) then
					TriggerClientEvent("inventory:Carry",Carry[Passport],source,"Detach")
					Player(Carry[Passport])["state"]["Carry"] = false
				end

				Player(source)["state"]["Carry"] = false
				Carry[Passport] = nil
			end
		end
	end,

	["premium"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 1
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			if vRP.LevelPremium(source) == Hierarchy and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end
	end,

	["premium2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 2
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			if vRP.LevelPremium(source) == Hierarchy and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end
	end,

	["premium3"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Hierarchy = 3
		if not vRP.UserPremium(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.SetPremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			if vRP.LevelPremium(source) == Hierarchy and vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.UpgradePremium(source,Passport,Hierarchy)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end
	end,

	["pager"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source)
		if ClosestPed and Player(ClosestPed)["state"]["Handcuff"] then
			local OtherPassport = vRP.Passport(ClosestPed)
			if OtherPassport then
				if vRP.HasService(OtherPassport,"Policia") then
					TriggerEvent("Wanted",source,Passport,600)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.ServiceLeave(ClosestPed,OtherPassport,"Policia",true)
						TriggerClientEvent("Notify",source,"Sucesso","Todas as comunicações foram retiradas.","verde",5000)
					end
				end

				if vRP.HasService(OtherPassport,"Paramedico") then
					TriggerEvent("Wanted",source,Passport,600)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.ServiceLeave(ClosestPed,OtherPassport,"Paramedico",true)
						TriggerClientEvent("Notify",source,"Sucesso","Todas as comunicações foram retiradas.","verde",5000)
					end
				end
			end
		end
	end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUEPRINTSTART
-----------------------------------------------------------------------------------------------------------------------------------------
for Name,v in pairs(ItemList()) do
	if v["Blueprint"] then
		Use["blueprint_"..Name] = function(source,Passport,Amount,Slot,Full,Item,Split)
			if not Users["Blueprints"][Passport] then
				Users["Blueprints"][Passport] = {}
			end

			if Users["Blueprints"][Passport] and Users["Blueprints"][Passport][Name] then
				TriggerClientEvent("inventory:Notify",source,"Aviso","Você já possui este aprendizado.","amarelo")

				return false
			end

			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("inventory:Notify",source,"Sucesso","Aprendizado adicionado.","verde")
				TriggerClientEvent("inventory:Update",source,"Backpack")
				Users["Blueprints"][Passport][Name] = true
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESSTART
-----------------------------------------------------------------------------------------------------------------------------------------
for Model,v in pairs(VehicleList()) do
	if v["Item"] then
		Use["vehicle_"..Model] = function(source,Passport,Amount,Slot,Full,Item,Split)
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Model })
			if Vehicle[1] then
				TriggerClientEvent("Notify",source,"Aviso","Já possui um <b>"..VehicleName(Model).."</b>.","amarelo",5000)
			else
				if VehicleStock(Model) and vRP.Scalar("vehicles/Count",{ Vehicle = Model }) >= VehicleStock(Model) then
					TriggerClientEvent("Notify",source,"Aviso","Estoque insuficiente.","amarelo",5000)

					return false
				end

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Plate = vRP.GeneratePlate()

					if v["Item"] == "Monthly" then
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Model, Plate = Plate, Weight = VehicleWeight(Model), Work = 0 })
					elseif v["Item"] == "Permanent" then
						vRP.Query("vehicles/addVehicles",{ Passport = Passport, Vehicle = Model, Plate = Plate, Weight = VehicleWeight(Model), Work = 0 })
					end

					TriggerClientEvent("Notify",source,"Sucesso","Veículo <b>"..VehicleName(Model).."</b> adicionado.","verde",5000)
					TriggerClientEvent("inventory:Update",source,"Backpack")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPRAYCONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local SprayConfig = {
	["spray_ballas"] = {
		["Permission"] = "Ballas",
		["Color"] = 50
	},
	["spray_vagos"] = {
		["Permission"] = "Vagos",
		["Color"] = 60
	},
	["spray_families"] = {
		["Permission"] = "Families",
		["Color"] = 69
	},
	["spray_marabunta"] = {
		["Permission"] = "Marabunta",
		["Color"] = 63
	},
	["spray_bennys"] = {
		["Permission"] = "Bennys",
		["Color"] = 76
	},
	["spray_aztecas"] = {
		["Permission"] = "Aztecas",
		["Color"] = 77
	},
	["spray_bahamas"] = {
		["Permission"] = "Bahamas",
		["Color"] = 82
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
for ItemName,v in pairs(SprayConfig) do
	Use[ItemName] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Hash = ItemName
		local Application,Coords = vCLIENT.SprayControlling(source,Hash)
		if Application and Coords then
			Player(source)["state"]["Buttons"] = true

			if vCLIENT.CheckInterior(source) then
				TriggerClientEvent("Notify",source,"Atenção","Só pode ser posicionado fora de interiores.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			if vRPC.SprayExist(source,500) then
				TriggerClientEvent("Notify",source,"Atenção","No momento você não pode prosseguir porque outro grupo está dominando a localidade.","amarelo",5000)
				Player(source)["state"]["Buttons"] = false

				return false
			end

			Active[Passport] = os.time() + 999
			TriggerClientEvent("Progress",source,"Agitando",5000)
			vRPC.CreateObjects(source,"switch@franklin@lamar_tagging_wall","lamar_tagging_wall_loop_lamar","prop_cs_spray_can",1,28422)

			SetTimeout(5000,function()
				if Active[Passport] then
					Active[Passport] = os.time() + 10
					TriggerClientEvent("Progress",source,"Colocando",10000)
					TriggerClientEvent("sounds:Private",source,"sprays",0.5)
					vRPC.CreateObjects(source,"switch@franklin@lamar_tagging_wall","lamar_tagging_exit_loop_lamar","prop_cs_spray_can",1,28422)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil

							if not vRPC.SprayExist(source,500) and vRP.TakeItem(Passport,Full,1,true,Slot) then
								repeat
									Selected = GenerateString("DDLLDDLL")
								until Selected and not Objects[Selected]

								Objects[Selected] = { Coords = Coords, Object = Hash, Mode = "Sprays", ["Timer"] = os.time() + 1800, Ground = true, Color = v["Color"], Permission = v["Permission"], Bucket = GetPlayerRoutingBucket(source) }
								SaveObjects[Selected] = Objects[Selected]

								TriggerClientEvent("objects:Adicionar",-1,Selected,Objects[Selected])
							end
						end

						Wait(100)
					until not Active[Passport]
				end
			end)
		end

		Player(source)["state"]["Buttons"] = false
	end
end