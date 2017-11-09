
params ["_object"];

private _data = [];

if !(!isNil {_object getVariable "loaded"} || !Alive _object || isNull _object) then {
		_data pushBack (typeOf _object);
		_data pushBack (getPosASL _object);
		_data pushBack (getDir _object);
		_data pushBack (_object getVariable ["ace_rearm_magazineClass",""]);
		private _cargo = [];
		{_cargo pushBack [(typeOf _x),(_x getVariable ["ace_rearm_magazineClass",""]),[getWeaponCargo _x,getMagazineCargo _x,getItemCargo _x]]} foreach (_object getVariable ["cargo",[]]);
		_data pushBack _cargo;
		private _cont = [getWeaponCargo _object,getMagazineCargo _object,getItemCargo _object];
		_data pushBack _cont;
};

_data