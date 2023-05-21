
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_create_load

Description:
    Fill me when you edit me !

Parameters:
    _main_class - []
    _sub_class - []

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_create_load;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

lbClear 71;
btc_construction_array params ["_main_class", "_sub_class"];
for "_i" from 0 to ((count _main_class) - 1) do {
    private _lb = lbAdd [71, _main_class select _i];
    if (_i isEqualTo 0) then {
        lbSetCurSel [71, _lb];
    };
};
private _category = _sub_class select 0;
lbClear 72;
for "_i" from 0 to ((count _category) - 1) do {
    private _class = _category select _i;
    private _display = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
    private _index = lbAdd [72, _display];
    lbSetData [72, _index, _class];
    if (_i isEqualTo 0) then {
        lbSetCurSel [72, _index];
    };
};
true
