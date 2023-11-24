local QBCore = exports['qb-core']:GetCoreObject()

local searched = {3423423424}
local dumpsters = {-1096777189, 666561306, 1437508529, -1426008804, -228596739, 161465839, 651101403, -58485588, 1614656839, -58485588, 218085040}
local canSearch = true

RegisterNetEvent('qb-trashsearch:client:searchtrash', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false

        for i = 1, #dumpsters do
            local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
            local dumpPos = GetEntityCoords(dumpster)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)

            if dist < 1.8 then
            for i = 1, #searched do
                if searched[i] == dumpster then
                    dumpsterFound = true
                end
                if i == #searched and dumpsterFound then
                    QBCore.Functions.Notify('Deze afvalbak is al doorzocht', 'error')
                elseif i == #searched and not dumpsterFound then

                local itemType = math.random(#Config.RewardTypes)
                TriggerEvent('qb-trashsearch:client:progressbar',itemType)
                TriggerServerEvent('qb-trashsearch:server:startDumpsterTimer', dumpster)
                table.insert(searched, dumpster)
                end
            end
        end
    end
end
end)

RegisterNetEvent('qb-trashsearch:server:removeDumpster')
AddEventHandler('qb-trashsearch:server:removeDumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('qb-trashsearch:client:progressbar', function(itemType)
	local src = source
    local ply = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("trash_find", "Afvalbak doorzoeken", 12000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        if Config.RewardTypes[itemType].type == "item" then
            QBCore.Functions.Notify("Je hebt iets gevonden", "success")
            TriggerServerEvent('qb-trashsearch:server:recieveItem')
        elseif Config.RewardTypes[itemType].type == "money" then
            cash = math.random (4, 12)
            QBCore.Functions.Notify("Je hebt €" .. cash .. ",- cash gevonden", "success")
            TriggerServerEvent('qb-trashsearch:server:givemoney', cash)
        elseif Config.RewardTypes[itemType].type == "nothing" then
            QBCore.Functions.Notify("Je hebt niks gevonden", "error")
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        QBCore.Functions.Notify("Gestopt met zoeken", "error")
    end)
end)

----------------------------------------Dumster Storage---------------------------------------------

RegisterNetEvent('qb-dumpsters:client:open:Dumpster:storage') 
AddEventHandler('qb-dumpsters:client:open:Dumpster:storage', function()
    local DumpsterFound = ClosestContainer()
    if DumpsterFound == nil then 
        QBCore.Functions.Notify("Ga dichterbij staan of kijk recht naar de afvalbak.")
        return
    end
    local Dumpster = 'Container | '..math.floor(DumpsterFound.x).. ' | '..math.floor(DumpsterFound.y)..' |'
    TriggerServerEvent("inventory:server:OpenInventory", "stash", Dumpster, {maxweight = 1000000, slots = 50})
    TriggerEvent("inventory:client:SetCurrentStash", Dumpster)
end)

function ClosestContainer()
    for k, v in pairs(Config.Dumpsters) do
        local StartShape = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.1, 0)
        local EndShape = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.8, -0.4)
        local RayCast = StartShapeTestRay(StartShape.x, StartShape.y, StartShape.z, EndShape.x, EndShape.y, EndShape.z, 16, PlayerPedId(), 0)
        local Retval, Hit, Coords, Surface, EntityHit = GetShapeTestResult(RayCast)
        local BinModel = 0
        if EntityHit then
          BinModel = GetEntityModel(EntityHit)
        end
        if v['Model'] == BinModel then
         local EntityHitCoords = GetEntityCoords(EntityHit)
         if EntityHitCoords.x < 0 or EntityHitCoords.y < 0 then
             EntityHitCoords = {x = EntityHitCoords.x + 5000,y = EntityHitCoords.y + 5000}
         end
         return EntityHitCoords
        end
    end
end

--Target Functions

local trashCans = {
    -1096777189,
    666561306,
    1437508529,
    -1426008804,
    -228596739,
    161465839,
    651101403,
    -58485588,
    218085040,
    -206690185,
}

exports['qb-target']:AddTargetModel(trashCans, {
    options = {
        {
            type = "client",
            event = "qb-trashsearch:client:searchtrash",
            icon = "fas fa-dumpster",
            label = "Afvalbak doorzoeken",
        },
        {
            type = "client",
            event = "qb-dumpsters:client:open:Dumpster:storage",
            icon = "far fa-trash-alt",
            label = "Open afvalbak",
        },
    },
    distance = 3.0
})