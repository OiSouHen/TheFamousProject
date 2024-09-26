-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify", function(Theme, Message, Title, Timer)
    Timer = Timer or Config.DefaultTime
    local Theme = Config.Themes[Color] or Config.Themes["default"]
    SendNUIMessage({ Action = "Notify", Payload = { Title or "Notificação", Message, Timer, Theme } })
end)