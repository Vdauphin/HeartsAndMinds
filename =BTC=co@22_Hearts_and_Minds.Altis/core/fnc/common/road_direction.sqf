
private ["_road","_roadConnectedTo","_connectedRoad","_direction"];

_road = _this select 0;
_roadConnectedTo = roadsConnectedTo _road;
_connectedRoad = _roadConnectedTo select 0;
_direction = [_road, _connectedRoad] call BIS_fnc_dirTo;

_direction