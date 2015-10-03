
private ["_city"];

_city = btc_city_all select (_this select 0);
_city setVariable ["occupied",false];

if (_city getVariable ["marker",""] != "") then {(_city getVariable ["marker",""]) setMarkerColor "ColorGreen";};

if (btc_final_phase) then {
	btc_city_remaining = btc_city_remaining - [_city];
};


if (btc_debug) then {(format ["loc_%1",(_this select 0)]) setMarkerColor "ColorGreen";};