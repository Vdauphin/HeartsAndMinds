
/* ----------------------------------------------------------------------------
Function: btc_slot_fnc_deserializeState_s

Description:
    Deserialize player slot.

Parameters:
    _player - Player. [Object]
    _key - HashMap key. [String, Array]

Returns:

Examples:
    (begin example)
        [allPlayers#0, (keys btc_slots_serialized)#0] call btc_slot_fnc_deserializeState_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]],
    ["_key", "", ["", []]],
    ["_owner", -1, [0]]
];

private _data = btc_slots_serialized getOrDefault [_key, []];
if (_data isEqualTo []) exitWith {};
if (_data select 4) then {
    if ((btc_chem_contaminated pushBackUnique _player) > -1) then {
        publicVariable "btc_chem_contaminated";
    };
};

_data remoteExecCall ["btc_slot_fnc_deserializeState", _owner];
