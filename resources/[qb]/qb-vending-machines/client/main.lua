local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

exports['qb-target']:AddTargetModel(Config.CoffeeMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:CoffeeShop",
            icon = "fas fa-coffee",
            label = "Gebruik koffieautomaat",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.SnackMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:SnackShop",
            icon = "fas fa-cookie",
            label = "Koop Snacks",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.FizzyMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:FizzyShop",
            icon = "fas fa-beer",
            label = "Koop Drinken",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.WaterMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:WaterShop",
            icon = "fas fa-water",
            label = "Koop Water",
        },
    },
    distance = 2.5
})

RegisterNetEvent("qb-vending:CoffeeShop")
AddEventHandler("qb-vending:CoffeeShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Koffie Automaat", Config.CoffeeItems)
end)

RegisterNetEvent("qb-vending:SnackShop")
AddEventHandler("qb-vending:SnackShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Snack Automaat", Config.SnackItems)
end)

RegisterNetEvent("qb-vending:FizzyShop")
AddEventHandler("qb-vending:FizzyShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Drink Automaat", Config.FizzyItems)
end)

RegisterNetEvent("qb-vending:WaterShop")
AddEventHandler("qb-vending:WaterShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Water Automaat", Config.WaterItems)
end)


