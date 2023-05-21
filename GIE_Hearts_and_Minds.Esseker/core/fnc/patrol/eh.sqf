
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_eh

Description:
    Remove events and delete entity.

Parameters:
    _veh - Object to delete. [Object, Group]

Returns:

Examples:
    (begin example)
        [cursorTarget] call btc_patrol_fnc_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull, grpNull]]
];

if (_veh getVariable ["btc_patrol_fnc_eh_fired", false]) exitWith {};
_veh setVariable ["btc_patrol_fnc_eh_fired", true, true];

if (btc_debug_log) then {
    [format ["%1, isRE %2", _veh, isRemoteExecuted], __FILE__, [false]] call btc_debug_fnc_message;
};

private _group = if (_veh isEqualType grpNull) then {
    _veh
} else {
    _veh getVariable ["btc_crews", grpNull]
};

if !(
    _group in btc_patrol_active ||
    _group in btc_civ_veh_active
) exitWith {};

if (_veh isEqualType objNull) then {
    if (btc_debug) then {
        deleteMarker format ["Patrol_fant_%1", _group getVariable ["btc_patrol_id", 0]];
    };

    [[], [_veh, _group]] call btc_fnc_delete;
} else {
    private _vehicle = assignedVehicle leader _veh;
    _vehicle setVariable ["btc_patrol_fnc_eh_fired", true, true];
    [[], [_vehicle, _veh]] call btc_fnc_delete;
};
