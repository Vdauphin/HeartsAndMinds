
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_init

Description:
    Initialise patrol between two city.

Parameters:
    _group - Group patroling. [Group]
    _cities - Contain a starting city and the current active city. [Array]
    _area - Area to find the end city. [Number]
    _isBoat - Does the vehicle is a boat. [Boolean]

Returns:

Examples:
    (begin example)
        [group cursorTarget, [selectRandom values btc_city_all, selectRandom values btc_city_all]] call btc_patrol_fnc_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_cities", [], [[]]],
    ["_area", btc_patrol_area, [0]],
    ["_isBoat", false, [false]]
];
_cities params [
    ["_start_city", objNull, [objNull]],
    ["_active_city", objNull, [objNull]]
];

if !(isGroupDeletedWhenEmpty _group) then {
    _group deleteGroupWhenEmpty true;
};

private _useful = [[_start_city, _active_city], _area, _isBoat] call btc_patrol_fnc_usefulCity;
if (_useful isEqualTo [] || objNull in _useful) exitWith {
    _group call CBA_fnc_deleteEntity;
};
private _end_city = selectRandom _useful;

private _pos = getPos _end_city;
if (_isBoat) then {
    ((selectBestPlaces [_pos, _end_city getVariable ["cachingRadius", 100], "sea", 10, 1]) select 0 select 0) params ["_x", "_y"];
    _pos = [_x, _y, 0];
};

private _start_cityID = _start_city getVariable ["id", 0];
private _active_cityID = _active_city getVariable ["id", 0];
private _end_cityID = _end_city getVariable ["id", 0];
private _waypointStatements = format ["[group this, %1, %2, %3, %4] call btc_patrol_fnc_WPCheck;", _area, _pos, [_start_cityID, _active_cityID, _end_cityID], _isBoat];

[_group, _pos, _waypointStatements] call btc_patrol_fnc_addWP;

if (btc_debug_log) then {
    if (!isNil {_group getVariable "btc_patrol_id"}) then {
        [format ["ID: %1, End city ID: %2", _group getVariable ["btc_patrol_id", "Missing patrol ID"], _end_cityID], __FILE__, [false]] call btc_debug_fnc_message;
    };
};
