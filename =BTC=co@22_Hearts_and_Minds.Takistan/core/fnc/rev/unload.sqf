_veh = btc_int_target;

closeDialog 0;

if (isNull _veh || !Alive _veh) exitWith {hint "Error: No vehicle";};

{
	if (_x getVariable ["btc_rev_isUnc",false]) then {[[4,_x],"btc_fnc_code_on_local",_x,false] spawn BIS_fnc_MP;};
} foreach crew _veh;
