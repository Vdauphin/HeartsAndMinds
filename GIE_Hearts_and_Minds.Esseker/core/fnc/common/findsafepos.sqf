
/* ----------------------------------------------------------------------------
Function: btc_fnc_findsafepos

Description:
    Find safe position.

Parameters:
    _check_pos - Center position. [Array]
    _mindist - Minimum distance from the center position. [Number]
    _random_area - Maximum distance from the center position. [Number]
    _objdist - Minimum distance from the resulting position to the center of nearest object. Specifying quite large distance here will slow the function and might often fail to find suitable position. Recommended value: 0 - 10. [Number]
    _allow_water - Allow water position. [Boolean]

Returns:

Examples:
    (begin example)
        _result = [getPos player] call btc_fnc_findsafepos;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_check_pos", [0, 0, 0], [[]]],
    ["_mindist", 0, [0]],
    ["_random_area", 100, [0]],
    ["_objdist", 0, [0]],
    ["_allow_water", false, [false, 0]]
];

private _return_pos = [];
for "_i" from 0 to 4 do {
    _return_pos = [_check_pos, _mindist, _random_area, _objdist, [0, 1] select _allow_water, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
    if (count _return_pos isEqualTo 2) exitWith {
        _return_pos = [_return_pos select 0, _return_pos select 1, 0];
    };

    _random_area = _random_area * 1.5;
};
_return_pos
