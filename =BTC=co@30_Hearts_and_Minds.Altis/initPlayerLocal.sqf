// This section is for slot locking
fnc_reservedSlot = {
	player enableSimulationGlobal false;
	["Restricted", false] call BIS_fnc_endMission;
};
// This section is for Arsenal Restrictions
null = [] execVM "MG-Arsenal\init.sqf";
// This section is for vehicle seat locking
[] execVM "MG-Seat\seatLock.sqf";
