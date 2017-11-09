
private ["_bbr","_c"];

btc_log_placing_obj = _this;

[btc_log_placing_obj,player] remoteExec ["btc_fnc_set_owner", 2];

hint composeText [
	(localize "STR_BTC_HAM_LOG_PLACE_HINT1"), //Q/Z to raise/lower the object
	lineBreak,
	(localize "STR_BTC_HAM_LOG_PLACE_HINT2"), //X/C to rotate the object
	lineBreak,
	(localize "STR_BTC_HAM_LOG_PLACE_HINT3") //X/C to rotate the object
];

btc_log_placing = true;
btc_log_placing_dir = 180;
btc_log_release = player addAction [("<t color=""#ED2744"">" + (localize "STR_BTC_HAM_LOG_PLACE_RELEASE") + "</t>"),{btc_log_placing = false;}, [], 9, true, false, "", "true"]; //Release
btc_log_place_EH_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", btc_fnc_log_place_key_down];

[player] call ace_weaponselect_fnc_putWeaponAway;
player forceWalk true;

btc_log_placing_obj enableSimulation false;

_bbr = boundingBoxReal btc_log_placing_obj;
_c = boundingCenter btc_log_placing_obj;

btc_log_placing_h = (abs ((_bbr select 0) select 2)) - (_c select 2);
btc_log_placing_d = 1.5 + (abs (((_bbr select 1) select 1) - ((_bbr select 0) select 1)));

btc_log_placing_obj attachTo [player,[0,(btc_log_placing_d),btc_log_placing_h]];
btc_log_placing_obj setDir btc_log_placing_dir;

waitUntil {!alive player || player getVariable ["ACE_isUnconscious",false] || !btc_log_placing};

btc_log_placing_obj enableSimulation true;
detach btc_log_placing_obj;
player forceWalk false;

btc_log_placing_obj = objNull;
(findDisplay 46) displayRemoveEventHandler ["KeyDown",btc_log_place_EH_keydown];
player removeAction btc_log_release;
hintSilent "";
