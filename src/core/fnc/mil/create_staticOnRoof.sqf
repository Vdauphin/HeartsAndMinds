
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_create_staticOnRoof

Description:
    Create static on roof.

Parameters:
    _house - House to find the roof. [Group]
    _n - Number of static to generate. [Number]
    _city - City where the static is created. [Object]

Returns:

Examples:
    (begin example)
        _result = [flatten ([position player, 30] call btc_fnc_getHouses), 3] call btc_mil_fnc_create_staticOnRoof;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_houses", [], [[]]],
    ["_n", 0, [0]],
    ["_city", objNull, [objNull]]
];

private _i = 1;
while {
    _i <= _n &&
    {_houses isNotEqualTo []}
} do {
    private _house = _houses deleteAt 0;
    if (
        !(_house isKindOf "Ruins") &&
        {!(_house isKindOf "Church")} &&
        {!("Chapel" in typeOf _house)}
    ) then {
        ([_house] call btc_fnc_roof) params ["_spawnPos", "_surfaceNormal"];

        if (acos (_surfaceNormal vectorCos [0, 0, 1]) < 37) then {
            [ASLToATL _spawnPos, btc_type_mg + btc_type_gl, (_house getDir _spawnPos) + (random [-15, 0, 15]), _surfaceNormal, _city] call btc_mil_fnc_create_static;
            _i = _i + 1;
        };
    };
};
