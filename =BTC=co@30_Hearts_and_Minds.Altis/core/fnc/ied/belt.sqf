
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_belt

Description:
    Arrange three objects in upper direction.

Parameters:
    _expl1 - Object to set vector. [Object]
    _expl2 - Object to set vector. [Object]
    _expl3 - Object to set vector. [Object]

Returns:

Examples:
    (begin example)
        [object1, object2, object3] call btc_ied_fnc_belt;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_expl1", objNull, [objNull]],
    ["_expl2", objNull, [objNull]],
    ["_expl3", objNull, [objNull]]
];

_expl1 setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
_expl2 setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
_expl3 setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];
