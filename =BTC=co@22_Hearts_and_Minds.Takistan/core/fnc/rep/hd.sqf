_unit = _this select 0;
_part = _this select 1;
_dam = _this select 2;
_injurer = _this select 3;
_ammo = _this select 4;

if (_part == "body") then
{
	if (isPlayer _injurer) then
	{
		btc_rep_malus_civ_hd call btc_fnc_rep_change;
		if (btc_global_reputation < 600) then {[getpos _unit] spawn btc_fnc_rep_eh_effects;};
		if (btc_debug_log) then {diag_log format ["REP HD = GREP %1 THIS = %2",btc_global_reputation,_this];};
	};
};

_dam