-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("jobcenter",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENJOBCENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jobcenter:OpenJobCenter", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if (vRP.HasPermission(Passport, "Policia") or vRP.HasPermission(Passport, "Paramedico") or vRP.HasPermission(Passport, "Mecanico")) then
			TriggerClientEvent("Notify", source, "vermelho", "Você já possúi um emprego formal.", "Aviso", 5000)
		else
			TriggerClientEvent("jobcenter:Open", source, Config)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTJOB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jobcenter:StartJob", function(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Work == "Sair" then
			TriggerClientEvent("dynamic:Close", source)

			if vRP.Request(source, "Empregos", "Deseja se demitir do seu emprego atual pagando uma taxa de <b>$"..parseInt(225).."</b>?") then
				if vRP.PaymentFull(Passport, 225) then
					vRP.ChangeWork(Passport, "Nenhum")
				end
			end
		else
			if vRP.Request(source, "Empregos", "Deseja se registrar no emprego de <b>"..ClassWork(Work).."</b>?") then
				vRP.ChangeWork(Passport, Work)

				TriggerClientEvent("jobcenter:GPS", source, Work)
				TriggerClientEvent("Notify", source, "verde", "Local do serviço marcado em seu GPS.", "Sucesso", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDJOB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jobcenter:FindJob", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:Close", source)

		TriggerClientEvent("jobcenter:GPS", source, vRP.GetWork(Passport))
		TriggerClientEvent("Notify", source, "verde", "Local do serviço marcado em seu GPS.", "Sucesso", 5000)
	end
end)