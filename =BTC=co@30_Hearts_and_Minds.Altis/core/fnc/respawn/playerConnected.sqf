
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_playerConnected

Description:
    Send the number of respawn tickets to a player during connection.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_playerConnected;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

if (_name isEqualTo "__SERVER__") exitWith {};

[{
    !isNull (_this call BIS_fnc_getUnitByUID)
}, {
    private _tickets = btc_respawn_tickets getOrDefault [_this, btc_p_respawn_ticketsAtStart];
    if (_tickets isEqualTo 0) then {
        _tickets = -1;
    };
    [
        _this call BIS_fnc_getUnitByUID,
        _tickets
    ] call BIS_fnc_respawnTickets;
}, _uid, 4 * 60] call CBA_fnc_waitUntilAndExecute;
