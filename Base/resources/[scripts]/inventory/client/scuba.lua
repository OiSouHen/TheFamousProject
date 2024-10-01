-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
ScubaMask = nil
ScubaTank = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SCUBAREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:ScubaRemove")
AddEventHandler("inventory:ScubaRemove",function()
	if ScubaMask and DoesEntityExist(ScubaMask) then
		TriggerServerEvent("DeleteObject",ObjToNet(ScubaMask))
		ScubaMask = nil
	end

	if ScubaTank and DoesEntityExist(ScubaTank) then
		TriggerServerEvent("DeleteObject",ObjToNet(ScubaTank))
		ScubaTank = nil
	end

	SetEnableScuba(PlayerPedId(),false)
	SetPedMaxTimeUnderwater(PlayerPedId(),10.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Scuba")
AddEventHandler("inventory:Scuba",function()
	if ScubaMask or ScubaTank then
		TriggerEvent("inventory:ScubaRemove")
	else
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		local Network = vRPS.CreateObject("p_s_scuba_tank_s",Coords["x"],Coords["y"],Coords["z"])
		if Network then
			ScubaTank = LoadNetwork(Network)
			if ScubaTank then
				AttachEntityToEntity(ScubaTank,Ped,GetPedBoneIndex(Ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
				SetModelAsNoLongerNeeded("p_s_scuba_tank_s")
				SetEntityLodDist(ScubaTank,0xFFFF)
			end
		end

		local Network = vRPS.CreateObject("p_s_scuba_mask_s",Coords["x"],Coords["y"],Coords["z"])
		if Network then
			ScubaMask = LoadNetwork(Network)
			if ScubaMask then
				AttachEntityToEntity(ScubaMask,Ped,GetPedBoneIndex(Ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
				SetModelAsNoLongerNeeded("p_s_scuba_mask_s")
				SetEntityLodDist(ScubaMask,0xFFFF)
			end
		end

		SetEnableScuba(Ped,true)
		SetPedMaxTimeUnderwater(Ped,9999.0)
	end
end)