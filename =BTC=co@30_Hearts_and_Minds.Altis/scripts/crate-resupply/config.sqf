/*
    Crates can be grabbed from an ammo source with a limit set to the Squad itself
    Some squads have access to specialty crates
    Some squads can grab more than other squads.
    Some squads can resupply the crates of other squads while the rest cannot.
    Some squads have access to different kinds of specialty crates
    Each specialty crate has a different cooldown that occurs when they grab or refill it.
    Crate refill cooldowns belong to the squad the crate belongs to, not the squad that refills it.
    Some squads may have access to more than just 1 specialty crate they can pull or refill at a time.
    Architecture will be a client-server authoritative as much as it can. Clients send requests. Server will receive and create the crates and fill them via global commands. It will also be the source of truth on current allocations.
*/
"config.sqf" call resupplyLog;


// What provides a source for refililng and grabbing crates
ResupplyCrateSourceClasses = [
	// "B_Slingload_01_Ammo_F" // Huron Ammo Container
    "Land_CargoBox_V1_F" // USMC Vehicle Service Point
];

// Maps a role description name to a shorthand flag that is used by the scripts to determine what ROLE someone belongs to
// Format is:
// [FLAG]: SUBSTRING OF ROLE DESCRIPTION NAME
// They will be cached to have the SL flag.
// Use is primarily for devs, however the search string must be updated if role names are going to be changed to properly set flags.
// i.e. Someone that picks the SL slot for 1-1 will have the role description 'Assassin 1-1 Squad Leader@Assassin 1-1 (Infantry)'
// We read the "Squad Leader" part to set them an SL flag.
// These flags are used in conjunction with the group flags to gain access to a variety of specialty crates, etc..
// i.e. A player with MED flag in 1-1 can have different stuff than a player in 1-6 with MED flag.
// NOTE: Key or value, it doesn't matter as we need to loop through and do a string find anyway. None of the role descriptions match exactly with a key to enable a O(1) lookup.
ResupplyRoleDescriptionsToRoleFlags = createHashMapFromArray [
    ["SL", "Squad Leader"],
    ["RCNL", "Phantom Team Leader"],
    ["PL", "Platoon Leader"],
    ["PSG", "Platoon Sergeant"],
    ["FTL", "Fireteam Leader"],
    ["CO", "Company Commander"],
    ["XO", "Company Executive Officer"],
    ["FAC", "Senior JTAC"],
    ["CWO", "Pilot"],
    ["WO", "Crew"],
    ["JFO", "JTAC"],
    ["MED", "Corpsman"],
    ["ENG", "Engineer"],
    ["TL", "Banshee Team Leader"],
    ["LOGI", "Ogre"],
    ["IDF", "Savage"],
    ["PJ", "Trauma Specialist"]
];
// Maps a role description to a shorthand flag that is used by the scripts to determine what type of SQUAD someone belongs to
// If someone in their role description contains one of these strings then they will be marked to that flag.
// i.e. "Assassin 1-6 Platoon Leader@Assassin 1-6 (Leadership)" will contain Assassin 1-6, thus will be marked as belong to a PLHQ squad.
// Each squad should uniquely belong to only one type... If additional types are required, refactoring will be required to deconflict Specialty allocations, max crate, caching the squad flags for the player's current squad instead of a singular.

