
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_getStructures

Description:
    Fill me when you edit me !

Parameters:
    _pos - [Array]
    _radius - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_mil_fnc_getStructures;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_radius", 100, [0]]
];

private _objects = nearestTerrainObjects [_pos, ["House", "BUNKER", "FORTRESS", "TRANSMITTER"], _radius];
private _objects = _objects select {
    (_x buildingPos -1) isNotEqualTo [] &&
    {damage _x isEqualTo 0}
};

private _structures = _objects select {getText (configOf _x >> "editorSubcategory") isEqualTo "EdSubcat_Military"};

[_structures, _objects]
