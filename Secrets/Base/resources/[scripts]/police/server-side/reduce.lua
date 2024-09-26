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
	if Passport and Identity and Identity["Prison"] > 0 then
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

				exports["vrp"]:CallPolice({
					["Source"] = source,
					["Passport"] = Passport,
					["Coords"] = vec3(1860.4,2594.06,45.66),
					["Permission"] = "Policia",
					["Name"] = "Fuga do Presidio",
					["Code"] = 34,
					["Color"] = 22
				})

				TriggerClientEvent("Notify",source,"Departamento Policial","Você fugiu da prisão e as autoridades foram notificadas, fuja o mais rápido possível daqui.","policia",5000)

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRP.UpdatePrison(Passport,Amount)
				vRPC.Destroy(source)
			else
				TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
			end
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

		vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)
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