ResupplyRoleDescriptionToSquadFlags = [
    createHashMapFromArray [
        ["FlagName", "JFO"],
        ["SquadNames",
            [
                "Assassin 1-8",
                "Assassin 2-8",
                "Phantom JTAC"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "FAC"],
        ["SquadNames",
            [
                "Assassin 8"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "RCN"],
        ["SquadNames",
            [
                "Phantom 1"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "GI"],
        ["SquadNames",
            [
                "Assassin 1-1",
                "Assassin 1-2",
                "Assassin 1-3",
                "Assassin 2-1",
                "Assassin 2-2",
                "Assassin 2-3",
                "Assassin 3-1",
                "Assassin 3-2"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "WPSQ"],
        ["SquadNames",
            [
                "Assassin 1-4",
                "Assassin 2-4",
                "Assassin 3-3"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "PLHQ"],
        ["SquadNames",
            [
                "Assassin 1 HQ",
                "Assassin 2 HQ",
                "Assassin 3 HQ"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "CHQ"],
        ["SquadNames",
            [
                "Assassin HQ"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "LOGI"],
        ["SquadNames",
            [
                "Ogre 1",
                "Ogre 2"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "AIR"],
        ["SquadNames",
            [
                "Stalker"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "PJ"],
        ["SquadNames",
            [
                "Banshee"
            ]
        ]
    ],
    createHashMapFromArray [
        ["FlagName", "IDF"],
        ["SquadNames",
            [
                "Savage"
            ]
        ]
    ]
];


// What type of squad has what type of allocations
/* Format is [SHORTHAND_SQUAD_IDENTIFIER]: {
    "CrateAllocations": number // How many crates they can have out at once
    "SpecialtyAllocations": number // How much specialty resource they have currently
    "WhitelistedFlags": Array<string> // What role flags are allowed to see the crate system within the squad. Empty array means anyone is allowed
    "Resupplier": boolean // Can this role resupply crates from other squads that is not their own
}*/
ResupplyCrateAllocations = createHashMapFromArray [
    [
        "JFO",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 1],
            ["WhitelistedFlags", []]
        ]
    ],
    [
        "FAC",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 1],
            ["WhitelistedFlags", []]
        ]
    ],
    [
        "GI",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", ["SL", "MED"]]
        ]
    ],
    [
        "WPSQ",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 1],
            ["WhitelistedFlags", ["SL", "MED"]]
        ]
    ],
    [
        "CHQ",
        createHashMapFromArray [
            ["CrateAllocations", 2],
            ["SpecialtyAllocations", 1],
            ["WhitelistedFlags", ["CO", "XO", "MED", "FAC"]]
        ]
    ],
    [
        "PLHQ",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 1],
            ["WhitelistedFlags", ["PL", "PSG", "MED"]]
        ]
    ],
    [
        "LOGI",
        createHashMapFromArray [
            ["CrateAllocations", 5],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", []],
            ["Resupplier", true]
        ]
    ],
    [
        "AIR",
        createHashMapFromArray [
            ["CrateAllocations", 2],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", ["WO", "CWO"]]
        ]
    ],
    [
        "RCN",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", ["RCNL", "MED"]]
        ]
    ],
    [
        "PJ",
        createHashMapFromArray [
            ["CrateAllocations", 1],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", ["MED", "TL", "PJ"]]
        ]
    ],
    [
        "IDF",
        createHashMapFromArray [
            ["CrateAllocations", 2],
            ["SpecialtyAllocations", 0],
            ["WhitelistedFlags", []]
        ]
    ]
];


/*

    "ResupplyCrates": [
            "Crate Name": {
                "SquadLocks": Array<SQUAD NAMES> // An array of the shorthand squad identifiers that this crate will be locked to. If empty then its not locked to any specific squad.
                "WhitelistedRoles": Array<Flags> // What flags can pull this crate specifically, if left as empty array then it will use only blacklist to exclude
                "BlacklistedRoles": Array<Flags> // What flags can not pull this crate specifically, if left as empty array, then only whitelisted flags can pull. If both are empty, then anyone can pull.
                "Specialty"?: boolean // Is this a specialty crate (optional)
                "CustomCooldown"?: number // A custom cooldown can be specified (optional)
                "SpecialtyCost"?: number // A custom cost can be added too. (optional)
                "Model": string, // Crate model
                "Items": {
                    [key: string]: number // Items inside and how many
                },
                "Offset"?: [number, number, number], // Carrying offset (optional)
            }
        ]
*/
// Default timer for specialty crates on grabbing / refill
ResupplyDefaultSpecialtyCooldown = 3600;
ResupplyDefaultRecallCooldown = 3600;


