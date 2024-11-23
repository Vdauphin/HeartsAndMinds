
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
        [btc_city_all get 1, [[getPosASL player, getDir player, "ACE_Grave"]]] call btc_civ_fnc_createGrave;
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

        private _grave = createVehicle [_graveType, [0, 0, 0], [], 0, "NONE"];
        _grave setPosASL _posASL;
        _grave setDir _dir;
        _grave setVectorUp surfaceNormal _posASL;

        _flowers = [];
        for "_i" from 0 to (1 + round random 2) do {
            _flowers pushBack createSimpleObject [
                selectRandom btc_type_flowers,
                [[_posASL vectorAdd [0, 0, 0.2], 0.2, 0.8, _dir, true]] call CBA_fnc_randPosArea
            ];
            (_flowers select _i) setDir random 360;
        };

        [_flowers, _grave]
    }
];
