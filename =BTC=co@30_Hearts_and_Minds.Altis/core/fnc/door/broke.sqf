
/* ----------------------------------------------------------------------------
Function: btc_door_fnc_broke

Description:
    Unlock door.

Parameters:
    _house - House. [Object]
    _door - Door name. [String]

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
    ["_door", "", [""]]
];

_house setVariable [format ["bis_disabled_%1", _door], 0, true];
playSound3D ["\z\ace\addons\logistics_wirecutter\sound\wirecut.ogg", player];
[btc_rep_malus_breakDoor, player] remoteExecCall ["btc_rep_fnc_change", 2];

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
    _house animate [_x, 0.2];
} forEach _animations;
