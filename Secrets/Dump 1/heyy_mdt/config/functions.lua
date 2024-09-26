Functions = {}

-- * Database
function Functions.prepare(name, query)
	if not IsDuplicityVersion() then return end

	Citizen.CreateThread(function()
		vRP.Prepare(name, query)
	end)
end

function Functions.query(name, data)
	return vRP.Query(name, data or {})
end

function Functions.execute(name, data)
	return vRP.Query(name, data or {})
end
-- * /Database

-- * Basic functions
function Functions.getUserId(player)
	return vRP.Passport(player)
end

function Functions.getUserSource(user_id)
	return vRP.Source(user_id)
end

function Functions.hasPermission(user_id, permission)
	if type(permission) == "table" then
		for _, v in ipairs(permission) do
			if Functions.hasPermission(user_id, v) then
				return true
			end
		end
		return false
	end

	if permission == "Admin" then
		return vRP.HasGroup(user_id, permission)
	end

	if permission:find("@") then
        local splitted = splitString(permission, "@")
        local permission = splitted[1]
        local level = parseInt(splitted[2])
        return vRP.HasGroup(user_id, permission, level)
    end

	return vRP.HasService(user_id, permission)
end

function Functions.hasGroup(user_id, group)
	return vRP.HasPermission(user_id, group)
end

function Functions.getUsersByPermission(permission)
	return vRP.NumPermission(permission)
end

function Functions.getUData(user_id, key)
	local Consult = vRP.Query("playerdata/GetData",{ Passport = user_id, Name = key })
	return Consult[1]?.Information or ""
end

function Functions.setUData(user_id, key, value)
	Functions.execute("playerdata/SetData",{ Passport = user_id, Name = key, Information = value })
end

function Functions.getInventoryItemAmount(user_id, item)
	return vRP.ItemAmount(user_id, item)
end

function Functions.giveInventoryItem(user_id, item, amount)
	return vRP.GiveItem(user_id, item, amount)
end

function Functions.tryGetInventoryItem(user_id, item, amount)
	return vRP.TakeItem(user_id, item, amount)
end

-- Utilizado se infractionsConfig.bailToOfficer estiver ativo
function Functions.giveMoney(user_id, amount)
	return Functions.giveInventoryItem(user_id, "dollars", amount)
end

-- Utilizado ao pagar uma fiança
function Functions.tryPayment(user_id, amount)
	return vRP.PaymentBank(user_id, amount)
end

function Functions.requestConfirmation(player, message, time)
	return vRP.Request(player, message)
end

if IsDuplicityVersion() then
	local Tunnel = module("vrp","lib/Tunnel")
	vSKINSHOP = Tunnel.getInterface("skinshop")
end

function Functions.getPlayerClothes(player, user_id)
	return vSKINSHOP.Customization(player)
end

function Functions.setPlayerClothes(player, user_id, clothes)
	TriggerClientEvent("updateRoupas", player, clothes)
end


-- * Tablet functions
Functions.prepare("heyy_mdt/search", "SELECT * FROM characters WHERE concat(Name, \" \", Lastname) LIKE concat('%', @search '%') LIMIT 1")
-- Functions.prepare("heyy_mdt/searchByPlate", "SELECT Passport FROM vehicles WHERE plate = @search LIMIT 1") -- vehicles
-- Functions.prepare("heyy_mdt/searchByPlate", "SELECT * FROM nation_user_vehicles WHERE plate = @search LIMIT 1") -- nation_user_vehicles
function Functions.doesUserExist(search)
	-- o parâmetro "search" pode ser um ID de usuário ou o nome de um jogador
	local result
	-- ID
	if tonumber(search) then
		result = Functions.query("characters/Person", { Passport = parseInt(search) })
	-- Nome de jogador
    else
		local vehicleResult = Functions.query("heyy_mdt/searchByPlate", { search = search })
        if vehicleResult and vehicleResult[1] then
			vehicleResult[1].id = vehicleResult[1].Passport -- vehicles
			-- vehicleResult[1].id = tonumber(vehicleResult[1].user) -- nation_user_vehicles
			result = vehicleResult[1]
		else
			result = Functions.query("heyy_mdt/search", { search = search })
		end
	end
	return (result[1] ~= nil), (result[1] and result[1].id or nil)
