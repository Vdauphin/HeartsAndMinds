
private ["_body","_asker"];

_body = _this select 0;
_asker = _this select 1;

if (_body getVariable ["intel",false] && !(_body getVariable ["btc_already_interrogated",false])) then {
	_body setVariable ["intel",false];
	if (isServer) then	{[_asker] spawn btc_fnc_info_give_intel} else {[[_asker],"btc_fnc_info_give_intel",false] spawn BIS_fnc_MP;};
} else {
	[[3],"btc_fnc_show_hint",_asker] spawn BIS_fnc_MP;
};