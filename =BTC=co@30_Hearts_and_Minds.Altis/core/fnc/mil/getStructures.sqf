
params ["_pos","_radius"];

private _structures = (nearestTerrainObjects [_pos, ["House", "BUNKER", "FORTRESS"], _radius]) select {gettext(configfile >> "CfgVehicles" >> typeof _x >> "editorSubcategory") isEqualTo "EdSubcat_Military"};
private _useful    = _structures select {(format["%1", _x buildingPos 1] != "[0,0,0]" && {damage _x == 0} && {isNil {_x getVariable "btc_house_taken"}})};
_useful