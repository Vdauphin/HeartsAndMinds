
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_treatment

Description:
    Change reputation when a caller is healing a civilian.

Parameters:
    _caller - Healer. [Object]
    _target - Civilian heal. [Object]
    _selectionName - Not use. [String]
    _className - Type of healing. [String]

Returns:

Examples:
    (begin example)
        _result = [] call btc_rep_fnc_treatment;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_caller", objNull, [objNull]],
    ["_target", objNull, [objNull]],
    ["_selectionName", "", [""]],
    ["_className", "", [""]]
];

if (isPlayer _target) exitWith {};
if (
    alive _target &&
    side group _target isEqualTo civilian &&
    !(_className in ["CheckPulse", "CheckBloodPressure", "CheckResponse"])
) then {
    _this remoteExecCall ["btc_rep_fnc_hh", 2];
};
