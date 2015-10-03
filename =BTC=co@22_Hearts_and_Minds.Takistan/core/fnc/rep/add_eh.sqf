if (!isNil {_this getVariable "btc_rep_eh_added"}) exitWith {true};

_id_h = _this addEventHandler ["HandleHeal", btc_fnc_rep_hh];
_id_d = _this addEventHandler ["HandleDamage", btc_fnc_rep_hd];
_id_k = _this addEventHandler ["Killed", btc_fnc_rep_killed];

_this setVariable ["btc_rep_eh_added", [_id_h,_id_d,_id_k]];

true