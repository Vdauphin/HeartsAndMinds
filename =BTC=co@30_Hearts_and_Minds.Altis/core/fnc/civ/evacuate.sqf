
params ["_position", ["_position_evac", []]];

private _civilians = (allUnits select {side _x isEqualTo civilian}) select {_x distance _position < 200};

if (_position_evac isEqualTo []) then {
	private _safe = (nearestTerrainObjects [_position, ["CHURCH","CHAPEL"], 400]);
	if (_safe isEqualTo []) then {
		_position_evac = [_position, 0, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
	} else {
		private _safe_building = _safe select 0;
		if ((_safe_building buildingPos -1) isEqualTo []) then 	{
			_position_evac = _safe_building getPos [((boundingBox _safe_building) select 1 select 0) + 10, getDir _safe_building];
		} else {
			_position_evac = getPos _safe_building;
		};
	};
};

{
	private _group = group _x;
	while {(count (waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};

	[_group, _position_evac, 20] spawn btc_fnc_civ_addWP;
} forEach _civilians;

_civilians