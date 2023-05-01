[ 
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