end

Functions.prepare("heyy_mdt/search/stack", "SELECT * FROM characters WHERE id = @search OR concat(Name, \" \", Lastname) LIKE concat('%', @search '%')")
function Functions.searchPlayers(search)
	return Functions.query("heyy_mdt/search/stack", { search = search }) or {}
end

function Functions.getUserIdentity(user_id)
	local identity = vRP.Identity(user_id)
	if not identity then
		_error("Usuário não encontrado", user_id)
		return {
			name = "Indefinido",
			surname = "Indefinido",
			age = 0,
			phone = "4002-8922",
			registration = "ERROR404"
		}
	end

	local userIdentity = {
		name = identity.Name,
		surname = identity.Lastname,
		age = 0,
		phone = vRP.Phone(user_id),
		registration = identity.License:sub(-8):upper(),
	}

	return userIdentity
end

function Functions.getUserVehicles(userID)
	local vehicleList = {}
	--[[
		vehicleList = {
			{
				name = nome do veículo
				plate = placa do veículo
				arrested = true/false
			}
		}
	]]
	local vehicles = Functions.query("vehicles/UserVehicles", { Passport = userID })
	for _, v in ipairs(vehicles) do
		table.insert(vehicleList, {
			vehicle = v.Vehicle,
			name = Functions.getVehNameByModel(v.Vehicle),
			plate = v.Plate,
			arrested = (v.Arrest ~= 0)
		})
	end

	return vehicleList
end

function Functions.getUserHouses(userID)
	local houseList = {}
	--[[
		houseList = {
			{
				name = nome da casa,
				isOwner = true/false,
			} 
		}
	]]

	-- creative -> propertys (script padrão da base)
	local houses = Functions.query("propertys/AllUser", { Passport = userID })
	for k, v in ipairs(houses) do
		table.insert(houseList, {
			name = v.Name,
			isOwner = true
		})
	end

    -- heyyshop -> heyy_houses (www.heyyshop.com.br)
	-- local houseConfig = exports.heyy_houses:getConfig()
    -- local houses = Functions.query("heyy_houses/propertys/getByMembers", { userID = userID })
    -- for _, v in ipairs(houses) do
    --     local property = exports.heyy_houses:getPropertyData(v.label)
    --     local propertyType = houseConfig.propertyTypes[property.type]
    --     table.insert(houseList, {
    --         name = exports.heyy_houses:formatPropertyName(v.label, propertyType, v.internalID),
    --         isOwner = (v.userID == userID)
    --     })
    -- end
	return houseList
end

function Functions.getVehNameByModel(model)
	-- model = nome de spawn
	return VehicleName(model)
end

-- Função que será utilizada para multar jogador
function Functions.applyFine(user_id, officer_id, value, reason)
    -- bank - Padrão
	exports["bank"]:AddFines(user_id,officer_id,value,reason)

	-- bank - Biblioteca do SummerZ
	-- local officerIdentity = Functions.getUserIdentity(officer_id)
	-- local officerName = officerIdentity.name .. " " .. officerIdentity.surname
	-- local date = os.date("*t")
	-- local day = fillZero(date.day, 2) .. "/" .. fillZero(date.month, 2)
	-- local hour = fillZero(date.hour, 2) .. ":" .. fillZero(date.min, 2)
	-- Functions.execute("fines/Add", { Passport = user_id, Name = officerName, Date = day, Hour = hour, Value = value, Message = reason })

	-- bank - Jester
    -- exports.bank:createFine(targetID, infractions, math.floor(finesValue), "7d", math.floor(finesValue * 0.15)) -- 7 dias para pagar. Após os 7 dias, 15% de juros por dia.
end

