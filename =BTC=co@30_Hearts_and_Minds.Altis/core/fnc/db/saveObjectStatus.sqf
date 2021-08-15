
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_saveObjectStatus

Description:
    Save all data from an object like position, ACE cargo, inventory ...

Parameters:
    _object - Object to get data. [Object]

Returns:
    _data - Data array (type, position, direction ...). [Array]

Examples:
    (begin example)
        [cursorObject] call btc_db_fnc_saveObjectStatus;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];

private _data = [];
_data pushBack (typeOf _object);
_data pushBack (getPosASL _object);
_data pushBack (getDir _object);
_data pushBack (_object getVariable ["ace_rearm_magazineClass", ""]);
private _cargo = (_object getVariable ["ace_cargo_loaded", []]) apply {
    if (_x isEqualType "") then {
        [_x, "", [[], [], []]]
    } else {
        [
            typeOf _x,
            _x getVariable ["ace_rearm_magazineClass", ""],
            _x call btc_log_fnc_inventoryGet,
            _x in btc_chem_contaminated
        ]
    };    
};
_data pushBack _cargo;
_data pushBack (_object call btc_log_fnc_inventoryGet);
_data pushBack [vectorDir _object, vectorUp _object];
_data pushBack (_object in btc_chem_contaminated);

_data
