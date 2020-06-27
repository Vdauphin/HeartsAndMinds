
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_getSpreadLevel

Description:
    Get the cbrn spread from the source with the given chem level to the target.

Parameters:
    _source - Source object. [Object]
    _chemlevel - Chemical contamination level of the source unit. [Number]
    _target - Target object. [Object]

Returns:
    _spreadLevel - Chemical contamination level for the target unit from the source. [Number]

Examples:
    (begin example)
        [player, cursorObject] call btc_fnc_chem_getSpreadLevel;
    (end)

Author:
    Zakant

---------------------------------------------------------------------------- */

params [
    ["_source", objNull, [objNull]],
    ["_chemlevel", 0, [0]],
    ["_target", objNull, [objNull]]
];

// Calculate the real (3D) distance between source and target
private _distance = _source distance _target;

// If distance is greater then the max range, the spread is zero
if (_distance >= btc_chem_maxrange) exitWith { 0 };

// Calculate spread value at position
private _distanceValues = matrixTranspose ([[4, 5, 6, 7, 0] apply {_distance ^ _x}]);

private _levelDependentValues = (btc_chem_levelDependentCoefficents matrixMultiply _distanceValues) select 0 select 0;

private _independentValues = (btc_chem_IndependentCoefficents matrixMultiply _distanceValues) select 0 select 0;

private _spreadLevel = _levelDependentValues * _chemlevel + _independentValues;

// Reduce the spread value by the given reduction
_spreadLevel = (_spreadLevel - btc_chem_spreadReduction) max 0;

_spreadLevel
