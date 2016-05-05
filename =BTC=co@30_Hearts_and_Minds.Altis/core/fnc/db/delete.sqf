
if !(isClass(configFile >> "cfgPatches" >> "inidbi2")) exitWith {[[11, "deleted"],"btc_fnc_show_hint"] spawn BIS_fnc_MP;};

"delete" call OO_fnc_inidbi;

[[10],"btc_fnc_show_hint"] spawn BIS_fnc_MP;