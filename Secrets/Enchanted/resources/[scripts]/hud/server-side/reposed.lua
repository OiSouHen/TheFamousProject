-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lock = {}
local Repose = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Repose",function(source,Passport,Seconds)
	local Seconds = parseInt(Seconds)
	local Passport = tostring(Passport)

	if Repose[Passport] then
		if os.time() > Repose[Passport] then
			Repose[Passport] = os.time() + Seconds
		else
			Repose[Passport] = Repose[Passport] + Seconds
		end
	else
		Repose[Passport] = os.time() + Seconds
	end

	TriggerClientEvent("hud:Repose",source,Repose[Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Repose",function(Passport)
	local Passport = tostring(Passport)

	return Repose[Passport] and Repose[Passport] > os.time() and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Passport = tostring(Passport)

	if Lock[Passport] then
		TriggerEvent("Repose",source,Passport,Lock[Passport])

		Lock[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	local Passport = tostring(Passport)

	if Repose[Passport] then
		if Repose[Passport] > os.time() then
			Lock[Passport] = (Repose[Passport] - os.time())
		end

		Repose[Passport] = nil
	end
end)