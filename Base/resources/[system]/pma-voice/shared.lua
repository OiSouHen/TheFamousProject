Cfg = {}

voiceTarget = 1

if not IsDuplicityVersion() then
	LocalPlayer = LocalPlayer
	playerServerId = GetPlayerServerId(PlayerId())
end

Player = Player
Entity = Entity

Cfg.voiceModes = {
	{ 1.0,"Baixo" },
	{ 4.0,"Médio" },
	{ 8.0,"Alto" },
	{ 12.0,"Muito Alto" },
	{ 28.0, "Megafone" }
}

local function types(Message)
	local argType = type(Message[1])
	for i = 2,#Message do
		local arg = Message[i]
		if argType == arg then
			return true,argType
		end
	end

	return false,argType
end

function type_check(...)
	local vars = {...}
	for i = 1,#vars do
		local var = vars[i]
		local matchesType,varType = types(var)
		if not matchesType then
			table.remove(var,1)
		end
	end
end