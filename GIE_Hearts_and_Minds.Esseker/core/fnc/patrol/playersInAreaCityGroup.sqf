
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_playersInAreaCityGroup

Description:
    Check if player is around the active city or leader of the patrol.

Parameters:
    _active_city - Active city triggered. [Object]
    _group - Group patrolling. [Group]
    _area - Radius of patrol. [Number]
    _players - Players. [Array]

Returns:

Examples:
    (begin example)
        [selectRandom values btc_city_all, group cursorTarget] call btc_patrol_fnc_playersInAreaCityGroup;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_active_city", objNull, [objNull]],
    ["_group", grpNull, [grpNull]],
    ["_area", btc_patrol_area, [0]],
    ["_players", [switchableUnits, playableUnits] select isMultiplayer, [[]]]
];

_players inAreaArray [getPosWorld _active_city, _area/2, _area/2] isEqualTo [] &&
{_players inAreaArray [getPosWorld leader _group, _area/2, _area/2] isEqualTo []}
