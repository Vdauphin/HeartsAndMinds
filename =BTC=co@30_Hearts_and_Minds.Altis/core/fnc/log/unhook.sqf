
private ["_veh","_towed","_pos"];

_veh = _this;

btc_int_ask_data = nil;
[4,_veh,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

if (isNull btc_int_ask_data) exitWith {hint (localize "STR_BTC_HAM_LOG_UNHOOK_NOROPE");}; //This vehicle is not attached to another!

deTach _veh;
_veh removeEventHandler ["RopeBreak", _veh getVariable ["btc_eh", -1]];
(ropes _veh) apply {ropeDestroy _x};

_pos = getpos _veh;
if ((_pos select 2) < -0.05) then {
	_veh setpos [_pos select 0, _pos select 1, 0];
};

_towed = btc_int_ask_data;

deTach _towed;
_towed removeEventHandler ["RopeBreak", _towed getVariable ["btc_eh", -1]];
(ropes _towed) apply {ropeDestroy _x};

_pos = getpos _towed;
if ((_pos select 2) < -0.05) then {
	_towed setposasl [_pos select 0, _pos select 1, ((getPosASL _veh) select 2) - (_pos select 2)];
} else {
	_towed setVelocity [0, 0, 0.01];
};

[_towed,"tow",objNull] remoteExec ["btc_fnc_int_change_var", 2];
[_veh,"tow",objNull] remoteExec ["btc_fnc_int_change_var", 2];
