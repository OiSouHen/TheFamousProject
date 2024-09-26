-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("lb-phone")

while not NetworkIsSessionStarted() do
    Wait(500)
end

loaded = true

function HasPhoneItem()
    if not LocalPlayer["state"]["Active"] or IsPauseMenuActive() or LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or LocalPlayer["state"]["Cancel"] or IsPedReloading(Ped) then
        return false
    end

    return vSERVER.CheckPhone()
end

function HasJob(jobs)
    return false
end

function ApplyVehicleMods(vehicle, vehicleData)
end

function CreateFrameworkVehicle(vehicleData, coords)
end

function GetCompanyData(cb)
    cb {}
end

function DepositMoney(amount, cb)
    cb(false)
end

function WithdrawMoney(amount, cb)
    cb(false)
end

function HireEmployee(source, cb)
    cb(false)
end

function FireEmployee(identifier, cb)
    cb(false)
end

function SetGrade(identifier, newGrade, cb)
    cb(false)
end

function ToggleDuty()
    return false
end