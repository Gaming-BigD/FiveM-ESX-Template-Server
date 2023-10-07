QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Arbeitlos',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Arbeitslos',
                payment = 100
            },
        },
	},
    ['burgershot'] = {
		label = 'BurgerShot',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 500 },
			['1'] = { name = 'Novice', payment = 675 },
			['2'] = { name = 'Experienced', payment = 750 },
			['3'] = { name = 'Advanced', payment = 825 },
			['4'] = { name = 'Manager', isboss = true, payment = 1000 },
        },
	},
    ["cluckingbell"] = {
        label = "cluckingbell",
        offDutyPay = false,
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'recruit',
                payment = 500,
            },
              ['1'] = {
                name = 'Employee',
                payment = 675,
            },
            ['2'] = {
                name = 'Vice Manager',
                payment = 700,
            },
            ['3'] = {
                name = 'Manager',
                isboss = true,
                payment = 1000,
            },
        }
    },
    ["noodle"] = {
        label = "Noodle",
        defaultDuty = true,
        grades = {
            ['0'] = {
                label = 'Worker',
                payment = 500,
            },
            ['1'] = {
                label = 'Vice Boss',
                payment = 670,
            },
            ['2'] = {
                label = 'Boss',
                payment = 1000,
            },
        },
    },
    ['vanilla'] = {
		label = 'Vanilla Unicorn',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 500 },
			['1'] = { name = 'Novice', payment = 650 },
			['2'] = { name = 'Experienced', payment = 750 },
			['3'] = { name = 'Advanced', payment = 855 },
			['4'] = { name = 'Manager', isboss = true, payment = 1000 },
        },
	},

    
    ['uwu'] = {
		label = 'UwU Cat Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 500
            },
			['1'] = {
                name = 'Employee',
                payment = 650
            },
			['2'] = {
                name = 'Experienced',
                payment = 750
            },
			['3'] = {
                name = 'Advanced',
                payment = 855
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 1000
            },
        },
	},

    

	['police'] = {
        label = 'LSPD',
        type = "leo",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Cadet',
                payment = 500
            },
            ['1'] = {
                name = 'Officer l',
                payment = 700
            },
            ['2'] = {
                name = 'Officer ll',
                payment = 800
            },
            ['3'] = {
                name = 'Officer lll',
                payment = 1000
            },
            ['4'] = {
                name = 'Sergeant l',
                payment = 1300
            },
            ['5'] = {
                name = 'Sergeant ll',
                payment = 1600
            },
            ['6'] = {
                name = 'Lieutenant',
                payment = 1900
            },
            ['7'] = {
                name = 'Captain',
                payment = 2300
            },
            ['8'] = {
                name = 'Commander',
                payment = 2600
            },
            ['9'] = {
                name = 'Assistant Chief',
                payment = 2900
            },
            ['10'] = {
                name = 'Chief of Police',
                isboss = true,
                payment = 3500
            },
            ['11'] = {
                name = 'Cadet Sheriff',
                payment = 500
            },
            ['12'] = {
                name = 'Officer sheriff Sheriff',
                payment = 1000
            },
            ['13'] = {
                name = 'Lieutnant Sheriff',
                payment = 2500
            },
            ['14'] = {
                name = 'Asisstant Sheriff',
                isboss = true,
                payment = 2800
            },
            ['15'] = {
                name = 'Sheriff',
                isboss = true,
                payment = 3500
            },
        },
    },
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Paramedic',
                payment = 700
            },
			['2'] = {
                name = 'Doctor',
                payment = 1000
            },
			['3'] = {
                name = 'Surgeon',
                payment = 2000
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 3000
            },
        },
	},
	['realestate'] = {
		label = 'Immobilien',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Driver',
                payment = 650
            },
			['2'] = {
                name = 'Event Driver',
                payment = 750
            },
			['3'] = {
                name = 'Sales',
                payment = 850
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 1000
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Fahrzeug Händler',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 600
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 900
            },
			['2'] = {
                name = 'Business Sales',
                payment = 1000
            },
			['3'] = {
                name = 'Finance',
                payment = 1500
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 2000
            },
        },
	},
    ['motordealer'] = {
		label = 'Motorrad Händler',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 600
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 900
            },
			['2'] = {
                name = 'Business Sales',
                payment = 1000
            },
			['3'] = {
                name = 'Finance',
                payment = 1500
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 2000
            },
        },
	},
	['mechanic'] = {
		label = 'Mechaniker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 300
            },
			['1'] = {
                name = 'Novice',
                payment = 500
            },
			['2'] = {
                name = 'Experienced',
                payment = 600
            },
			['3'] = {
                name = 'Advanced',
                payment = 800
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 1000
            },
        },
	},
    ['firefighter'] = {
		label = 'LSFD',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Novice',
                payment = 600
            },
			['2'] = {
                name = 'Experienced',
                payment = 750
            },
			['3'] = {
                name = 'Advanced',
                payment = 800
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 1000
            },
        },
	},
   
    ["weedshop"] = {
		label = "WeedShop Mitarbeiter",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 500
            },
			['1'] = {
                name = "Employee",
                payment = 700
            },
			['2'] = {
                name = "Owner",
                isboss = true,
                payment = 1000
            }
        },
        ["boss"] = {
            [1] = {x = 179.5, y = -247.16, z = 54.11, h = 134.87}
        },
    },
	['judge'] = {
		label = 'Ehrenamtlich',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 1500
            },
        },
	},
	['lawyer'] = {
		label = 'Anwaltskanzlei',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 1000
            },
        },
	},
    ['rooster'] = {
		label = 'Rooster',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 200
            },
        },
	},
    ['miner'] = {
		label = 'Miner',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 200
            },
        },
	},
	['reporter'] = {
		label = 'reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'reporter',
                payment = 500
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 500
            },
        },
	},
    
    	['garbage'] = {
		label = 'Müll Fahrer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 500
            },
        },
	},
	['vineyard'] = {
		label = 'Weinberge',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 500
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 500
            },
        },
	},
    ["casino"] = {
        label = "Spiel Casino",
        salary = 500,
        grades = {
            [0] = {
                name = "Security",
                salary = 600
            },
            [1] = {
                name = "Bar Tender/Cashier",
                salary = 700
            },
            [2] = {
                name = "Assistant Manager",
                salary = 850,
                isboss = true
            },
            [3] = {
                name = "Casino Boss",
                salary = 1000,
                isboss = true
            }
        },
        ["boss"] = {
            [1] = {x = 956.41, y = 20.64, z = 75.74, h = 209.06}
        },
        defaultDuty = false
    },
    ['mikel'] = {
		label = 'mikel Machine',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 500
            },
			['1'] = {
                name = 'Employee',
                payment = 700
            },
			['2'] = {
                name = 'Experienced',
                payment = 800
            },
			['3'] = {
                name = 'Advanced',
                payment = 900
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 1500
            },
        },
	},
    ['tuner'] = {
        label = 'Tuner Autos',
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
            ['1'] = {
                name = 'Mechanic',
                payment = 750
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
                payment = 1000
            
            },
            ['3'] = {
                name = 'Co-Owner',
                isboss = true,
                payment = 1250
            },
            ['4'] = {
                name = 'Owner',
                isboss = true,
                payment = 1500
            },
        },
	},
    ['mafia'] = {
		label = 'mafia boss',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'boss',
                payment = 0
            },
        },
	},
    ['shops'] = {
		label = 'shop manger',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'boss',
                payment = 1000
            },
        },
	},
}


            -- Jobs Creator integration (jobs_creator)
            RegisterNetEvent("jobs_creator:injectJobs", function(jobs)
                QBShared.Jobs = jobs
            end)
        