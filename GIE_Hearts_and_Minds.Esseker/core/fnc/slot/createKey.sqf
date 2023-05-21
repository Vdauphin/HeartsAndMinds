
/* ----------------------------------------------------------------------------
Function: btc_slot_fnc_createKey

Description:
    Create hashMap key from slot and player.

Parameters:
    _player - Player. [Object]

Returns:

Examples:
    (begin example)
        [allPlayers#0] call btc_slot_fnc_createKey;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

private _key = position _player;
if !(btc_p_slot_isShare) then {
    _key pushBack getPlayerUID _player;
};

_player setVariable ["btc_slot_key", _key];

_key
