
[btc_int_search_intel_time,"Searching for intel . . .",_this] call btc_fnc_int_action_result;

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	[[_this,player],"btc_fnc_info_has_intel",false] spawn BIS_fnc_MP;
};