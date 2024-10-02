-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Cooldown = {}
local GangsBank = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local GangsDuration = 30
local GangsCooldown = 900
local NeedGangsMember = 4
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GANGSVERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:GangsVerify")
AddEventHandler("player:GangsVerify", function(Gang)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport, Gang) then
			if vRP.Banks("See", false, Gang) > 0 then
				local Permission = vRP.NumPermission(Gang)
				for Passports,Sources in pairs(Permission) do
					async(function()
						TriggerClientEvent("Notify", Sources, "amarelo", "<b>"..vRP.FullName(Passport).."</b> abriu o cofre.", "Cofre dos "..Gang, 5000)
						vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
					end)
				end

				TriggerClientEvent("player:GangsVerifyPanel", source, Gang, Dotted(vRP.Banks("See", false, Gang)))
			else
				TriggerClientEvent("Notify", source, "amarelo", "O cofre dos <b>"..Gang.."</b> está vázio.", "Cofre dos "..Gang, 5000)
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você não pertence ao grupo dos <b>"..Gang.."</b>.", "Aviso", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GANGSWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:GangsWithdraw")
AddEventHandler("player:GangsWithdraw", function(Gang)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport, Gang) then
			if vRP.HasPermission(Passport, Gang, 1) then
				if vRP.Banks("See", false, Gang) > 0 then
					if (not GangsBank[Passport] or os.time() > GangsBank[Passport]) then
						TriggerClientEvent("dynamic:Close", source)

						if vRP.Request(source, "Cofre dos "..Gang, "Você deseja realmente retirar <b>$"..Dotted(vRP.Banks("See", false, Gang)).." "..ItemName(DefaultDollars1).."</b> do <b>Cofre dos "..Gang.."</b>?") then
							if GangsLog then
								exports["vrp"]:Embed("Gangs","**Passaporte:** "..Passport.."\n**Retirou:** $ "..vRP.Banks("See", false, Gang),0xa3c846)
							end

							vRP.PaymentService(Passport, vRP.Banks("See", false, Gang), "Legal", true)
							vRP.Banks("Rem", vRP.Banks("See", false, Gang), Gang)
							GangsBank[Passport] = os.time() + 600

							local Permission = vRP.NumPermission(Gang)
							for Passports,Sources in pairs(Permission) do
								async(function()
									TriggerClientEvent("Notify", Sources, "amarelo", "O cofre foi esvaziado.", "Cofre dos "..Gang, 5000)
									vRPC.PlaySound(Sources, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
								end)
							end
						end
					else
						local Cooldown = CompleteTimers(GangsBank[Passport] - os.time())
						TriggerClientEvent("Notify", source, "azul", "Aguarde <b>"..Cooldown.."</b>.", false, 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O cofre dos <b>"..Gang.."</b> está vázio.", "Cofre dos "..Gang, 5000)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não tem direitos suficientes.", "Aviso", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "vermelho", "Você não pertence ao grupo dos <b>"..Gang.."</b>.", "Aviso", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:GANGSROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:GangsRobbery")
AddEventHandler("player:GangsRobbery", function(Gang)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.Banks("See", false, Gang) > 0 then
			local Service,Total = vRP.NumPermission(Gang)
			if Total >= NeedGangsMember then
				if not Cooldown[Gang] or os.time() > Cooldown[Gang] then
					if vRP.Device(source, 60) then
						Cooldown[Gang] = os.time() + GangsCooldown

						local Coords = vRP.GetEntityCoords(source)
						for Passports,Sources in pairs(Service) do
							async(function()
								TriggerClientEvent("sounds:Private",Sources,"crime",0.5)
								TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo ao Cofre", x = Coords["x"], y = Coords["y"], z = Coords["z"], color = 22 })
							end)
						end

						vRPC.AnimActive(source)
						Player(source)["state"]["Buttons"] = true
						Active[Passport] = os.time() + GangsDuration
						TriggerEvent("Wanted",source,Passport,GangsDuration * 3)
						vRPC.PlayAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
						TriggerClientEvent("Progress",source,"Roubando",GangsDuration * 1000)

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								vRPC.Destroy(source)
								Active[Passport] = nil
								Player(source)["state"]["Buttons"] = false
								vRP.PaymentService(Passport, vRP.Banks("See", false, Gang), "Legal", true)
								vRP.Banks("Rem", vRP.Banks("See", false, Gang), Gang)
							end

							Wait(100)
						until not Active[Passport]
					end
				else
					TriggerClientEvent("Notify", source, "azul", "Aguarde <b>"..Cooldown[Gang] - os.time().."</b> segundos.", false, 5000)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "Membros indisponíveis.", "Atenção", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "amarelo", "O cofre dos <b>"..Gang.."</b> está vázio.", "Cofre dos "..Gang, 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)