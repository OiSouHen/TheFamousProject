-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local Itens = {
	{ ["Item"] = "dirtydollar", ["Chance"] = 100, ["Min"] = 325, ["Max"] = 375 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Register")
AddEventHandler("inventory:Register",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vCLIENT.CheckWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Pé de Cabra</b> não encontrado.","amarelo",5000)

			return false
		end

		if not Cooldown[Number] or os.time() > Cooldown[Number] then
			if vRP.Task(source,3,7500) then
				Active[Passport] = os.time() + 15
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("Progress",source,"Roubando",15000)
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

				exports["vrp"]:CallPolice({
					["Source"] = source,
					["Passport"] = Passport,
					["Permission"] = "Policia",
					["Name"] = "Roubo a Caixa Registradora",
					["Percentage"] = 750,
					["Wanted"] = 60,
					["Code"] = 31,
					["Color"] = 22
				})

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) and Number and (not Cooldown[Number] or os.time() > Cooldown[Number]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Cooldown[Number] = os.time() + 3600
						Player(source)["state"]["Buttons"] = false

						vRP.MountContainer(Passport,"Registers:"..Number,Itens,1,false)
						TriggerClientEvent("player:Residual",source,"Resquício de Línter")
						TriggerClientEvent("chest:Open",source,"Registers:"..Number,"Custom",false,true,true)
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			local Consult = vRP.GetSrvData("Registers:"..Number,false)
			if json.encode(Consult) ~= "[]" and (Cooldown[Number] - 3300) >= os.time() then
				TriggerClientEvent("chest:Open",source,"Registers:"..Number,"Custom",false,true,true)
			else
				TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Cooldown[Number] - os.time())..".","amarelo",5000)
			end
		end
	end
end)