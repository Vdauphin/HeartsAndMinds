
private ["_pos","_marker"];

if (isNull btc_cache_obj) exitWith {};

_pos = [
	((btc_cache_pos select 0) + (random btc_cache_info - random btc_cache_info)),
	((btc_cache_pos select 1) + (random btc_cache_info - random btc_cache_info))
];

if !(_this select 0) then {
	private "_axis";
	_axis = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize") / 2;
	_pos = [
		(_axis + (random (btc_cache_info + _axis))),
		(_axis + (random (btc_cache_info + _axis)))
	];
};

_marker = createmarker [format ["%1", _pos], _pos];
_marker setmarkertype "hd_unknown";
_marker setMarkerText format ["%1m", btc_cache_info];
_marker setMarkerSize [0.5, 0.5];
_marker setMarkerColor "ColorRed";

if ((_this select 1) > 0) then {[[1],"btc_fnc_show_hint"] spawn BIS_fnc_MP;};

btc_cache_info = btc_cache_info - btc_info_cache_ratio;
if (btc_cache_info < btc_info_cache_ratio) then {btc_cache_info = btc_info_cache_ratio;};

btc_cache_markers = btc_cache_markers + [_marker];