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
	
	removeAllWeapons player;
};

if (btc_debug) then {
	onMapSingleClick "if (vehicle player == player) then {player setpos _pos} else {vehicle player setpos _pos}";
	player allowDamage false;
	
	btc_marker_debug_cond = true;
	[] spawn btc_fnc_marker_debug;
};