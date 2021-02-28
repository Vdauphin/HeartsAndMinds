
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_getStructures

Description:
    Fill me when you edit me !

Parameters:
    _pos - [Array]
    _radius - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_mil_getStructures;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_radius", 100, [0]]
];

private _cfgVehicles = configFile >> "CfgVehicles";
private _structures = (nearestTerrainObjects [_pos, ["House", "BUNKER", "FORTRESS"], _radius]) select {getText(_cfgVehicles >> typeOf _x >> "editorSubcategory") isEqualTo "EdSubcat_Military"};

private _useful = _structures select {(
    !((_x buildingPos -1) isEqualTo []) &&
    {damage _x isEqualTo 0}
)};

_useful
