
/* ----------------------------------------------------------------------------
Function: btc_fnc_ied_suicider_create

Description:
    Create a suicider in a city under a random area.

Parameters:
    _city - City where the suicider is created. [Object]
    _area - Area around the city the suicider is created randomly. [Number]
    _rpos - Create the suicider at this position. [Array]
    _type_units - Type of units. [Group]

Returns:
    _suicider - Created suicider. [Object]

Examples:
    (begin example)
        _suicider = [allplayers select 0, 100] call btc_fnc_ied_suicider_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_area", 100, [0]],
    ["_rpos", [], [[]]],
    ["_type_units", "", [""]]
];

if (btc_debug_log) then {
    [format ["_name = %1 _area %2", _city getVariable ["name", "name"], _area], __FILE__, [false]] call btc_fnc_debug_message;
};

if (_rpos isEqualTo []) then {
    _rpos = [position _city, _area] call btc_fnc_randomize_pos;
};
if (_type_units isEqualTo "") then {
    _type_units = selectRandom btc_civ_type_units;
};

private _group = createGroup [civilian, true];
_group setVariable ["btc_city", _city];
private _suicider = _group createUnit [_type_units, _rpos, [], 0, "CAN_COLLIDE"];

[_group] call btc_fnc_civ_addWP;
_group setVariable ["suicider", true];

[_suicider] call btc_fnc_ied_suiciderLoop;

_suicider
