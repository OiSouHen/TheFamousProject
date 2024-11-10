local disableUpdates = false
local isListenerEnabled = false
local plyCoords = GetEntityCoords(PlayerPedId())
proximity = MumbleGetTalkerProximity()
currentTargets = {}

function orig_addProximityCheck(ply)
	local tgtPed = GetPlayerPed(ply)
	local voiceRange = proximity * 3 or proximity
	local distance = #(plyCoords - GetEntityCoords(tgtPed))

	return distance < voiceRange,distance
end

local addProximityCheck = orig_addProximityCheck

exports("overrideProximityCheck",function(fn)
	addProximityCheck = fn
end)

exports("resetProximityCheck",function()
	addProximityCheck = orig_addProximityCheck
end)

function addNearbyPlayers()
	if disableUpdates then return end

	local Ped = PlayerPedId()
	plyCoords = GetEntityCoords(Ped)
	proximity = MumbleGetTalkerProximity()
	currentTargets = {}
	MumbleClearVoiceTargetChannels(voiceTarget)
	if LocalPlayer.state.disableProximity then return end
	MumbleAddVoiceChannelListen(LocalPlayer.state.assignedChannel)
	MumbleAddVoiceTargetChannel(voiceTarget,LocalPlayer.state.assignedChannel)

	for source, _ in pairs(callData) do
		if source ~= playerServerId then
			MumbleAddVoiceTargetChannel(voiceTarget,MumbleGetVoiceChannelFromServerId(source))
		end
	end

	local players = GetActivePlayers()
	for i = 1,#players do
		local ply = players[i]
		local serverId = GetPlayerServerId(ply)
		local shouldAdd, distance = addProximityCheck(ply)
		if shouldAdd then
			MumbleAddVoiceTargetChannel(voiceTarget,MumbleGetVoiceChannelFromServerId(serverId))
		end
	end
end

function setSpectatorMode(enabled)
	isListenerEnabled = enabled
	local players = GetActivePlayers()
	if isListenerEnabled then
		for i = 1,#players do
			local ply = players[i]
			local serverId = GetPlayerServerId(ply)
			if serverId == playerServerId then goto skip_loop end
			MumbleAddVoiceChannelListen(MumbleGetVoiceChannelFromServerId(serverId))

			::skip_loop::
		end
	else
		for i = 1,#players do
			local ply = players[i]
			local serverId = GetPlayerServerId(ply)
			if serverId == playerServerId then goto skip_loop end
			MumbleRemoveVoiceChannelListen(MumbleGetVoiceChannelFromServerId(serverId))

			::skip_loop::
		end
	end
end

RegisterNetEvent("onPlayerJoining",function(serverId)
	if isListenerEnabled then
		MumbleAddVoiceChannelListen(MumbleGetVoiceChannelFromServerId(serverId))
	end
end)

RegisterNetEvent("onPlayerDropped",function(serverId)
	if isListenerEnabled then
		MumbleRemoveVoiceChannelListen(MumbleGetVoiceChannelFromServerId(serverId))
	end
end)

local listenerOverride = false
exports("setListenerOverride",function(enabled)
	type_check({ enabled,"boolean" })
	listenerOverride = enabled
end)

local lastTalkingStatus = false
local lastRadioStatus = false
local voiceState = "proximity"

CreateThread(function()
	while true do
		while not MumbleIsConnected() do
			Wait(100)
		end

		local curTalkingStatus = MumbleIsPlayerTalking(PlayerId()) == 1

		if lastRadioStatus ~= radioPressed or lastTalkingStatus ~= curTalkingStatus then
			lastRadioStatus = radioPressed
			lastTalkingStatus = curTalkingStatus
			TriggerEvent("hud:Voice",curTalkingStatus)
		end

		if voiceState == "proximity" then
			addNearbyPlayers()
			local cam = GetRenderingCam() or -1
			local isSpectating = NetworkIsInSpectatorMode() or cam ~= -1
			if not isListenerEnabled and (isSpectating or listenerOverride) then
				setSpectatorMode(true)
			elseif isListenerEnabled and not isSpectating and not listenerOverride then
				setSpectatorMode(false)
			end
		end

		Wait(200)
	end
end)

exports("setVoiceState",function(_voiceState,channel)
	voiceState = _voiceState
	if voiceState == "channel" then
		type_check({ channel,"number" })
		channel = channel + 65535
		MumbleSetVoiceChannel(channel)

		while MumbleGetVoiceChannelFromServerId(playerServerId) ~= channel do
			Wait(250)
		end

		MumbleAddVoiceTargetChannel(voiceTarget,channel)
	elseif voiceState == "proximity" then
		handleInitialState()
	end
end)

AddEventHandler("onClientResourceStop",function(Resource)
	if type(addProximityCheck) == "table" then
		local proximityCheckRef = addProximityCheck.__cfx_functionReference
		if proximityCheckRef then
			local isResource = string.match(proximityCheckRef,Resource)
			if isResource then
				addProximityCheck = orig_addProximityCheck
			end
		end
	end
end)

exports("addVoiceMode",function(distance,name)
	for i = 1,#Cfg.voiceModes do
		local voiceMode = Cfg.voiceModes[i]
		if voiceMode[2] == name then
			voiceMode[1] = distance
			return
		end
	end
	Cfg.voiceModes[#Cfg.voiceModes + 1] = { distance,name }
end)

exports("removeVoiceMode",function(name)
	for i = 1,#Cfg.voiceModes do
		local voiceMode = Cfg.voiceModes[i]
		if voiceMode[2] == name then
			table.remove(Cfg.voiceModes,i)
			if mode == i then
				local newMode = Cfg.voiceModes[1]
				mode = 1
				setProximityState(newMode[mode],false)
			end

			return true
		end
	end

	return false
end)