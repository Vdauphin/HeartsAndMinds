
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_get

Description:
    Serialize dead bodies.

Parameters:
    _bodies - Bodies. [Array]

Returns:
    _serializedBodies - Serialized bodies. [Array]

Examples:
    (begin example)
        [btc_body_deadPlayers] call btc_body_fnc_get;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_bodies", [], [[]]]
];

private _serializedBodies = (_bodies  - [objNull]) apply {[
    typeOf _x,
    getPosASL _x,
    getDir _x,
    getUnitLoadout _x,
    _x call btc_body_fnc_dogtagGet,
    _x in btc_chem_contaminated,
    getForcedFlagTexture _x
]};

_serializedBodies
