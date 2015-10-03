_group = _this select 0;
_house = _this select 1;

_n_pos = 0;
while {format ["%1", _house buildingPos _n_pos] != "[0,0,0]" } do 
{
	_n_pos = _n_pos + 1;
	_wp = _group addWaypoint [getPos _house, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 0;
	_wp waypointAttachObject _house;
	_wp setWaypointHousePosition _n_pos;
	_wp setWaypointTimeout [15, 20, 30];
};
_wp = _group addWaypoint [getPos _house, 0];
_wp setWaypointType "CYCLE";
_wp waypointAttachObject _house;
_wp setWaypointHousePosition 0;
_wp setWaypointCompletionRadius 0;
_wp setWaypointTimeout [15, 20, 30];