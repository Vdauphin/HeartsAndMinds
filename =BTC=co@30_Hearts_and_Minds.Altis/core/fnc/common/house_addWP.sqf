
params ["_group","_house"];

private _allpositions = [_group,_house] call btc_fnc_house_addWP_loop;

private _wp = _group addWaypoint [_allpositions select 0, 0.2];
_wp setWaypointType "CYCLE";
_wp waypointAttachObject _house;
_wp setWaypointHousePosition 0;
_wp setWaypointCompletionRadius 0;
_wp setWaypointTimeout [15, 20, 30];