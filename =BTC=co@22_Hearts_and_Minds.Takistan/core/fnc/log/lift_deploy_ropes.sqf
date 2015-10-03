
private "_heli";

btc_ropes_deployed = true;
btc_lifted = false;
btc_log_hud = false;

btc_log_lifted = objNull;

_heli = vehicle player;

_heli setVariable ["cargo",nil];
_heli setVariable ["rope",nil];

ropeCreate [_heli, "slingload0", 10, []];

btc_lift_action_hud = player addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),{if (btc_log_hud) then {btc_log_hud = false;} else {btc_log_hud = true;[] spawn btc_fnc_log_lift_hud;};}, [], -8, false, false, "", "true"];
btc_lift_action = player addAction [("<t color=""#ED2744"">" + ("Hook") + "</t>"),btc_fnc_log_lift_hook, [], 9, true, false, "", "[] call btc_fnc_log_lift_check"];

waitUntil {sleep 5; (vehicle player == player)};

btc_ropes_deployed = false;
player removeAction btc_lift_action;
player removeAction btc_lift_action_hud;

if (count ropes _heli > 0) then
{
	{ropeDestroy _x;} foreach ropes _heli;
};