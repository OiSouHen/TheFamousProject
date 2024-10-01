-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("plants", Hensa)
vSERVER = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	-- Vermelho
	LoadModel("prop_stoneshroom1")

	-- Verde
	LoadModel("prop_stoneshroom2")

	-- Broto
	LoadModel("bkr_prop_weed_01_small_01c")

	-- Pequena
	LoadModel("bkr_prop_weed_01_small_01a")

	-- Média
	LoadModel("bkr_prop_weed_med_01a")

	-- Grande
	LoadModel("bkr_prop_weed_lrg_01a")

	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Index, v in pairs(Plants) do
			local OtherCoords = vec3(v["Coords"][1], v["Coords"][2], v["Coords"][3])
			if #(Coords - OtherCoords) <= 100 then
				if not Objects[Index] and v["Route"] == LocalPlayer["state"]["Route"] then
					exports["target"]:AddBoxZone("Plants:"..Index, OtherCoords, 0.6, 0.6, {
						name = "Plants:"..Index,
						heading = 0.0
					}, {
						shop = Index,
						Distance = 1.5,
						options = {
							{
								event = "plants:Informations",
								label = "Verificar",
								tunnel = "shop"
							}, {
								event = "plants:Fertilizer",
								label = "Fertilizar",
								tunnel = "shop"
							}
						}
					})

					Objects[Index] = CreateObjectNoOffset(v["Model"], OtherCoords, false, false, false)

					FreezeEntityPosition(Objects[Index], true)
					SetEntityLodDist(Objects[Index], 0xFFFF)
					SetModelAsNoLongerNeeded(v["Model"])

					if v["Model"] == "prop_stoneshroom1" or v["Model"] == "prop_stoneshroom2" then
						SetEntityCollision(Objects[Index], false, false)
					else
						SetEntityCollision(Objects[Index], true, true)
					end
				end
			else
				if Objects[Index] then
					if DoesEntityExist(Objects[Index]) then
						exports["target"]:RemCircleZone("Plants:"..Index)
						DeleteEntity(Objects[Index])
					end

					Objects[Index] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Informations")
AddEventHandler("plants:Informations", function(Number)
	local Informations = vSERVER.Informations(Number)
	if Informations then
		exports["dynamic"]:AddButton("Vida", Informations[3], false, false, false, false)
		exports["dynamic"]:AddButton("Saúde", Informations[4], false, false, false, false)
		exports["dynamic"]:AddButton("Coletar", Informations[1], "plants:Collect", Number, false, true)
		exports["dynamic"]:AddButton("Clonagem", Informations[2], "plants:Cloning", Number, false, true)

		if LocalPlayer["state"]["Admin"] then
			exports["dynamic"]:AddButton("Remover", "Clique para remover esta plantação.", "plants:Remove", Number, false, true)
			exports["dynamic"]:AddButton("Administração", "Verificar informações da plantação.", "plants:Verify", Number, false, true)
		end

		exports["dynamic"]:openMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:FERTILIZER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Fertilizer")
AddEventHandler("plants:Fertilizer", function(Number)
	TriggerServerEvent("plants:Fertilizer", Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Table")
AddEventHandler("plants:Table", function(Table)
	Plants = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:NEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:New")
AddEventHandler("plants:New", function(Number, Table)
	Plants[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Remove")
AddEventHandler("plants:Remove", function(Number)
	Plants[Number] = nil

	if Objects[Number] then
		if DoesEntityExist(Objects[Number]) then
			exports["target"]:RemCircleZone("Plants:"..Number)
			DeleteEntity(Objects[Number])
		end

		Objects[Number] = nil
	end
end)