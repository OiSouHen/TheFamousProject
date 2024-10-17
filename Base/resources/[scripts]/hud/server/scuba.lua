-----------------------------------------------------------------------------------------------------------------------------------------
-- OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Oxigen(Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeOxigen(Passport, Value)
	end
end