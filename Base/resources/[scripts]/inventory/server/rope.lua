-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Carry")
AddEventHandler("inventory:Carry",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Carry[Passport] then
			local OtherSource = vRPC.ClosestPed(source)
			local OtherPassport = vRP.Passport(OtherSource)
			if OtherSource and not Carry[OtherPassport] and vRP.DoesEntityExist(OtherSource) and not vRPC.PlayingAnim(OtherSource,"amb@world_human_sunbathe@female@back@idle_a","idle_a") and not vRP.IsEntityVisible(OtherSource) then
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SERVERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ServerCarry")
AddEventHandler("inventory:ServerCarry",function(source,Passport,OtherSource,Handcuff)
	if not Carry[Passport] then
		local OtherPassport = vRP.Passport(OtherSource)
		if not Carry[OtherPassport] and vRP.DoesEntityExist(OtherSource) then
			Carry[Passport] = OtherSource
			Player(source)["state"]["Carry"] = true
			Player(OtherSource)["state"]["Carry"] = true
			TriggerClientEvent("inventory:Carry",OtherSource,source,"Attach",Handcuff)
		end
	else
		if vRP.DoesEntityExist(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],source,"Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
		end

		Player(source)["state"]["Carry"] = false
		Carry[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:CarryDetach")
AddEventHandler("inventory:CarryDetach",function(source,Passport)
	if Carry[Passport] then
		if vRP.DoesEntityExist(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],source,"Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
		end

		Player(source)["state"]["Carry"] = false
		Carry[Passport] = nil
	end
end)