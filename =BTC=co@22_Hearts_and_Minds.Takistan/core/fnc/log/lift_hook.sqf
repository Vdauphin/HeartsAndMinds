private ["_chopper","_array","_cargo_array","_cargo"];
_chopper = vehicle player;
_array = [vehicle player] call btc_fnc_log_get_liftable;
_cargo_array = nearestObjects [_chopper, _array, 30];
if (count _cargo_array > 0 && driver (_cargo_array select 0) == player) then {_cargo_array set [0,0];_cargo_array = _cargo_array - [0];};
if (count _cargo_array > 0) then {_cargo = _cargo_array select 0;} else {_cargo = objNull;};
if (isNull _cargo) exitWith {};

if (!Alive _cargo) exitWith {
	_cargo spawn btc_fnc_log_lift_hook_fake;
};

private ["_rope","_max_cargo","_mass"];

{ropeDestroy _x;} foreach ropes _chopper;

_rope = ropeCreate [vehicle player, "slingload0", _cargo, [0, 0, 0], 10];

_max_cargo  = getNumber (configFile >> "cfgVehicles" >> typeof _chopper >> "slingLoadMaxCargoMass");
_mass = getMass _cargo;

waitUntil {local _cargo};

if (_mass > _max_cargo) then {
	private "_new_mass";
	_cargo setVariable ["mass",_mass];
	_new_mass = (_max_cargo - 1000);
	if (_new_mass < 0) then {_new_mass = 50;};
	_cargo setMass _new_mass;
	//if (local _cargo) then {_cargo setMass _new_mass;} else {[[_cargo,_new_mass],"btc_fnc_log_set_mass",_cargo] spawn BIS_fnc_MP;};
};

(vehicle player) setVariable ["cargo",_cargo];
(vehicle player) setVariable ["rope",_rope];

btc_lifted = true;

waitUntil {sleep 5; (!Alive player || !Alive _cargo || !btc_lifted || vehicle player == player)};

//if (local _cargo) then {_cargo setMass _mass;} else {[[_cargo,_mass],"btc_fnc_log_set_mass",_cargo] spawn BIS_fnc_MP;};
_cargo setMass _mass;