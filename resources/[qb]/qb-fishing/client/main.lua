
cachedData = {}
local JobBusy = false

function CreateBlips()
	for i, zone in ipairs(Config.FishingZones) do
		local coords = zone.secret and ((zone.coords / 1.5) - 133.37) or zone.coords
		local name = zone.name
		if not zone.secret then
			local x = AddBlipForCoord(coords)
			SetBlipSprite (x, 405)
			SetBlipDisplay(x, 4)
			SetBlipScale  (x, 0.35)
			SetBlipAsShortRange(x, true)
			SetBlipColour(x, 69)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(x)
		end
	end
end

function DeleteBlips()
	if DoesBlipExist(coords) then
		RemoveBlip(coords)
	end
end

-- function SellFish()


RegisterNetEvent("qb-fishing:tryToFish")
AddEventHandler("qb-fishing:tryToFish", function()
	TryToFish() 
end)


RegisterNetEvent("qb-fishing:yesellfishes")
AddEventHandler("qb-fishing:yesellfishes", function()
	SellFish()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)

exports["qb-target"]:AddCircleZone("fishsales", vector3(-1860.611, -1236.99, 8.6157913), 1.0,
    {
        name = "fishsales",
        debugPoly = false,
        useZ = true
    },
    {
        options = {
            {
                event = "qb-fishing:yesellfishes",
                icon = "fas fa-fish",
                label = "Sell Fish",
                job = 'all',
            }
        },
        distance = 2.5
    }
)