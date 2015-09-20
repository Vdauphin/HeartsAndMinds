enableSaving [false,false];
//Server
call compile preprocessFile "core\def\mission.sqf";
call compile preprocessFile "define_mod.sqf";
call compile preprocessFile "core\fnc\compile.sqf";

if (isServer) then {
	
	call compile preprocessFile "core\fnc\city\init.sqf";
	for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};
	
	[] execVM "core\fnc\cache\init.sqf";
	
	//[btc_helo_1,30,true] spawn btc_fnc_eh_veh_add_respawn;
	[btc_helo_1,true,30,btc_p_marker] spawn btc_fnc_veh_track_marker;
	
	[] spawn {{waitUntil {!isNull _x};_x addEventHandler ["Killed", btc_fnc_eh_veh_killed];} foreach [btc_veh_1,btc_veh_2,btc_veh_3,btc_veh_4,btc_veh_5,btc_veh_6,btc_veh_7,btc_veh_8,btc_veh_9,btc_veh_10,btc_veh_11,btc_veh_12,btc_veh_13];};
	
};

if (!isDedicated) then {

	[] execVM "core\doc.sqf";
	
	[] spawn {
		waitUntil {!isNull player};
		
		player addRating 9999;
		
		player addEventHandler ["Respawn", btc_fnc_eh_player_respawn];
		
		call btc_fnc_int_add_actions;
		
		//Side
		if (btc_side_assigned) then	{
			[] spawn {
				btc_int_ask_data = nil;
				
				[[5,nil,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;

				waitUntil {!(isNil "btc_int_ask_data")};
				
				btc_int_ask_data spawn btc_fnc_task_create;
			};
		};
		
		{[_x] spawn btc_fnc_task_create} foreach [0,1];
		
		if (player getVariable ["interpreter", false]) then {player createDiarySubject ["Diary log","Diary log"];};
	};
};

if (btc_debug) then {
	onMapSingleClick "if (vehicle player == player) then {player setpos _pos} else {vehicle player setpos _pos}";
	player allowDamage false;
	
	btc_marker_debug_cond = true;
	[] spawn btc_fnc_marker_debug;
};
