
/* ----------------------------------------------------------------------------
Function: btc_slot_fnc_serializeState

Description:
    Serialize player slot.

Parameters:
    _unit - Unit. [Object]

Returns:

Examples:
    (begin example)
        [allPlayers#0] call btc_slot_fnc_serializeState;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

if (
    isNil {_unit getVariable "btc_slot_key"} || 
    {!btc_p_slot_isSaved}
) exitWith {};

private _loadout = [_unit] call CBA_fnc_getLoadout;

private _data = [
    getPosASL _unit,
    getDir _unit,
    _loadout,
    getForcedFlagTexture _unit,
    _unit in btc_chem_contaminated,
    [_unit] call ace_medical_fnc_serializeState,
    vehicle _unit,
    [
        _unit getVariable ["acex_field_rations_thirst", 0],
        _unit getVariable ["acex_field_rations_hunger", 0]
    ]
];

if (btc_debug || btc_debug_log) then {
    [format ["%1", name _unit], __FILE__, [btc_debug, btc_debug_log, btc_debug]] call btc_debug_fnc_message;
    [format ["%1", _data], __FILE__, [false, btc_debug_log, false]] call btc_debug_fnc_message;
};

btc_slots_serialized set [_unit getVariable ["btc_slot_key", [0, 0, 0]], _data];
