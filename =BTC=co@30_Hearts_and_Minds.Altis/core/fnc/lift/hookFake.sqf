
/* ----------------------------------------------------------------------------
Function: btc_fnc_lift_hookFake

Description:
    Fill me when you edit me !

Parameters:
    _cargo - [Object]
    _chopper - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_lift_hookFake;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cargo", objNull, [objNull]],
    ["_chopper", objNull, [objNull]]
];

private _simulation = createVehicle ["Box_EAF_AmmoVeh_F", getPosATL _cargo , [], 0, "CAN_COLLIDE"];
_simulation enableSimulation false;
(getPosATL _cargo) params ["_x", "_y", "_z"];
_simulation setPosATL [_x, _y, [_z, 0] select (_z < -0.05)];
_simulation setDir getDir _cargo;
_simulation setVectorUp vectorUp _cargo;

_cargo attachTo [_simulation, [0, 0, 0.2 + abs(((_cargo modelToWorld [0, 0, 0]) select 2) - ((_simulation modelToWorld [0, 0, 0]) select 2))]];

_chopper addEventHandler ["RopeBreak", {
    params ["_object1", "_rope", "_object2"];

    _object1 removeEventHandler ["RopeBreak", _thisEventHandler];
    btc_lifted = false;
    {
        detach _x;
        _x setVectorUp surfaceNormal getPosATL _x;
        (getPosATL _x) params ["_xx", "_yy", "_zz"];
        if (_zz < -0.05) then {
            _x setPosATL [_xx, _yy, 0];
        };
    } forEach attachedObjects _object2;
    deleteVehicle _object2;
}];

_simulation enableSimulation true;
clearWeaponCargoGlobal _simulation;
clearItemCargoGlobal _simulation;
clearMagazineCargoGlobal _simulation;
_simulation setObjectTextureGlobal [0, ""];
_simulation setObjectTextureGlobal [1, ""];

_simulation
