
//ENGINEER CHECK

[btc_ied_check_time,"Checking for IED . . .",_this] call btc_fnc_int_action_result;

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	btc_int_ask_data = nil;
	[[0,_this,player],"btc_fnc_int_ask_var",_this,false] spawn BIS_fnc_MP;
	waitUntil {!(isNil "btc_int_ask_data")};
	
	if (btc_int_ask_data) then {
		_this setVariable ["active",true];
		hint "This object is an IED";
	} else {hint "This object is not an IED";};
};