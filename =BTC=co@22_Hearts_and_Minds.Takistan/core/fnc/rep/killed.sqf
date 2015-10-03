_unit = _this select 0;
_killer = _this select 1;
if (isPlayer _killer) then 
{
	btc_rep_malus_civ_killed call btc_fnc_rep_change;
	if (btc_global_reputation < 600) then {[getpos _unit] spawn btc_fnc_rep_eh_effects;};
	if (btc_debug_log) then {diag_log format ["REP KILLED = GREP %1 THIS = %2",btc_global_reputation,_this];};
};

if !(isNil {_unit getVariable ["traffic",objNull]}) then
{
	btc_civ_veh_active = btc_civ_veh_active - 1;
	[getPos _unit,(_unit getVariable ["traffic",objNull])] spawn 
	{
		waitUntil {sleep 5; ({_x distance (_this select 0) < 600} count playableUnits == 0)};
		deleteVehicle (_this select 1);
	};
};