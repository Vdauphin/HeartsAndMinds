call compile preprocessFile "core\fnc\city\init.sqf";

if (btc_db_load && {profileNamespace getVariable ["btc_hm_db",false]}) then {
	call compile preprocessFile "core\fnc\db\load.sqf";
} else {
	for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};

	[] execVM "core\fnc\cache\init.sqf";
};

[btc_helo_1,30,false] spawn btc_fnc_eh_veh_add_respawn;
[btc_helo_2,30,false] spawn btc_fnc_eh_veh_add_respawn;
[btc_helo_3,30,false] spawn btc_fnc_eh_veh_add_respawn;
//[btc_helo_1,true,30] spawn btc_fnc_veh_track_marker;

[] spawn {{waitUntil {!isNull _x};_x addEventHandler ["Killed", {_this call btc_fnc_eh_veh_killed}];} foreach btc_vehicles;};