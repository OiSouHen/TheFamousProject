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
Tunnel.bindInterface("doors",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	-- Boolingbroke
	["1"] = { ["Coords"] = vec3(1844.99,2604.81,44.63), ["Hash"] = 741314661, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Emergencia" },
	["2"] = { ["Coords"] = vec3(1818.54,2604.40,44.61), ["Hash"] = 741314661, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Emergencia" },
	["3"] = { ["Coords"] = vec3(1837.91,2590.25,46.19), ["Hash"] = 539686410, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["4"] = { ["Coords"] = vec3(1768.54,2498.41,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["5"] = { ["Coords"] = vec3(1765.40,2496.59,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["6"] = { ["Coords"] = vec3(1762.25,2494.77,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["7"] = { ["Coords"] = vec3(1755.96,2491.14,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["8"] = { ["Coords"] = vec3(1752.81,2489.33,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["9"] = { ["Coords"] = vec3(1749.67,2487.51,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["10"] = { ["Coords"] = vec3(1758.07,2475.39,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["11"] = { ["Coords"] = vec3(1761.22,2477.20,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["12"] = { ["Coords"] = vec3(1764.36,2479.02,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["13"] = { ["Coords"] = vec3(1767.51,2480.84,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["14"] = { ["Coords"] = vec3(1770.66,2482.65,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["15"] = { ["Coords"] = vec3(1773.80,2484.47,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["16"] = { ["Coords"] = vec3(1776.95,2486.29,45.88), ["Hash"] = 913760512, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },

	-- Police Los Santos
	["17"] = { ["Coords"] = vec3(450.00,-990.75,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["18"] = { ["Coords"] = vec3(451.09,-991.29,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["19"] = { ["Coords"] = vec3(439.07,-997.62,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["20"] = { ["Coords"] = vec3(441.27,-978.02,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["21"] = { ["Coords"] = vec3(450.12,-978.02,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["22"] = { ["Coords"] = vec3(474.11,-1008.53,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["23"] = { ["Coords"] = vec3(476.76,-1008.53,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["24"] = { ["Coords"] = vec3(482.96,-1008.53,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["25"] = { ["Coords"] = vec3(485.63,-1008.53,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["26"] = { ["Coords"] = vec3(480.76,-1004.62,26.47), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["27"] = { ["Coords"] = vec3(480.76,-1000.51,26.47), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["28"] = { ["Coords"] = vec3(478.24,-1000.89,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["29"] = { ["Coords"] = vec3(478.24,-997.74,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["30"] = { ["Coords"] = vec3(482.27,-996.71,26.45), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["31"] = { ["Coords"] = vec3(484.34,-1002.88,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["32"] = { ["Coords"] = vec3(484.34,-998.30,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["33"] = { ["Coords"] = vec3(478.99,-987.70,26.45), ["Hash"] = -113421396, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["34"] = { ["Coords"] = vec3(477.40,-989.74,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["35"] = { ["Coords"] = vec3(472.67,-989.74,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["36"] = { ["Coords"] = vec3(472.67,-986.96,26.56), ["Hash"] = -300093563, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["37"] = { ["Coords"] = vec3(477.40,-986.96,26.56), ["Hash"] = 11515395, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["38"] = { ["Coords"] = vec3(481.11,-986.87,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["39"] = { ["Coords"] = vec3(485.40,-986.93,25.41), ["Hash"] = -691335480, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["40"] = { ["Coords"] = vec3(440.38,-987.22,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "41" },
	["41"] = { ["Coords"] = vec3(440.38,-989.82,30.83), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "40" },
	["42"] = { ["Coords"] = vec3(470.02,-972.02,30.84), ["Hash"] = 1239973900, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "43" },
	["43"] = { ["Coords"] = vec3(467.42,-972.02,30.84), ["Hash"] = -1095702117, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "42" },
	["44"] = { ["Coords"] = vec3(470.01,-1014.50,26.53), ["Hash"] = -158854912, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "45" },
	["45"] = { ["Coords"] = vec3(467.41,-1014.50,26.53), ["Hash"] = 794198680, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "44" },
	["46"] = { ["Coords"] = vec3(467.41,-1004.54,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "47" },
	["47"] = { ["Coords"] = vec3(470.01,-1004.54,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "46" },
	["48"] = { ["Coords"] = vec3(471.24,-1007.89,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "49" },
	["49"] = { ["Coords"] = vec3(471.24,-1005.29,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "48" },
	["50"] = { ["Coords"] = vec3(457.59,-979.61,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "51" },
	["51"] = { ["Coords"] = vec3(457.59,-982.21,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "50" },
	["52"] = { ["Coords"] = vec3(457.59,-994.26,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "53" },
	["53"] = { ["Coords"] = vec3(457.59,-991.66,26.53), ["Hash"] = 1079515784, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia", ["Other"] = "52" },
	["54"] = { ["Coords"] = vec3(451.38,-1001.22,26.69), ["Hash"] = -246583363, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Policia" },
	["55"] = { ["Coords"] = vec3(432.54,-1001.23,26.75), ["Hash"] = -246583363, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 7.0, ["Perm"] = "Policia" },
	["56"] = { ["Coords"] = vec3(425.75,-998.76,30.83), ["Hash"] = 794198680, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },

	-- Police Sandy Shores
	["61"] = { ["Coords"] = vec3(1853.43,3705.59,34.30), ["Hash"] = -1385904007, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["62"] = { ["Coords"] = vec3(1856.81,3702.30,34.39), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["63"] = { ["Coords"] = vec3(1858.54,3703.30,34.39), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["64"] = { ["Coords"] = vec3(1861.98,3702.18,34.39), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["65"] = { ["Coords"] = vec3(1861.89,3705.24,34.39), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["66"] = { ["Coords"] = vec3(1865.03,3707.03,34.39), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["67"] = { ["Coords"] = vec3(1871.79,3710.73,34.39), ["Hash"] = -1919309060, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" },
	["68"] = { ["Coords"] = vec3(1855.33,3699.84,34.39), ["Hash"] = 385070503, ["Disabled"] = false, ["Lock"] = true, ["Distance"] = 1.75, ["Perm"] = "Policia" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Doors"][Number] and GlobalState["Doors"][Number]["Perm"] and vRP.HasGroup(Passport,GlobalState["Doors"][Number]["Perm"]) then
		local Doors = GlobalState["Doors"]

		Doors[Number]["Lock"] = not Doors[Number]["Lock"]

		if Doors[Number]["Other"] then
			local Second = Doors[Number]["Other"]
			Doors[Second]["Lock"] = not Doors[Second]["Lock"]
		end

		GlobalState:set("Doors",Doors,true)
	end
end