Config = {};

Config.IdCardSettings = {
   closeKey = 'Backspace',
   autoClose = {
      status = true, -- or true
      time = 4000
   }
};

Config.Licenses = {
   ['id_card'] = {
      header = 'ID Kaart',
      background = '#ebf7fd',
      prop = 'prop_franklin_dl'
   },
   ['driver_license'] = {
      header = 'Rijbewijs',
      background = '#febbbb',
      prop = 'prop_franklin_dl',
   },
   ['weaponlicense'] = {
      header = 'Wapen Licentie',
      background = '#c7ffe5',
      prop = 'prop_franklin_dl',
   },
   ['lawyerpass'] = {
      header = 'Advocaten pas',
      background = '#f9c491',
      prop = 'prop_cs_r_business_card'
   },
}
