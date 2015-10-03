
private ["_unit","_order","_group"];

_unit = _this select 0;
_order = _this select 1;
_group = group _unit;

if (_order == _unit getVariable ["order",0]) exitWith {};

_unit setVariable ["order",_order];

while {(count (waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};

switch (_order) do {
	case 1 : {doStop _unit;};
	case 2 : {doStop _unit;_unit setUnitPos "DOWN";};
	case 3 : {
		private "_wp_pos";
		_wp_pos = [getPos _unit, 200] call btc_fnc_randomize_pos;
		_unit setUnitPos "UP";
		_unit doMove _wp_pos;
	};
};

waitUntil {sleep 3; (isNull _unit || !Alive _unit || (count (getpos _unit nearEntities ["SoldierWB", 50]) == 0))};

if (isNull _unit || !Alive _unit) exitWith {};

_unit setVariable ["order",nil];
_unit setUnitPos "AUTO";
_unit doMove getPos _unit;
_group spawn btc_fnc_civ_addWP;