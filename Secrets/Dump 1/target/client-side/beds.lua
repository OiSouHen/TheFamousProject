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
	{ ["Coords"] = vec4(-1246.87,341.55,64.64,184.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1249.69,341.30,64.64,184.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1252.59,341.05,64.64,184.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1252.37,349.74,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1249.61,349.98,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1246.91,350.22,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1245.06,335.14,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1248.20,334.86,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1251.28,334.59,64.64,4.99), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1251.09,325.84,64.64,185.0), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1248.13,326.09,64.64,185.0), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(-1245.12,326.36,64.64,185.0), ["Invert"] = 0.0 },
	-- Boolingbroke
	{ ["Coords"] = vec4(1761.87,2591.56,45.50,272.13), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(1761.87,2594.64,45.50,272.13), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(1761.87,2597.73,45.50,272.13), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(1771.98,2597.95,45.50,87.88), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(1771.98,2594.88,45.50,87.88), ["Invert"] = 0.0 },
	{ ["Coords"] = vec4(1771.98,2591.79,45.50,87.88), ["Invert"] = 0.0 },
	-- Clandestine
	{ ["Coords"] = vec4(-471.87,6287.56,13.63,53.86), ["Invert"] = 0.0 }
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

		LocalPlayer["state"]:set("Cyndaquil",true,false)
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
		LocalPlayer["state"]:set("Cyndaquil",true,false)
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
				LocalPlayer["state"]:set("Cyndaquil",false,false)
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