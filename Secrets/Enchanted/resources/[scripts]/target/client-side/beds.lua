-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec4(316.28,-1416.90,32.25,139.98), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.46,-1415.38,32.25,140.38), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(312.58,-1413.79,32.25,140.41), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(310.73,-1412.25,32.25,140.11), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(308.84,-1410.66,32.25,140.05), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(306.99,-1409.10,32.25,139.96), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(304.99,-1407.43,32.25,140.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(303.17,-1405.90,32.25,139.84), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(310.10,-1404.32,32.25,50.000), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(311.68,-1402.43,32.25,50.330), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(313.23,-1400.59,32.25,50.150), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.82,-1398.70,32.25,50.020), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(322.02,-1396.00,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(323.84,-1397.53,32.25,320.23), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(325.72,-1399.11,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(327.57,-1400.66,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(329.46,-1402.25,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(331.31,-1403.80,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(333.30,-1405.47,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(335.13,-1407.00,32.25,320.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(326.63,-1408.37,32.25,230.01), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(325.05,-1410.25,32.25,230.17), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(323.50,-1412.09,32.25,230.00), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(321.91,-1413.99,32.25,230.09), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(314.45,-1407.28,32.25,139.96), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(316.35,-1408.88,32.25,139.35), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(318.19,-1410.42,32.25,139.60), ["Invert"] = 0.0 },
	-- Boolingbroke
	{ ["Coords"] = vec4(1761.87,2591.56,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1761.87,2594.64,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1761.87,2597.73,45.50,272.13), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2597.95,45.50,87.88), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2594.88,45.50,87.88), ["Invert"] = 180.0 },
	{ ["Coords"] = vec4(1771.98,2591.79,45.50,87.88), ["Invert"] = 180.0 },
	-- Clandestine
	{ ["Coords"] = vec4(-471.87,6287.56,13.63,53.86), ["Invert"] = 180.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,v["Coords"]["xyz"],2.0,1.0,{
			name = "Beds:"..Number,
			heading = v["Coords"]["w"],
			minZ = v["Coords"]["z"] - 0.25,
			maxZ = v["Coords"]["z"] + 0.50
		},{
			shop = Number,
			Distance = 1.50,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:PutBed",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 0.5)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Coords"]["w"] - Beds[Number]["Invert"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:Treatment",function(Number,Ignore)
	if not Previous and Beds[Number] and (Ignore or vSERVER.CheckIn()) then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 0.5)
		vRP.playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
		SetEntityHeading(Ped,Beds[Number]["Coords"]["w"] - Beds[Number]["Invert"])

		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")
		SetEntityInvincible(Ped,true)

		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(101)
		end

		Treatment = GetGameTimer() + 1000
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]:set("Commands",true,true)
		LocalPlayer["state"]:set("Buttons",true,true)
		LocalPlayer["state"]:set("Cancel",true,true)
		SetEntityInvincible(PlayerPedId(),true)
		NetworkSetFriendlyFireOption(false)
		Treatment = GetGameTimer() + 1000
		TriggerEvent("paramedic:Reset")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Treatment and GetGameTimer() >= Treatment then
			TimeDistance = 100
			Treatment = GetGameTimer() + 1000
			local Health = GetEntityHealth(Ped)

			if Health < 200 then
				SetEntityHealth(Ped,Health + 1)
			else
				Treatment = false
				SetEntityInvincible(Ped,false)
				NetworkSetFriendlyFireOption(true)
				LocalPlayer["state"]:set("Cancel",false,true)
				LocalPlayer["state"]:set("Buttons",false,true)
				LocalPlayer["state"]:set("Commands",false,true)
				TriggerEvent("Notify","Centro Médico","Tratamento concluido.","hospital",5000)
			end
		end

		if Previous and not IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 0.5)
			TimeDistance = 100
			Previous = nil
		end

		Wait(TimeDistance)
	end
end)