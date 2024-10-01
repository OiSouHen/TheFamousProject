-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Hash)
	if type(Hash) == "string" then
		Hash = GetHashKey(Hash)
	end

	RequestModel(Hash)
	if IsModelInCdimage(Hash) and IsModelValid(Hash) then
		while not HasModelLoaded(Hash) do
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
	while not HasAnimDictLoaded(Dict) do
		RequestAnimDict(Dict)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
	RequestStreamedTextureDict(Library, false)
	while not HasStreamedTextureDictLoaded(Library) do
		RequestStreamedTextureDict(Library, false)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadMovement(Library)
	RequestAnimSet(Library)
	while not HasAnimSetLoaded(Library) do
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
	while not HasNamedPtfxAssetLoaded(Library) do
		RequestNamedPtfxAsset(Library)
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadNetwork(Network)
	Wait(100)

	if NetworkDoesNetworkIdExist(Network) then
		local Object = NetToEnt(Network)

		if DoesEntityExist(Object) then
			NetworkRequestControlOfEntity(Object)
			while not NetworkHasControlOfEntity(Object) do
				Wait(1)
			end

			SetEntityAsMissionEntity(Object, true, true)
			while not IsEntityAMissionEntity(Object) do
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
	return LocalPlayer["state"]["Policia"]
end