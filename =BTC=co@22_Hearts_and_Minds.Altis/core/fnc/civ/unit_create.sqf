//_this

if !(isNil {_this getVariable "btc_init"}) exitWith {true};

_this setVariable ["btc_init",true];

_this call btc_fnc_rep_add_eh;

true 