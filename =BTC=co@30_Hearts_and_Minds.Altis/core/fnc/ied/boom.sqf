
private ["_pos"];

if (btc_debug_log) then {diag_log format ["IED BOOM %1 - POS %2",_this,getPos (_this select 0)]};
_pos = getPos (_this select 1);
deleteVehicle (_this select 1);
"Bo_GBU12_LGB_MI10" createVehicle _pos;
deleteVehicle (_this select 0);
[_pos] call btc_fnc_deaf_earringing;
//separate execution to make it compatible in "singleplayer" and on dedicated servers
if (isDedicated) then {[_pos] remoteExec ["btc_fnc_ied_effects",-2];} else {[_pos] remoteExec ["btc_fnc_ied_effects",0];};
