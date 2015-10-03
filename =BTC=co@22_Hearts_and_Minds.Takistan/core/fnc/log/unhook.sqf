
private ["_veh","_towed"];

_veh = _this;

deTach _veh;

btc_int_ask_data = nil;
[[4,_veh,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;

waitUntil {!(isNil "btc_int_ask_data")};

if (isNull btc_int_ask_data) exitWith {hint "This vehicle is not attached to another!"};

_towed = btc_int_ask_data;

deTach _towed;
_towed setVelocity [0, 0, 0.01];

[[_towed,"tow",objNull],"btc_fnc_int_change_var",false] spawn BIS_fnc_MP;
[[_veh,"tow",objNull],"btc_fnc_int_change_var",false] spawn BIS_fnc_MP;