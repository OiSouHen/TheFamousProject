-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("barbershop", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Barbers, Creation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Tables = json.encode(Barbers)
		if Tables ~= "[]" then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Barbershop", Information = Tables })
		end

		if Creation then
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Creator", Information = json.encode(1) })
		end
	end
end