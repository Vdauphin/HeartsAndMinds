
private ["_group","_pos","_radius","_wp","_houses"];

_group = _this;

_pos = getpos leader _group;
_radius = 50;


_wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 0;
_wp setWaypointSpeed "LIMITED";
_wp setWaypointBehaviour "SAFE";

_houses = [_pos,_radius] call btc_fnc_getHouses;
if (count _houses > 0) then {
	private ["_house","_n_pos"];
	_house = _houses select (floor random count _houses);

	_n_pos = 0;
	while {format ["%1", _house buildingPos _n_pos] != "[0,0,0]" } do {
		_n_pos = _n_pos + 1;
		_wp = _group addWaypoint [getPos _house, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 0;
		_wp waypointAttachObject _house;
		_wp setWaypointHousePosition _n_pos;
		_wp setWaypointTimeout [15, 20, 30];
	};
	_houses = _houses - [_house];
};

for "_i" from 1 to 4 do {
	private "_wp_pos";
	_wp_pos = [_pos, _radius] call btc_fnc_randomize_pos;
	_wp = _group addWaypoint [_wp_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 0;
};

if (count _houses > 0) then {
	private ["_house","_n_pos"];
	_house = _houses select (floor random count _houses);

	_n_pos = 0;
	while {format ["%1", _house buildingPos _n_pos] != "[0,0,0]" } do {
		_n_pos = _n_pos + 1;
		_wp = _group addWaypoint [getPos _house, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 0;
		_wp waypointAttachObject _house;
		_wp setWaypointHousePosition _n_pos;
	};
	_houses = _houses - [_house];
};

_wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "CYCLE";