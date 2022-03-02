
/* ----------------------------------------------------------------------------
Function: btc_door_fnc_broke

Description:
    Unlock door.

Parameters:
    _house - House. [Object]
    _door - Door name. [String]
    _instigator - Who broke the door. [Object]
    _phase -  Range 0 (start point of the animation) to 1 (end point of the animation). [Number]
    _speed - Boolean or Number: When true animation is instant. Since Arma 3 v1.66 Number > 0 is treated as config speed value multiplier.

Returns:

Examples:
    (begin example)
        ([2] call ace_interaction_fnc_getDoor) call btc_door_fnc_broke;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_house", objNull, [objNull]],
    ["_door", "", [""]],
    ["_player", player, [objNull]],
    ["_phase", 1, [0]],
    ["_speed", false, [0, true]]
];
if (_door isEqualTo "") exitWith {};

_house setVariable [format ["bis_disabled_%1", _door], 0, true];
[btc_rep_malus_breakDoor, _player] remoteExecCall ["btc_rep_fnc_change", 2];

private _getDoorAnimations = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
_getDoorAnimations params ["_animations"];
if (_animations isEqualTo []) exitWith {};

// Add handle on carrier
if (typeOf _house == "Land_Carrier_01_island_01_F") then {
    private _handle = format ["door_handle_%1_rot_1", (_animations select 0) select [5, 1]];
    _animations pushBack _handle;
};
// do incremental door opening
{
    _house animate [_x, _phase, _speed];
} forEach _animations;
