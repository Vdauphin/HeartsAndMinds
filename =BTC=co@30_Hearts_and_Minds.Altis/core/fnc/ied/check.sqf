
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_check

Description:
    Constantly check if player is around by calling btc_ied_fnc_checkLoop. If yes, trigger the explosion.

Parameters:
    _city - City where IED has been created. [Object]

Returns:

Examples:
    (begin example)
        [_city, _ieds] call btc_ied_fnc_check;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]]
];

private _array = _city getVariable ["ieds", []];
if (_array isEqualTo []) exitWith {};

private _ieds = _array apply {_x call btc_ied_fnc_create};

if (btc_debug || btc_debug_log) then {
    [format ["START CITY ID %1", _city getVariable "id"], __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;
};

private _ieds_check = _ieds select {(_x select 2) isNotEqualTo objNull};

[_city, _ieds, _ieds_check] call btc_ied_fnc_checkLoop;
