AddEventHandler("rcore_clothing:onClothingShopOpened", function()
    TriggerServerEvent("rcore_clothing:enabletemppermissions")
end)

AddEventHandler("rcore_clothing:onClothingShopClosed", function()
    TriggerServerEvent("rcore_clothing:disabletemppermissions")
end)