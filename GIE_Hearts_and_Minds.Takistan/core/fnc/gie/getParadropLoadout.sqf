private _paradrop = [ 
    [ 
        "B_supplyCrate_F","Munitions","", 
        { 
            clearItemCargoGlobal _this;  
            clearBackpackCargoGlobal _this;  
            clearWeaponCargoGlobal _this;  
            clearMagazineCargoGlobal _this; 
            
            private _ammo = [ 
				["rhsusf_100Rnd_762x51","rhs_mag_m67","SmokeShell","rhsusf_200Rnd_556x45_box","rhs_mag_30Rnd_556x45_M855A1_Stanag","rhsusf_20Rnd_762x51_m80_Mag","rhs_mag_M441_HE","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","UGL_FlareCIR_F"], 
				[10,10,10,10,30,10,20,10,10,4] 
            ]; 
            
            { 
                _this addMagazineCargoGlobal [_x, (_ammo select 1 select _forEachIndex)]; 
            } forEach (_ammo select 0); 
        } 
    ], 
    [ 
        "B_supplyCrate_F","Lanceurs","", 
        { 
            clearItemCargoGlobal _this;  
            clearBackpackCargoGlobal _this;  
            clearWeaponCargoGlobal _this;  
            clearMagazineCargoGlobal _this;  
            
            private _launchers = [ 
				["rhs_weap_fgm148","rhs_weap_fim92","rhs_weap_M136","rhs_weap_M136_hedp","rhs_weap_m72a7"], 
				[1,1,4,4,1] 
            ]; 
            { 
                _this addWeaponCargoGlobal [_x, (_launchers select 1 select _forEachIndex)]; 
            } forEach (_launchers select 0); 
            
            private _ammo = [ 
				["rhs_fgm148_magazine_AT","rhs_fim92_mag"], 
				[2,1] 
            ]; 
            { 
                _this addMagazineCargoGlobal [_x, (_ammo select 1 select _forEachIndex)]; 
            } forEach (_ammo select 0); 
        } 
    ],
	"ACE_medicalSupplyCrate_advanced"
];

if (!isNil "GIE_paradrop_box") then {
    _paradrop pushBack [typeof GIE_paradrop_box, "Matériel personnalisé", "",
        {
            clearItemCargoGlobal _this;  
            clearBackpackCargoGlobal _this;  
            clearWeaponCargoGlobal _this;  
            clearMagazineCargoGlobal _this;

            private _items = getItemCargo GIE_paradrop_box;
            { 
                _this addItemCargoGlobal [_x, (_items select 1 select _forEachIndex)]; 
            } forEach (_items select 0);

            private _backpacks = getBackpackCargo GIE_paradrop_box;
            { 
                _this addBackpackCargoGlobal [_x, (_backpacks select 1 select _forEachIndex)]; 
            } forEach (_backpacks select 0);

            private _weapons = getWeaponCargo GIE_paradrop_box;
            { 
                _this addWeaponCargoGlobal [_x, (_weapons select 1 select _forEachIndex)]; 
            } forEach (_weapons select 0);

            private _magazines = getMagazineCargo GIE_paradrop_box;
            { 
                _this addMagazineCargoGlobal [_x, (_magazines select 1 select _forEachIndex)]; 
            } forEach (_magazines select 0);

            GIE_paradrop_box call CBA_fnc_deleteEntity;  
        }
    ]
};

_paradrop;