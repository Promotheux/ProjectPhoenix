local Translations = {
    info = {
        ["air_veh"] = "Vliegtuig huren",
        ["land_veh"] = "Voertuig huren",
        ["sea_veh"] = "Boot huren",
    },
    error = {
        ["not_enough_space"] = "%{vehicle} staat in de weg!",
        ["not_enough_money"] = "Je hebt niet genoeg geld",
        ["no_vehicle"] = "Je hebt geen voertuig om terug te brengen",
        ["no_driver_license"] = "Je hebt geen rijbewijs",
        ["no_pilot_license"] = "Je hebt geen vliegbrevet"
    },
    task = {
        ["return_veh"] = "Breng jouw gehuurde voertuig terug",
        ['veh_returned'] = 'Voertuig ingeleverd'
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})