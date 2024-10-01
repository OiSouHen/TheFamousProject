-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("lib/Proxy")
Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
DEVICE = Tunnel.getInterface("device")
MEMORY = Tunnel.getInterface("memory")
REQUEST = Tunnel.getInterface("request")
TASKBAR = Tunnel.getInterface("taskbar")
LOCKPICK = Tunnel.getInterface("lockpick")
SURVIVAL = Tunnel.getInterface("survival")
SAFEZONE = Tunnel.getInterface("safezone")
SAFECRACK = Tunnel.getInterface("safecrack")
SCREWDRIVER = Tunnel.getInterface("screwdriver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Policia"] = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:SERVICE_REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:service_request",function(Data)
	local Answered = false
	local Service = vRP.NumPermission(Data["service"]["permission"])

	for Passport,Sources in pairs(Service) do
		async(function()
			TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Chamado", text = Data["content"], name = Data["name"], phone = Data["phone"], x = Data["location"][1], y = Data["location"][2], z = Data["location"][3], color = 2 })

			if vRP.Request(Sources,"Chamado","Aceitar o chamado de <b>"..Data["name"].."?") then
				if not Answered then
					Answered = true
					TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_RESPONSE",{})
					TriggerClientEvent("smartphone:pusher",Sources,"GPS",{ location = Data["location"] })
				else
					TriggerClientEvent("Notify",Sources,"verde","Chamado atendido.","Sucesso",5000)
				end
			end
		end)
	end

	SetTimeout(30000,function()
		if not Answered then
			TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_REJECT",{})
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:IS_SERVICE_CUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:is_service_custom",function(_,Reply)
	Reply(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(source,Title,Message)
	return REQUEST.Function(source,Title,Message)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Revive(source,Health)
	return SURVIVAL.Revive(source,Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Task(source,Amount,Speed)
	return TASKBAR.Task(source,Amount,Speed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Lock(source,Item,Difficulty,Pins)
	return LOCKPICK.Lock(source,Item,Difficulty,Pins)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.SCREWDRIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Screwdriver(source)
	return SCREWDRIVER.Screwdriver(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.MEMORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Memory(source)
	return MEMORY.Memory(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.SAFECRACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Safecrack(source,Number)
	return SAFECRACK.Safecrack(source,Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.DEVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Device(source,Seconds)
    return DEVICE.Device(source,Seconds)
end