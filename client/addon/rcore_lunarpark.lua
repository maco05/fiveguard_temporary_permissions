-- Freefall
AddEventHandler("rcore_lunarpark:Freefall:attachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:enabletemppermissions")
end)

AddEventHandler("rcore_lunarpark:Freefall:detachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:disabletemppermissions")
end)

-- RollerCoaster
AddEventHandler("rcore_lunarpark:RollerCoaster:attachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:enabletemppermissions")
end)

AddEventHandler("rcore_lunarpark:RollerCoaster:detachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:disabletemppermissions")
end)

-- Wheel
AddEventHandler("rcore_lunarpark:Wheel:attachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:enabletemppermissions")
end)

AddEventHandler("rcore_lunarpark:Wheel:detachPlayer", function()
    TriggerServerEvent("rcore_lunarpark:disabletemppermissions")
end)