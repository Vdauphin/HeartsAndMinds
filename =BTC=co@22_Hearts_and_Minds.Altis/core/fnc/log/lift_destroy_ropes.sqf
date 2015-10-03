
private "_heli";

btc_ropes_deployed = false;
btc_log_hud = false;
btc_lifted = false;

_heli = vehicle player;

player removeAction btc_lift_action;
player removeAction btc_lift_action_hud;

if (count ropes _heli > 0) then {
	{ropeDestroy _x;} foreach ropes _heli;
};

_heli setVariable ["cargo",nil];
_heli setVariable ["rope",nil];