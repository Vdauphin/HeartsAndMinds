
/* ----------------------------------------------------------------------------
Function: btc_flag_fnc_int

Description:
    Add flag interaction for vehicle.

Parameters:
    _type - Type of vehicle. [String]

Returns:

Examples:
    (begin example)
        [typeOf cursorObject] call btc_flag_fnc_int;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_type", "", [""]]
];

private _action = ["btc_flag_deployVeh", localize "STR_BTC_HAM_ACTION_VEHINIT_DEPLOYFLAG", "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa", {}, {
    btc_p_flag > 0 &&
    {getForcedFlagTexture _target isEqualTo ""} &&
    {(driver vehicle player) isEqualTo player}
}, btc_flag_fnc_deploy] call ace_interact_menu_fnc_createAction;
[_type, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

_action = ["btc_flag_cutVeh", localize "STR_BTC_HAM_ACTION_VEHINIT_CUTFLAG", "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa", {
    _target forceFlagTexture "";
}, {
    btc_p_flag > 0 &&
    {getForcedFlagTexture _target isNotEqualTo ""} &&
    {(driver vehicle player) isEqualTo player}
}] call ace_interact_menu_fnc_createAction;
[_type, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
