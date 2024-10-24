-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Locations = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ESCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Escape")
AddEventHandler("police:Escape",function()
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	if Passport and Identity then
		if Identity["Prison"] > 0  then
			local Amount = Identity["Prison"]
			local EscapePrice = Amount * 475

			if vRP.Request(source,"Prisioneiro","Parece que você quer escapar da prisão, mas para isso acontecer você vai ter que deixar comigo o custeio de <b>$"..Dotted(EscapePrice).."</b> dólares, ta afim?") then
				if vRP.PaymentFull(Passport,EscapePrice) then
					if Locations[Passport] then
						Locations[Passport] = nil
					end

					if Active[Passport] then
						Active[Passport] = nil
					end

					vRP.CallGroup(vec3(1860.4,2594.06,45.66), "Policia", "Presidio", "Fuga do Presidio", 34, 22)
					TriggerClientEvent("Notify",source,"Departamento Policial","Você fugiu da prisão e as autoridades foram notificadas, fuja o mais rápido possível daqui.","policia",5000)

					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRP.UpdatePrison(Passport,Amount)
					vRPC.Destroy(source)
				else
					TriggerClientEvent("Notify",source,"Aviso","<b>"..ItemName(DefaultMoneyOne).."</b> insuficientes.","amarelo",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","Você não tem motivos para fugir.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:REDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduce")
AddEventHandler("police:Reduce",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	if Passport and Identity and Identity["Prison"] > 0 then
		if not Locations[Passport] then
			Locations[Passport] = {}
		end

		if Locations[Passport][Number] then
			if os.time() >= Locations[Passport][Number] then
				Reduction(source,Passport,Number)
			else
				TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Locations[Passport][Number] - os.time())..".","amarelo",5000)
			end
		else
			Reduction(source,Passport,Number)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function Reduction(source,Passport,Number)
	if not Active[Passport] then
		Active[Passport] = true

		vRPC.PlayAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)
		TriggerClientEvent("Progress",source,"Vasculhando",10000)
		Locations[Passport][Number] = os.time() + 300
		Player(source)["state"]["Buttons"] = true
		Player(source)["state"]["Cancel"] = true
		local Progress = 10
		local Services = 2

		repeat
			Wait(1000)
			Progress = Progress - 1
		until Progress <= 0

		Player(source)["state"]["Buttons"] = false
		Player(source)["state"]["Cancel"] = false
		vRP.UpdatePrison(Passport,Services)
		vRPC.Destroy(source)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:TRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Trade")
AddEventHandler("police:Trade",function()
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(Passport)
	if Passport and Identity then
		if Identity["Prison"] > 0 then
			local Likes = vRP.GetLikes(Passport)
			if Likes > 0 then
				if vRP.Request(source,"Prisioneiro","Você deseja usar toda sua reputação <b>Positiva</b> para sair da prisão?") then
					vRP.RemoveLikes(Passport,Likes)
					vRP.UpdatePrison(Passport,Identity["Prison"])
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Você não possúi reputação suficiente.","Atenção",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você não tem motivos para júri popular.","Atenção",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Locations[Passport] then
		Locations[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end
end)