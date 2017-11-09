
[btc_int_search_intel_time,(localize "STR_BTC_HAM_CON_INFO_SEARCH_BAR"),_this] call btc_fnc_int_action_result; //Searching for intel . . .

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	[_this,player] remoteExec ["btc_fnc_info_has_intel", 2];
};
