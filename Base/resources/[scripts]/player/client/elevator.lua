-----------------------------------------------------------------------------------------------------------------------------------------
-- POINTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Points = {
	{ 344.3,-586.15,28.8, "Hospital" },
	{ 345.61,-582.54,28.8, "Hospital" },
	{ 332.37,-595.66,43.29, "Hospital" },
	{ 330.41,-601.18,43.29, "Hospital" },
	{ 327.08,-603.87,43.29, "Hospital" },
	{ 338.51,-583.84,74.16, "Hospital" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ELEVATOR
-----------------------------------------------------------------------------------------------------------------------------------------
local Elevator = {
	["Hospital"] = {
		["Floors"] = {
			[1] = {["Name"] = "Térreo", ["Coords"] = {344.31, -586.11, 28.8}},
			[2] = {["Name"] = "Primeiro", ["Coords"] = {332.39, -595.72, 43.29}},
			[3] = {["Name"] = "Cobertura", ["Coords"] = {338.51, -583.84, 74.16}},
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADELEVATORS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		for _,v in pairs(Points) do
			local Distance = #(Coords - vec3(v[1],v[2],v[3]))
			if Distance <= 2.5 then
				TimeDistance = 1

				if IsControlJustPressed(1, 38) then
					if not GlobalState["Blackout"] then
						local sortedFloors = {}
						for k, v in pairs(Elevator[v[4]]["Floors"]) do
							table.insert(sortedFloors, {id = k, name = v["Name"], coords = v["Coords"]})
						end

						local function compare(a, b)
							return a.id < b.id
						end

						table.sort(sortedFloors, compare)

						for _, floor in ipairs(sortedFloors) do
							exports["dynamic"]:AddButton(floor.name, "Clique para ir para o andar de número <b>"..floor.id.."</b>.", "player:Elevator", floor.coords, false, true)
						end

						exports["dynamic"]:openMenu()
					else
						TriggerEvent("Notify", "vermelho", "Os <b>Elevadores</b> não estão funcionando pois estamos sem eletricidade.", "Aviso", 5000)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)