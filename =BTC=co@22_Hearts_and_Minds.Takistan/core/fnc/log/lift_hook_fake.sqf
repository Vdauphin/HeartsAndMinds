btc_lifted = true;

_this attachTo [vehicle player,[0,0,-10]];

btc_lift_action_unhook_fake = player addAction [("<t color=""#ED2744"">" + ("UnHook") + "</t>"),{btc_lifted = false;}, [], 9, true, false, "", "true"];

waitUntil {sleep 1; (!btc_lifted || !Alive player || isNull _this || vehicle player == player)};

detach _this;
player removeAction btc_lift_action_unhook_fake;