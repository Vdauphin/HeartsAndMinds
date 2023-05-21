
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_WPCheck

Description:
    Check if the waypoint has been completed and initialise a new patrol.

Parameters:
    _group - Group patroling. [Group]
    _area - Area of patroling. [Number]
    _last_wp_pos - Position of the end city (last waypoint). [Array]
    _citiesID - ID of the starting city, activated city by player and end city. [Array]
    _isBoat - Does the vehicle is a boat. [Boolean]

Returns:

Examples:
    (begin example)
        [group cursorTarget, 1000, getPos player, [0, 1, 2]] call btc_patrol_fnc_WPCheck;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_area", btc_patrol_area, [0]],
    ["_last_wp_pos", [0, 0, 0], [[]]],
    ["_citiesID", [], [[]]],
    ["_isBoat", false, [false]]
];
_citiesID params [
    ["_start_cityID", 0, [0]],
    ["_active_cityID", 0, [0]],
    ["_end_cityID", 0, [0]]
];

if (btc_debug) then {
    if (!isNil {_group getVariable "btc_patrol_id"}) then {
        deleteMarker format ["Patrol_fant_%1", _group getVariable ["btc_patrol_id", 0]];
    };
};

private _start_city = btc_city_all get _start_cityID;
private _active_city = btc_city_all get _active_cityID;
private _end_city = btc_city_all get _end_cityID;

//Remove if too far from player
if ([_active_city, _group, _area] call btc_patrol_fnc_playersInAreaCityGroup) exitWith {
    [_group] call btc_patrol_fnc_eh;
};

//Sometimes the waypoint is completed but too far due to obstacle (water for island etc)
if ((leader _group) distance _last_wp_pos > 100) then {
    if (btc_debug || btc_debug_log) then {
        [format ["Patrol ID: %1, %2 inaccessible (end city ID: %3)", _group getVariable ["btc_patrol_id", "Missing patrol ID"], _end_city getVariable ["name", "no name"], _end_city getVariable ["id", 0]], __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;
    };

    //Dynamically create a balcklist of cities inaccessible from the starting city
    private _cities_inaccessible = _start_city getVariable ["btc_cities_inaccessible", []];
    _cities_inaccessible pushBack _end_city;
    _start_city setVariable ["btc_cities_inaccessible", _cities_inaccessible];

    _end_city = _start_city;
};

[_group, [_end_city, _active_city], _area, _isBoat] call btc_patrol_fnc_init;
