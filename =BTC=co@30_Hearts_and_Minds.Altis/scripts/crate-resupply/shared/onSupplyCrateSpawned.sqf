onSupplyCrateSpawned = {
	params ["_supplyCrate", "_spawner", "_offset"];

	format ["OnSupplyCrateSpawned(%1, %2, %3)", _supplyCrate, _spawner, _offset];

	// Call ACE function stuff to carry for the spawner

	
	[_supplyCrate, true, _offset, 0, true] call ace_dragging_fnc_setCarryable;

	if(_spawner == player) then {
		[_spawner, _supplyCrate] call ace_dragging_fnc_startCarry;
	};

	// Add supply crate ace actions for clients.
	if( (isServer && !isDedicated) || !isServer) then {
		[_supplyCrate] call addResupplyActions;
	};
	
};