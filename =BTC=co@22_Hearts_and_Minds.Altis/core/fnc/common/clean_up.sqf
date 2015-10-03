{
	private ["_obj"];_obj = _x;
	if (({_x distance _obj < 150} count playableUnits) == 0) then {deleteVehicle _obj};
} foreach (allMissionObjects "groundweaponholder");
{
	private ["_dead"];_dead = _x;
	if (({_x distance _dead < 300} count playableUnits) == 0 && isNil {_dead getVariable "btc_dont_delete"}) then {deleteVehicle _dead};
} foreach alldead;
{
	if ({Alive _x} count units _x == 0) then {deleteGroup _x;};
} foreach allGroups;