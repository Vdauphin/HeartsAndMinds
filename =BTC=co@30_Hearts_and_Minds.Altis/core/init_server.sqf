call compile preprocessFile "core\fnc\city\init.sqf";

{[_x] spawn btc_fnc_task_create} foreach [0,1];

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db",worldName],false]}) then {
	if (btc_version isEqualTo (profileNamespace getVariable [format ["btc_hm_%1_version",worldName],1.13])) then	{
		call compile preprocessFile "core\fnc\db\load.sqf";
	} else {
		call compile preprocessFile "core\fnc\db\load_old.sqf";
	};
} else {
	for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};

	private _date = date;
	_date set [3, btc_p_time];
	setDate _date;

	[] execVM "core\fnc\cache\init.sqf";

	[] spawn {{waitUntil {!isNull _x}; _x call btc_fnc_db_add_veh;} foreach btc_vehicles;};
};

call btc_fnc_db_autosave;

addMissionEventHandler ["HandleDisconnect",{
	if ((_this select 0) in (entities "HeadlessClient_F")) then 	{
		//Remove HC player when disconnect
		deleteVehicle (_this select 0);
	};
}];

["Initialize"] call BIS_fnc_dynamicGroups;

setTimeMultiplier btc_p_acctime;

{[_x,30,false] spawn btc_fnc_eh_veh_add_respawn;} forEach btc_helo;

if (btc_p_side_mission_cycle) then {
	[true] spawn btc_fnc_side_create;
};