
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_get_rc

Description:
    Fill me when you edit me !

Parameters:
    _obj - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_get_rc;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_obj", objNull, [objNull]]
];

private _type = typeOf _obj;
private _rc = 0;
private _cond = false;
for "_i" from 0 to (count btc_log_def_rc - 1) do {
    if (typeName (btc_log_def_rc select _i) isEqualTo "STRING" && !_cond) then {
        if (!_cond && _type isEqualTo (btc_log_def_rc select _i)) then {
            _rc = (btc_log_def_rc select (_i + 1));
            _cond = true;
        };
    };
};
if (!_cond) then {
    for "_i" from 0 to (count btc_log_main_rc - 1) do {
        if (typeName (btc_log_main_rc select _i) isEqualTo "STRING" && !_cond) then {
            if (!_cond && _type isKindOf (btc_log_main_rc select _i)) then {
                _rc = (btc_log_main_rc select (_i + 1));
                _cond = true;
            };
        };
    };
};
_rc
