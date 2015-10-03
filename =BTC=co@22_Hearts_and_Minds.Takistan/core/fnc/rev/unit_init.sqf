if !(local _this && isNil {_this getVariable "btc_rev_eh"}) exitWith {};
_this call btc_fnc_rev_init_var;
btc_rev_eh_id = _this addEventHandler ["HandleDamage", { _this call btc_fnc_rev_hd; }];
_this setVariable ["btc_rev_eh", true];