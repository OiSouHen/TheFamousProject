-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number, v["Coords"], 2.0, 1.0, {
			name = "Beds:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.10,
			maxZ = v["Coords"]["z"] + 0.50
		}, {
			shop = Number,
			Distance = 1.50,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				}, {
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
RegisterNetEvent("target:PutBed")
AddEventHandler("target:PutBed", function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped, Beds[Number]["Coords"]["x"], Beds[Number]["Coords"]["y"], Beds[Number]["Coords"]["z"] - 1, false, false, false, false)
		vRP.PlayAnim(false, { "amb@world_human_sunbathe@female@back@idle_a", "idle_a" }, true)
		SetEntityHeading(Ped, Beds[Number]["Heading"] - 180.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed", function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped, Previous["x"], Previous["y"], Previous["z"] - 1, false, false, false, false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment", function(Number)
	if not Previous and vSERVER.CheckIn() then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped, Beds[Number]["Coords"]["x"], Beds[Number]["Coords"]["y"], Beds[Number]["Coords"]["z"] - 1, false, false, false, false)
		vRP.PlayAnim(false, { "amb@world_human_sunbathe@female@back@idle_a", "idle_a" }, true)
		SetEntityHeading(Ped, Beds[Number]["Heading"] - 180.0)

		TriggerEvent("inventory:PreventWeapon")
		LocalPlayer["state"]:set("Commands", true, true)
		LocalPlayer["state"]:set("Buttons", true, true)
		LocalPlayer["state"]:set("Cancel", true, true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")

		if GetEntityHealth(Ped) <= 100 then
			exports["survival"]:Revive(101)
		end

		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment", function()
	if not Treatment then
		LocalPlayer["state"]:set("Commands", true, true)
		LocalPlayer["state"]:set("Buttons", true, true)
		LocalPlayer["state"]:set("Cancel", true, true)
		NetworkSetFriendlyFireOption(false)
		TriggerEvent("paramedic:Reset")
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Previous and not IsEntityPlayingAnim(Ped, "amb@world_human_sunbathe@female@back@idle_a", "idle_a", 3) then
			SetEntityCoords(Ped, Previous["x"], Previous["y"], Previous["z"] - 1, false, false, false, false)
			Previous = nil
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Treatment then
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health < 200 then
					SetEntityHealth(Ped, Health + 1)
				else
					Treatment = false
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("Cancel", false, true)
					LocalPlayer["state"]:set("Buttons", false, true)
					LocalPlayer["state"]:set("Commands", false, true)
					TriggerEvent("Notify", "verde", "Tratamento concluido.", "Sucesso", 5000)
				end
			end
		end

		Wait(1000)
	end
end)