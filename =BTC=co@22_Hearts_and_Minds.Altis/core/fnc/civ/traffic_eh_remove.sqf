//diag_log format ["EH REMOVE TRAFFIC %1 - %2",_this,_this getVariable "eh"];
if (isNil {_this getVariable "eh"}) exitWith {true};

private "_data";
_data = _this getVariable "eh";
_this removeEventHandler ["HandleDamage", (_data select 0)];
_this removeEventHandler ["Fuel", (_data select 1)];
_this removeEventHandler ["GetOut", (_data select 2)];