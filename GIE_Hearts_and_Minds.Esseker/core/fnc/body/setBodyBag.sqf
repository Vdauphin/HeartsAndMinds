
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_setBodyBag

Description:
    Set bodybag variable from a patient.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_body_fnc_setBodyBag;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_patient", "_bodyBag"];

if (_patient getVariable ["btc_UID", ""] isEqualTo "") exitWith {};

deleteMarker (_patient getVariable ["btc_body_deadMarker", ""]);
_bodyBag setVariable ["btc_UID", _patient getVariable ["btc_UID", ""]];

[_bodyBag] call btc_log_fnc_init;
