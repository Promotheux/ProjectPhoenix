Config = {}

Config.Debug = false
Config.JobBusy = false

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}


Config.FishingItems = {
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "Fishing Rod"
    },
    ["bait"] = {
        ["name"] = "fishbait",
        ["label"] = "Fishing Bait"
    },
    ["fish"] = {
        ["price"] = 47
    },
    ["fish_bass"] = {
        ["price"] = 75
    },
    ["fish_bluefish"] = {
        ["price"] = 100
    },
    ["fish_cod"] = {
        ["price"] = 125
    },
    ["fish_flounder"] = {
        ["price"] = 190
    },
    ["fish_mackerel"] = {
        ["price"] = 250
    },
    ["fish_dolphin"] = {    
        ["price"] = 340
    },
    ["fish_shark"] = {    
        ["price"] = 360
    },
    ["fish_whale"] = {
        ["price"] = 390
    },
}


Config.FishingZones = {
    {
        ["name"] = "Beach Fishing",
        ["coords"] = vector3(-1861.96, -1240.744, 8.6157846),
        ["radius"] = 50.0,
    }
}
