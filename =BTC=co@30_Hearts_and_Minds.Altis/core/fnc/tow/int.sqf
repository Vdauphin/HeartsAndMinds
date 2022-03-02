
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_int

Description:
    Add towing interactions.

Parameters:
    _type - Type of vehicle. [String]

Returns:

Examples:
    (begin example)
        [typeOf cursorObject] call btc_tow_fnc_int;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_type", "", [""]]
];

private _action = [
    "Logistic",
    localize "STR_BTC_HAM_ACTION_LOC_MAIN",
    "\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",
    {},
    {isNull isVehicleCargo attachedto _target && isNull isVehicleCargo _target}
] call ace_interact_menu_fnc_createAction;
[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

if (
    !(_type isKindOf "Helicopter") ||
    !(_type isKindOf "Plane")
) then {
    _action = [
        "log_tow",
        localize "STR_ACE_Towing_displayName",
        "",
        {btc_tow_vehicleTowing = _target; (localize "STR_BTC_HAM_TOW_HOOK") call CBA_fnc_notify;},
        {
            isNull (_target getVariable ["btc_towing", objNull]) &&
            alive _target
        }
    ] call ace_interact_menu_fnc_createAction;
    [_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
};

_action = [
    "log_hook",
    localize "STR_ACE_Towing_attach",
    "\z\ace\addons\attach\UI\attach_ca.paa",
    {[btc_tow_vehicleTowing, _target] call btc_tow_fnc_ropeCreate;},
    {!isNull btc_tow_vehicleTowing && {btc_tow_vehicleTowing != _target}}
] call ace_interact_menu_fnc_createAction;
[_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;

_action = [
    "log_unhook",
    localize "STR_ACE_Towing_detach",
    "\z\ace\addons\attach\UI\detach_ca.paa",
    {_target call btc_tow_fnc_unhook;},
    {!isNull (_target getVariable ["btc_towing", objNull]);}
] call ace_interact_menu_fnc_createAction;
[_type, 0, ["ACE_MainActions", "Logistic"], _action] call ace_interact_menu_fnc_addActionToClass;
