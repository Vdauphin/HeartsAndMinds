if (btc_global_reputation >= 600) exitWith {};

_pos = _this select 0;

_rep = (btc_global_reputation / 100);

_random = random (10 - _rep);

if (_random <= 3) exitWith {};

if (time > (btc_rep_militia_called + btc_rep_militia_call_time)) then
{
	if (_random > 3) then //CALL MILITIA
	{
		[_pos] spawn btc_fnc_rep_call_militia;
	};
};
if (btc_global_reputation < 300) then
{
	if (_random > 4) then //GET WEAPONS
	{
		[_pos,300] spawn btc_fnc_civ_get_weapons;
	};	
};

if (btc_debug) then
{
	diag_log format ["REP = %1 - RANDOM = %2 - RINF TIME = %3 - MILITIA/WEAPONS = %4/%5",_rep,_random,(time > (btc_rep_militia_called + btc_rep_militia_call_time)),(_random > 3),(_random > 4)];
};