
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_check_cap

Description:
    Capture city around with a time cooler.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_mil_fnc_check_cap;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

private _cap_to = btc_hideouts select {
    time - (_x getVariable ["cap_time", time]) > btc_hideout_cap_time
};
if (_cap_to isEqualTo []) exitWith {};

{
    private _hideout = _x;
    private _city_inRange = values btc_city_all inAreaArray [getPosWorld _hideout, btc_hideout_range, btc_hideout_range];
    if (_city_inRange isEqualTo []) then {continue};

    private _closest = [_hideout, _city_inRange, true] call btc_fnc_find_closecity;
    if (_closest isEqualTo []) then {continue};

    _hideout setVariable ["cap_time", time];

    if (_closest getVariable ["initialized", false]) then {
        for "_i" from 0 to (2 + (round random 3)) do {
            [btc_mil_fnc_send, [_hideout, _closest, 0], _i * 2 + 1] call CBA_fnc_waitAndExecute;
        };
    } else {
        _closest setVariable ["occupied", true];
        if (btc_debug) then {
            (format ["loc_%1", _closest getVariable "id"]) setMarkerColor "ColorRed";
        };
    };
} forEach _cap_to;
