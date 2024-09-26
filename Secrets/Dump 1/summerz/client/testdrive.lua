RegisterNetEvent('hydrus:testdrive', function(model)
    local test_location = { -888.8, -3212.37, 13.95, 58.0 }
    local y_limit = -2370.87

    DoScreenFadeOut(500)
    Wait(500)

    local x,y,z,h = table.unpack(test_location)

    -- Anticheats in fivem are weirdos
    if IsWaypointActive() then
        DeleteWaypoint()
        Wait(3000)
    end

    local ped = PlayerPedId()
    local start = GetEntityCoords(ped)
    SetEntityCoords(ped, x, y, z)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(50)
    end

    local vehicle = CreateVehicle(model, x, y, z, h, false)
    SetModelAsNoLongerNeeded(model)

    SetPedIntoVehicle(ped, vehicle, -1)

    DoScreenFadeIn(500)

    -- TriggerEvent('Notify', 'info', 'Leave the vehicle to leave the test drive')

    while IsPedInVehicle(ped, vehicle) and GetEntityCoords(ped).y < y_limit do
        Wait(400)
    end

    DoScreenFadeOut(500)
    Wait(500)

    DeleteEntity(vehicle)
    RPC('EXIT_TESTDRIVE')

    SetEntityCoords(ped, start)
    DoScreenFadeIn(500)
end)