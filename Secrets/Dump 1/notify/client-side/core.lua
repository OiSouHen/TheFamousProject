-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify", function(Title, Message, Color, Timer)
    Timer = Timer or Config.DefaultTime
    local Theme = Config.Themes[Color] or Config.Themes["default"]
    SendNUIMessage({ Action = "Notify", Payload = { Title, Message, Timer, Theme } })
end)