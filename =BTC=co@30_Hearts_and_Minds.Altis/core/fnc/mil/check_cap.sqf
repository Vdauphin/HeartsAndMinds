
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_check_cap

Description:
    Capture city around with a time cooler.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_mil_check_cap;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if (btc_hideout_cap_checking) exitWith {};

btc_hideout_cap_checking = true;

private _cap_to = btc_hideouts select {time - (_x getVariable ["cap_time", time]) > btc_hideout_cap_time};

if (_cap_to isEqualTo []) exitWith {
    btc_hideout_cap_checking = false;
    if (btc_debug_log) then {
        ["exit cap time", __FILE__, [false]] call btc_fnc_debug_message;
    };
};

{
    private _hd = _x;
    private _in_range = btc_city_all inAreaArray [getPosWorld _hd, btc_hideout_range, btc_hideout_range];

    if (_in_range isEqualTo []) exitWith {
        btc_hideout_cap_checking = false;
        if (btc_debug_log) then {
            [format ["exit no in range = %1", _hd getVariable "id"], __FILE__, [false]] call btc_fnc_debug_message;
        };
    };

    private _closest = [_hd, _in_range, true] call btc_fnc_find_closecity;

    if (btc_debug_log) then {
        [format ["_in_range = %1", _in_range], __FILE__, [false]] call btc_fnc_debug_message;
    };

    if (_closest isEqualTo []) exitWith {
        btc_hideout_cap_checking = false;
        if (btc_debug_log) then {
            [format ["exit null _closest = %1", _hd getVariable "id"], __FILE__, [false]] call btc_fnc_debug_message;
        };
    };

    if (btc_debug_log) then {
        [format ["SEND FROM = %1 TO %2 [int %3]", _hd getVariable "id", _closest getVariable ["name", "error"], _closest getVariable ["initialized", false]], __FILE__, [false]] call btc_fnc_debug_message;
    };

    _hd setVariable ["cap_time", time];

    if (_closest getVariable ["initialized", false]) then {
        for "_i" from 0 to (2 + (round random 3)) do {
            [{
                _this call btc_fnc_mil_send;
            }, [_hd, _closest, 0], _i * 2 + 1] call CBA_fnc_waitAndExecute;
        };
    } else {
        _closest setVariable ["occupied", true];
        if (btc_debug) then {
            (format ["loc_%1", _closest getVariable "id"]) setMarkerColor "ColorRed";
        };
    };
} forEach _cap_to;

btc_hideout_cap_checking = false;
