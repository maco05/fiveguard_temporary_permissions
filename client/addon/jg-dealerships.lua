AddEventHandler("jg-dealerships:client:open-showroom", function(dealershipId)
    TriggerServerEvent("jg-dealerships:enabletemppermissions")
end)

AddEventHandler("jg-dealerships:__ox_cb_jg-dealerships:server:exit-showroom", function(dealershipId)
    TriggerServerEvent("jg-dealerships:disabletemppermissions")
end)