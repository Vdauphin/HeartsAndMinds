
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_effect_rocks

Description:
    Add rocks effect, some rock fall from the sky.

Parameters:
    _pos - Position of the IED. [Array]

Returns:

Examples:
    (begin example)
        [player] call btc_ied_fnc_effect_rocks;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];
_pos params ["_x", "_y"];

_posASL = [_x, _y, getTerrainHeightASL _pos];

private _rockesArr = [];

private _rVar = [
    [0, [1, 1, 0], [20, 20, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0],
    [0, [1, 1, 0], [25, 25, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0],
    [0, [1, 1, 0], [30, 30, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0]
];

private _rubVar = [
  [.45, .45],
  [.27, .27],
  [.09, .09]
];

for "_i" from 0 to ((count _rVar)-1) step 1 do {
    private _rocks = "#particlesource" createVehicleLocal _posASL;
    _rocks setPosASL _posASL;
    _rocks setParticleCircle [0, [0, 0, 0]];
    _rocks setParticleRandom (_rVar select _i);
    _rocks setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, _rubVar select _i, [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _posASL, 0, false, 0.3];
    _rocks setDropInterval 0.01;
    _rockesArr pushBack _rocks;
};

sleep 0.22;
{deleteVehicle _x} forEach _rockesArr;
