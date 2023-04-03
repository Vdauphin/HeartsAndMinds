
/* ----------------------------------------------------------------------------
Function: btc_slot_fnc_deserializeState

Description:
    Deserialize player slot.

Parameters:
    _previousPos - Position of the player. [Array]
    _dir - Direction of the player. [Number]
    _loadout - Loadout of the player. [Array]
    _flagTexture - Flag raised. [String]
    _isContaminated - Chemically contaminated. [Boolean]
    _medicalDeserializeState - Medical ACE state. [String]
    _vehicle - Vehicle occupied by player. [Object]
    _field_rations - Thirst and hunger player's. [Array]

Returns:

Examples:
    (begin example)
        (btc_slots_serialized getOrDefault [(keys btc_slots_serialized)#0, []]) remoteExecCall ["btc_slot_fnc_deserializeState", allPlayers#0];
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{!isNull player}, {
    params [
        "_previousPos",
        "_dir",
        "_loadout",
        "_flagTexture",
        "_isContaminated",
        "_medicalDeserializeState",
        ["_vehicle", objNull, [objNull]],
        ["_field_rations", [], [[]]]
    ];

    if (
        player distance ASLToAGL _previousPos > 50 || // Don't set loadout when near main base
        btc_p_autoloadout isEqualTo 0
    ) then { 
        [{[player, _this] call CBA_fnc_setLoadout;}, _loadout] call CBA_fnc_execNextFrame;
    };
    if ((isNull _vehicle) || {!(player moveInAny _vehicle)}) then {
        player setPosASL _previousPos;
    };
    player setDir _dir;
    player forceFlagTexture _flagTexture;
    [{player getVariable ["ace_medical_initialized", false]}, {
        [player, _this] call ace_medical_fnc_deserializeState;
    }, _medicalDeserializeState] call CBA_fnc_waitUntilAndExecute;

    if (_isContaminated) then {
        player call btc_chem_fnc_damageLoop;
    };

    _field_rations params [["_thirst", 0, [0]], ["_hunger", 0, [0]]];
    player setVariable ["acex_field_rations_thirst", _thirst];
    player setVariable ["acex_field_rations_hunger", _hunger];

}, _this] call CBA_fnc_waitUntilAndExecute;
