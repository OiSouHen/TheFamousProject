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
Tunnel.bindInterface("doors", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	["1"] = { Coords = vec3(431.41, -999.59, 28.68), Hash = 2130672747, Disabled = false, Lock = true, Distance = 7, Perm = "Policia" },
	["2"] = { Coords = vec3(452.30, -1000.80, 28.68), Hash = 2130672747, Disabled = false, Lock = true, Distance = 7, Perm = "Policia" },
	["3"] = { Coords = vec3(488.89, -1016.89, 27.14), Hash = -1603817716, Disabled = false, Lock = true, Distance = 7, Perm = "Policia" },
	["4"] = { Coords = vec3(476.61, -1008.87, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["5"] = { Coords = vec3(481.00, -1004.11, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["6"] = { Coords = vec3(477.91, -1012.18, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["7"] = { Coords = vec3(480.91, -1012.18, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["8"] = { Coords = vec3(483.91, -1012.18, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["9"] = { Coords = vec3(486.91, -1012.18, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["10"] = { Coords = vec3(484.17, -1007.73, 26.48), Hash = -53345114, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["11"] = { Coords = vec3(440.52, -977.60, 30.82), Hash = 2888281650, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["12"] = { Coords = vec3(440.52, -986.23, 30.82), Hash = 4198287975, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["13"] = { Coords = vec3(479.75, -999.62, 30.78), Hash = -692649124, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["14"] = { Coords = vec3(487.43, -1000.18, 30.78), Hash = -692649124, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["15"] = { Coords = vec3(467.36, -1014.40, 26.48), Hash = -692649124, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "16" },
	["16"] = { Coords = vec3(469.77, -1014.40, 26.48), Hash = -692649124, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "15" },
	["17"] = { Coords = vec3(440.73, -998.74, 30.81), Hash = -1547307588, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "18" },
	["18"] = { Coords = vec3(443.06, -998.74, 30.81), Hash = -1547307588, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "17" },
	["19"] = { Coords = vec3(458.20, -972.25, 30.81), Hash = -1547307588, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "20" },
	["20"] = { Coords = vec3(455.88, -972.25, 30.81), Hash = -1547307588, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia", Other = "19" },

	["21"] = { Coords = vec3(1844.99, 2604.81, 44.63), Hash = 741314661, Disabled = false, Lock = true, Distance = 7, Perm = "Emergencia" },
	["22"] = { Coords = vec3(1818.54, 2604.40, 44.61), Hash = 741314661, Disabled = false, Lock = true, Distance = 7, Perm = "Emergencia" },

	["23"] = { Coords = vec3(1837.91, 2590.25, 46.19), Hash = 539686410, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["24"] = { Coords = vec3(1768.54, 2498.41, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["25"] = { Coords = vec3(1765.40, 2496.59, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["26"] = { Coords = vec3(1762.25, 2494.77, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["27"] = { Coords = vec3(1755.96, 2491.14, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["28"] = { Coords = vec3(1752.81, 2489.33, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["29"] = { Coords = vec3(1749.67, 2487.51, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["30"] = { Coords = vec3(1758.07, 2475.39, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["31"] = { Coords = vec3(1761.22, 2477.20, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["32"] = { Coords = vec3(1764.36, 2479.02, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["33"] = { Coords = vec3(1767.51, 2480.84, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["34"] = { Coords = vec3(1770.66, 2482.65, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["35"] = { Coords = vec3(1773.80, 2484.47, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["36"] = { Coords = vec3(1776.95, 2486.29, 45.88), Hash = 913760512, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["37"] = { Coords = vec3(383.40, 798.29, 187.61), Hash = 517369125, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["38"] = { Coords = vec3(382.96, 796.82, 187.61), Hash = 517369125, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["39"] = { Coords = vec3(378.75, 796.83, 187.61), Hash = 517369125, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["40"] = { Coords = vec3(398.15, -1607.52, 28.34), Hash = 1286535678, Disabled = false, Lock = true, Distance = 7, Perm = "Policia" },
	-- [41"] = { Coords = vec3(413.09,-1619.81,28.34), Hash = -1483471451, Disabled = false, Lock = true, Distance = 7, Perm = "Policia", Disabled = true }, -- Impound
	-- [42"] = { Coords = vec3(418.54,-1651.08,28.29), Hash = -1483471451, Disabled = false, Lock = true, Distance = 7, Perm = "Policia", Disabled = true }, -- Impound
	["43"] = { Coords = vec3(1861.75, 3687.30, 33.01), Hash = 1286535678, Disabled = false, Lock = true, Distance = 7, Perm = "Policia" },
	["44"] = { Coords = vec3(-443.64, 6006.97, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["45"] = { Coords = vec3(-442.24, 6012.61, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["46"] = { Coords = vec3(-445.94, 6012.88, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["47"] = { Coords = vec3(-448.91, 6015.85, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["48"] = { Coords = vec3(-446.36, 6018.40, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["49"] = { Coords = vec3(-443.39, 6015.43, 27.73), Hash = -594854737, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["51"] = { Coords = vec3(369.06, -1605.68, 29.94), Hash = -674638964, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["52"] = { Coords = vec3(368.26, -1605.01, 29.94), Hash = -674638964, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["53"] = { Coords = vec3(375.07, -1598.43, 25.34), Hash = -674638964, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["54"] = { Coords = vec3(375.87, -1599.10, 25.34), Hash = -674638964, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["61"] = { Coords = vec3(1813.55, 3675.05, 34.39), Hash = 2010487154, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["62"] = { Coords = vec3(1810.13, 3676.46, 34.39), Hash = 2010487154, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["63"] = { Coords = vec3(1808.62, 3679.06, 34.39), Hash = 2010487154, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["64"] = { Coords = vec3(1807.13, 3681.66, 34.39), Hash = 2010487154, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },
	["65"] = { Coords = vec3(391.86, -1636.07, 29.97), Hash = -1156020871, Disabled = false, Lock = true, Distance = 1.5, Perm = "Policia" },

	["71"] = { Coords = vec3(309.13, -597.75, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },

	["72"] = { Coords = vec3(307.11, -569.56, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Emergencia" },

	["73"] = { Coords = vec3(336.16, -580.14, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["74"] = { Coords = vec3(340.78, -581.82, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["75"] = { Coords = vec3(346.77, -584.00, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["76"] = { Coords = vec3(339.00, -586.70, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["77"] = { Coords = vec3(360.50, -588.99, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["78"] = { Coords = vec3(358.72, -593.88, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["79"] = { Coords = vec3(352.19, -594.14, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["80"] = { Coords = vec3(350.83, -597.89, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["81"] = { Coords = vec3(345.51, -597.35, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["82"] = { Coords = vec3(346.88, -593.59, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["83"] = { Coords = vec3(356.12, -583.36, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["84"] = { Coords = vec3(357.49, -579.61, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["85"] = { Coords = vec3(303.95, -572.55, 43.43), Hash = 854291622, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico" },
	["86"] = { Coords = vec3(324.23, -589.22, 43.43), Hash = -434783486, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "87" },
	["87"] = { Coords = vec3(326.65, -590.10, 43.43), Hash = -1700911976, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "86" },
	["88"] = { Coords = vec3(312.00, -571.34, 43.43), Hash = -434783486, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "89" },
	["89"] = { Coords = vec3(314.42, -572.22, 43.43), Hash = -1700911976, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "88" },
	["90"] = { Coords = vec3(317.84, -573.46, 43.43), Hash = -434783486, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "91" },
	["91"] = { Coords = vec3(320.26, -574.34, 43.43), Hash = -1700911976, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "90" },
	["92"] = { Coords = vec3(323.23, -575.42, 43.43), Hash = -434783486, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "93" },
	["93"] = { Coords = vec3(325.65, -576.30, 43.43), Hash = -1700911976, Disabled = false, Lock = true, Distance = 1.5, Perm = "Paramedico", Other = "92" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Doors"][Number] then
		if GlobalState["Doors"][Number]["Perm"] and vRP.HasGroup(Passport,GlobalState["Doors"][Number]["Perm"]) then
			local Doors = GlobalState["Doors"]

			Doors[Number]["Lock"] = not Doors[Number]["Lock"]

			if Doors[Number]["Other"] then
				local Second = Doors[Number]["Other"]
				Doors[Second]["Lock"] = not Doors[Second]["Lock"]
			end

			GlobalState:set("Doors",Doors,true)

			vRPC.PlayAnim(source,true,{"anim@heists@keycard@","exit"},false)
			Wait(350)
			vRPC.Destroy(source)
		end
	end
end