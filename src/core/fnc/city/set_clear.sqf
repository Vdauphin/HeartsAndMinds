
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_set_clear

Description:
    Define a city with the corresponding ID as clear (no more occupied).

Parameters:
    _id - ID of the city no more occupied. [Number]
    _remainEnemyUnits - Remaining enemy units assigned to the city. [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_city_fnc_set_clear;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0]],
    ["_remainEnemyUnits", [], [[]]]
];

private _city = btc_city_all select _id;
_city setVariable ["occupied", false];

if (_remainEnemyUnits isNotEqualTo []) then {
    {
        if (unitIsUAV _x) then {
            _x setDamage 1;
        } else {
            [_x, true] call ace_captives_fnc_setSurrendered;
        };
    } forEach _remainEnemyUnits;
};

if (_city getVariable ["marker", ""] != "") then {
    (_city getVariable ["marker", ""]) setMarkerColor "ColorGreen";
};

if (btc_final_phase) then {
    btc_city_remaining = btc_city_remaining - [_city];
};

if (btc_debug) then {
    (format ["loc_%1", _id]) setMarkerColor "ColorGreen";
};
