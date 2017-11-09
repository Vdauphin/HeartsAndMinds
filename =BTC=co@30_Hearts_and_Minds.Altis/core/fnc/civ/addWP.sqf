
params ["_group", ["_pos", getpos leader param [0]] , ["_radius", 50]];

private _wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 0;
_wp setWaypointSpeed "LIMITED";
_wp setWaypointBehaviour "SAFE";

private _houses = [_pos,_radius] call btc_fnc_getHouses;
if (count _houses > 0) then {
	private _house = selectRandom _houses;
	[_group,_house] call btc_fnc_house_addWP_loop;
	_houses = _houses - [_house];
};

for "_i" from 1 to 4 do {
	private _wp_pos = [_pos, _radius] call btc_fnc_randomize_pos;
	_wp = _group addWaypoint [_wp_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 0;
};

if (count _houses > 0) then {
	private _house = selectRandom _houses;
	[_group,_house] call btc_fnc_house_addWP_loop;
	_houses = _houses - [_house];
};

_wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "CYCLE";