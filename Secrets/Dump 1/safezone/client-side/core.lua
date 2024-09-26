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
Tunnel.bindInterface("safezone",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = false
local LastVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Safezone = {
	["1"] = {
		["PolyZone"] = PolyZone:Create({
			vector2(205.79,-1024.9),
			vector2(208.78,-1025.24),
			vector2(211.59,-1023.95),
			vector2(213.45,-1021.75),
			vector2(265.77,-877.37),
			vector2(265.96,-872.18),
			vector2(263.66,-867.45),
			vector2(260.59,-865.25),
			vector2(253.69,-862.65),
			vector2(250.3,-863.26),
			vector2(246.89,-864.0),
			vector2(196.15,-845.44),
			vector2(194.17,-843.28),
			vector2(191.79,-840.11),
			vector2(186.61,-840.59),
			vector2(183.84,-843.67),
			vector2(174.82,-866.8),
			vector2(169.77,-877.06),
			vector2(162.94,-886.97),
			vector2(159.76,-893.61),
			vector2(126.22,-985.71),
			vector2(126.45,-990.34),
			vector2(129.62,-993.36),
			vector2(152.5,-1001.3),
			vector2(155.39,-1006.91),
			vector2(157.51,-1008.65),
			vector2(162.7,-1010.22),
			vector2(169.57,-1007.15),
			vector2(192.45,-1014.76),
			vector2(195.25,-1020.51),
			vector2(198.78,-1022.51)
		},{
			["name"] = "Square",
			["minZ"] = 28.00,
			["maxZ"] = 35.00
		})
	},
	["2"] = {
		["PolyZone"] = PolyZone:Create({
			vec2(-1218.14,252.22),
			vec2(-1239.3,246.04),
			vec2(-1261.52,238.29),
			vec2(-1281.3,234.52),
			vec2(-1312.87,231.62),
			vec2(-1344.69,229.55),
			vec2(-1361.57,226.19),
			vec2(-1389.08,218.26),
			vec2(-1402.49,224.27),
			vec2(-1417.52,246.11),
			vec2(-1424.49,262.3),
			vec2(-1427.67,281.13),
			vec2(-1425.56,303.54),
			vec2(-1409.92,335.11),
			vec2(-1396.31,351.75),
			vec2(-1380.52,364.84),
			vec2(-1363.63,374.88),
			vec2(-1337.74,385.32),
			vec2(-1315.23,390.69),
			vec2(-1204.83,398.72),
			vec2(-1196.33,390.89),
			vec2(-1196.1,379.22),
			vec2(-1194.06,359.11),
			vec2(-1185.82,345.71),
			vec2(-1175.06,335.69),
			vec2(-1166.45,325.77),
			vec2(-1215.91,310.32),
			vec2(-1215.37,293.83),
			vec2(-1219.8,280.82),
			vec2(-1224.11,272.68)
		},{
			["name"] = "Hospital",
			["minZ"] = 25.0,
			["maxZ"] = 100.0
		})
	},
	["3"] = {
		["PolyZone"] = PolyZone:Create({
			vec2(-1199.61,-1581.87),
			vec2(-1213.14,-1562.13),
			vec2(-1211.40,-1556.20),
			vec2(-1203.11,-1555.18),
			vec2(-1188.46,-1575.63)
		},{
			["name"] = "Academia",
			["minZ"] = 0.0,
			["maxZ"] = 50.0
		})
	},
	["4"] = {
		["PolyZone"] = PolyZone:Create({
			vec2(-1114.40,-2038.32),
			vec2(-1200.31,-2124.32),
			vec2(-1143.16,-2181.46),
			vec2(-1058.16,-2095.39)
		},{
			["name"] = "Mecanica",
			["minZ"] = 0.0,
			["maxZ"] = 50.0
		})
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetGhostedEntityAlpha(254)

	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Index,v in pairs(Safezone) do
			if v["PolyZone"]:isPointInside(Coords) then
				if not Active then
					Active = Index
					NetworkSetFriendlyFireOption(false)
					LocalPlayer["state"]:set("Safezone",Active,true)
					LocalPlayer["state"]:set("Cyndaquil",true,false)
					SetEntityInvincible(Ped,true)
					SetLocalPlayerAsGhost(true)

					if IsPedArmed(Ped,7) then
						TriggerEvent("inventory:CleanWeapons",true)
					end
				end
			else
				if Active and Active == Index then
					Active = false

					SetLocalPlayerAsGhost(false)
					SetEntityInvincible(Ped,false)
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("Safezone",Active,true)
					LocalPlayer["state"]:set("Cyndaquil",false,false)
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			TimeDistance = 1

			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,68,true)
			DisableControlAction(0,69,true)
			DisableControlAction(0,70,true)
			DisableControlAction(0,91,true)
			DisableControlAction(0,92,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,257,true)

			local Ped = PlayerPedId()
			DisablePlayerFiring(Ped,true)

			if IsPedInAnyVehicle(Ped) then
				if not LastVehicle then
					LastVehicle = GetPlayersLastVehicle()
					SetNetworkVehicleAsGhost(LastVehicle,true)
				end
			else
				if LastVehicle and DoesEntityExist(LastVehicle) then
					SetNetworkVehicleAsGhost(LastVehicle,false)
					LastVehicle = false
				end
			end
		end

		Wait(TimeDistance)
	end
end)