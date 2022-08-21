
/* ----------------------------------------------------------------------------
Function: btc_lift_fnc_destroyRopes

Description:
    Fill me when you edit me !

Parameters:
    _heli - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_lift_fnc_destroyRopes;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_heli", vehicle player, [objNull]]
];

btc_ropes_deployed = false;
btc_lift_hud = false;
btc_lifted = false;

player removeAction btc_lift_action;
player removeAction btc_lift_action_hud;

if (ropes _heli isNotEqualTo []) then {
    {
        ropeDestroy _x;
    } forEach ropes _heli;
};

_heli setVariable ["cargo", nil];
