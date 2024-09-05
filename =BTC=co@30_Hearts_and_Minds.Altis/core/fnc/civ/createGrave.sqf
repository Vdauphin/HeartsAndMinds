
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_createGrave

Description:
    Create graves and add flower bouquets next to them.

Parameters:
    _city - City. [Object]
    _graves - Array of grave around city. [Array]

Returns:

Examples:
    (begin example)
        [btc_city_all get 0, [[getPosASL player, getDir player]]] call btc_civ_fnc_createGrave;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_graves", [], [[]]]
];

_city setVariable [
    "btc_civ_graves", 
    _graves apply {
        _x params ["_posASL", "_dir", "_graveType"];

        _grave = createVehicle [_graveType, [0, 0, 0], [], 0, "NONE"];
        _grave setPosASL _posASL;
        _grave setDir _dir;
        _grave setVectorUp surfaceNormal _posASL;

        private _flowers = createSimpleObject [selectRandom btc_type_flowers, _posASL];
        _flowers setDir _dir;

        [_flowers, _grave]
    }
];