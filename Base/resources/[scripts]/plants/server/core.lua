-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("plants", Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
local PlantsAmount = math.random(2)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTSTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local PlantsTypes = {
	["mushseed"] = { "mushseed", "Cogumelo", "mushroom" },
	["weedclone"] = { "weedclone", "Maconha", "weedbud" },
	["weedclone2"] = { "weedclone2", "Maconha", "weedbud" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Plants", function(Model, Owner, Coords, Route, Points, Type)
	local Number = 1
	while Plants[tostring(Number)] do
		Number = Number + 1
	end

	local plantData = {
		["Model"] = Model,
		["Type"] = Type,
		["Owner"] = Owner,
		["Coords"] = {mathLength(Coords.x), mathLength(Coords.y), mathLength(Coords.z)},
		["Time"] = os.time() + 10800,
		["Points"] = Points,
		["Fertilizer"] = 0,
		["Route"] = Route
	}

	Plants[tostring(Number)] = plantData

	TriggerClientEvent("plants:New", -1, tostring(Number), plantData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPLANT
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePlant(Number, source)
	Plants[Number] = nil
	TriggerClientEvent("plants:Remove", -1, Number)
	TriggerClientEvent("dynamic:Close", source)
	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.Destroy(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Collect")
AddEventHandler("plants:Collect", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local currentTime = os.time()
		local plantTime = Plants[Number]["Time"]
		local timeDifference = currentTime - plantTime

		if timeDifference > 3600 then
			RemovePlant(Number, source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		elseif currentTime >= plantTime then
			local temporary = Plants[Number]
			local plantType = PlantsTypes[temporary["Type"]]
			local ItemWeight = ItemWeight(plantType[3])

			if plantType[1] == "weedclone" then
				plantsAmount = math.random(2)
			elseif plantType[1] == "weedclone2" then
				plantsAmount = math.random(3, 4)
			elseif plantType[1] == "mushseed" then
				plantsAmount = math.random(2)
			end

			local totalWeight = vRP.InventoryWeight(Passport) + ItemWeight * plantsAmount
			if totalWeight <= vRP.GetWeight(Passport) then
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("dynamic:Close", source)
				TriggerClientEvent("Progress", source, "Coletando", 10000)
				vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

				Wait(10000)

				vRP.GenerateItem(Passport, plantType[3].."-"..temporary["Points"], plantsAmount, true)

				if plantType[3] == "weedbud" then
					vRP.GenerateItem(Passport, "bucket", 1, true)
				end

				RemovePlant(Number, source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Sua recompensa caiu no chão.", "Mochila Sobrecarregada", 5000)
				exports["inventory"]:Drops(Passport, source, plantType[3].."-"..temporary["Points"], plantsAmount)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:CLONING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Cloning")
AddEventHandler("plants:Cloning", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local currentTime = os.time()
		local plantTime = Plants[Number]["Time"]
		local timeDifference = currentTime - plantTime

		if timeDifference > 3600 then
			RemovePlant(Number, source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		elseif plantTime - currentTime <= 5400 then
			local temporary = Plants[Number]
			local plantType = PlantsTypes[temporary["Type"]]
			local ItemWeight = ItemWeight(plantType[1])
			local plantsAmount

			if plantType[1] == "weedclone" then
				plantsAmount = math.random(2)
			elseif plantType[1] == "weedclone2" then
				plantsAmount = math.random(3, 4)
			elseif plantType[1] == "mushseed" then
				plantsAmount = math.random(2)
			end

			local totalWeight = vRP.InventoryWeight(Passport) + ItemWeight * plantsAmount
			if totalWeight <= vRP.GetWeight(Passport) then
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("dynamic:Close", source)
				TriggerClientEvent("Progress", source, "Clonando", 10000)
				vRPC.PlayAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

				Wait(10000)

				local points = parseInt(temporary["Points"]) + 1
				if points > 100 then
					points = 100
				end

				vRP.GenerateItem(Passport, plantType[1].."-"..points, plantsAmount, true)

				if plantType[1] == "weedclone" or plantType[1] == "weedclone2" then
					vRP.GenerateItem(Passport, "bucket", 1, true)
				end

				RemovePlant(Number, source)
			else
				TriggerClientEvent("Notify", source, "amarelo", "Sua recompensa caiu no chão.", "Mochila Sobrecarregada", 5000)
				exports["inventory"]:Drops(Passport, source, plantType[1].."-"..points, plantsAmount)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:FERTILIZER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Fertilizer")
AddEventHandler("plants:Fertilizer", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local currentTime = os.time()
		local plantTime = Plants[Number]["Time"]
		local timeDifference = currentTime - plantTime

		if timeDifference > 3600 then
			RemovePlant(Number, source)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
		else
			local fertilizerLimit = 3
			local fertilizerTimeLimit = 600
			local fertilizerItem = "fertilizer"

			if Plants[Number]["Fertilizer"] < fertilizerLimit and (plantTime - currentTime) >= fertilizerTimeLimit then
				local ConsultFertilizer = vRP.InventoryItemAmount(Passport, fertilizerItem)
				if ConsultFertilizer[1] <= 0 then
					TriggerClientEvent("Notify", source, "amarelo", "Você precisa de <b>1x "..ItemName(fertilizerItem).."</b>.", "Atenção", 5000)
				else
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:Close", source)
					TriggerClientEvent("Progress", source, "Fertilizando", 60000)
					vRPC.PlayAnim(source, false,{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },true)

					Wait(60000)

					TriggerClientEvent("Notify", source, "verde", "Fertilização completa.", "Sucesso", 5000)
					Plants[Number]["Points"] = Plants[Number]["Points"] + math.random(5, 10)
					Plants[Number]["Fertilizer"] = Plants[Number]["Fertilizer"] + 1
					Plants[Number]["Time"] = Plants[Number]["Time"] - fertilizerTimeLimit
					vRP.RemoveItem(Passport, fertilizerItem, 1, true)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.Destroy(source)
				end
			else
				TriggerClientEvent("Notify", source, "amarelo", "A plantação já foi fertilizada ao máximo.", "Atenção", 5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Remove")
AddEventHandler("plants:Remove", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local plantType = PlantsTypes[Plants[Number]["Type"]][1]

		if plantType == "weedclone" or plantType == "weedclone2" then
			vRP.GenerateItem(Passport, "bucket", 1, true)
		end

		Plants[Number] = nil
		TriggerClientEvent("plants:Remove", -1, Number)
		TriggerClientEvent("dynamic:Close", source)
		TriggerClientEvent("Notify", source, "verde", "A plantação foi removida.", "Sucesso", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Verify")
AddEventHandler("plants:Verify", function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plants[Number] then
		local Identity = vRP.Identity(Plants[Number]["Owner"])
		if Identity then
			local currentTime = os.time()
			local plantTime = Plants[Number]["Time"]
			local timeDifference = currentTime - plantTime
			local Validity, Collect, Cloning

			if timeDifference > 3600 then
				Validity = "Plantação Apodrecida"
			else
				Validity = "Plantação Ativa"
			end

			if currentTime < plantTime then
				Collect = Calculate(plantTime - currentTime)
			else
				Collect = "A coleta está disponível"
			end

			local cloningTime = plantTime - currentTime - 5400
			if cloningTime > 0 then
				Cloning = Calculate(cloningTime)
			else
				Cloning = "A clonagem está disponível"
			end

			TriggerClientEvent("Notify", source, "azul", "<b>Planta:</b> "..Number.." <b>Por:</b> "..Identity["Name"].." "..Identity["Lastname"]..".<br><b>Status:</b> "..Validity..".<br><b>Pureza da folhagem:</b> "..parseInt(Plants[Number]["Points"]).."%.<br><b>Fertilização da plantação:</b> "..parseInt(Plants[Number]["Fertilizer"]).."%.<br><b>Dimensão da plantação:</b> "..parseInt(Plants[Number]["Route"])..".<br><b>Coleta:</b> "..Collect..".<br><b>Clonagem:</b> "..Cloning..".", false, 10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Informations(Number)
	if Plants[Number] then
		local currentTime = os.time()
		local plantTime = Plants[Number]["Time"]
		local timeDifference = currentTime - plantTime

		if timeDifference > 3600 then
			Plants[Number] = nil
			TriggerClientEvent("plants:Remove", -1, Number)
			TriggerClientEvent("Notify", source, "amarelo", "A plantação apodreceu.", "Atenção", 5000)
			return false
		else
			local Collect = "A coleta está disponível"
			if currentTime < plantTime then
				Collect = "Aguarde <blue>"..Calculate(plantTime - currentTime).."</blue>."
			end

			local cloningTime = plantTime - currentTime - 5400
			local Cloning = "A clonagem está disponível"
			if cloningTime > 0 then
				Cloning = "Aguarde <blue>"..Calculate(cloningTime).."</blue>."
			end

			local Health = "Plantação com <blue>"..parseInt(Plants[Number]["Points"]).."%</blue> de pureza."
			local Status = "A plantação foi fertilizada <blue>"..parseInt(Plants[Number]["Fertilizer"]).."x</blue>."

			return { Collect, Cloning, Health, Status }
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Silenced)
	vRP.SetServerData("Plants", Plants)

	if not Silenced then
		print("O resource Plants salvou os dados.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Plants = vRP.GetServerData("Plants")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, source)
	TriggerClientEvent("plants:Table", source, Plants)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Calculate(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds % 86400

	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds % 3600

	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds % 60

	local timeString = ""
	local hasPrevious = false

	if Days > 0 then
		timeString = timeString .. Days .. " Dia"

		if Days > 1 then
			timeString = timeString .. "s"
		end

		hasPrevious = true
	end

	if Hours > 0 then
		if hasPrevious then
			timeString = timeString .. ", "
		end

		timeString = timeString .. Hours .. " Hora"

		if Hours > 1 then
			timeString = timeString .. "s"
		end

		hasPrevious = true
	end

	if Minutes > 0 then
		if hasPrevious then
			timeString = timeString .. ", "
		end

		timeString = timeString .. Minutes .. " Minuto"

		if Minutes > 1 then
			timeString = timeString .. "s"
		end

		hasPrevious = true
	end

	if Seconds > 0 then
		if hasPrevious then
			timeString = timeString .. " e "
		end

		timeString = timeString .. Seconds .. " Segundo"

		if Seconds > 1 then
			timeString = timeString .. "s"
		end
	end

	return timeString
end