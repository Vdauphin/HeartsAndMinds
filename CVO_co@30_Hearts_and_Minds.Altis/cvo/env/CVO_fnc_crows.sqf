// This is based of on the bis_fnc_crows.sqf 


private ["_flockPos","_flockArea","_flockCount","_wp0","_wp1","_wp2","_wp3","_wps","_crowList","_crow"];

_flockPos = _this select 0;
_flockArea = if (count _this > 1) then {_this select 1} else {50};
_flockCount = if (count _this > 2) then {_this select 2} else {_flockArea / 5};
_flockHeight = if (count _this > 3) then {_this select 3} else {30 + random 10};

if (typename _flockPos == typename objnull) then {_flockPos = position _flockPos};
if (typename _flockPos == typename "") then {_flockPos = markerpos _flockPos};

_flockPos set [2,_flockHeight];
_wp0 = [_flockPos, _flockArea, 00] 	call BIS_fnc_relPos;
_wp1 = [_flockPos, _flockArea, 090] call BIS_fnc_relPos;
_wp2 = [_flockPos, _flockArea, 180] call BIS_fnc_relPos;
_wp3 = [_flockPos, _flockArea, 270] call BIS_fnc_relPos;
_wps = [_wp0,_wp1,_wp2,_wp3];

_crowList = [];
for "_i" from 1 to _flockCount do {
	_crow = "crowe" camcreate [
		(_flockPos select 0) - _flockArea + (random _flockArea)*2,
		(_flockPos select 1) - _flockArea + (random _flockArea)*2,
		_flockHeight
	];
	[_crow,_wp0,_wp1,_wp2,_wp3,_flockArea] execfsm "A3\Functions_F\Environment\fn_crows.fsm";
	_crowList = _crowList + [_crow];
};

_crowList;