-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Fire = {}
local Blip = nil
local Objects = {}
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadModel("prop_mil_crate_01")
	LoadModel("prop_crashed_heli")

	if GlobalState["Helicrash"] then
		Active = GlobalState["Helicrash"]
		HelicrashMarkerMap()
	end

	while true do
		local TimeDistance = 5000
		if Active and Components[Active] then
			local Ped = PlayerPedId()
			local Select = Components[Active]
			local Coords = GetEntityCoords(Ped)

			if #(Coords - Select["Center"]["xyz"]) <= 1000 then
				if not Objects["Helicopter"] then
					Objects["Helicopter"] = CreateObjectNoOffset("prop_crashed_heli",Select["Center"]["xyz"],false,false,false)
					SetEntityLodDist(Objects["Helicopter"],0xFFFF)
					FreezeEntityPosition(Objects["Helicopter"],true)
					PlaceObjectOnGroundProperly(Objects["Helicopter"])
					SetEntityHeading(Objects["Helicopter"],Select["Center"]["w"])
				end

				for Number,Locate in pairs(Select["Coords"]) do
					if not Objects[Number] then
						Objects[Number] = CreateObjectNoOffset("prop_mil_crate_01",Locate["xyz"],false,false,false)
						SetEntityLodDist(Objects[Number],0xFFFF)
						FreezeEntityPosition(Objects[Number],true)
						PlaceObjectOnGroundProperly(Objects[Number])
						SetEntityHeading(Objects[Number],Locate["w"])

						if GlobalState["Work"] <= GlobalState["Helifire"] then
							Fire[Number] = StartScriptFire(Locate["xyz"],25,0)
						end

						exports["target"]:AddBoxZone("Helicrash:"..Number,Locate["xyz"],1.25,2.0,{
							name = "Helicrash:"..Number,
							heading = Locate["w"],
							minZ = Locate["z"] - 1.0,
							maxZ = Locate["z"] + 0.75
						},{
							shop = "Helicrash:"..Number,
							Distance = 2.0,
							options = {
								{
									event = "chest:Open",
									label = "Abrir",
									tunnel = "client",
									service = "Custom"
								}
							}
						})
					else
						if Fire[Number] then
							if #(Coords - Locate["xyz"]) <= 2.5 then
								ApplyDamageToPed(Ped,5,false)
								TimeDistance = 2500
							end

							if GlobalState["Work"] > GlobalState["Helifire"] then
								RemoveScriptFire(Fire[Number])
								Fire[Number] = nil
							end
						end
					end
				end
			else
				if Objects["Helicopter"] then
					for Index,v in pairs(Objects) do
						if Index ~= "Helicopter" then
							exports["target"]:RemCircleZone("Helicrash:"..Index)
						end

						if DoesEntityExist(Objects[Index]) then
							DeleteEntity(Objects[Index])
						end

						if Fire[Index] then
							RemoveScriptFire(Fire[Index])
							Fire[Index] = nil
						end

						Objects[Index] = nil
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Helicrash",nil,function(Name,Key,Value)
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
	end

	Active = Value

	if Value then
		HelicrashMarkerMap()
	end

	if Objects["Helicopter"] then
		for Index,v in pairs(Objects) do
			if Index ~= "Helicopter" then
				exports["target"]:RemCircleZone("Helicrash:"..Index)
			end

			if DoesEntityExist(Objects[Index]) then
				DeleteEntity(Objects[Index])
			end

			if Fire[Index] then
				RemoveScriptFire(Fire[Number])
				Fire[Index] = nil
			end

			Objects[Index] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASHMARKERMAP
-----------------------------------------------------------------------------------------------------------------------------------------
function HelicrashMarkerMap()
	if Components[Active] then
		Blip = AddBlipForCoord(Components[Active]["Center"]["xyz"])
		SetBlipSprite(Blip,43)
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,5)
		SetBlipScale(Blip,0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Helicrash")
		EndTextCommandSetBlipName(Blip)
	end
end