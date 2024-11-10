-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("postit",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Posts = {}
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Add(Coords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Keyboard = vKEYBOARD.Secondary(source,"Mensagem","Distância (3 a 15)")
		if Keyboard and parseInt(Keyboard[2]) >= 3 and parseInt(Keyboard[2]) <= 15 then
			if vRP.TakeItem(Passport,"postit",1,true) then
				local Route = GetPlayerRoutingBucket(source)

				if not Posts[Route] then
					Posts[Route] = {}
				end

				local Number = #Posts[Route] + 1

				Posts[Route][Number] = {
					["Coords"] = Coords,
					["Message"] = string.sub(Keyboard[1],1,100),
					["Distance"] = parseInt(Keyboard[2]),
					["Passport"] = Passport
				}

				TriggerClientEvent("postit:Add",-1,Route,Number,Posts[Route][Number])
			end
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delete(Route,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Posts[Route] and Posts[Route][Number] then
		Active[Passport] = true

		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("Notify",source,"Sucesso","Post-It do passaporte <b>"..Posts[Route][Number]["Passport"].."</b> removido.","verde",10000)
			TriggerClientEvent("postit:Delete",-1,Route,Number)
			Posts[Route][Number] = nil
		else
			if Posts[Route][Number]["Passport"] == Passport then
				TriggerClientEvent("postit:Delete",-1,Route,Number)
				Posts[Route][Number] = nil
			end
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETXT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Archive(Coords)
	vRP.Archive("Coords.txt",Coords)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)