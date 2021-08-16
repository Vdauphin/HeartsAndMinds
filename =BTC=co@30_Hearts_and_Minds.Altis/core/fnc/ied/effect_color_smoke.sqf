
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_effect_color_smoke

Description:
    Add colored smoke effect.

Parameters:
    _pos - Bucket position. [Array]
    _posASL - Smoke position. [Array]
    _colorSel - Color of the smoke. [String]
    _horizontal - Velocity horizontal. [Number]
    _upwards - Velocity upwards. [Number]
    _color - RGB color. [Array]

Returns:

Examples:
    (begin example)
        [getPos player, getPosASL player, "sand"] call btc_ied_fnc_effect_color_smoke;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_posASL", [0, 0, 0], [[]]],
    ["_colorSel", "", [""]],
    ["_horizontal", 900, [0]],
    ["_upwards", 500, [0]],
    ["_color", [], [[]]]
];

if (_colorSel isEqualTo "") exitWith {};
if (_colorSel isEqualTo "sand") then {_color = [[.55, .47, .37, .75], [0.78, 0.76, 0.71, 0]];};
if (_colorSel isEqualTo "gray") then {_color = [[.1, .1, .1, .75], [0.78, 0.76, 0.71, 0]];};
if (_colorSel isEqualTo "brown") then {_color = [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]];};

private _size = 1 + random 3;

private _thingToFling = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
_thingToFling hideObject true;
_thingToFling setPos _pos;
private _smoke = "#particlesource" createVehicleLocal _posASL;
_smoke setPosASL _posASL;
_smoke setParticleCircle [0, [0, 0, 0]];
_smoke setParticleRandom [0, [0, 0, -.5], [2, 2, .5], 0, 1, [0, 0, 0, 0.1], 0, 0];
_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10.5, [0, 0, .7], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2*_size], _color, [0.08], 1, 0, "", "", _thingToFling];
_smoke setDropInterval 0.005;

_thingToFling setVelocity [(random _horizontal) - _horizontal/2, (random _horizontal) - _horizontal/2, 5 + (random _upwards)];
_thingToFling allowDamage false;
private _sleepTime = random 0.5;
private _currentTime = 0;

while {_currentTime < _sleepTime and _size > 0} do {
    _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, .7], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2*_size], _color, [0.08], 1, 0, "", "", _thingToFling];
    private _sleep = random .05;
    _size = _size - 6*_sleep;
    _currentTime = _currentTime + _sleep;
    sleep _sleep;
};

_thingToFling setPos [0, 0, 0];
deleteVehicle _smoke;
deleteVehicle _thingToFling;
