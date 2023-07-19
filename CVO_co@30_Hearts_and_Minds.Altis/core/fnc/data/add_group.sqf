
/* ----------------------------------------------------------------------------
Function: btc_data_fnc_add_group

Description:
    If player is around: initiate patrol around the destination,
    Ifnot: save in database and delete units by calling btc_data_fnc_get_group.

Parameters:
    _group - Group of units. [Group]

Returns:

Examples:
    (begin example)
        _result = [] call btc_data_fnc_add_group;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]]
];

if (btc_debug_log) then {
    [format ["%1", _group], __FILE__, [false]] call btc_debug_fnc_message;
};
_group setVariable ["no_cache", nil];
[_group] call CBA_fnc_clearWaypoints;

private _city = [leader _group, values btc_city_all, false] call btc_fnc_find_closecity;
_city setVariable ["occupied", true];

if (_city getVariable ["marker", ""] != "") then {
    private _marker = _city getVariable ["marker", ""];
    _marker setMarkerColor "ColorRed";
    _marker setMarkerAlpha 0.3;
};

private _wp = if (vehicle leader _group isEqualTo leader _group) then {
    selectRandom ["HOUSE", "PATROL", "SENTRY"];
} else {
    if ((vehicle leader _group) isKindOf "Air") then {
        "PATROL";
    } else {
        selectRandom ["PATROL", "SENTRY"];
    };
};

[_group, _city, 200, _wp] call btc_mil_fnc_addWP;

if (_city getVariable ["active", false]) then {
    _group setVariable ["btc_city", _city];
} else {
    private _data_units = _city getVariable ["data_units", []];
    private _data_group = _group call btc_data_fnc_get_group;

    _data_units pushBack _data_group;
    _city setVariable ["data_units", _data_units];
    if (btc_debug_log) then {
        [format ["PUSHBACK = %1", _data_group], __FILE__, [false]] call btc_debug_fnc_message;
    };
};

if (btc_final_phase) then {
    btc_city_remaining pushBack _city;
};
if (btc_debug_log) then {
    [format ["END = %1", []], __FILE__, [false]] call btc_debug_fnc_message;
};
