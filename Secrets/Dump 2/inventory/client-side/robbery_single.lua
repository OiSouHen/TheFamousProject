-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATION
-----------------------------------------------------------------------------------------------------------------------------------------
local Location = {
	["1"] = { ["Coords"] = vec4(256.35,-47.51,69.7,249.76), ["Mode"] = "Ammunation" },
	["2"] = { ["Coords"] = vec4(846.13,-1036.62,27.95,178.74), ["Mode"] = "Ammunation" },
	["3"] = { ["Coords"] = vec4(-335.18,6083.29,31.21,45.57), ["Mode"] = "Ammunation" },
	["4"] = { ["Coords"] = vec4(-665.98,-932.24,21.58,358.38), ["Mode"] = "Ammunation" },
	["5"] = { ["Coords"] = vec4(-1301.93,-391.36,36.45,255.85), ["Mode"] = "Ammunation" },
	["6"] = { ["Coords"] = vec4(-1122.59,2698.25,18.31,42.82), ["Mode"] = "Ammunation" },
	["7"] = { ["Coords"] = vec4(2571.67,291.28,108.49,180.02), ["Mode"] = "Ammunation" },
	["8"] = { ["Coords"] = vec4(2571.66,291.29,108.49,181.06), ["Mode"] = "Ammunation" },
	["9"] = { ["Coords"] = vec4(19.57,-1103.0,29.55,339.07), ["Mode"] = "Ammunation" },
	["10"] = { ["Coords"] = vec4(813.92,-2160.34,29.37,179.33), ["Mode"] = "Ammunation" },
	["11"] = { ["Coords"] = vec4(1688.78,3759.13,34.46,47.5), ["Mode"] = "Ammunation" },

	["12"] = { ["Coords"] = vec4(28.18,-1338.55,29.24,359.45), ["Mode"] = "Department" },
	["13"] = { ["Coords"] = vec4(2548.61,384.87,108.36,87.98), ["Mode"] = "Department" },
	["14"] = { ["Coords"] = vec4(1159.12,-316.72,68.95,100.36), ["Mode"] = "Department" },
	["15"] = { ["Coords"] = vec4(-710.58,-906.72,18.96,90.17), ["Mode"] = "Department" },
	["16"] = { ["Coords"] = vec4(-45.73,-1749.8,29.17,50.77), ["Mode"] = "Department" },
	["17"] = { ["Coords"] = vec4(378.3,334.01,103.31,346.27), ["Mode"] = "Department" },
	["18"] = { ["Coords"] = vec4(-3250.66,1004.43,12.57,85.32), ["Mode"] = "Department" },
	["19"] = { ["Coords"] = vec4(1735.06,6421.41,34.78,333.6), ["Mode"] = "Department" },
	["20"] = { ["Coords"] = vec4(546.53,2662.18,41.89,186.7), ["Mode"] = "Department" },
	["21"] = { ["Coords"] = vec4(1958.93,3749.46,32.09,30.17), ["Mode"] = "Department" },
	["22"] = { ["Coords"] = vec4(2672.21,3286.9,54.98,61.68), ["Mode"] = "Department" },
	["23"] = { ["Coords"] = vec4(1706.27,4922.6,41.81,324.6), ["Mode"] = "Department" },
	["24"] = { ["Coords"] = vec4(-1828.06,796.31,137.93,132.2), ["Mode"] = "Department" },
	["25"] = { ["Coords"] = vec4(-3048.43,585.41,7.66,106.96), ["Mode"] = "Department" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Location) do
		exports["target"]:AddBoxZone("RobberySingle:"..Number,v["Coords"]["xyz"],0.895,0.875,{
			name = "RobberySingle:"..Number,
			heading = v["Coords"]["w"],
			minZ = v["Coords"]["z"] - 0.75,
			maxZ = v["Coords"]["z"] + 0.75
		},{
			shop = Number,
			Distance = 1.25,
			options = {
				{
					event = "inventory:RobberySingle",
					tunnel = "server",
					label = "Roubar",
					service = v["Mode"]
				}
			}
		})
	end
end)