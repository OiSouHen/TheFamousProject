-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Hash)
	if type(Hash) == "string" then
		Hash = GetHashKey(Hash)
	end

	RequestModel(Hash)
	local Looping = GetGameTimer() + 1000
	if IsModelInCdimage(Hash) and IsModelValid(Hash) then
		while not HasModelLoaded(Hash) and GetGameTimer() <= Looping do
			RequestModel(Hash)
			Wait(1)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadAnim(Dict)
	RequestAnimDict(Dict)
	local Looping = GetGameTimer() + 1000
	while not HasAnimDictLoaded(Dict) and GetGameTimer() <= Looping do
		RequestAnimDict(Dict)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
	local Looping = GetGameTimer() + 1000
	RequestStreamedTextureDict(Library,false)
	while not HasStreamedTextureDictLoaded(Library) and GetGameTimer() <= Looping do
		RequestStreamedTextureDict(Library,false)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadMovement(Library)
	RequestAnimSet(Library)
	local Looping = GetGameTimer() + 1000
	while not HasAnimSetLoaded(Library) and GetGameTimer() <= Looping do
		RequestAnimSet(Library)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPTFXASSET
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadPtfxAsset(Library)
	RequestNamedPtfxAsset(Library)
	local Looping = GetGameTimer() + 1000
	while not HasNamedPtfxAssetLoaded(Library) and GetGameTimer() <= Looping do
		RequestNamedPtfxAsset(Library)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadNetwork(Network)
	local Looping = GetGameTimer() + 1000
	while not NetworkDoesNetworkIdExist(Network) and GetGameTimer() <= Looping do
		Wait(1)
	end

	if NetworkDoesNetworkIdExist(Network) then
		local Object = NetToEnt(Network)

		if DoesEntityExist(Object) then
			Looping = GetGameTimer() + 1000
			NetworkRequestControlOfEntity(Object)
			while not NetworkHasControlOfEntity(Object) and GetGameTimer() <= Looping do
				NetworkRequestControlOfEntity(Object)
				Wait(1)
			end

			Looping = GetGameTimer() + 1000
			SetEntityAsMissionEntity(Object,true,true)
			while not IsEntityAMissionEntity(Object) and GetGameTimer() <= Looping do
				SetEntityAsMissionEntity(Object,true,true)
				Wait(1)
			end

			return Object
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPolice()
	return LocalPlayer["state"]["LSPD"] or LocalPlayer["state"]["BCSO"] or LocalPlayer["state"]["BCPR"]
end