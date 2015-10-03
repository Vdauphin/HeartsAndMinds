
private ["_pos","_order","_units"];

_pos = _this select 0;
_order = _this select 1;

_units = [];

if (count _this > 2) then {_units = [_this select 2];} else {_units = _pos nearEntities ["Civilian_F", btc_int_radius_orders];};

if (count _units == 0) exitWith {};

{if (isNil {group _x getVariable "suicider"}) then {[_x,_order] spawn btc_fnc_int_orders_behaviour;};} foreach _units;