-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local LootBoxes = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helicrash"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Loots = {
	{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4},
		["4"] = { item = "WEAPON_PISTOL50-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_PISTOL_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4},
		["4"] = { item = "WEAPON_SNSPISTOL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_PISTOL_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4},
		["4"] = { item = "WEAPON_VINTAGEPISTOL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_PISTOL_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4},
		["4"] = { item = "WEAPON_PISTOL_MK2-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_PISTOL_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4},
		["4"] = { item = "WEAPON_SNSPISTOL_MK2-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_PISTOL_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_MACHINEPISTOL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_MICROSMG-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_ASSAULTSMG-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_MINISMG-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_SMG_MK2-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_APPISTOL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 100 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_ADVANCEDRIFLE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_COMPACTRIFLE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_COLTXM177-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_BULLPUPRIFLE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_ASSAULTRIFLE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_HEAVYRIFLE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_FNSCAR-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_SPECIALCARBINE-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_PARAFAL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_FNFAL-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 2 },
		["2"] = { item = "meth", amount = 2 },
		["3"] = { item = "gauze", amount = 2 },
		["4"] = { item = "WEAPON_QBZ83-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_RIFLE_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 3 },
		["2"] = { item = "meth", amount = 3 },
		["3"] = { item = "gauze", amount = 3 },
		["4"] = { item = "WEAPON_GUSENBERG-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 120 },
		["6"] = { item = "dollars2", amount = 10000 }
	},{
		["1"] = { item = "analgesic", amount = 4 },
		["2"] = { item = "meth", amount = 4 },
		["3"] = { item = "gauze", amount = 4 },
		["4"] = { item = "WEAPON_GUSENBERG-"..os.time(), amount = 1 },
		["5"] = { item = "WEAPON_SMG_AMMO", amount = 90 },
		["6"] = { item = "dollars2", amount = 10000 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
local function ThreadTick()
	if TimersNotify[os.date("%H:%M")] then
		TriggerClientEvent("Notify",-1,"azul","A torre de controle recebeu a informação que uma <b>Aeronave</b> está com problemas mecânicos e está em queda livre, parece que em <b>5 minutos</b> a mesma vai colidir com o solo.","Queda de Aeronave",30000)
	end

	if Timers[os.date("%H:%M")] and not GlobalState["Helicrash"] then
		LootBoxes = 0
		local Selected = math.random(#Components)
		for Number,v in pairs(Components[Selected]) do
			if Number ~= "1" then
				LootBoxes = LootBoxes + 1

				local Loot = math.random(#Loots)
				vRP.RemoveServerData("Helicrash:"..Number)
				TriggerEvent("chest:Cooldown","Helicrash:"..Number)
				vRP.SetServerData("Helicrash:"..Number,Loots[Loot])
			end
		end

		TriggerClientEvent("Notify",-1,"azul","Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.","Queda de Aeronave",30000)
		GlobalState["Helicrash"] = Selected
	end

	SetTimeout(30000,ThreadTick)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
ThreadTick()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOX
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Box",function()
	if GlobalState["Helicrash"] then
		LootBoxes = LootBoxes - 1

		if LootBoxes <= 0 then
			GlobalState["Helicrash"] = false
			LootBoxes = 0
		end
	end
end)