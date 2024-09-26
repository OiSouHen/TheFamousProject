-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(Title,Message,Css,Timer)
	SendNUIMessage({ name = "Notify", payload = { Css,Message,Title,Timer } })
end)