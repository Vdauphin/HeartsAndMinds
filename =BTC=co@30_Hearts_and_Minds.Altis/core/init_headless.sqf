//Move btc_patrol_active group to HC
[] remoteExecCall ["btc_fnc_set_groupsOwner", 2];

// Register the damage event handler for chemical damage
[] call btc_fnc_chem_registerDamageEH;