function Functions.canPlayerEscape(player, user_id)
	local requirement = config.prison.escapes.requiredItem
	if Functions.getInventoryItemAmount(user_id, requirement.item) < requirement.amount then
		TriggerClientEvent("Notify", player, "negado", "Preciso de algo para abrir a porta...")
		return false
	end
	return true
end

-- Função para aleatorizar se jogador deverá receber a chave ou não
function Functions.randomizeChanceItem(player, user_id)
	if not Player(player).state.canEscape then return end

	local random = math.random(1, 1000)
	if random <= 4 then
		TriggerClientEvent("Notify", player, "importante", "Encontrei algo! Posso tentar fazer alguma coisa com isso...")
		return true
	end
	return false -- não recebe chave
end

-- Disparado quando o jogador escapa da prisão
AddEventHandler("heyy_mdt:playerEscaped", function(player, user_id)
	TriggerEvent("Wanted", player, user_id, 300) -- Definir jogador como procurado (Creative Network)

	local coords = GetEntityCoords(GetPlayerPed(player))

	local permissions = config.permissions.openTablet
	for _, permission in pairs(permissions) do
		local cops = Functions.getUsersByPermission(permission)
		for _, cSource in pairs(cops) do
			async(function()
				TriggerClientEvent("NotifyPush", cSource, {
					code = 31,
					title = "Fuga da prisão",
					x = coords.x, y = coords.y, z = coords.z,
					time = "Recebido às "..os.date("%H:%M"), blipColor = 44
				})
			end)
		end
	end
end)

-- ? Client-side
-- * Animations
function Functions.playAnim(upper, animDict, animName, looping)
	vRP.playAnim(upper, { animDict, animName }, looping)
end

function Functions.stopAnim()
	vRP.stopAnim()
end

function Functions.createObjects(animDict, animName, prop, animFlags, pedBone)
	vRP.CreateObjects(animDict, animName, prop, animFlags, pedBone)
end

function Functions.removeObjects()
	vRP.Destroy("one")
end

AddEventHandler("heyy_mdt:onTabletOpen", function()
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
end)

-- * Basic functions
function Functions.teleportPlayer(x, y, z, h)
	local ped = PlayerPedId()
	SetEntityCoords(ped, x, y, z)

	if h then
		SetEntityHeading(PlayerPedId(), h)
	end
end

function Functions.createSearchArea(coords)
	local blip = AddBlipForRadius(coords.x, coords.y, coords.z, 150.0)
	SetBlipColour(blip, 5)
	SetBlipAlpha(blip, 130)
	return blip
end

function fillZero(value, length)
	while tostring(value):len() < length do
		value = "0" .. value
	end
	return value
end



if IsDuplicityVersion() then
	RegisterServerEvent("police:prisonClothes")
	AddEventHandler("police:prisonClothes",function(entity)
		local source = source
		local Passport = vRP.Passport(source)
		if Passport and vRP.GetHealth(source) > 100 then
			local mHash = vRP.ModelPlayer(entity[1])
			if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity[1],config.prisonerPresets[GetHashKey(mHash)])
			end
		end
	end)
end



-- Custom Licenses [ADVANCED]
function Functions.getDriverLicense(userID)
	return Functions.getUData(userID, "driverLicense") == "true"
end

function Functions.updateDriverLicense(userID)
    local value = Functions.getDriverLicense(userID)
    Functions.setUData(userID, "driverLicense", tostring(not value))
    return true
end

function Functions.getHuntLicense(userID)
	return Functions.getUData(userID, "huntLicense") == "true"
end

function Functions.updateHuntLicense(userID)
	local value = Functions.getHuntLicense(userID)
	Functions.setUData(userID, "huntLicense", tostring(not value))
	return true
end

function Functions.getFlightLicense(userID)
	return Functions.getUData(userID, "flightLicense") == "true"
end

function Functions.updateFlightLicense(userID)
	local value = Functions.getFlightLicense(userID)
	Functions.setUData(userID, "flightLicense", tostring(not value))
	return true
end