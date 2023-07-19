// Might Interfere with BTC Slot Persistancy, but as we do not use it, it doesnt matter for us.
[] spawn {
	sleep 5;
	player setUnitLoadout (player getVariable ["CVO_Loadout", []]);
};
