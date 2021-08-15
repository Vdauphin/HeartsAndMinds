
/* ----------------------------------------------------------------------------
Function: btc_lift_fnc_hookFake

Description:
    Fill me when you edit me !

Parameters:
    _cargo - [Object]
    _chopper - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_lift_fnc_hookFake;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cargo", objNull, [objNull]],
    ["_chopper", objNull, [objNull]]
];

private _simulation = createVehicle ["Land_Pod_Heli_Transport_04_box_F", getPosATL _cargo, [], 0, "CAN_COLLIDE"];
(getPosATL _cargo) params ["_x", "_y", "_z"];
_simulation setPosATL [_x, _y, [_z, 0] select (_z < -0.05)];
_simulation setDir getDir _cargo;
_simulation setVectorUp vectorUp _cargo;

_cargo attachTo [_simulation, [0, 0, 0.2 + abs(((_cargo modelToWorld [0, 0, 0]) select 2) - ((_simulation modelToWorld [0, 0, 0]) select 2))]];

_chopper addEventHandler ["RopeBreak", {
    params ["_object1", "_rope", "_object2"];

    _object1 removeEventHandler ["RopeBreak", _thisEventHandler];
    btc_lifted = false;
    deleteVehicle _object2;
}];

clearWeaponCargoGlobal _simulation;
clearItemCargoGlobal _simulation;
clearMagazineCargoGlobal _simulation;
clearBackpackCargoGlobal _simulation;
_simulation setObjectTextureGlobal [0, ""];
_simulation setObjectTextureGlobal [1, ""];

_simulation
