
private ["_object","_array"];

_object = _this select 0;
_array = (nearestObjects [_object, ["LandVehicle","Air"], 10]) select {!((_x isKindOf "ACE_friesGantry") OR (typeof _x isEqualTo "ACE_friesAnchorBar"))};

if (count _array == 0) exitWith {hint (localize "STR_BTC_HAM_LOG_RWRECK_NOWRECK");}; //No wreck found

if (damage (_array select 0) != 1) exitWith {hint (localize "STR_BTC_HAM_LOG_RWRECK_NOTWRECK")}; //It is not a wreck!

[_array select 0] remoteExec ["btc_fnc_log_server_repair_wreck", 2];
