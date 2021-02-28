
/* ----------------------------------------------------------------------------
Function: btc_fnc_rep_remove_eh

Description:
    Remove event to civilian.

Parameters:
    _civilian - Civilian. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_rep_remove_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_civilian", objNull, [objNull]]
];

[_civilian, "FiredNear", "btc_fnc_rep_firednear"] call btc_fnc_eh_removePersistOnLocalityChange;
[_civilian, "HandleDamage", "btc_fnc_rep_hd"] remoteExecCall ["btc_fnc_eh_removePersistOnLocalityChange", _civilian];
[_civilian, "Killed", "btc_fnc_rep_killed"] remoteExecCall ["btc_fnc_eh_removePersistOnLocalityChange", _civilian];
