
if (isServer) exitWith {
	[str(_this), "SUCCEEDED",false] spawn BIS_fnc_taskSetState;
	if (_this isEqualTo 1) then {[2] call btc_fnc_task_create};
};

private ["_description"];

switch _this do
{
	case 0 : {
		_description = [(localize "STR_BTC_HAM_MISSION_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_MISSION_DEFEAT_WIN_TEXT")]; //"Mission accomplished!","Oplitas have been finally defeated!    Mission accomplished!"
	};
	case 1 : {
		_description = [(localize "STR_BTC_HAM_MISSION_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_MISSION_DESTORY_WIN_TEXT")]; //"Mission accomplished!","All the hideouts have been destroyed!"
	};
	case 2 : {
		_description = [(localize "STR_BTC_HAM_MISSION_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_MISSION_DEFEAT_WIN_TEXT")]; //"Mission accomplished!","Oplitas have been finally defeated!    Mission accomplished!"
	};
	case 3 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_SUPPLIES_WIN_TEXT")]; //"Side mission Accomplished!","Supplies have been delivered"
	};
	case 4 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_MINES_WIN_TEXT")]; //"Side mission Accomplished!","The minefield has been cleared"
	};
	case 5 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_VEHICLE_WIN_TEXT")]; //"Side mission Accomplished!","The vehicle has been repaired"
	};
	case 6 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CONQUER_WIN_TEXT")]; //"Side mission Accomplished!","The city has been cleared!"
	};
	case 7 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_TOWER_WIN_TEXT")]; //"Side mission Accomplished!","The tower has been destroyed!"
	};
	case 8 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CIVTREAT_WIN_TEXT")]; //"Side mission Accomplished!","The civilian has been stabilized!"
	};
	case 9 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CHECKPOINT_WIN_TEXT")]; //"Side mission Accomplished!","Checkpoints have been destroyed!"
	};
	case 10 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CIVTREATBOAT_WIN_TEXT")]; //"Side mission Accomplished!","The civilian has been stabilized!"
	};
	case 11 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_UNDERWATER_WIN_TEXT")]; //"Side mission Accomplished!","The underwater generator has been destroyed!"
	};
	case 12 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CONVOY_WIN_TEXT")]; //"Side mission Accomplished!","The armed convoy has been destroyed!"
	};
	case 13 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_RESC_WIN_TEXT")]; //"Side mission Accomplished!","The pilot has been rescued!"
	};
	case 14 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_CAPOFF_WIN_TEXT")]; //"Side mission Accomplished!","The officer has been captured!"
	};
	case 15 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_HOSTAGE_WIN_TEXT")]; //"Side mission Accomplished!","The hostage has been liberated!"
	};
	case 16 : {
		_description = [(localize "STR_BTC_HAM_SIDE_BASIC_WIN_TITLE"),(localize "STR_BTC_HAM_SIDE_HACK_WIN_TEXT")]; //"Side mission Accomplished!","The missile has been hacked!"
	};
};
["task" + "SUCCEEDED" + "Icon",[[[str(_this)] call BIS_fnc_taskType] call bis_fnc_taskTypeIcon, _description select 1]] call bis_fnc_showNotification;
