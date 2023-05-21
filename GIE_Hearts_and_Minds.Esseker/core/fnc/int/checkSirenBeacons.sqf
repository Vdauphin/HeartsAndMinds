
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_checkSirenBeacons

Description:
    Check if player turn ON siren or beacons.

Parameters:
    _veh - Vehicle. [Object]
    _text - Text displayed. [String]
    _typesConfig - Type of config to check. [Array]
    _typeVariable - Variable name. [String]

Returns:

Examples:
    (begin example)
        [cursorObject, configOf _veh >> "UserActions" >> siren_Start >> "displayName", ["siren_Start", "siren_stop"] , "btc_int_sirenStart"] call btc_int_fnc_checkSirenBeacons;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    "_veh",
    "_text",
    "_typesConfig",
    "_typeVariable"
];
_typesConfig params ["_start", "_stop"];

private _userActions = configOf _veh >> "UserActions";
if (
    getText (_userActions >> _start >> "displayName") isEqualTo _text
) exitWith {
    _veh call btc_int_fnc_ordersLoop;
    _veh setVariable [_typeVariable, true, true];
};
if (
    getText (_userActions >> _stop >> "displayName") isEqualTo _text
) exitWith {
    _veh setVariable [_typeVariable, false, true];
};
