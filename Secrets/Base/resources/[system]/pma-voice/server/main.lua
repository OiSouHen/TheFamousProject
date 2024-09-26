voiceData = {}
radioData = {}
callData = {}

local mappedChannels = {}
function firstFreeChannel()
	for i = 1,2048 do
		if not mappedChannels[i] then
			return i
		end
	end

	return 0
end

function defaultTable(source)
	handleStateBagInitilization(source)

	return {
		radio = 0,
		call = 0,
		lastRadio = 0,
		lastCall = 0
	}
end

function handleStateBagInitilization(source)
	local plyState = Player(source).state
	if not plyState.pmaVoiceInit then
		plyState:set("call",60,true)
		plyState:set("radio",30,true)
		plyState:set("submix",nil,true)
		plyState:set("proximity",{},true)
		plyState:set("callChannel",0,true)
		plyState:set("radioChannel",0,true)
		plyState:set("voiceIntent","speech",true)
		plyState:set("pmaVoiceInit",true,false)
	end

	local assignedChannel = firstFreeChannel()
	plyState:set("assignedChannel",assignedChannel,true)
	if assignedChannel ~= 0 then
		mappedChannels[assignedChannel] = source
	end
end

CreateThread(function()
	local plyTbl = GetPlayers()
	for i = 1,#plyTbl do
		local ply = tonumber(plyTbl[i])
		voiceData[ply] = defaultTable(plyTbl[i])
	end
end)

AddEventHandler("playerJoining",function()
	if not voiceData[source] then
		voiceData[source] = defaultTable(source)
	end
end)

AddEventHandler("playerDropped",function()
	local source = source
	local mappedChannel = Player(source).state.assignedChannel

	if voiceData[source] then
		local plyData = voiceData[source]

		if plyData.radio ~= 0 then
			removePlayerFromRadio(source,plyData.radio)
		end

		if plyData.call ~= 0 then
			removePlayerFromCall(source,plyData.call)
		end

		voiceData[source] = nil
	end

	if mappedChannel then
		mappedChannels[mappedChannel] = nil
	end
end)

function isValidPlayer(source)
	return voiceData[source]
end
exports("isValidPlayer",isValidPlayer)

function getPlayersInRadioChannel(channel)
	local returnChannel = radioData[channel]
	if returnChannel then
		return returnChannel
	end

	return {}
end

exports("getPlayersInRadioChannel",getPlayersInRadioChannel)
exports("GetPlayersInRadioChannel",getPlayersInRadioChannel)