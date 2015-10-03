
private ["_city","_ieds","_ieds_check"];

_city = _this select 0;
_ieds = _this select 1;

if (btc_debug) then {player sideChat format ["START IED CHECK CITY ID %1",_city getVariable "id"];};
if (btc_debug_log) then {diag_log format ["START IED CHECK CITY ID %1",_city getVariable "id"];};

_ieds_check = + _ieds;

while {_city getVariable ["active", false]} do {
	{
		private "_ied";
		_ied = _x;
		if !(_ied getVariable ["active",false]) then {_ieds_check = _ieds_check - [_ied];};
		if (!isNull _ied && {Alive _ied} && {_ied getVariable ["active",false]}) then 
		{
			_list = _ied nearEntities ["allvehicles", 12];
			{
				if (side _x == btc_player_side && {(speed _x > 5 || vehicle _x != _x)}) then {_ied spawn btc_fnc_ied_boom;};
			} foreach _list;
		};
	} foreach _ieds_check;
	sleep 1;
};

_data = [];

{
	if (!isNull _x && {Alive _x}) then {_data pushBack [getPos _x,typeOf _x,getDir _x,_x getVariable ["active",true]];deleteVehicle _x;};
} foreach _ieds;

_city setVariable ["ieds",_data];

if (btc_debug) then {player sideChat format ["END IED CHECK CITY ID %1",_city getVariable "id"];};
if (btc_debug_log) then {diag_log format ["END IED CHECK CITY ID %1",_city getVariable "id"];};