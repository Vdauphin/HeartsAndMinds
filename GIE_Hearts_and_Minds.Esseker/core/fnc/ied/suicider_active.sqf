
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_suicider_active

Description:
    Activate the suicider by adding explosive charge around his pelvis and force suicider to move in the direction of soldier.

Parameters:
    _suicider - Suicider created. [Object]

Returns:

Examples:
    (begin example)
        [_suicider] call btc_ied_fnc_suicider_active;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_suicider", objNull, [objNull]]
];

private _group = createGroup [btc_enemy_side, true];
[_suicider] joinSilent _group;
_group setVariable ["suicider", true];
_group setVariable ["acex_headless_blacklist", true];

[group _suicider] call CBA_fnc_clearWaypoints;

private _trigger = createTrigger ["EmptyDetector", getPos _suicider, false];
_trigger setTriggerArea [5, 5, 0, false];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", false];
_trigger setTriggerStatements ["this", "thisTrigger call btc_ied_fnc_allahu_akbar;", ""];
_trigger setVariable ["suicider", _suicider];

_trigger attachTo [_suicider, [0, 0, 0]];

private _array = getPos _suicider nearEntities [btc_player_type, 30];

if (_array isEqualTo []) exitWith {};

private _expl1 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl1 attachTo [_suicider, [-0.1, 0.1, 0.15], "Pelvis", true];
private _expl2 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl2 attachTo [_suicider, [0, 0.15, 0.15], "Pelvis", true];
private _expl3 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl3 attachTo [_suicider, [0.1, 0.1, 0.15], "Pelvis", true];

[_expl1, _expl2, _expl3] remoteExecCall ["btc_ied_fnc_belt", 0];

_suicider addEventHandler ["Killed", {
    params ["_unit", "_killer"];

    if !(isPlayer _killer) then {
        (attachedObjects _unit) call CBA_fnc_deleteEntity;
    };
}];

(group _suicider) setBehaviour "CARELESS";
(group _suicider) setSpeedMode "FULL";

if (btc_debug_log) then {
    [format ["_suicider = %1 POS %2 START LOOP", _suicider, getPos _suicider], __FILE__, [false]] call btc_debug_fnc_message;
};

[_suicider, _trigger] call btc_ied_fnc_suicider_activeLoop;
