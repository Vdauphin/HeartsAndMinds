
/* ----------------------------------------------------------------------------
Function: btc_fnc_lift_deployRopes

Description:
    Fill me when you edit me !

Parameters:
    _heli - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_lift_deployRopes;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_heli", vehicle player, [objNull]]
];

btc_ropes_deployed = true;
btc_lifted = false;
btc_lift_hud = false;

_heli setVariable ["cargo", nil];

ropeCreate [_heli, "slingload0", 10, []];

btc_lift_action_hud = player addAction ["<t color=""#ED2744"">" + (localize "STR_BTC_HAM_LOG_LDR_ACTIONHUD") + "</t>", {
    if (btc_lift_hud) then {
        btc_lift_hud = false;
    } else {
        btc_lift_hud = true;
        [] call btc_fnc_lift_hud;
    };
}, [], -8, false, false, "", "true"]; //"<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"
btc_lift_action = player addAction ["<t color=""#ED2744"">" + (localize "STR_BTC_HAM_ACTION_VEHINIT_HOOK") + "</t>",{[] call btc_fnc_lift_hook}, [], 9, true, false, "", "[] call btc_fnc_lift_check"]; //"<t color=""#ED2744"">" + ("Hook") + "</t>"

waitUntil {sleep 5; (vehicle player isEqualTo player)};

btc_ropes_deployed = false;
player removeAction btc_lift_action;
player removeAction btc_lift_action_hud;

if !(ropes _heli isEqualTo []) then {
    {ropeDestroy _x;} forEach ropes _heli;
};
