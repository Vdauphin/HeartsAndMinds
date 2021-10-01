
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_create_staticOnRoof

Description:
    Create static on roof.

Parameters:
    _house - House to find the roof. [Group]
    _n - Number of static to generate. [Number]
    _city - City where the static is created. [Object]

Returns:

Examples:
    (begin example)
        _result = [[position player, 30] call btc_fnc_getHouses, 3] call btc_fnc_mil_create_staticOnRoof;
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
    {!(_houses isEqualTo [])}
} do {
    private _house = _houses deleteAt 0;
    private _houseType = typeOf _house;
    if (
        !(_houseType isKindOf "Ruins") &&
        {!(_houseType isKindOf "Church")} &&
        {!("Chapel" in _houseType)}
    ) then {
        ([_house] call btc_fnc_roof) params ["_spawnPos", "_surfaceNormal"];

        if (acos (_surfaceNormal vectorCos [0, 0, 1]) < 30) then {
            [ASLToATL _spawnPos, btc_type_mg + btc_type_gl, (_house getDir _spawnPos) + (random [-15, 0, 15]), _surfaceNormal, _city] call btc_fnc_mil_create_static;
            _i = _i + 1;
        };
    };
};
