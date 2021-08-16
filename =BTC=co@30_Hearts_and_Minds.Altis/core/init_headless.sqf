[] call btc_eh_fnc_headless;

//Move btc_patrol_active group to HC
[] remoteExecCall ["btc_fnc_set_groupsOwner", 2];
