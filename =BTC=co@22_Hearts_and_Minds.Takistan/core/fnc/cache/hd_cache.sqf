
private ["_cache","_damage","_ammo","_explosive","_cache"];

_cache = _this select 0;
_damage = _this select 2;
_ammo = _this select 4;

_explosive = (getNumber(configFile >> "cfgAmmo" >> _ammo >> "explosive") > 0);

if (isNil {_cache getVariable "btc_hd_cache"} && {_explosive} && {_damage > 0.6}) then {
	_cache setVariable ["btc_hd_cache",true];
	//Effects
	private ["_pos","_marker"];
	_pos = getposATL btc_cache_obj;
	"Bo_GBU12_LGB_MI10" createVehicle _pos;
	_pos spawn {sleep 2;"M_PG_AT" createVehicle _this;sleep 2;"M_Titan_AT" createVehicle _this;};
	playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", btc_cache_obj, false, _pos, 1, 1];
	deleteVehicle btc_cache_obj;
	_marker = createmarker [format ["btc_cache_%1", btc_cache_n], btc_cache_pos];
	_marker setmarkertype "hd_destroy";
	_marker setMarkerText format ["Cached %1 destroyed", btc_cache_n];
	_marker setMarkerSize [1, 1];
	_marker setMarkerColor "ColorRed";
	if (btc_debug_log) then	{
		diag_log format ["CACHE DESTROYED: ID %1 POS %2",btc_cache_n,btc_cache_pos];
	};	
	btc_rep_bonus_cache spawn btc_fnc_rep_change;
	
	btc_cache_pos = [];
	btc_cache_n = btc_cache_n + 1;
	btc_cache_obj = objNull;
	btc_cache_info = btc_info_cache_def;
	{deleteMarker _x} foreach btc_cache_markers;
	btc_cache_markers = [];
	
	//Notification
	[[0],"btc_fnc_show_hint"] spawn BIS_fnc_MP;
	
	[]spawn {[] call btc_fnc_cache_find_pos;};
} else {0};