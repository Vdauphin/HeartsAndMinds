//_this

if !(isNil {_this getVariable "btc_init"}) exitWith {true};

_this setVariable ["btc_init",true];

_this addEventHandler ["Killed",btc_fnc_mil_unit_killed];

if (btc_p_set_skill) then {_this call btc_fnc_mil_set_skill;};

/*
if (isNil {_this getVariable "btc_eh_killed_assigned"}) then
{
	_this addEventHandler ["Killed",btc_fnc_mil_eh_killed];
	_this setVariable ["btc_eh_killed_assigned",true];
};
*/
true 