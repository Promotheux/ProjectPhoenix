local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-fishing:GetItemData', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)	

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    TriggerClientEvent('qb-fishing:tryToFish', source)
end)

RegisterNetEvent('qb-fishing:receiveFish2', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

	local giveItem = function(item)
		local itemInfo = QBCore.Shared.Items[item]
		print(item)
		Player.Functions.AddItem(item, 1)
		TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
		exports['dx-log']:Log('fishing', src, 'just got `%s`.', itemInfo.label);
	end


	for i = 1, itemCount, 1 do
		if luck == 100 then
			giveItem("fish_whale")
		elseif luck >= 98 then
			giveItem("fish_shark")
		elseif luck >= 97  then
			giveItem("fish_dolphin")
		elseif luck >= 88 then
			giveItem("fish_mackerel")
		elseif luck >= 80 then
			giveItem("fish_flounder")
		elseif luck >= 74 then
			giveItem("fish_cod")
		elseif luck >= 69 then
			giveItem("fish_bluefish")
		elseif luck >= 67 then
			giveItem("fish_bass")
		else
			giveItem("fish")
		end

		Citizen.Wait(500)
	end
end)

RegisterServerEvent('qb-fishing:sellFish')
AddEventHandler('qb-fishing:sellFish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local whatSold = {};
    local total = 0;

    for k,v in pairs(Config.FishingItems) do
		if v.price then
			local item = Player.Functions.GetItemByName(k)
			if item ~= nil then
				if Player.Functions.RemoveItem(k, item.amount) then
					local price = v.price * item.amount;
					table.insert(whatSold, ('`%dx` %s - `$%d`'):format(item.amount, item.label, price));
					total = total + price;
				end
			end
		end
    end

    Player.Functions.AddMoney('cash', total)

    if total > 0 then
      exports['dx-log']:Log('fishing', src, 'just sold `$%d` in total:\n%s', total, table.concat(whatSold, "\n"));
    end
end)
