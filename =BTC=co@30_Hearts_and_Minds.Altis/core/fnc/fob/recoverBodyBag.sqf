
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_recoverBodyBag

Description:
    Add respawn tickets when a body bag is provided.

Parameters:
    _object - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fob_fnc_recoverBodyBag;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];

private _array = nearestObjects [_object, ["ACE_bodyBagObject"], 10];
if (_array isEqualTo []) exitWith {(localize "STR_BTC_HAM_LOG_RWRECK_NOWRECK") call CBA_fnc_notify;};

[btc_player_side, 1] call BIS_fnc_respawnTickets;
deleteVehicle (_array select 0);