ResupplyCrates = createHashMapFromArray [
    [
        "General Purpose",
        createHashMapFromArray [
            ["Model", "Box_NATO_Ammo_F"],
            ["SquadLocks", []],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", ["MED", "FAC", "JFO", "IDF", "TL", "PJ"]],
            [
                "Items",
                createHashMapFromArray [
                    ["rhs_mag_30Rnd_556x45_Mk262_PMAG_Tan", 20],
                    ["rhsusf_200rnd_556x45_mixed_box", 3],
					["rhs_mag_M433_HEDP", 15],
                    ["rhs_mag_M441_HE", 15],
                    ["rhs_mag_m67", 5],
                    ["rhs_mag_an_m8hc", 10],
                    ["SmokeShellBlue", 3],
                    ["rhs_weap_m72a7",2],
                    ["ACE_elasticBandage", 10],
                    ["ACE_packingBandage", 10],
                    ["ACE_quikclot", 10],
                    ["ACE_bloodIV", 2],
                    ["ACE_bloodIV_250", 2],
                    ["ACE_bloodIV_500", 2]
                ]
            ]
        ]
    ],
    ["M72A7 Launchers",
        createHashMapFromArray [
            ["Model", "Box_NATO_WpsLaunch_F"],
            ["SquadLocks", []],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", ["MED", "FAC", "JFO", "IDF", "TL", "PJ"]],
             ["Offset", [0, 1.5, 1]],
            ["Items",
                createHashMapFromArray [
                    ["rhs_weap_m72a7", 10]
                ]
            ]
        ]
    ],
    ["5.56 NATO Ammunition",
        createHashMapFromArray [
            ["Model", "Box_NATO_Ammo_F"],
            ["SquadLocks", []],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", ["MED", "FAC", "JFO", "IDF", "TL", "PJ"]],
            ["Items",
                createHashMapFromArray [
                    ["rhs_mag_30Rnd_556x45_Mk262_PMAG_Tan", 80],
                    ["rhsusf_200rnd_556x45_mixed_box", 15]
                ]
            ]
        ]
    ],
    ["7.62 NATO Ammunition",
        createHashMapFromArray [
            ["Model", "Box_NATO_Ammo_F"],
            ["SquadLocks", []],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", ["MED", "FAC", "JFO", "IDF", "TL", "PJ"]],
            ["Items",
                createHashMapFromArray [
                    ["rhsusf_100Rnd_762x51_m62_tracer", 25]
                ]
            ]
        ]
    ],
    ["Medical Supplies",
        createHashMapFromArray [
            ["Model", "ACE_medicalSupplyCrate_advanced"],
            ["SquadLocks", ["PLHQ", "CHQ", "LOGI", "PJ", "GI"]],
            ["WhitelistedRoles", ["MED", "LOGI", "ENG", "XO", "CO", "PJ", "TL"]],
            ["BlacklistedRoles", []],
            ["Items",
                createHashMapFromArray [
                    ["ACE_bloodIV", 10],
                    ["ACE_bloodIV_250", 10],
                    ["ACE_bloodIV_500", 10],
                    ["ACE_elasticBandage", 50],
                    ["ACE_packingBandage", 50],
                    ["ACE_quikclot", 50],
                    ["ACE_epinephrine", 10],
                    ["ACE_morphine", 10],
                    ["ACE_adenosine", 10],
                    ["ACE_personalAidKit", 2],
                    ["ACE_surgicalKit", 2],
                    ["ACE_tourniquet", 5],
                    ["ACE_splint", 5]
                ]
            ]
        ]
    ],
    [
        "Platoon Heavy Weapons",
        createHashmapFromArray [
            ["Model", "Box_NATO_WpsSpecial_F"],
            ["SquadLocks", ["PLHQ"]],
            ["WhitelistedRoles", ["PL", "PSG"]],
            ["BlacklistedRoles", []],
            ["SpecialtyCost", 1],
            ["Offset", [0, 1.5, 1]],
            ["Category", "Special Equipment"],
            [
                "Items",
                createHashMapFromArray [
                    ["rhs_mag_smaw_HEDP", 6],
					["rhs_mag_smaw_HEAA", 6],
                    ["rhs_weap_smaw", 3],
					["rhs_weap_optic_smaw", 3],
                    ["rhs_weap_M136_hp", 6],
                    ["rhs_weap_M136", 6],
                    ["rhs_weap_m32", 1],
                    ["rhsusf_mag_6Rnd_M433_HEDP", 6],
                    ["rhsusf_mag_6Rnd_M441_HE", 6],
                    ["rhsusf_mag_6Rnd_M583A1_white", 6],
                    ["rhsusf_mag_6Rnd_M714_white", 6]
                ]
            ]
        ]
    ],
    [
        "1x Quadcopter UAV",
        createHashmapFromArray [
            ["Model", "Box_NATO_Equip_F"],
            ["SquadLocks", ["JFO"]],
            ["WhitelistedRoles", ["JFO"]],
            ["BlacklistedRoles", []],
            ["SpecialtyCost", 1],
            ["Offset", [0, 1.5, 1]],
            ["Category", "Special Equipment"],
            [
                "Items",
                createHashMapFromArray [
                    ["ITC_Land_B_AR2i_Packed", 1],
                    ["ACE_UAVBattery", 1]
                ]
            ]
        ]
    ],
    [
        "Mixed Heavy Launchers",
        createHashmapFromArray [
            ["Model", "Box_NATO_WpsSpecial_F"],
            ["SquadLocks", ["WPSQ", "CHQ"]],
            ["WhitelistedRoles", ["SL", "CO", "XO"]],
            ["BlacklistedRoles", []],
            ["SpecialtyCost", 1],
             ["Offset", [0, 1.5, 1]],
            ["Category", "Special Equipment"],
            [
                "Items",
                createHashMapFromArray [
                    ["rhs_weap_M136_hp", 3],
                    ["rhs_fgm148_magazine_AT", 3],
                    ["rhs_weap_fgm148", 1],
                    ["MRAWS_HEAT55_F", 4],
					["MRAWS_HEAT_F", 4],
                    ["launch_MRAWS_green_F", 2],
                    ["rhs_fim92_mag", 4],
                    ["rhs_weap_fim92", 1]
                ]
            ]
        ]
    ],
    [
        "2x Quadcopter UAV",
        createHashMapFromArray [
            ["Model", "Box_NATO_Equip_F"],
            ["SquadLocks", ["FAC"]],
            ["WhitelistedRoles", ["FAC"]],
            ["BlacklistedRoles", []],
            ["Category", "Special Equipment"],
            ["Offset", [0, 1.5, 1]],
            ["SpecialtyCost", 1],
            [
                "Items",
                createHashMapFromArray [
                    ["ITC_Land_B_AR2i_Packed", 2],
                    ["ACE_UAVBattery", 6]
                ]
            ]
        ]
    ],
    [
        "81mm HE Rounds",
        createHashMapFromArray [
            ["Model", "ACE_Box_82mm_Mo_Combo"],
            ["SquadLocks", ["IDF"]],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", []],
            ["Category", "Basic"],
            ["Offset", [0, 1, 1]],
            [
                "Items",
                createHashMapFromArray [
                    ["ACE_1Rnd_82mm_Mo_HE", 48]
                ]
            ]
        ]
    ],
    [
        "81mm ILLUM Rounds",
        createHashMapFromArray [
            ["Model", "ACE_Box_82mm_Mo_Combo"],
            ["SquadLocks", ["IDF"]],
            ["WhitelistedRoles", []],
            ["BlacklistedRoles", []],
            ["Category", "Basic"],
            ["Offset", [0, 1, 1]],
            [
                "Items",
                createHashMapFromArray [
                    ["ACE_1Rnd_82mm_Mo_Illum", 48]
                ]
            ]
        ]
    ]
];

