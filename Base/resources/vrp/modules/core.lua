-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Sources = {}
Characters = {}
CharactersArena = {}
GlobalState["Players"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = {}
local Party = {}
local Global = {}
local Salary = {}
local SrvData = {}
local SelfReturn = {}
local SalaryCooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {}
Party["Room"] = {}
Party["Users"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERIES
-----------------------------------------------------------------------------------------------------------------------------------------
local Prepares = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Prepare(Name, Query)
	Prepares[Name] = Query
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Query(Name, Params)
	return exports.oxmysql:query_async(Prepares[Name], Params)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identities(source)
	local Result = false

	local Identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(Identifiers) do
		if string.find(v, BaseMode) then
			local SplitName = splitString(v, ":")
			Result = SplitName[2]
			break
		end
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Archive(Archive,Text)
	Archive = io.open(Archive,"a")

	if Archive then
		Archive.write(Archive,Text.."\n")
	end

	Archive.close(Archive)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Banned(License)
	local Consult = vRP.Query("banneds/GetBanned",{ License = License })
	if Consult and Consult[1] then
		if Consult[1]["Time"] <= os.time() then
			vRP.Query("banneds/RemoveBanned",{ License = License })
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTOKEN
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckToken(source, License)
	local tokens = GetPlayerTokens(source)
	local valid = true

	for _, token in ipairs(tokens) do
		local consult = vRP.Query("banneds/GetToken", { Token = token })
		if consult and consult[1] then
			valid = false
			break
		else
			vRP.Query("banneds/InsertToken",{ License = License, Token = token })
		end
	end

	return valid
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Account(License)
	return vRP.Query("accounts/Account",{ License = License })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserData(Passport, Value)
	local Consult = vRP.Query("playerdata/GetData",{ Passport = Passport, Name = Value })
	if Consult and Consult[1] then
		return json.decode(Consult[1]["Information"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsidePropertys(Passport, Coords)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		HensaTable["Pos"] = { x = Optimize(Coords["x"]), y = Optimize(Coords["y"]), z = Optimize(Coords["z"]) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Inventory(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if not HensaTable["Inventory"] then
			HensaTable["Inventory"] = {}
		end

		return HensaTable["Inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SkinCharacter(Passport, Hash)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		HensaTable["Skin"] = Hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Passport(source)
	if Characters[source] then
		return Characters[source]["id"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Players()
	return Sources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Source(Passport)
	return Sources[parseInt(Passport)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Datatable(Passport)
	if Characters[Sources[parseInt(Passport)]] then
		return Characters[Sources[parseInt(Passport)]]["table"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Kick(source, Reason)
	DropPlayer(source, Reason)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(Reason)
	if Characters[source] and DoesEntityExist(GetPlayerPed(source)) then
		Disconnect(source, GetEntityHealth(GetPlayerPed(source)), GetPedArmour(GetPlayerPed(source)), GetEntityCoords(GetPlayerPed(source)), Reason)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function Disconnect(source, Health, Armour, Coords, Reason)
	local Passport = vRP.Passport(source)
	local HensaTable = vRP.Datatable(Passport)
	if Passport then
		exports["discord"]:Embed("Disconnect","**Source:** "..source.."\n**Passaporte:** "..vRP.Passport(source).."\n**Health:** "..Health.."\n**Armour:** "..Armour.."\n**Cds:** "..Coords.."\n**Motivo:** "..Reason,0xa3c846)

		if HensaTable then
			if CharactersArena[Passport] then
				HensaTable["Stress"] = CharactersArena[Passport]["Stress"]
				HensaTable["Hunger"] = CharactersArena[Passport]["Hunger"]
				HensaTable["Thirst"] = CharactersArena[Passport]["Thirst"]
				HensaTable["Armour"] = CharactersArena[Passport]["Armour"]
				HensaTable["Health"] = CharactersArena[Passport]["Health"]
				HensaTable["Inventory"] = CharactersArena[Passport]["Inventory"]
				HensaTable["Pos"] = { x = BackArenaPos["x"], y = BackArenaPos["y"], z = BackArenaPos["z"] }
				TriggerEvent("arena:Players", "-", CharactersArena[Passport]["route"])
				CharactersArena[Passport] = nil
			else
				HensaTable["Health"] = Health
				HensaTable["Armour"] = Armour
				HensaTable["Pos"] = { x = Optimize(Coords["x"]), y = Optimize(Coords["y"]), z = Optimize(Coords["z"]) }
			end

			if HensaTable["Health"] <= 100 then
				TriggerClientEvent("hud:Textform", -1, Coords, "<b>Passaporte:</b> " .. Passport .. "<br><b>Motivo:</b> " .. Reason, CombatLogMinutes * 60000)
			end

			TriggerEvent("Disconnect", Passport, source)
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Datatable", Information = json.encode(HensaTable) })
			Characters[source] = nil
			Sources[Passport] = nil

			if GlobalState["Players"][source] then
				GlobalState["Players"][source] = nil
				GlobalState:set("Players", GlobalState["Players"], true)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function()
	for k,v in pairs(Sources) do
		local HensaTable = vRP.Datatable(k)
		if HensaTable then
			vRP.Query("playerdata/SetData",{ Passport = k, Name = "Datatable", Information = json.encode(HensaTable) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:Connecting", function(source, identifiers, deferrals)
	deferrals.defer()

	local Identities = vRP.Identities(source)
	if Identities then
		local Account = vRP.Account(Identities)
		if not Account then
			vRP.Query("accounts/NewAccount", { License = Identities })
		end

		if Maintenance then
			if MaintenanceLicenses[Identities] then
				deferrals.done()
			else
				deferrals.done(MaintenanceText)
			end
		elseif not vRP.Banned(Identities) then
			if Whitelisted then
				local Account = vRP.Account(Identities)
				if Account["Whitelist"] then
					deferrals.done()
				else
					deferrals.done(ReleaseText .. ": " .. Account["id"])
				end
			else
				deferrals.done()
			end
		else
			CheckToken(source, Identities)
			deferrals.done(BannedText .. ".")
		end
	else
		deferrals.done("Conexão perdida.")
	end

	TriggerEvent("Queue:Remove", identifiers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSENCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChosenCharacter(source, Passport, Model)
	Sources[Passport] = source
	if not Characters[source] then
		local Consult = vRP.Query("characters/Person",{ id = Passport })
		local Identities = vRP.Identities(source)
		local Account = vRP.Account(Identities)
		if #Consult > 0 then
			Characters[source] = {}

			Characters[source]["id"] = Consult[1]["id"]
			Characters[source]["License"] = Consult[1]["License"]
			Characters[source]["Phone"] = Consult[1]["Phone"]
			Characters[source]["Name"] = Consult[1]["Name"]
			Characters[source]["Lastname"] = Consult[1]["Lastname"]
			Characters[source]["Sex"] = Consult[1]["Sex"]
			Characters[source]["Skin"] = Consult[1]["Skin"]
			Characters[source]["Bank"] = Consult[1]["Bank"]
			Characters[source]["Blood"] = Consult[1]["Blood"]
			Characters[source]["Prison"] = Consult[1]["Prison"]
			Characters[source]["Avatar"] = Consult[1]["Avatar"]
			Characters[source]["Likes"] = Consult[1]["Likes"]
			Characters[source]["Unlikes"] = Consult[1]["Unlikes"]
			Characters[source]["Badge"] = Consult[1]["Badge"]
			Characters[source]["Created"] = Consult[1]["Created"]
			Characters[source]["Login"] = Consult[1]["Login"]
			Characters[source]["Deleted"] = Consult[1]["Deleted"]

			Characters[source]["Premium"] = Account["Premium"]
			Characters[source]["Discord"] = Account["Discord"]
			Characters[source]["Characters"] = Account["Characters"]

			Characters[source]["table"] = vRP.UserData(Passport,"Datatable")

			GlobalState["Players"][source] = Passport
			GlobalState:set("Players",GlobalState["Players"], true)
		end

		if Model then
			Characters[source]["table"]["Skin"] = Model
			Characters[source]["table"]["Inventory"] = {}

			for k,v in pairs(CharacterItens) do
				vRP.GenerateItem(Passport,k,v,false)
			end

			-- if GiveIdentity then
			-- 	vRP.GenerateItem(Passport,"identity-"..Passport,1,false)
			-- end

			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Barbershop", Information = json.encode(BarbershopInit[Model]) })
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Clothings", Information = json.encode(SkinshopInit[Model]) })
			vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Datatable", Information = json.encode(Characters[source]["table"]) })
		end

		if Account["Gemstone"] > 0 then
			TriggerClientEvent("hud:AddGemstone",source,Account["Gemstone"])
		end

		vRP.Query("characters/LastLogin",{ Passport = Passport })

		exports["discord"]:Embed("Connect","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Nome:** "..vRP.FullName(Passport).."\n**Address:** "..GetPlayerEndpoint(source),0xa3c846)
	end

	TriggerEvent("ChosenCharacter",Passport,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapName(ServerName)
	SetGameType(ServerName)
	SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function getQueue(ids, trouble, source, connect)
	for k, v in ipairs(connect and Queue.Connecting or Queue.List) do
		local inQueue = false

		if not source then
			for _, i in ipairs(v.ids) do
				if inQueue then
					break
				end

				for _, o in ipairs(ids) do
					if o == i then
						inQueue = true
						break
					end
				end
			end
		else
			inQueue = ids == v.source
		end

		if inQueue then
			if trouble then
				return k, connect and Queue.Connecting[k] or Queue.List[k]
			else
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSERUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function LicenseRunning(source)
	local identifiers = GetPlayerIdentifiers(source)
	for _, v in ipairs(identifiers) do
		if string.find(v, BaseMode) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPriority(player)
	for _, identifier in ipairs(GetPlayerIdentifiers(player)) do
		if string.find(identifier, BaseMode) and vRP.LicensePremium(splitString(identifier, ":")[2]) then
			return 10
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function addQueue(ids, connectTime, name, source, deferrals)
	if getQueue(ids) then
		return
	end

	local priority = CheckPriority(ids)
	local tmp = {
		source = source,
		ids = ids,
		name = name,
		firstconnect = connectTime,
		priority = priority,
		timeout = 0,
		deferrals = deferrals
	}

	local insertIndex = #Queue.List + 1
	for k, v in ipairs(Queue.List) do
		if priority then
			if not v.priority or priority > v.priority then
				insertIndex = k
				break
			end
		end
	end

	table.insert(Queue.List, insertIndex, tmp)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function removeQueue(ids, source)
	if getQueue(ids, false, source) then
		local pos, data = getQueue(ids, true, source)
		table.remove(Queue.List, pos)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function isConnect(ids, source, refresh)
	local k,v = getQueue(ids, refresh and true or false, source and true or false, true)

	if not k then
		return false
	end

	if refresh and k and v then
		Queue.Connecting[k]["timeout"] = 0
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function removeConnect(ids, source)
	for k,v in ipairs(Queue.Connecting) do
		local connect = false

		if not source then
			for _, i in ipairs(v["ids"]) do
				if connect then
					break
				end

				for _, o in ipairs(ids) do
					if o == i then
						connect = true
						break
					end
				end
			end
		else
			connect = ids == v["source"]
		end

		if connect then
			table.remove(Queue.Connecting, k)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function addConnect(ids, ignorePos, autoRemove, done)
	local function removeFromQueue()
		if not autoRemove then
			return
		end

		done(Lang.Error)
		removeConnect(ids)
		removeQueue(ids)
	end

	if #Queue.Connecting >= 100 then
		removeFromQueue()
		return false
	end

	if isConnect(ids) then
		removeConnect(ids)
	end

	local pos, data = getQueue(ids, true)
	if not ignorePos and (not pos or pos > 1) then
		removeFromQueue()
		return false
	end

	table.insert(Queue.Connecting, data)
	removeQueue(ids)

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMIDS
-----------------------------------------------------------------------------------------------------------------------------------------
function steamIds(source)
	return GetPlayerIdentifiers(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function updateData(source, ids, deferrals)
	local pos, data = getQueue(ids, true)
	Queue.List[pos]["ids"] = ids
	Queue.List[pos]["timeout"] = 0
	Queue.List[pos]["source"] = source
	Queue.List[pos]["deferrals"] = deferrals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function notFull(firstJoin)
	local canJoin = Queue.Counts + #Queue.Connecting < Queue.Max and #Queue.Connecting < 100
	if firstJoin and canJoin then
		canJoin = #Queue.List <= 1
	end

	return canJoin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function setPosition(ids, newPos)
	local pos, data = getQueue(ids, true)
	table.remove(Queue.List, pos)
	table.insert(Queue.List, newPos, data)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUETHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local function playerConnect(name, setKickReason, deferrals)
		local source = source
		local ids = steamIds(source)
		local connecting = true
		local connectTime = os.time()
		deferrals.defer()

		CreateThread(function()
			while connecting do
				Wait(500)
				if not connecting then
					return
				end

				deferrals.update(Lang.Connecting)
			end
		end)

		Wait(1000)
		local function done(message)
			connecting = false
			CreateThread(function()
				if message then
					deferrals.update(tostring(message) and tostring(message) or "")
				end

				Wait(1000)

				if message then
					deferrals.done(tostring(message) and tostring(message) or "")
					CancelEvent()
				end
			end)
		end

		local function update(message)
			connecting = false
			deferrals.update(tostring(message) and tostring(message) or "")
		end

		if not LicenseRunning(source) then
			done("Você esta sem sua steam ou algum dos nossos identificadores abertos.")
			CancelEvent()
			return
		end

		local reason = "Removido da fila."

		local function setReason(message)
			reason = tostring(message)
		end

		TriggerEvent("Queue:playerJoinQueue", source, setReason)

		if WasEventCanceled() then
			done(reason)

			removeQueue(ids)
			removeConnect(ids)

			CancelEvent()
			return
		end

		if getQueue(ids) then
			rejoined = true
			updateData(source, ids, deferrals)
		else
			addQueue(ids, connectTime, name, source, deferrals)
		end

		if isConnect(ids, false, true) then
			removeConnect(ids)

			if notFull() then
				local added = addConnect(ids, true, true, done)
				if not added then
					CancelEvent()
					return
				end

				done()
				TriggerEvent("Queue:Connecting", source, ids, deferrals)

				return
			else
				addQueue(ids, connectTime, name, source, deferrals)
				setPosition(ids, 1)
			end
		end

		local pos, data = getQueue(ids, true)

		if not pos or not data then
			done(Lang.Error)
			RemoveFromQueue(ids)
			RemoveFromConnecting(ids)
			CancelEvent()
			return
		end

		if notFull(true) then
			local added = addConnect(ids, true, true, done)
			if not added then
				CancelEvent()
				return
			end

			done()

			TriggerEvent("Queue:Connecting", source, ids, deferrals)

			return
		end

		update(string.format(Lang.Position, pos, #Queue.List))

		CreateThread(function()
			if rejoined then
				return
			end

			Queue.Threads = Queue.Threads + 1
			local dotCount = 0

			while true do
				Wait(1000)
				local dots = ""

				dotCount = dotCount + 1
				if dotCount > 3 then
					dotCount = 0
				end

				for i = 1, dotCount do
					dots = dots .. "."
				end

				local pos, data = getQueue(ids, true)

				if not pos or not data then
					if data and data.deferrals then
						data.deferrals.done(Lang.Error)
					end

					CancelEvent()
					removeQueue(ids)
					removeConnect(ids)
					Queue.Threads = Queue.Threads - 1
					return
				end

				if pos <= 1 and notFull() then
					local added = addConnect(ids)
					data.deferrals.update(Lang.Join)
					Wait(500)

					if not added then
						data.deferrals.done(Lang.Error)
						CancelEvent()
						Queue.Threads = Queue.Threads - 1
						return
					end

					data.deferrals.update("Carregando conexão com o servidor.")

					removeQueue(ids)
					Queue.Threads = Queue.Threads - 1

					TriggerEvent("Queue:Connecting", source, data.ids, data.deferrals)

					return
				end

				local message = string.format("Base Hensa\n\n"..Lang.Position.."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.", pos, #Queue.List, dots)
				data.deferrals.update(message)
			end
		end)
	end

	AddEventHandler("playerConnecting", playerConnect)

	local function checkTimeOuts()
		local i = 1

		while i <= #Queue.List do
			local data = Queue.List[i]
			local lastMsg = GetPlayerLastMsg(data.source)

			if lastMsg == 0 or lastMsg >= 30000 then
				data.timeout = data.timeout + 1
			else
				data.timeout = 0
			end

			if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
				data.deferrals.done(Lang.Error)
				table.remove(Queue.List, i)
			elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
				data.deferrals.done(Lang.Error)
				removeQueue(data.source, true)
				removeConnect(data.source, true)
			else
				i = i + 1
			end
		end

		i = 1

		while i <= #Queue.Connecting do
			local data = Queue.Connecting[i]
			local lastMsg = GetPlayerLastMsg(data.source)
			data.timeout = data.timeout + 1

			if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
				removeQueue(data.source, true)
				removeConnect(data.source, true)
			else
				i = i + 1
			end
		end

		SetTimeout(1000, checkTimeOuts)
	end

	checkTimeOuts()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE:CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Queue:Connect")
AddEventHandler("Queue:Connect", function()
	local source = source
	if not Queue.Players[source] then
		local ids = steamIds(source)
		Queue.Counts = Queue.Counts + 1
		Queue.Players[source] = true
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function()
	local identifiers = GetPlayerIdentifiers(source)
	local rockstarLicense = ""
	local discordID = ""

	for _, identifier in ipairs(identifiers) do
		if string.find(identifier, "license:") then
			rockstarLicense = string.gsub(identifier, "license:", "")
		elseif string.find(identifier, "discord:") then
			discordID = string.gsub(identifier, "discord:", "")
		end

		if rockstarLicense ~= "" and discordID ~= "" then
			break
		end
	end

	if rockstarLicense ~= "" then
		exports["oxmysql"]:execute("UPDATE accounts SET Discord = ? WHERE License LIKE ?", { discordID, "%" .. rockstarLicense })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
	if Queue.Players[source] then
		local ids = steamIds(source)
		Queue.Counts = Queue.Counts - 1
		Queue.Players[source] = nil
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:remove", function(ids)
	removeQueue(ids)
	removeConnect(ids)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholReturn(Passport)
	if Timer[Passport] then
		if os.time() < Timer[Passport] then
			return parseInt(Timer[Passport] - os.time())
		else
			Timer[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholTimer(Passport, Time)
	if Timer[Passport] then
		Timer[Passport] = Timer[Passport] + Time * 60
	else
		Timer[Passport] = os.time() + Time * 60
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identity(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source] or false
	else
		return vRP.Query("characters/Person",{ id = Passport })[1] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FULLNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FullName(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source]["Name"].." "..Characters[Source]["Lastname"]
	else
		return "Lucas Hen"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOWERNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LowerName(Passport)
	local Source = vRP.Source(Passport)
	if Characters[Source] then
		return Characters[Source]["Name"]
	else
		return "Hensa"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVATAR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Avatar(Passport)
	return vRP.Identity(Passport)["Avatar"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEAVATAR
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpdateAvatar(Passport, Avatar)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query("characters/UpdateAvatar",{ Avatar = Avatar, Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Avatar"] = Avatar
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVELIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveLikes(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddLikes",{ Likes = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Likes"] = Characters[Source]["Likes"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVELIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveLikes(Passport, Amount)
	local Source = vRP.Source(Passport)
	local intValue = tonumber(Amount)

	if intValue and intValue > 0 then
		vRP.Query("characters/RemLikes", { Likes = intValue, Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Likes"] = (Characters[Source]["Likes"] or 0) - intValue

			if Characters[Source]["Likes"] <= 0 then
				Characters[Source]["Likes"] = math.max(Characters[Source]["Likes"], 0)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEUNLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveUnLikes(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/AddUnlikes",{ Unlikes = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Unlikes"] = Characters[Source]["Unlikes"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEUNLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveUnlikes(Passport, Amount)
	local Source = vRP.Source(Passport)
	local intValue = tonumber(Amount)

	if intValue and intValue > 0 then
		vRP.Query("characters/RemUnlikes", { Unlikes = intValue, Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Unlikes"] = (Characters[Source]["Unlikes"] or 0) - intValue

			if Characters[Source]["Unlikes"] <= 0 then
				Characters[Source]["Unlikes"] = math.max(Characters[Source]["Unlikes"], 0)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetLikes(Passport)
	return vRP.Identity(Passport)["Likes"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUNLIKES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUnLikes(Passport)
	return vRP.Identity(Passport)["Unlikes"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSTATS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetStats(Passport)
	return { vRP.Identity(Passport)["Likes"], vRP.Identity(Passport)["Unlikes"] }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsertPrison(Passport, Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 then
		vRP.Query("characters/InsertPrison",{ Prison = parseInt(Amount), Passport = Passport })

		if Characters[Source] then
			Characters[Source]["Prison"] = Characters[Source]["Prison"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdatePrison(Passport, Amount)
	local Source = vRP.Source(Passport)
	Amount = tonumber(Amount)

	if Amount > 0 then
		vRP.Query("characters/ReducePrison", { Prison = Amount, Passport = Passport })

		if Characters[Source] then
			local prisonRemaining = Characters[Source]["Prison"] - Amount
			Characters[Source]["Prison"] = prisonRemaining

			if prisonRemaining <= 0 then
				Characters[Source]["Prison"] = 0
				exports["markers"]:Exit(Source, Passport)
				TriggerClientEvent("police:Prisioner", Source, false)
				vRP.Teleport(Source, UnprisonCoords["x"], UnprisonCoords["y"], UnprisonCoords["z"])
				TriggerClientEvent("Notify", Source, "verde", "Serviços finalizados.", "Sucesso", 5000)
			else
				TriggerClientEvent("Notify", Source, "azul", "Restam <b>" .. prisonRemaining .. " serviços</b>.", "Sistema Penitenciário", 5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearPrison(OtherPassport)
	local Source = vRP.Source(OtherPassport)
	vRP.Query("characters/CleanPrison",{ Passport = OtherPassport })

	if Characters[Source] then
		Characters[Source]["Prison"] = 0
		TriggerClientEvent("Notify", Source, "Sucesso", UnprisonText, "verde", 10000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBADGE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetBadge(Passport, Badge)
	local Source = vRP.Source(Passport)

	vRP.Query("characters/SetBadge", { Badge = parseInt(Badge), Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Badge"] = parseInt(Badge)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeChars(source)
	if Characters[source] then
		vRP.Query("accounts/UpdateCharacters",{ License = Characters[source]["License"] })
		Characters[source]["Characters"] = Characters[source]["Characters"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserGemstone(License)
	return vRP.Account(License)["Gemstone"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeGemstone(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Identity = vRP.Identity(Passport)
	if parseInt(Amount) > 0 and Identity then
		vRP.Query("accounts/AddGemstone",{ Gemstone = parseInt(Amount), License = Identity["License"] })

		if Characters[Source] then
			TriggerClientEvent("hud:AddGemstone", Source, parseInt(Amount))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeNames(Passport,Name,Lastname)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdateName",{ Name = Name, Lastname = Lastname, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Name"] = Name
		Characters[Source]["Lastname"] = Lastname
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePhone(Passport,Phone)
	local Source = vRP.Source(Passport)
	vRP.Query("characters/UpdatePhone",{ Phone = Phone, Passport = Passport })

	if Characters[Source] then
		Characters[Source]["Phone"] = Phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
	return vRP.Query("characters/Phone",{ Phone = Phone })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetPhone(Passport)
	if UsingLbPhone then
		local LBPhone = vRP.Query("lb-phone/GetPhone",{ id = Passport, owner = Passport})
		if LBPhone[1] then
			return exports["lb-phone"]:FormatNumber(LBPhone[1]["phone_number"])
		end
	else
		local Smartphone = vRP.Query("characters/Person",{ id = Passport })
		if Smartphone[1] then
			return Smartphone[1]["Phone"]
		end
	end

	return "Sem Sinal"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PassportPlate(Plate)
	return vRP.Query("vehicles/plateVehicles",{ Plate = Plate })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CallGroup(Coords, Permission, Title, Description, Code, Color)
	local Service = vRP.NumPermission(Permission)
	for Passports, Sources in pairs(Service) do
		async(function()
			TriggerClientEvent("NotifyPush", Sources, { code = Code, title = Title, x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = Description, blipColor = Color })
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateString(Format)
	local Number = ""
	for i = 1, #Format do
		if string.sub(Format, i, i) == "D" then
			Number = Number..string.char(string.byte("0") + math.random(0, 9))
		elseif "L" == string.sub(Format, i, i) then
			Number = Number..string.char(string.byte("A") + math.random(0, 25))
		else
			Number = Number..string.sub(Format, i, i)
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePlate()
	local Passport = nil
	local Serial = ""
	repeat
		Passport = vRP.PassportPlate(vRP.GenerateString("DDLLLDDD"))
		Serial = vRP.GenerateString("DDLLLDDD")
	until not Passport

	return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePhone()
	local Passport = nil
	local Phone = ""
	repeat
		Passport = vRP.UserPhone(vRP.GenerateString("DDD-DDD"))
		Phone = vRP.GenerateString("DDD-DDD")
	until not Passport

	return Phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ConsultItem(Passport, Item, Amount)
	if vRP.Source(Passport) then
		if Amount > vRP.InventoryItemAmount(Passport, Item)[1] then
			return false
		elseif vRP.CheckDamaged(vRP.InventoryItemAmount(Passport, Item)[2]) then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetWeight(Passport)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = DefaultBackpackNormal
		end

		return Datatable["Weight"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetWeight(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = DefaultBackpackNormal
		end

		Datatable["Weight"] = Datatable["Weight"] + Amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveWeight(Passport, Amount)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Source and Datatable then
		if not Datatable["Weight"] then
			Datatable["Weight"] = DefaultBackpackNormal
		end

		Datatable["Weight"] = Datatable["Weight"] - Amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryWeight(Passport)
	local Weight = 0
	local source = vRP.Source(Passport)
	if source then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			Weight = Weight + ItemWeight(v["item"]) * v["amount"]
		end
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckWeight(Passport, Item, Amount)
	local source = vRP.Source(Passport)
	if source then
		Amount = Amount or 1

		if (vRP.InventoryWeight(Passport) + ItemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckDamaged(Item)
	if ItemDurability(Item) and splitString(Item, "-")[2] then
		local DurabilityPercentage = parseInt((3600 * ItemDurability(Item) - parseInt(os.time() - splitString(Item, "-")[2])) / (3600 * ItemDurability(Item)) * 100)
		if DurabilityPercentage <= 1 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChestWeight(List)
	local Weight = 0
	for k,v in pairs(List) do
		Weight = Weight + (ItemWeight(v["item"]) * v["amount"])
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryItemAmount(Passport, Item)
	local Source = vRP.Source(Passport)
	if Source then
		local Inventory = vRP.Inventory(Passport)
		local totalAmount = 0
		local baseItem = splitString(Item, "-")[1]

		for _, v in pairs(Inventory) do
			if splitString(v["item"], "-")[1] == baseItem then
				totalAmount = totalAmount + parseInt(v["amount"])
			end
		end

		if totalAmount > 0 then
			return { totalAmount, Item }
		end
	end

	return { 0, "" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryFull(Passport, Item)
	if vRP.Source(Passport) then
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			if v["item"] == Item then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMOUNT -- HENSA FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ItemAmount(Passport, Item)
	if vRP.Source(Passport) then
		local Inventory = vRP.Inventory(Passport)
		local totalAmount = 0
		local baseItem = splitString(Item, "-")[1]

		for _, v in pairs(Inventory) do
			if splitString(v["item"], "-")[1] == baseItem then
				totalAmount = totalAmount + v["amount"]
			end
		end

		return totalAmount
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveItem(Passport, Item, Amount, Notify, Slot)
	local Source = vRP.Source(Passport)
	local amountParsed = parseInt(Amount)

	if Source and amountParsed > 0 then
		local Inventory = vRP.Inventory(Passport)
		if Inventory then
			if not Slot then
				local NewSlot = 0

				repeat
					NewSlot = NewSlot + 1
				until not Inventory[tostring(NewSlot)] or (Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item)

				if not Inventory[tostring(NewSlot)] then
					Inventory[tostring(NewSlot)] = { amount = amountParsed, item = Item }
				elseif Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item then
					Inventory[tostring(NewSlot)]["amount"] = Inventory[tostring(NewSlot)]["amount"] + amountParsed
				end

				if Notify and ItemIndex(Item) then
					TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), amountParsed, ItemName(Item) })
				end
			else
				Slot = tostring(Slot)

				if Inventory[Slot] then
					if Inventory[Slot]["item"] == Item then
						Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + amountParsed
					end
				else
					Inventory[Slot] = { amount = amountParsed, item = Item }
				end

				if Notify and ItemIndex(Item) then
					TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), amountParsed, ItemName(Item) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateItem(Passport, Item, Amount, Notify, Slot)
	local Source = vRP.Source(Passport)
	local amountParsed = parseInt(Amount)

	if Source and amountParsed > 0 then
		local Inventory = vRP.Inventory(Passport)

		if ItemDurability(Item) then
			if ItemType(Item) == "Armamento" then
				Item = Item.."-"..os.time().."-"..Passport
			else
				Item = Item.."-"..os.time()
			end
		elseif ItemLoads(Item) then
			Item = Item.."-"..ItemLoads(Item)
		end

		if not Slot then
			local NewSlot = 0

			repeat
				NewSlot = NewSlot + 1
			until not Inventory[tostring(NewSlot)]

			if not Inventory[tostring(NewSlot)] then
				Inventory[tostring(NewSlot)] = { amount = amountParsed, item = Item }
			elseif Inventory[tostring(NewSlot)] and Inventory[tostring(NewSlot)]["item"] == Item then
				Inventory[tostring(NewSlot)]["amount"] = Inventory[tostring(NewSlot)]["amount"] + amountParsed
			end

			if Notify and ItemIndex(Item) then
				TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), amountParsed, ItemName(Item) })
			end
		else
			Slot = tostring(Slot)

			if Inventory[Slot] then
				if Inventory[Slot]["item"] == Item then
					Inventory[Slot]["amount"] = Inventory[Slot]["amount"] + amountParsed
				end
			else
				Inventory[Slot] = { amount = amountParsed, item = Item }
			end

			if Notify and ItemIndex(Item) then
				TriggerClientEvent("NotifyItem", Source, { "+", ItemIndex(Item), amountParsed, ItemName(Item) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.MaxItens(Passport, Item, Amount)
	local amountParsed = parseInt(Amount)
	if ItemIndex(Item) and vRP.Source(Passport) and ItemMaxAmount(Item) and amountParsed then
		if vRP.ItemAmount(Passport, Item) + amountParsed > ItemMaxAmount(Item) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeItem(Passport, Item, Amount, Notify, Slot)
	SelfReturn[Passport] = false

	local Source = vRP.Source(Passport)
	local amountParsed = parseInt(Amount)
	if Source and amountParsed > 0 then
		local splitName = splitString(Item, "-")
		local Inventory = vRP.Inventory(Passport)

		if not Slot then
			for k, v in pairs(Inventory) do
				if v["item"] == Item and amountParsed <= v["amount"] then
					v["amount"] = v["amount"] - amountParsed

					if v["amount"] <= 0 then
						if ItemType(Item) == "Armamento" or ItemType(Item) == "Throwing" then
							TriggerClientEvent("inventory:VerifyWeapon", Source, Item)
						end
						Inventory[k] = nil
					end

					if Notify and ItemExist(Item) then
						TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), amountParsed, ItemName(Item) })
					end

					SelfReturn[Passport] = true
					break
				end
			end
		elseif Inventory[Slot] and Inventory[Slot]["item"] == Item and amountParsed <= Inventory[Slot]["amount"] then
			Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - amountParsed

			if Inventory[Slot]["amount"] <= 0 then
				if ItemType(Item) == "Armamento" or ItemType(Item) == "Throwing" then
					TriggerClientEvent("inventory:VerifyWeapon", Source, Item)
				end
				Inventory[Slot] = nil
			end

			if Notify and ItemExist(Item) then
				TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), amountParsed, ItemName(Item) })
			end

			SelfReturn[Passport] = true
		end
	end

	return SelfReturn[Passport]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveItem(Passport, Item, Amount, Notify)
	local Source = vRP.Source(Passport)
	local amountParsed = parseInt(Amount)

	if Source and amountParsed > 0 then
		local Inventory = vRP.Inventory(Passport)
		if Inventory then
			for k, v in pairs(Inventory) do
				if v["item"] == Item and amountParsed <= v["amount"] then
					v["amount"] = v["amount"] - amountParsed

					if v["amount"] <= 0 then
						if "Armamento" == ItemType(Item) or "Throwing" ~= ItemType(Item) then
							TriggerClientEvent("inventory:VerifyWeapon", Source, Item)
						end

						Inventory[k] = nil
					end

					if Notify and ItemIndex(Item) then
						TriggerClientEvent("NotifyItem", Source, { "-", ItemIndex(Item), amountParsed, ItemName(Item) })
					end

					break
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetServerData(Key)
	if not SrvData[Key] then
		local Rows = vRP.Query("entitydata/GetData", { Name = Key })
		if #Rows > 0 then
			local decodedData = json.decode(Rows[1]["Information"]) or {}
			SrvData[Key] = { data = decodedData, timer = 180 }
		else
			SrvData[Key] = { data = {}, timer = 180 }
		end
	end

	return SrvData[Key].data
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetServerData(Key, Data)
	SrvData[Key] = { data = Data, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESERVERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveServerData(Key)
	SrvData[Key] = { data = {}, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SRVDATATHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k, v in pairs(SrvData) do
			if v["timer"] > 0 then
				v["timer"] = v["timer"] - 1

				if v["timer"] <= 0 then
					vRP.Query("entitydata/SetData",{ Name = k, Information = json.encode(v["data"]) })
					SrvData[k] = nil
				end
			end
		end

		Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Save)
	for k,v in pairs(SrvData) do
		if json.encode(v["data"]) == "[]" or json.encode(v["data"]) == "{}" then
			vRP.Query("entitydata/RemoveData",{ Name = k })
		else
			vRP.Query("entitydata/SetData",{ Name = k, Information = json.encode(v["data"]) })
		end
	end

	if not Save then
		print("O resource ^2vRP^7 salvou os dados.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeChest(Passport, Data, Amount, Slot, Target)
	local Source = vRP.Source(Passport)
	local Datatable = vRP.GetServerData(Data)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local AmountInt = parseInt(Amount)

	if Source and AmountInt > 0 and Datatable[Slot] then
		local Inventory = vRP.Inventory(Passport)

		if vRP.MaxItens(Passport, Datatable[Slot].item, AmountInt) then
			TriggerClientEvent("Notify", Source, "vermelho", "Limite atingido.", "Aviso", 5000)
			return true
		end

		if vRP.InventoryWeight(Passport) + ItemWeight(Datatable[Slot].item) * AmountInt <= vRP.GetWeight(Passport) then
			if Inventory[Target] then
				if Inventory[Target].item == Datatable[Slot].item and AmountInt <= Datatable[Slot].amount then
					Inventory[Target].amount = Inventory[Target].amount + AmountInt
					Datatable[Slot].amount = Datatable[Slot].amount - AmountInt

					if Datatable[Slot].amount <= 0 then
						Datatable[Slot] = nil
					end

					return true
				end
			elseif AmountInt <= Datatable[Slot].amount then
				Inventory[Target] = { amount = AmountInt, item = Datatable[Slot].item }
				Datatable[Slot].amount = Datatable[Slot].amount - AmountInt

				if Datatable[Slot].amount <= 0 then
					Datatable[Slot] = nil
				end

				return true
			end
		end
	end

	return false
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.StoreChest(Passport, Data, Amount, Weight, Slot, Target)
	local Inventory = vRP.Inventory(Passport)
	local Datatable = vRP.GetServerData(Data)
	local Source = vRP.Source(Passport)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local AmountInt = parseInt(Amount)

	if Source and AmountInt > 0 and Inventory[Slot] then
		if Weight >= (vRP.ChestWeight(Datatable) + ItemWeight(Inventory[Slot].item)) * AmountInt then
			if Datatable[Target] then
				if Inventory[Slot] and Inventory[Slot].item == Datatable[Target].item then
					if AmountInt <= Inventory[Slot].amount then
						Datatable[Target].amount = Datatable[Target].amount + AmountInt
						Inventory[Slot].amount = Inventory[Slot].amount - AmountInt

						if Inventory[Slot].amount <= 0 then
							if ItemType(Inventory[Slot].item) == "Armamento" or ItemType(Inventory[Slot].item) ~= "Throwing" then
								TriggerClientEvent("inventory:VerifyWeapon", Source, Inventory[Slot].item)
							end

							Inventory[Slot] = nil
						end

						return true
					end
				end
			elseif Inventory[Slot] and AmountInt <= Inventory[Slot].amount then
				Datatable[Target] = { item = Inventory[Slot].item, amount = AmountInt }
				Inventory[Slot].amount = Inventory[Slot].amount - AmountInt

				if Inventory[Slot].amount <= 0 then
					if ItemType(Inventory[Slot].item) == "Armamento" or ItemType(Inventory[Slot].item) ~= "Throwing" then
						TriggerClientEvent("inventory:VerifyWeapon", Source, Inventory[Slot].item)
					end

					Inventory[Slot] = nil
				end

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateChest(Passport, Data, Slot, Target, Amount)
	local Datatable = vRP.GetServerData(Data)
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local Amount = parseInt(Amount)

	if vRP.Source(Passport) and Amount > 0 and Datatable[Slot] then
		local sourceItem = Datatable[Slot]
		local targetItem = Datatable[Target]

		if targetItem then
			if sourceItem.item == targetItem.item then
				if Amount <= sourceItem.amount then
					sourceItem.amount = sourceItem.amount - Amount
					targetItem.amount = targetItem.amount + Amount

					if sourceItem.amount <= 0 then
						Datatable[Slot] = nil
					end

					return true
				end
			else
				Datatable[Target], Datatable[Slot] = Datatable[Slot], Datatable[Target]
				return true
			end
		elseif Amount <= sourceItem.amount then
			sourceItem.amount = sourceItem.amount - Amount
			Datatable[Target] = { item = sourceItem.item, amount = Amount }

			if sourceItem.amount <= 0 then
				Datatable[Slot] = nil
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.UpdateInventory(Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and parseInt(Amount) > 0 then
		SelfReturn[Passport] = true

		local Inventory = vRP.Inventory(Passport)
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		if Inventory[Slot] then
			if Inventory[Target] then
				if Inventory[Slot]["item"] == Inventory[Target]["item"] then
					if parseInt(Amount) <= Inventory[Slot]["amount"] then
						Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)
						Inventory[Target]["amount"] = Inventory[Target]["amount"] + parseInt(Amount)

						if Inventory[Slot]["amount"] <= 0 then
							Inventory[Slot] = nil
						end

						SelfReturn[Passport] = false
					end
				else
					if Inventory[Slot]["item"] and Inventory[Target]["item"] then
						if Inventory[Slot]["item"] == "repairkit0"..string.sub(Inventory[Slot]["item"],11,12) then
							if vRP.CheckDamaged(Inventory[Target]["item"]) and Inventory[Target]["amount"] == 1 then
								local repairItem = ItemRepair(Inventory[Target]["item"])
								if repairItem and Inventory[Slot]["item"] == "repairkit0" .. string.sub(Inventory[Slot]["item"], 11, 12) then
									if repairItem == Inventory[Slot]["item"] then
										if vRP.TakeItem(Passport, Inventory[Slot]["item"], 1, false, Slot) then
											local timeSuffix = os.time()

											if splitString(Inventory[Target]["item"], "-")[3] then
												Inventory[Target]["item"] = splitString(Inventory[Target]["item"], "-")[1] .. "-" .. timeSuffix .. "-" .. splitString(Inventory[Target]["item"], "-")[3]
											else
												Inventory[Target]["item"] = splitString(Inventory[Target]["item"], "-")[1] .. "-" .. timeSuffix
											end

											TriggerClientEvent("Notify", source, "verde", "Reparado.", "Sucesso", 5000)
										end
									else
										local repairItemName = ItemName(repairItem)
										TriggerClientEvent("Notify", source, "amarelo", "Use <b>1x " .. repairItemName .. "</b>.", "Atenção", 5000)
									end
								end
							end
						else
							Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]

							SelfReturn[Passport] = false
						end
					end
				end
			elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot]["amount"] then
				Inventory[Target] = { item = Inventory[Slot]["item"], amount = parseInt(Amount) }
				Inventory[Slot]["amount"] = Inventory[Slot]["amount"] - parseInt(Amount)

				if Inventory[Slot]["amount"] <= 0 then
					Inventory[Slot] = nil
				end

				SelfReturn[Passport] = false
			end
		else
			TriggerClientEvent("inventory:Update", source, "Backpack")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPremium(source)
	if Characters[source] then
		vRP.Query("accounts/SetPremium",{ Premium = os.time() + 2592000, License = Characters[source]["License"] })
		Characters[source]["Premium"] = parseInt(os.time() + 2592000)
		vRP.SetWeight(vRP.Passport(source),DefaultBackpackPremium)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePremium(source)
	if Characters[source] then
		vRP.Query("accounts/UpgradePremium",{ License = Characters[source]["License"] })
		Characters[source]["Premium"] = Characters[source]["Premium"] + 2592000
		vRP.SetWeight(vRP.Passport(source),DefaultBackpackPremium)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPremium(Passport)
	local Source = vRP.Source(Passport)
	local Permission = vRP.HasPermission(Passport, "Premium")

	if Characters[Source] then
		local premiumExpiration = Characters[Source]["Premium"]

		if premiumExpiration and premiumExpiration < os.time() then
			if Permission then
				vRP.RemovePermission(Passport, "Premium")
			end
		elseif not Permission then
			vRP.SetWeight(Passport, DefaultBackpackPremium)
			vRP.SetPermission(Passport, "Premium")
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicensePremium(License)
	local Account = vRP.Account(License)
	if Account and Account["Premium"] >= os.time() then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Create(source, Passport, Message)
	if Message and not Party["Users"][Passport] and not Party["Room"][Message] then
		Party["Room"][Message] = {}
		Party["Users"][Passport] = Message
		Party["Room"][Message][Passport] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Add(source, Passport, Message)
	if not Party["Users"][Passport] and not Party["Room"][Message][Passport] then
		Party["Users"][Passport] = Message
		Party["Room"][Party["Users"][Passport]][Passport] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Rem(source, Passport, Message)
	if Party["Users"][Passport] and Party["Room"][Message][Passport] then
		Party["Users"][Passport] = nil
		Party["Room"][Message][Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Leave(source, Passport)
	if Party["Users"][Passport] then
		vRP.Rem(source, Passport, Party["Users"][Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Party(Passport)
	if Passport then
		if Party["Users"][Passport] and Party["Room"][Party["Users"][Passport]] then
			for k,v in pairs(Party["Room"][Party["Users"][Passport]]) do
				return "#"..k.." "..vRP.FullName(k).."<br>"
			end
		end

		return false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Party", function(Passport, source, Distance)
	local Partys = {}
	if Party["Users"][Passport] and Party["Room"][Party["Users"][Passport]] then
		for k,v in pairs(Party["Room"][Party["Users"][Passport]]) do
			if Distance >= #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) then
				Partys[#Partys + 1] = {
					["Passport"] = k,
					["Source"] = source
				}
			end
		end
	end

	return Partys
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveBank(Passport, Amount)
	local source = vRP.Source(Passport)
	local intValue = tonumber(Amount)

	if intValue and intValue > 0 then
		vRP.Query("characters/AddBank", { Bank = intValue, Passport = Passport })

		exports["bank"]:AddTransactions(Passport, "entry", intValue)

		if Characters[source] then
			Characters[source]["Bank"] = (Characters[source]["Bank"] or 0) + intValue
			TriggerClientEvent("NotifyItem", source, { "+", DefaultMoneyOne, intValue, ItemName(DefaultMoneyOne) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveBank(Passport, Amount)
	local Source = vRP.Source(Passport)
	local intValue = tonumber(Amount)

	if intValue and intValue > 0 then
		vRP.Query("characters/RemBank", { Bank = intValue, Passport = Passport })

		exports["bank"]:AddTransactions(Passport, "exit", intValue)

		if Characters[Source] then
			Characters[Source]["Bank"] = (Characters[Source]["Bank"] or 0) - intValue

			if Characters[Source]["Bank"] <= 0 then
				Characters[Source]["Bank"] = math.max(Characters[Source]["Bank"], 0)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetBank(source)
	if Characters[source] then
		return Characters[source]["Bank"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentGemstone(Passport,Amount)
	local Source = vRP.Source(Passport)
	if parseInt(Amount) > 0 and Characters[Source] and parseInt(Amount) <= vRP.UserGemstone(Characters[Source]["License"]) then
		vRP.Query("accounts/RemoveGemstone",{ Gemstone = parseInt(Amount), License = Characters[Source]["License"] })
		TriggerClientEvent("hud:RemoveGemstone",Source,parseInt(Amount))

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentBank(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Amount = parseInt(Amount)

    if Amount > 0 and Characters[Source] and Amount <= Characters[Source]["Bank"] then
        vRP.RemoveBank(Passport, Amount)
        TriggerClientEvent("NotifyItem", Source, { "-", DefaultMoneyOne, Amount, ItemName(DefaultMoneyOne) })
        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentFull(Passport, Amount)
	local Amount = parseInt(Amount)
	local Source = vRP.Source(Passport)

	if Amount and Amount > 0 then
		if vRP.TakeItem(Passport, DefaultMoneyOne, Amount, true) then
			return true
		elseif Characters[Source] and Amount <= (Characters[Source]["Bank"] or 0) then
			vRP.RemoveBank(Passport, Amount)
			TriggerClientEvent("NotifyItem", Source, { "-", DefaultMoneyOne, Amount, ItemName(DefaultMoneyOne) })
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WithdrawCash(Passport, Amount)
	local Source = vRP.Source(Passport)
	local intValue = tonumber(Amount)

	if intValue and intValue > 0 and Characters[Source] then
		local bankBalance = Characters[Source]["Bank"] or 0

		if intValue <= bankBalance then
			vRP.GenerateItem(Passport, DefaultMoneyOne, intValue, true)
			vRP.RemoveBank(Passport, intValue)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSENCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("ChosenCharacter", function(Passport, source)
	if GetResourceMetadata("vrp", "hensa") == "yes" then
		local HensaTable = vRP.Datatable(Passport)
		if HensaTable then
			if HensaTable["Pos"] then
				if not (HensaTable["Pos"]["x"] and HensaTable["Pos"]["y"] and HensaTable["Pos"]["z"]) then
					HensaTable["Pos"] = { x = SpawnCoords["x"], y = SpawnCoords["y"], z = SpawnCoords["z"] }
				end
			else
				HensaTable["Pos"] = { x = SpawnCoords["x"], y = SpawnCoords["y"], z = SpawnCoords["z"] }
			end

			if not HensaTable["Skin"] then
				HensaTable["Skin"] = "mp_m_freemode_01"
			end

			if not HensaTable["Inventory"] then
				HensaTable["Inventory"] = {}
			end

			if not HensaTable["Health"] then
				HensaTable["Health"] = 200
			end

			if not HensaTable["Armour"] then
				HensaTable["Armour"] = 0
			end

			if not HensaTable["Stress"] then
				HensaTable["Stress"] = 0
			end

			if not HensaTable["Hunger"] then
				HensaTable["Hunger"] = 100
			end

			if not HensaTable["Thirst"] then
				HensaTable["Thirst"] = 100
			end

			if not HensaTable["Weight"] then
				HensaTable["Weight"] = DefaultBackpackNormal
			end

			vRPC.Skin(source, HensaTable["Skin"])
			vRP.SetArmour(source, HensaTable["Armour"])
			vRPC.SetHealth(source, HensaTable["Health"])
			vRP.Teleport(source, HensaTable["Pos"]["x"], HensaTable["Pos"]["y"], HensaTable["Pos"]["z"])

			TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
			TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
			TriggerClientEvent("tattooshop:Apply", source, vRP.UserData(Passport, "Tatuagens"))

			TriggerClientEvent("hud:Thirst", source, HensaTable["Thirst"])
			TriggerClientEvent("hud:Hunger", source, HensaTable["Hunger"])
			TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])

			TriggerClientEvent("vRP:Active", source, Passport, vRP.FullName(Passport))

			Player(source)["state"]["Passport"] = Passport

			local Position = vec3(HensaTable["Pos"]["x"], HensaTable["Pos"]["y"], HensaTable["Pos"]["z"])
			if GetResourceMetadata("vrp", "creator") == "yes" then
				if vRP.UserData(Passport, "Creator") == 1 then
					TriggerClientEvent("spawn:Finish", source, Position, false)
				else
					TriggerClientEvent("spawn:Finish", source, false, true)
				end
			else
				TriggerClientEvent("spawn:Finish", source, Position, false)
			end

			TriggerEvent("Connect", Passport, source, Global[Passport] == nil)
			Global[Passport] = true
		end
	else
		print("Seu vRP foi modificado. Por favor, entre em contato com a equipe Hensa.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject", function(Index, Value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Value and Objects[Passport] and Objects[Passport][Value] then
			Index = Objects[Passport][Value]
			Objects[Passport][Value] = nil
		end
	end

	TriggerEvent("DeleteObjectServer", Index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DeleteObjectServer", function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed", function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugObjects", function(value)
	if Objects[value] then
		for objectID, _ in pairs(Objects[value]) do
			TriggerEvent("DeleteObjectServer", objectID)
			Objects[value][objectID] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugWeapons", function(value)
	if Objects[value] then
		for _, objectID in pairs(Objects[value]) do
			TriggerEvent("DeleteObjectServer", objectID)
		end

		Objects[value] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg", function(source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GetPlayerRoutingBucket(source) < 900000 and SURVIVAL.CheckDeath(source) then
		if vRP.UserPremium(Passport) then
			if ClearPremiumInventory then
				vRP.ClearInventory(Passport)
			end
		elseif CleanNormalInventory then
			vRP.ClearInventory(Passport)
		end

		local HensaTable = vRP.Datatable(Passport)
		if WipeBackpackDeath and HensaTable and HensaTable["Weight"] then
			HensaTable["Weight"] = DefaultBackpackNormal

			local Consult = vRP.GetServerData("Backpacks:"..Passport)
			if Consult["Comum"] then
				vRP.RemoveServerData("Backpacks:"..Passport)
			end
		end

		vRP.UpgradeThirst(Passport, 100)
		vRP.UpgradeHunger(Passport, 100)
		vRP.DowngradeStress(Passport, 100)

		SURVIVAL.Respawn(source) --verificar

		exports["discord"]:Embed("Airport","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Address:** "..GetPlayerEndpoint(source),0xa3c846)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearInventory(Passport)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if source and HensaTable and HensaTable["Inventory"] then
		exports["inventory"]:CleanWeapons(parseInt(Passport), true)

		TriggerEvent("DebugObjects", parseInt(Passport))
		TriggerEvent("DebugWeapons", parseInt(Passport))

		HensaTable["Inventory"] = {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeThirst(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 0
		end

		HensaTable["Thirst"] = HensaTable["Thirst"] + parseInt(Amount)

		if HensaTable["Thirst"] > 100 then
			HensaTable["Thirst"] = 100
		end

		TriggerClientEvent("hud:Thirst", source, HensaTable["Thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeHunger(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 0
		end

		HensaTable["Hunger"] = HensaTable["Hunger"] + parseInt(Amount)

		if HensaTable["Hunger"] > 100 then
			HensaTable["Hunger"] = 100
		end

		TriggerClientEvent("hud:Hunger", source, HensaTable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeStress(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Stress"] then
			HensaTable["Stress"] = 0
		end

		HensaTable["Stress"] = HensaTable["Stress"] + parseInt(Amount)

		if HensaTable["Stress"] > 100 then
			HensaTable["Stress"] = 100
		end

		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeThirst(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and Source then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 100
		end

		HensaTable["Thirst"] = HensaTable["Thirst"] - parseInt(Amount)

		if HensaTable["Thirst"] < 0 then
			HensaTable["Thirst"] = 0
		end

		TriggerClientEvent("hud:Thirst", Source, HensaTable["Thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeHunger(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and Source then
		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 100
		end

		HensaTable["Hunger"] = HensaTable["Hunger"] - parseInt(Amount)

		if HensaTable["Hunger"] < 0 then
			HensaTable["Hunger"] = 0
		end

		TriggerClientEvent("hud:Hunger", Source, HensaTable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeStress(Passport, Amount)
	local source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and source then
		if not HensaTable["Stress"] then
			HensaTable["Stress"] = 0
		end

		HensaTable["Stress"] = HensaTable["Stress"] - parseInt(Amount)

		if HensaTable["Stress"] < 0 then
			HensaTable["Stress"] = 0
		end

		TriggerClientEvent("hud:Stress", source, HensaTable["Stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(Sources) do
			local Source = vRP.Source(k)
			if Source then
				vRP.DowngradeHunger(k, ConsumeHunger)
				vRP.DowngradeThirst(k, ConsumeThirst)
			end
		end

		Wait(CooldownHungerThrist)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Foods()
	local source = source
	local Passport = vRP.Passport(source)
	local HensaTable = vRP.Datatable(Passport)
	if source and HensaTable then
		if not HensaTable["Thirst"] then
			HensaTable["Thirst"] = 100
		end

		if not HensaTable["Hunger"] then
			HensaTable["Hunger"] = 100
		end

		HensaTable["Hunger"] = HensaTable["Hunger"] - ConsumeHunger
		HensaTable["Thirst"] = HensaTable["Thirst"] - ConsumeThirst

		if HensaTable["Thirst"] < 0 then
			HensaTable["Thirst"] = 0
		end

		if HensaTable["Hunger"] < 0 then
			HensaTable["Hunger"] = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetHealth(source)
	return GetEntityHealth(GetPlayerPed(source))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ModelPlayer(source)
	if GetEntityModel(GetPlayerPed(source)) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end

	return "mp_m_freemode_01"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetExperience(Passport, Work)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable and not HensaTable[Work] then
		HensaTable[Work] = 0
	end

	return HensaTable[Work] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PutExperience(Passport, Work, Number)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if not HensaTable[Work] then
			HensaTable[Work] = 0
		end

		HensaTable[Work] = HensaTable[Work] + Number
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetArmour(source, Amount)
	if GetPedArmour(GetPlayerPed(source)) + Amount > 100 then
		Amount = 100 - GetPedArmour(GetPlayerPed(source))
	end

	SetPedArmour(GetPlayerPed(source), GetPedArmour(GetPlayerPed(source)) + Amount)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Teleport(source, x, y, z)
	SetEntityCoords(GetPlayerPed(source), x + 0.0001, y + 0.0001, z + 0.0001, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetEntityCoords(source)
	return GetEntityCoords(GetPlayerPed(source))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreatePed(Model, X, Y, Z, Heading, Type)
	local Hash = GetHashKey(Model)
	local Create = CreatePed(Type, Hash, X, Y, Z, Heading, true, false)
	local timeout = GetGameTimer() + 1000
	while not DoesEntityExist(Create) do
		if GetGameTimer() > timeout then
			return false, nil
		end

		Wait(1)
	end

	local Network = NetworkGetNetworkIdFromEntity(Create)
	return true, Network
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObject(Model, x, y, z, Weapon)
	local Passport = vRP.Passport(source)
	if Passport then
		local SpawnObjects = 0
		local Hash = GetHashKey(Model)
		local Object = CreateObject(Hash, x, y, z, true, true, false)

		while not DoesEntityExist(Object) and SpawnObjects <= 1000 do
			SpawnObjects = SpawnObjects + 1
			Wait(1)
		end

		if DoesEntityExist(Object) then
			local NetworkID = NetworkGetNetworkIdFromEntity(Object)
			if Weapon then
				Objects[Passport] = Objects[Passport] or {}
				Objects[Passport][Weapon] = NetworkID
			else
				Objects[Passport] = Objects[Passport] or {}
				Objects[Passport][NetworkID] = true
			end

			return true, NetworkID
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketClient")
AddEventHandler("vRP:BucketClient", function(value)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if value == "Enter" then
			Player(source)["state"]["Route"] = Passport
			SetPlayerRoutingBucket(source, Passport)
		else
			Player(source)["state"]["Route"] = 0
			SetPlayerRoutingBucket(source, 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer", function(source, value, bucket)
	if value == "Enter" then
		Player(source)["state"]["Route"] = bucket
		SetPlayerRoutingBucket(source, bucket)

		if bucket > 0 then
			SetRoutingBucketEntityLockdownMode(0, EntityLockdown)
			SetRoutingBucketPopulationEnabled(bucket, false)
		end
	else
		SetPlayerRoutingBucket(source, 0)
		Player(source)["state"]["Route"] = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Groups()
	return Groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATAGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(Permission)
	return vRP.GetServerData("Permissions:"..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserType(Passport,Type)
	for k,v in pairs(Groups) do
		local Datatable = vRP.GetServerData("Permissions:"..k)
		if Groups[k]["Type"] and Groups[k]["Type"] == Type and Datatable[tostring(Passport)] then
			return k
		end
	end

	return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERHIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserHierarchy(Passport, Permission)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Datatable[tostring(Passport)] then
		return Datatable[tostring(Passport)]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGROUPSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetGroupSalary(GroupName, Hierarchy)
	if Hierarchy then
		for k,v in pairs(Groups) do
			if k == GroupName then
				return v["Salary"][Hierarchy]
			end
		end
	else
		for k,v in pairs(Groups) do
			if k == GroupName then
				return v["Salary"]
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Hierarchy(Permission)
	if Groups[Permission] and Groups[Permission]["Hierarchy"] then
		return Groups[Permission]["Hierarchy"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMEHIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.NameHierarchy(Permission,Passport)
	if Groups[Permission] then
		return vRP.Hierarchy(Permission)[vRP.GetUserHierarchy(Passport, Permission)]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.NumPermission(Permission)
	local Permissions = {}
	local ServiceCount = 0
	if Groups[Permission] and Groups[Permission]["Parent"] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			if Groups[k] and Groups[k]["Service"] then
				for i,groups in pairs(Groups[k]["Service"]) do
					if groups and Characters[groups] and not Permissions[i] then
						Permissions[i] = groups
						ServiceCount = ServiceCount + 1
					end
				end
			end
		end
	end

	return Permissions, ServiceCount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceToggle(Source, Passport, Permission, Silenced)
	local Perm = splitString(Permission, "-")
	if (Characters[Source] and Groups[Perm[1]]) and Groups[Perm[1]]["Service"] then
		if Groups[Perm[1]]["Service"][tostring(Passport)] == Source then
			vRP.ServiceLeave(Source, tostring(Passport), Perm[1], Silenced)
		else
			if vRP.HasGroup(tostring(Passport), Perm[1]) and not Groups[Perm[1]]["Service"][tostring(Passport)] then
				vRP.ServiceEnter(Source, tostring(Passport), Perm[1], Silenced)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICEENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceEnter(Source, Passport, Permission, Silenced)
	if Characters[Source] then
		if ClientState[Permission] then
			Player(Source)["state"][Permission] = true
			TriggerClientEvent("service:Label", Source, Permission, "Sair de Serviço")
		end

		if GroupBlips[Permission] then
			local Hierarchy = vRP.GetUserHierarchy(Passport,Permission)
			exports["markers"]:Enter(Source,Permission,Hierarchy,Passport,false)
		end

		if Groups[Permission] and Groups[Permission]["Salary"] then
			TriggerEvent("Salary:Add", tostring(Passport), Permission)
		end

		Groups[Permission]["Service"][tostring(Passport)] = Source

		exports["discord"]:Embed("Services","**Passaporte:** "..Passport.."\n**Entrou na permissão:** "..Permission,0xa3c846)

		if not Silenced then
			TriggerClientEvent("Notify", Source, "Sucesso", "Você entrou em serviço.", "verde", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceLeave(Source, Passport, Permission, Silenced)
	if Characters[Source] then
		if ClientState[Permission] then
			Player(Source)["state"][Permission] = false
			TriggerClientEvent("service:Label", Source, Permission, "Entrar em Serviço")
		end

		if GroupBlips[Permission] then
			exports["markers"]:Exit(Source, Passport)
			TriggerClientEvent("radio:RadioClean", Source)
		end

		if Groups[Permission] and Groups[Permission]["Salary"] then
			TriggerEvent("Salary:Remove", tostring(Passport), Permission)
		end

		if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
			Groups[Permission]["Service"][tostring(Passport)] = nil
		end

		
		exports["discord"]:Embed("Services","**Passaporte:** "..Passport.."\n**Saiu da permissão:** "..Permission,0xa3c846)

		if not Silenced then
			TriggerClientEvent("Notify", Source, "Atenção", "Você saiu de serviço.", "amarelo", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPermission(Passport, Permission, Level, Mode)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Groups[Permission] then
		if Mode then
			if Mode == "Demote" then
				Datatable[tostring(Passport)] = Datatable[tostring(Passport)] + 1

				if Datatable[tostring(Passport)] > #Groups[Permission]["Hierarchy"] then
					Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
				end
			else
				Datatable[tostring(Passport)] = Datatable[tostring(Passport)] - 1

				if Datatable[tostring(Passport)] < 1 then
					Datatable[tostring(Passport)] = 1
				end
			end
		else
			if Level then
				Level = parseInt(Level)

				if #Groups[Permission]["Hierarchy"] < Level then
					Level = #Groups[Permission]["Hierarchy"]
					Datatable[tostring(Passport)] = Level
				else
					Datatable[tostring(Passport)] = Level
				end
			end

			if not Level then
				Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
			end
		end

		vRP.ServiceEnter(vRP.Source(Passport), tostring(Passport), Permission, true)
		vRP.Query("entitydata/SetData",{ Name = "Permissions:"..Permission, Information = json.encode(Datatable) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemovePermission(Passport, Permission)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Groups[Permission] then
		if Groups[Permission]["Service"] and Groups[Permission]["Service"][tostring(Passport)] then
			Groups[Permission]["Service"][tostring(Passport)] = nil
		end

		if Datatable[tostring(Passport)] then
			Datatable[tostring(Passport)] = nil
			vRP.ServiceLeave(vRP.Source(tostring(Passport)), tostring(Passport), Permission, true)
			vRP.Query("entitydata/SetData",{ Name = "Permissions:"..Permission, Information = json.encode(Datatable) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasPermission(Passport, Permission, Level)
	local Datatable = vRP.GetServerData("Permissions:"..Permission)
	if Datatable[tostring(Passport)] then
		if not Level or not (Datatable[tostring(Passport)] > Level) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasGroup(Passport, Permission, Level)
	if Groups[Permission] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			local Datatable = vRP.GetServerData("Permissions:"..k)
			if Datatable[tostring(Passport)] then
				if not Level or not (Datatable[tostring(Passport)] > Level) then
					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasService(Passport, Permission)
	if Groups[Permission] then
		for k,v in pairs(Groups[Permission]["Parent"]) do
			if Groups[k]["Service"][tostring(Passport)] then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Update")
AddEventHandler("Salary:Update",function(Passport, Amount)
	local Source = vRP.Source(Passport)
	local HensaTable = vRP.Datatable(Passport)
	if HensaTable then
		if HensaTable["Salary"] ~= nil then
			HensaTable["Salary"] = HensaTable["Salary"] + parseInt(Amount)
		else
			HensaTable["Salary"] = parseInt(Amount)
		end

		TriggerClientEvent("Notify", Source, "Banco Central", "Você recebeu <b>$"..Dotted(Amount).."</b> "..ItemName(DefaultMoneyOne)..".", "money", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Verify")
AddEventHandler("Salary:Verify", function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Normal" then
			local HensaTable = vRP.Datatable(Passport)
			if HensaTable then
				local Salary = HensaTable["Salary"] or 0
				TriggerClientEvent("Notify", source, "Conta Salário", "Seu saldo é de: <b>$"..Dotted(Salary).."</b> "..ItemName(DefaultMoneyOne)..".", "money", 10000)
			end
		elseif Mode == "Special" then
			local Identities = vRP.Identities(source)
			local Account = vRP.Account(Identities)
			if Identities and Account then
				if Account["Gemstone"] > 0 then
					TriggerClientEvent("Notify", source, "Conta Especial", "Seu saldo é de: <b>"..Dotted(Account["Gemstone"]).."</b> "..ItemName(DefaultMoneySpecial)..".", "money", 10000)
				else
					TriggerClientEvent("Notify", source, "Conta Especial", "Seu saldo é de: <b>0</b> "..ItemName(DefaultMoneySpecial)..".", "money", 5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:RECEIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Salary:Receive")
AddEventHandler("Salary:Receive", function()
    local source = source
    local passport = vRP.Passport(source)
    
    if passport then
        local hensaTable = vRP.Datatable(passport)
        
        if hensaTable then
            if not (SalaryCooldown[passport] and os.time() <= SalaryCooldown[passport]) then
                if hensaTable["Salary"] then
                    local salaryAmount = hensaTable["Salary"]
                    local confirmation = vRP.Request(source, "Banco Central", string.format("Você realmente deseja sacar <b>$%s</b> %s?", Dotted(salaryAmount), ItemName(DefaultMoneyOne)))
                    
                    if confirmation then
                        exports["discord"]:Embed("Salary", string.format("**Passaporte:** %s\n**Sacou de salário:** %s", passport, Dotted(salaryAmount)), 0xa3c846, source)
                        
                        TriggerClientEvent("Notify", source, "Banco Central", string.format("Você efetuou o saque de <b>$%s</b> %s.", Dotted(salaryAmount), ItemName(DefaultMoneyOne)), "money", 5000)
                        
                        vRP.GiveBank(passport, salaryAmount)
                        SalaryCooldown[passport] = os.time() + 60
                        hensaTable["Salary"] = nil
                    end
                else
                    TriggerClientEvent("Notify", source, "Aviso", "Você não possui valores para sacar.", "vermelho", 5000)
                end
            else
                local cooldown = CompleteTimers(SalaryCooldown[passport] - os.time())
                TriggerClientEvent("Notify", source, "Banco Central", string.format("Aguarde <b>%s</b>.", cooldown), "azul", 5000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Add", function(Passport, Permission)
	if not Salary[Permission] then
		Salary[Permission] = {}
	end

	if not Salary[Permission][Passport] then
		Salary[Permission][Passport] = os.time() + SalarySeconds
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Remove", function(Passport, Permission)
	if Permission then
		if Salary[Permission] and Salary[Permission][Passport] then
			Salary[Permission][Passport] = nil
		end
	else
		for k,v in pairs(Salary) do
			if Salary[k][Passport] then
				Salary[k][Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(60000)

		local Users = vRP.Players()
		local ActualTime = os.time()
		for Index,Source in pairs(Users) do
			local Passport = vRP.Passport(Source)
			if Passport then
				for Group,SourceAndTime in pairs(Salary) do
					if Salary[Group][Passport] then
						if Salary[Group][Passport] <= ActualTime then
							local Hensa = vRP.GetUserHierarchy(Passport, Group)
							if Hensa then
								local GroupSalary = vRP.GetGroupSalary(Group, Hensa)
								if GroupSalary then
									if Groups[Group]["Type"] == "Work" then
										if vRP.HasService(Passport, Group) then
											TriggerEvent("Salary:Update", Passport, GroupSalary)
											Salary[Group][Passport] = os.time() + SalarySeconds
										end
									else
										TriggerEvent("Salary:Update", Passport, GroupSalary)
										Salary[Group][Passport] = os.time() + SalarySeconds
									end
								end
							end
						end
					else
						Salary[Group][Passport] = os.time() + SalarySeconds
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, Source)
	for groupName, groupData in pairs(Groups) do
		local permissions = vRP.GetServerData("Permissions:" .. groupName)
		local hasPermission = permissions[tostring(Passport)]

		if hasPermission then
			if groupData["Service"] then
				vRP.ServiceToggle(Source, Passport, groupName, true)
			end

			if groupData["Salary"] then
				TriggerEvent("Salary:Add", tostring(Passport), groupName)
			end

			if vRP.HasGroup(Passport, "Admin") then
				Player(Source)["state"]["Admin"] = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport, Source)
	if Party["Users"][Passport] then
		local room = Party["Room"][Party["Users"][Passport]]
		if room and room[Passport] then
			room[Passport] = nil

			if next(room) == nil then
				Party["Room"][Party["Users"][Passport]] = nil
			end
        end

		Party["Users"][Passport] = nil
	end

	for k, group in pairs(Groups) do
		if group["Service"][tostring(Passport)] then
			if GroupBlips[k] then
				exports["markers"]:Exit(Source, Passport)
			end

			group["Service"][tostring(Passport)] = false
		end

		if Groups[k] and Groups[k]["Salary"] then
			TriggerEvent("Salary:Remove", tostring(Passport), k)
		end

		if vRP.HasGroup(Passport, "Admin") then
			Player(Source)["state"]["Admin"] = false
		end
	end

	TriggerEvent("DebugObjects", Passport)
	TriggerEvent("DebugWeapons", Passport)

	for k, userSalary in pairs(Salary) do
		if userSalary[Passport] then
			Salary[k][Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart", function(resource)
	if resource == "vrp" then
		print("^5Hensa vRP^7 Premium.")
	end
end)