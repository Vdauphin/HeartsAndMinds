
private "_ratio";

[btc_ied_check_time,"Disarming IED . . .",_this] call btc_fnc_int_action_result;

waitUntil {!(isNil "btc_int_action_result")};

if (btc_int_action_result) then {
	_ratio = 40;
	if ((player call btc_fnc_is_engineer) || (btc_p_engineer == 1)) then {_ratio = 95;};
	if (random 100 > _ratio) then {[_this,"btc_fnc_ied_boom",false] spawn BIS_fnc_MP;} else	{
		hint "IED disarmed!";
		[[_this,"active",false],"btc_fnc_int_change_var",false] spawn BIS_fnc_MP;
		[btc_rep_bonus_disarm,"btc_fnc_rep_change",false] spawn BIS_fnc_MP;
	};
};
