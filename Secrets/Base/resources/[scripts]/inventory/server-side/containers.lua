-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CONTAINER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Container")
AddEventHandler("inventory:Container",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Cooldown[Number] or os.time() > Cooldown[Number] then
			if vRP.Task(source,3,10000) then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("Progress",source,"Roubando",10000)
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

				exports["vrp"]:CallPolice({
					["Source"] = source,
					["Passport"] = Passport,
					["Permission"] = "Policia",
					["Name"] = "Roubo ao Container",
					["Percentage"] = 900,
					["Wanted"] = 120,
					["Code"] = 31,
					["Color"] = 22
				})

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) and Number and (not Cooldown[Number] or os.time() > Cooldown[Number]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Cooldown[Number] = os.time() + 3600
						Player(source)["state"]["Buttons"] = false

						TriggerClientEvent("player:Residuals",source,"Resquício de Poeira")
						vRP.MountContainer(Passport,"Containers:"..Number,IlegalItens,math.random(3))
						TriggerClientEvent("chest:Open",source,"Containers:"..Number,"Custom",false,true,true)
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			local Consult = vRP.GetSrvData("Containers:"..Number,false)
			if json.encode(Consult) ~= "[]" and (Cooldown[Number] - 3300) >= os.time() then
				TriggerClientEvent("chest:Open",source,"Containers:"..Number,"Custom",false,true,true)
			else
				TriggerClientEvent("Notify",source,"Atenção","Aguarde "..CompleteTimers(Cooldown[Number] - os.time())..".","amarelo",5000)
			end
		end
	end
end)