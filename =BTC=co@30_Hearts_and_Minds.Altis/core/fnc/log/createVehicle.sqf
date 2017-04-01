
private _type = _this select 0;
private _pos = _this select 1;
private _dir = _this select 2;
private _textures = if (count _this > 3) then {_this select 3} else {[]};

_veh  = createVehicle [_type, [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
_veh setPosASL _pos;
_veh setDir _dir;

{
	_veh setObjectTextureGlobal [ _foreachindex, _x ];
} forEach _textures;
_veh setVariable ["btc_dont_delete",true];

if (getNumber(configFile >> "CfgVehicles" >> typeof _veh >> "isUav") isEqualTo 1) then {
	createVehicleCrew _veh;
};

_veh call btc_fnc_db_add_veh;

_veh