/*
if (lbText [371, lbCurSel 371] != "Items") exitWith {[3912,false] call btc_fnc_gear_show_button;};

_item = lbData [372, lbCurSel 372];

if ((getNumber(configfile >> "CfgWeapons" >> _item >> "type") != 131072)) exitWith {[3912,false] call btc_fnc_gear_show_button;};

_p = primaryWeapon player;
_s = secondaryWeapon player;
_h = handGunWeapon player;

if (_item in (getArray(configFile >> "cfgWeapons" >> _p >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 1;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _p >> "WeaponSlotsInfo" >> "PointerSlot" >> "MuzzleSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 1;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _p >> "WeaponSlotsInfo" >> "PointerSlot" >> "CowsSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 1;};


if (_item in (getArray(configFile >> "cfgWeapons" >> _s >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 2;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _s >> "WeaponSlotsInfo" >> "PointerSlot" >> "MuzzleSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 2;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _s >> "WeaponSlotsInfo" >> "PointerSlot" >> "CowsSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 2;};

if (_item in (getArray(configFile >> "cfgWeapons" >> _h >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 3;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _h >> "WeaponSlotsInfo" >> "PointerSlot" >> "MuzzleSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 3;};
if (_item in (getArray(configFile >> "cfgWeapons" >> _h >> "WeaponSlotsInfo" >> "PointerSlot" >> "CowsSlot"))) exitWith {[3912,true] call btc_fnc_gear_show_button;btc_gear_acc_type = 3;};

[3912,false] call btc_fnc_gear_show_button;*/