-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Index,v in pairs(Academy) do
		exports["target"]:AddCircleZone("Academy:"..Index,v["Target"],0.15,{
			name = "Academy:"..Index,
			heading = 0.0,
			useZ = true
		},{
			shop = Index,
			Distance = 1.75,
			options = {
				{
					event = "target:Academy",
					label = "Exercitar",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ACADEMY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("target:Academy",function(Number)
	if Academy[Number] and not GlobalState["Academy-"..Number] and not exports["lb-phone"]:IsOpen() then
		local Ped = PlayerPedId()

		SetEntityHeading(Ped,Academy[Number]["Coords"]["w"])
		SetEntityCoords(Ped,Academy[Number]["Coords"]["xyz"])
		TriggerEvent("emotes",Academy[Number]["Anim"])

		if vSERVER.Academy(Number) then
			TriggerEvent("Progress","Malhando",30000)

			SetTimeout(30000,function()
				vSERVER.AcademyWeight(Number)
				vRP.Destroy()
			end)
		end
	end
end)