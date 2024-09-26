-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DamageVehicleEngineHealth = true
local LastDamage = 0.0
local Vehicle = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE
-----------------------------------------------------------------------------------------------------------------------------------------
local Engine = {
	["Delta"] = 0.0,
	["Scale"] = 0.0,
	["New"] = 1000.0,
	["Last"] = 1000.0,
	["Current"] = 1000.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BODY
-----------------------------------------------------------------------------------------------------------------------------------------
local Body = {
	["Delta"] = 0.0,
	["Scale"] = 0.0,
	["New"] = 1000.0,
	["Last"] = 1000.0,
	["Current"] = 1000.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = {
	["Delta"] = 0,
	["Scale"] = 0,
	["New"] = 1000,
	["Last"] = 1000,
	["Current"] = 1000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Last = nil
local Same = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = {
	[0] = 1.5,
	[1] = 1.5,
	[2] = 1.5,
	[3] = 1.5,
	[4] = 1.5,
	[5] = 1.5,
	[6] = 1.5,
	[7] = 1.5,
	[8] = 1.5,
	[9] = 1.5,
	[10] = 1.5,
	[11] = 1.5,
	[12] = 1.5,
	[13] = 1.5,
	[14] = 0.0,
	[15] = 0.5,
	[16] = 0.5,
	[17] = 1.5,
	[18] = 1.5,
	[19] = 1.5,
	[20] = 1.5,
	[21] = 1.5,
	[22] = 1.5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHVEH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999

        local Ped = PlayerPedId()
        if IsPedInAnyVehicle(Ped) then
            local Vehicle = GetVehiclePedIsUsing(Ped)
            local Classes = GetVehicleClass(Vehicle)
            if Classes ~= 13 and Classes ~= 14 then
                TimeDistance = 1

                if Same == nil then
                    Same = false
                end

                if Same then
                    local Torque = 1.0
                    if Engine["New"] < 900 then
                        Torque = (Engine["New"] + 200.0) / 1100
                    end

                    SetVehicleEngineTorqueMultiplier(Vehicle, Torque)
                end

                if GetPedInVehicleSeat(Vehicle, -1) == Ped then
                    local Roll = GetEntityRoll(Vehicle)
                    if (Roll > 75.0 or Roll < -75.0) and (Classes ~= 15 and Classes ~= 16) then
                        DisableControlAction(0, 59, true)
                        DisableControlAction(0, 60, true)

                        if DamageVehicleEngineHealth then
                            SetVehicleEngineHealth(Vehicle, 0)
                        end
                    end
                end

                Engine["Current"] = GetVehicleEngineHealth(Vehicle)
                if Engine["Current"] >= 1000 then
                    Engine["Last"] = 1000.0
                end

                Engine["New"] = Engine["Current"]
                Engine["Delta"] = Engine["Last"] - Engine["Current"]
                Engine["Scale"] = Engine["Delta"] * 0.6 * Class[Classes + 1]

                Body["Current"] = GetVehicleBodyHealth(Vehicle)
                if Body["Current"] >= 1000 then
                    Body["Last"] = 1000.0
                end

                Body["New"] = Body["Current"]
                Body["Delta"] = Body["Last"] - Body["Current"]
                Body["Scale"] = Body["Delta"] * 0.6 * Class[Classes + 1]

                Health["Current"] = GetEntityHealth(Vehicle)
                if Health["Current"] >= 1000 then
                    Health["Last"] = 1000
                end

                Health["New"] = Health["Current"]
                Health["Delta"] = Health["Last"] - Health["Current"]
                Health["Scale"] = Health["Delta"] * 0.6 * Class[Classes + 1]

                if Vehicle ~= Last then
                    Same = false
                end

                if Same then
                    if Engine["Current"] ~= 1000.0 or Body["Current"] ~= 1000.0 then
                        local Combine = math.max(Engine["Scale"], Body["Scale"])
                        if Combine > (Engine["Current"] - 100.0) then
                            Combine = Combine * 0.7
                        end

                        if Combine > Engine["Current"] then
                            Combine = Engine["Current"] - (210.0 / 5)
                        end

                        Engine["New"] = Engine["Last"] - Combine

                        if Engine["New"] > 210.0 and Engine["New"] < 350.0 then
                            Engine["New"] = Engine["New"] - (0.038 * 7.4)
                        end

                        if Engine["New"] < 210.0 then
                            Engine["New"] = Engine["New"] - (0.1 * 1.5)
                        end

                        if Body["New"] < 0 then
                            Body["New"] = 0.0
                        end

                        if Engine["New"] < 0 then
                            Engine["New"] = 0.0
                        end
                    end
                else
                    Same = true
                end

                if Health["Current"] < 100 then
                    Health["New"] = 100
                end

                if Body["Current"] < 100.0 then
                    Body["New"] = 100.0
                end

                if Engine["Current"] < 100.0 then
                    Engine["New"] = 100.0
                end

                if Engine["New"] ~= Engine["Current"] then
                    SetVehicleEngineHealth(Vehicle, Engine["New"])
                end

                if Body["New"] ~= Body["Current"] then
                    SetVehicleBodyHealth(Vehicle, Body["New"])
                end

                if Health["New"] ~= Health["Current"] then
                    SetEntityHealth(Vehicle, Health["New"])
                    SetVehiclePetrolTankHealth(Vehicle, Health["New"] + 0.0)
                end

                Last = Vehicle
                Body["Last"] = Body["New"]
                Health["Last"] = Health["New"]
                Engine["Last"] = Engine["New"]

                if BurstTyresBySpeed then
                    if GetEntitySpeed(Vehicle) > 65 and math.random(5000) >= 4995 then
                        local NumWheels = GetVehicleNumberOfWheels(Vehicle)
                        local WheelAffect = 0

                        if NumWheels == 2 then
                            WheelAffect = (math.random(2) - 1) * 4
                        elseif NumWheels == 4 then
                            WheelAffect = (math.random(4) - 1)

                            if WheelAffect > 1 then
                                WheelAffect = WheelAffect + 2
                            end
                        elseif NumWheels == 6 then
                            WheelAffect = (math.random(6) - 1)
                        end

                        if GetTyreHealth(Vehicle, WheelAffect) == 1000.0 then
                            SetVehicleTyreBurst(Vehicle, WheelAffect, false, 1000.0)
                        end
                    end
                end

                if ShakeVehicleCamera then
                    local PedsVehicle = GetVehiclePedIsIn(Ped, false)
                    if DoesEntityExist(PedsVehicle) then
                        local Speed = GetEntitySpeed(PedsVehicle) * 2.236936 / 250.0
                        if PedsVehicle ~= nil and PedsVehicle ~= 0 then
                            local VehicleHealth = GetVehicleBodyHealth(PedsVehicle)
                            if VehicleHealth ~= LastDamage then
                                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE", Speed)

								TriggerServerEvent("player:UpgradeStress", 1)
                            end

                            LastDamage = VehicleHealth
                        end
                    end
                end
            end
        else
            if Same then
                Same = false
            end
        end

        Wait(TimeDistance)
    end
end)