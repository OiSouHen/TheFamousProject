RegisterNetEvent('hydrus:open_url', function(url)
    SendNUIMessage({ 'OPEN_URL', url })
end)

RegisterNetEvent('hydrus:popup', function(payload)
    SendNUIMessage({ 'POPUP', payload })
end)

RegisterNetEvent('hydrus:overlay', function(visible)
    SendNUIMessage({ 'OVERLAY', { visible = visible } })
end)

local requests = { id = 0 }

function RPC(name, args)
    local id = requests.id + 1
    requests.id = id

    TriggerServerEvent('hydrus:rpc', id, name, args or {})
    local future = promise.new()
    requests[id] = future
    return Citizen.Await(future)
end

RegisterNetEvent('hydrus:rpc', function(id, err, response)
    local future = requests[id]
    if future then
        requests[id] = nil
        if err then
            future:reject(err)
        else
            future:resolve(response)
        end
    end
end)

RegisterNUICallback('RPC', function(data, reply)
    reply(RPC(data.name, data.args))
end)

RegisterNUICallback('CLOSE', function(data, reply)
    SetNuiFocus(false)
    reply(true)
end)

RegisterCommand('store', function()
    local credits = RPC('GET_CREDITS')

    if #credits > 0 then
        SetNuiFocus(true, true)
        SendNUIMessage({ 'OPEN', credits })
    end
end)