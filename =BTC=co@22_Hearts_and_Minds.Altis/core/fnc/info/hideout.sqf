
private ["_ho","_pos","_marker","_array"];

if (count btc_hideouts == 0) exitWith {};

private ["_ho","_pos","_marker","_array"];

_hd = [btc_hq_red getVariable ["info_hideout",objNull], btc_hq_green getVariable ["info_hideout",objNull]] select (str(btc_enemy_side)=="GUER");


if (isNull _ho) then {
	_ho = btc_hideouts select (floor random count btc_hideouts);
	if (str(btc_enemy_side)=="GUER") then 
	{
		btc_hq_green setVariable ["info_hideout",_hd];
	}
	else 
	{
		btc_hq_red setVariable ["info_hideout",_hd];
	};
};

_pos = [
	(((getPos _ho) select 0) + (random btc_info_hideout_radius - random btc_info_hideout_radius)),
	(((getPos _ho) select 1) + (random btc_info_hideout_radius - random btc_info_hideout_radius))
];

_marker = createmarker [format ["%1", _pos], _pos];
_marker setmarkertype "hd_warning";
_marker setMarkerText format ["%1m", btc_info_hideout_radius];
_marker setMarkerSize [0.5, 0.5];
_marker setMarkerColor "ColorRed";

_array = _ho getVariable ["markers",[]];

_array pushBack _marker;

_ho setVariable ["markers",_array];