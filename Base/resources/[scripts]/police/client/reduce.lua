-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	vector4(1657.02,2548.57,45.56,0.75),
	vector4(1649.16,2538.66,45.35,0.35),
	vector4(1665.02,2568.67,45.55,0.75),
	vector4(1635.82,2489.26,45.54,0.70),
	vector4(1634.70,2489.16,45.54,0.70),
	vector4(1633.48,2489.03,45.05,0.25),
	vector4(1618.07,2521.04,45.53,0.25),
	vector4(1606.75,2541.28,45.55,0.25),
	vector4(1606.29,2541.70,45.35,0.25),
	vector4(1605.92,2542.18,45.55,0.25),
	vector4(1698.90,2534.57,45.41,0.25),
	vector4(1698.87,2535.34,45.34,0.25),
	vector4(1698.77,2532.05,45.45,0.25),
	vector4(1715.32,2567.16,45.55,0.35),
	vector4(1715.32,2567.94,45.55,0.35),
	vector4(1715.37,2568.76,45.55,0.35),
	vector4(1767.86,2566.11,45.05,0.35),
	vector4(1768.73,2566.27,45.25,0.35),
	vector4(1769.47,2566.16,45.25,0.30),
	vector4(1773.40,2538.06,45.05,0.35),
	vector4(1773.33,2536.57,45.52,0.35),
	vector4(1772.33,2535.53,44.95,0.35),
	vector4(1720.76,2502.44,45.23,0.75),
	vector4(1694.49,2507.13,45.18,0.75),
	vector4(1699.38,2472.39,45.25,0.35),
	vector4(1698.83,2471.86,45.25,0.35),
	vector4(1698.25,2471.30,45.05,0.35),
	vector4(1664.85,2515.65,45.25,0.35),
	vector4(1664.34,2515.07,45.25,0.35),
	vector4(1625.44,2567.95,45.45,0.35),
	vector4(1625.39,2567.08,45.45,0.35),
	vector4(1636.12,2554.23,45.25,0.35),
	vector4(1628.29,2543.19,45.25,0.35),
	vector4(1628.19,2542.58,44.98,0.35),
	vector4(1628.99,2542.65,44.97,0.35),
	vector4(1648.74,2536.77,45.56,0.35),
	vector4(1649.62,2535.84,44.87,0.35),
	vector4(1650.18,2535.33,44.85,0.35)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number = 1,#Locations do
		exports["target"]:AddCircleZone("Prison:"..Number,Locations[Number]["xyz"],Locations[Number]["w"],{
			name = "Prison:"..Number,
			heading = 0.0,
			useZ = true
		},{
			shop = tostring(Number),
			Distance = 2.0,
			options = {
				{
					event = "police:Reduce",
					tunnel = "server",
					label = "Vasculhar"
				}
			}
		})
	end
end)