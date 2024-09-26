function handleInitialState()
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(voiceModeData[1] + 0.0)
	MumbleClearVoiceTarget(voiceTarget)
	MumbleSetVoiceTarget(voiceTarget)
	MumbleSetVoiceChannel(LocalPlayer.state.assignedChannel)

	while MumbleGetVoiceChannelFromServerId(playerServerId) ~= LocalPlayer.state.assignedChannel do
		Wait(250)
		MumbleSetVoiceChannel(LocalPlayer.state.assignedChannel)
	end

	MumbleAddVoiceTargetChannel(voiceTarget,LocalPlayer.state.assignedChannel)

	addNearbyPlayers()
end

AddEventHandler("mumbleConnected",function()
	local voiceModeData = Cfg.voiceModes[mode]
	LocalPlayer.state:set("proximity",{
		index = mode,
		distance = voiceModeData[1],
		mode = voiceModeData[2]
	},true)

	handleInitialState()
end)

AddEventHandler("pma-voice:settingsCallback",function(cb)
	cb(Cfg)
end)