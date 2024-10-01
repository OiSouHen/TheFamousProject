-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Reposed = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Reposed", function(source, Passport, Seconds)
	if Reposed[Passport] then
		if os.time() > Reposed[Passport] then
			Reposed[Passport] = os.time() + Seconds
		else
			Reposed[Passport] = Reposed[Passport] + Seconds
		end
	else
		Reposed[Passport] = os.time() + Seconds
	end

	TriggerClientEvent("hud:Reposed", source, Reposed[Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed", function(Passport)
	local Passport = parseInt(Passport)

	if Reposed[Passport] then
		if Reposed[Passport] > os.time() then
			return true
		end
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	if Reposed[Passport] then
		if Reposed[Passport] > os.time() then
			TriggerClientEvent("hud:Reposed", source, Reposed[Passport] - os.time())
		end
	end
end)