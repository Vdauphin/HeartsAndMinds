
if (btc_hideout_cap_checking) exitWith {};

btc_hideout_cap_checking = true;

_cap_to = [];

{
	//_hd = _x;
	//if ({_x distance _hd < 700} count playableUnits > 0) exitWith {};
	if (time - (_x getVariable ["cap_time",time]) > btc_hideout_cap_time) then {_cap_to = _cap_to + [_x];};
} foreach btc_hideouts;

if (count _cap_to == 0) exitWith {if (btc_debug_log) then {diag_log "btc_fnc_mil_check_cap: exit cap time";};};

{
	private ["_hd","_in_range"];
	_hd = _x;
	_in_range = [];
	{
		if (_hd distance _x < btc_hideout_range) then {_in_range = _in_range + [_x];};
	} foreach btc_city_all;
	
	if (count _in_range == 0) exitWith {if (btc_debug_log) then {diag_log format ["btc_fnc_mil_check_cap: exit no in range = %1",_hd getVariable "id"];};};
	
	_closest = objNull;
	_dist = 999999;
	_pos = getPos _hd;
	{
		if (_x distance _pos < _dist && {!(_x getVariable ["occupied",false])}) then {_closest = _x;_dist = _x distance _pos;};
	} foreach _in_range;diag_log format ["btc_fnc_mil_check_cap: _in_range = %1",_in_range];

	if (isNull _closest) exitWith {if (btc_debug_log) then {diag_log format ["btc_fnc_mil_check_cap: exit null _closest = %1",_hd getVariable "id"];};};
	
	if (btc_debug_log) then {diag_log format ["btc_fnc_mil_check_cap: SEND FROM = %1 TO %2 [int %3]",_hd getVariable "id",_closest getVariable ["name","error"],_closest getVariable ["initialized",false]];};
	
	_hd setVariable ["cap_time",time];
	
	if (_closest getVariable ["initialized",false]) then
	{
		/*[_hd,_closest,1,"I_Truck_02_transport_F"] spawn btc_fnc_mil_send;
		sleep 1;
		[_hd,_closest,1,"I_Truck_02_transport_F"] spawn btc_fnc_mil_send;
		sleep 1;*/
		for "_i" from 0 to (2 + (round random 3)) do {[_hd,_closest,0] call btc_fnc_mil_send;};
	} else {_closest setVariable ["occupied",true];if (btc_debug) then {(format ["loc_%1",_closest getVariable "id"]) setMarkerColor "ColorRed";};};
	
} foreach _cap_to;

btc_hideout_cap_checking = false;