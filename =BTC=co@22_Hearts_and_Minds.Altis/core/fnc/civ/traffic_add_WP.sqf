
private ["_group","_city","_area","_players","_cities","_pos","_isboat"];

_group = _this select 0;
_city = _group getVariable ["city",objNull];
_area = _this select 1;
_isboat = _this select 2;

_players = if (isMultiplayer) then {playableUnits} else {switchableUnits};

if ({_x distance _city < (_area/2) || _x distance leader _group < (_area/2)} count _players isEqualTo 0) exitWith {//playableUnits
	diag_log text "DELETE TRAFFIC GROUP";
	if (vehicle leader _group != leader _group) then {deleteVehicle (vehicle leader _group)};
	{deleteVehicle _x;} foreach units _group;deleteGroup _group;
	btc_civ_veh_active = btc_civ_veh_active - 1;
};

_cities = [];
{if ((_x distance _city < _area) && ((!_isboat && {_x getVariable ["type",""] != "NameMarine"}) || (_isboat && {_x getVariable ["hasbeach",false]})))  then {
		_cities pushBack _x;
};} foreach btc_city_all;
_pos = [];
if (_cities isEqualTo []) then {_pos = getPos _city;} else {
	_pos = getPos (_cities select (floor random count _cities));
};
if (_isboat) then {
	_pos = [_pos, 0, ((_city getVariable ["RadiusX",0]) + (_city getVariable ["RadiusY",0])), 13, 2, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_pos = [_pos select 0, _pos select 1, 0];
};

private ["_wp","_wp_1"];

while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};

if ((vehicle leader _group) isKindOf "Air" || (vehicle leader _group) isKindOf "LandVehicle") then {(vehicle leader _group) setFuel 1;};
_group setBehaviour "SAFE";
_wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 20;
_wp setWaypointStatements ["true", format ["_spawn = [group this,%1,%2] spawn btc_fnc_civ_traffic_add_WP;",_area,_isboat]];

if (btc_debug) then {
	if (!isNil {_group getVariable "btc_traffic_id"}) then {
		private "_marker";
		_marker = createmarker [format ["btc_traffic_%1", _group getVariable "btc_traffic_id"] , [(_pos select 0) + random 30,(_pos select 1) + random 30,0]];
		format ["btc_traffic_%1", _group getVariable "btc_traffic_id"] setmarkertype "mil_dot";
		format ["btc_traffic_%1", _group getVariable "btc_traffic_id"]  setMarkerText format ["P %1", _group getVariable "btc_traffic_id"];
		format ["btc_traffic_%1", _group getVariable "btc_traffic_id"]  setmarkerColor "ColorOrange";
		format ["btc_traffic_%1", _group getVariable "btc_traffic_id"]  setMarkerSize [0.5, 0.5];
		diag_log text format ["ID: %1 (%3) POS: %2",_group getVariable "btc_traffic_id",_pos,typeof vehicle leader _group];
	};
};