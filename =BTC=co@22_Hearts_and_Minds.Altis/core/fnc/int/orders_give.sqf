
private ["_pos","_order","_units","_wp_pos"];

_pos = _this select 0;
_order = _this select 1;

_units = [];
_wp_pos = [0,0,0];

switch (count _this) do {
	case 2 : {_units = _pos nearEntities [["Car","Civilian_F"], btc_int_radius_orders];};
	case 3 : {_units = [_this select 2];};
	case 4 : {
		_units = [_this select 2];
		_wp_pos = (_this select 3);
	};
};

if (count _units == 0) exitWith {};

{if ((isNil {group _x getVariable "suicider"}) && ((side _x) == civilian)) then {[_x,_order,_wp_pos] spawn btc_fnc_int_orders_behaviour;};} foreach _units;