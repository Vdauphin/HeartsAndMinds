
private ["_pos","_type","_dir","_static","_group","_unit_type","_gunner"];

_pos  = _this select 0;
_type = _this select 1;
_dir = 0; if (count _this > 2) then {_dir = _this select 2;};
if (typeName _type == "ARRAY") then {_type = selectRandom _type;};

_static = _type createVehicle _pos;
_static setDir _dir;
_static setpos _pos;

_group = createGroup btc_enemy_side;
_unit_type = selectRandom btc_type_units;
_gunner = _group createUnit [_unit_type, _pos, [], 0, "NONE"];
[_gunner] joinSilent _group;
_gunner moveInGunner _static;
_gunner setBehaviour "COMBAT";
_gunner setCombatMode "RED";

_gunner call btc_fnc_mil_unit_create;

if (btc_debug_log) then {diag_log format ["btc_fnc_mil_create_static: _this = %1 ; POS %2 _type %3",_this,_pos,_type];};