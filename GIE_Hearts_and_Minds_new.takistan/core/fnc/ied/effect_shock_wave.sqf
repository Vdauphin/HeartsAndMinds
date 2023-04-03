
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_effect_shock_wave

Description:
    Create a shock wave.

Parameters:
    _pos - Position of the IED. [Array]

Returns:

Examples:
    (begin example)
        [getPos player] call btc_ied_fnc_effect_shock_wave;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];
_pos params ["_x", "_y"];

_posASL = [_x, _y, getTerrainHeightASL _pos];

private _color = [
    [[0, 0, 0, 1], [.35, .35, .35, .35], [.35, .35, .35, 0]],
    [[.78, .76, .71, 1], [.35, .35, .35, .35], [.35, .35, .35, 0]],
    [[.55, .47, .37, 1], [.35, .35, .35, .35], [.35, .35, .35, 0]],
    [[.1, .1, .1, 1], [.2, .2, .2, .35], [.35, .35, .35, 0]]
];

private _smokes = [];
for "_i" from 0 to ((count _color)-1) step 1 do {
    private _smoke = "#particlesource" createVehicleLocal _posASL;
    _smoke setPosASL _posASL;
    _smoke setParticleCircle [0, [0, 0, 0]];
    _smoke setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
    _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], _color select _i, [.08], 1, 0, "", "", _posASL];
    _smoke setDropInterval .0004;

    _smokes pushBack _smoke;
};

sleep .07;
{deletevehicle _x} forEach _smokes;
