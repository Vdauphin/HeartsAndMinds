_healer = _this select 1;
if (isPlayer _healer) then 
{
	btc_rep_bonus_civ_hh spawn btc_fnc_rep_change;if (btc_debug_log) then {diag_log format ["REP HH = GREP %1 THIS = %2",btc_global_reputation,_this];};
};
