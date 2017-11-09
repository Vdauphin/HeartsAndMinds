
private _cargo = _this select 0;
private _chopper = _this select 1;

private _simulation = createVehicle ["Box_T_NATO_WpsSpecial_F", getPos _cargo , [], 0, "CAN_COLLIDE"];
_simulation enableSimulation false;
private _pos = getPosATL _cargo;
if ((_pos select 2) < -0.05) then {_pos = [_pos select 0, _pos select 1, (_pos select 2) - ((getPosATL _cargo) select 2)]};
_simulation setPosATL _pos;
_simulation setDir getDir _cargo;
_simulation setVectorUp vectorUp _cargo;

_cargo attachTo [_simulation, [0,0, 0.2 + abs(((_cargo modelToWorld [0,0,0]) select 2) - ((_simulation  modelToWorld [0,0,0]) select 2))]];


_chopper addEventHandler ["RopeBreak", {
	(_this select 0) removeEventHandler ["RopeBreak", _thisEventHandler];
	btc_lifted = false;
	{
		detach _x;
		_x setVectorUp surfaceNormal getPosATL _x;
		private _pos = getPosATL _x;
		if ((_pos select 2) < -0.05) then {
			_x setPosATL [_pos select 0, _pos select 1, 0];
		};
	} forEach attachedObjects (_this select 2);
	deleteVehicle (_this select 2);
}];

_simulation enableSimulation true;
clearWeaponCargoGlobal _simulation;
clearItemCargoGlobal _simulation;
clearMagazineCargoGlobal _simulation;
_simulation setObjectTextureGlobal [0, ""];
_simulation setObjectTextureGlobal [1, ""];

_simulation