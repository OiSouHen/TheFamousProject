-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("jobcenter",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jobcenter:Open", function(config)
	if not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and MumbleIsConnected() then
			if GetClockHours() >= 06 and GetClockHours() <= 22 then
				if LocalPlayer["state"]["Work"] == true then
					exports["dynamic"]:AddButton("Localização", "Localização do seu serviço atual.", "jobcenter:FindJob", false, false, true)
					exports["dynamic"]:AddButton("Finalizar", "Finalize o seu serviço atual.", "jobcenter:StartJob", "Sair", false, true)
					exports["dynamic"]:openMenu()
				else
					vRP.CreateObjects("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "prop_cs_tablet", 49, 28422, -0.05, 0.0, 0.0, 0.0, 0.0, 0.0)
					SendNUIMessage( { type = "open", config = config } )
					SetNuiFocus(true, true)
				end
			else
				TriggerEvent("Notify", "azul", "Estamos fechados por agora, nosso horário de funcionamento é das <b>06</b> ás <b>22 Horas</b>.", "Central de Empregos", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTJOB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("startJob", function(data, cb)
	TriggerServerEvent("jobcenter:StartJob", data["rank"])
	SetNuiFocus(false, false)
	vRP.Destroy()
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)
	vRP.Destroy()
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jobcenter:GPS", function(job)
	for Name,v in pairs(Coords) do
		if v["Name"] == job then
			SetNewWaypoint(v["X"], v["Y"])
		end
	end
end)