// Cache what is special
SpecialCategories = createHashMap;

ResupplyModelsUsed = createHashMap;

{
    private _crateName = _x;
    private _crateInfo = _y;

    private _model = _crateInfo get "Model";

    private _exists = ResupplyModelsUsed getOrDefault [_model, false];

    if(!_exists) then {
        ResupplyModelsUsed set [_model, true];
    };


    private _category = _crateInfo get "Category";

    if (isNil { _category }) then {
        continue
    };
    private _specialtyCost = _crateInfo getOrDefault ["SpecialtyCost", 0];

    if(_specialtyCost > 0) then {
        SpecialCategories set [_category, true];
    };
} forEach ResupplyCrates;



// Server sets this globally and persistent for JIP via missionNamespace variable at start up.
// One source of truth.
// Clients can get from missionNamespace with their squad name in an O(1) lookup for data pertaining to current status even if JIP.
if (isServer) then {

    "Server Init Config" call resupplyLog;
    {

        private _flagInfo = _x;


        private _squadNames = _flagInfo get "SquadNames";
        private _squadFlag = _flagInfo get "FlagName";
        format ["Squad Flag %1: %2", _squadFlag, _squadNames] call resupplyLog;

        private _specialtyResourceToStart = ResupplyCrateAllocations getOrDefault [_squadFlag, createHashMapFromArray [["SpecialtyAllocations", 0]]] get "SpecialtyAllocations";



        {

            private _squadName = _x;
            format ["SpecialtyResourceToStart set to %1 for %2", _specialtyResourceToStart, _squadName] call resupplyLog;
            // TODO: Verify this isn't going to break anything or have conflicts.
            missionNamespace setVariable [_squadName,
                createHashMapFromArray [
                    ["SpecialtyResources", _specialtyResourceToStart],
                    ["Crates", 0],
                    ["ResetTime", -1],
                    ["RecallResetTime", -1],
                    ["CanReset", true],
                    ["CrateObjects", []]
                ],
                true
            ];
        } forEach _squadNames;
    } forEach ResupplyRoleDescriptionToSquadFlags;
};
