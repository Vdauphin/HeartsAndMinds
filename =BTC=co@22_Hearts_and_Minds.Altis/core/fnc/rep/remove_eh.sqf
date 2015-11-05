
if (isNil {_this getVariable "btc_rep_eh_added"}) exitWith {true};

_data = _this getVariable "btc_rep_eh_added";

_this removeEventHandler ["HandleHeal", (_data select 0)];
_this removeEventHandler ["HandleDamage", (_data select 1)];
_this removeEventHandler ["Killed", (_data select 2)];

//, [_id_h,_id_d,_id_k]];

true