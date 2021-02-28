
/* ----------------------------------------------------------------------------
Function: btc_fnc_rep_add_eh

Description:
    Add event handler link to the reputation system to a unit not initialised.

Parameters:
    _civilian - Unit. [Object]

Returns:

Examples:
    (begin example)
        [curosrTarget] call btc_fnc_rep_add_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_civilian", objNull, [objNull]]
];

[_civilian, "HandleDamage", "btc_fnc_rep_hd"] call btc_fnc_eh_persistOnLocalityChange;
[_civilian, "Killed", "btc_fnc_rep_killed"] call btc_fnc_eh_persistOnLocalityChange;
[_civilian, "FiredNear", "btc_fnc_rep_firednear"] call btc_fnc_eh_persistOnLocalityChange;
