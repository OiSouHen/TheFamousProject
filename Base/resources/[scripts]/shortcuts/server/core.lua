-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("shortcuts",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Shortcuts()
	local Shortcuts = {}
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inv = vRP.Inventory(Passport)

		for Number = 1,5 do
			local Number = tostring(Number)
			if Inv[Number] then
				Shortcuts[Number] = ItemIndex(Inv[Number]["item"])
			else
				Shortcuts[Number] = ""
			end
		end
	end

	return Shortcuts
end