
private ["_veh","_cargo","_text","_ui"];

_veh = _this;

if (isNull _veh) exitWith {};

btc_log_veh_selected = _veh;

btc_int_ask_data = nil;
[3,_veh,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};
closeDialog 0;
disableSerialization;
createDialog "btc_log_dlg";

waitUntil {Dialog};

_ui = uiNamespace getVariable "btc_log_dlg";

//player setVariable ["btc_int_busy",true];

_cargo = btc_int_ask_data;
_text = format [(localize "STR_BTC_HAM_LOG_CHECKC_VEHICLE"),(getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName")),[_veh,_cargo] call btc_fnc_log_check_cc,[_veh] call btc_fnc_log_get_cc]; //Vehicle: %1  | CC: %2/%3

(_ui displayCtrl 990) ctrlSetText _text;

{
	private ["_index","_displayName"];
	_displayName = getText (configFile >> "cfgVehicles" >> typeof _x >> "displayName");
	if (_displayName isEqualTo "ace_rearm_dummy_obj") then {_displayName = getText (configfile >> "CfgMagazines" >> (_x getVariable "ace_rearm_magazineClass") >> "displayName");
	};
	_index = lbAdd [ 991, _displayName ];
	lbSetData [ 991, _index, typeOf _x ];
	lbSetTooltip [ 991, _index, _displayName ];
} foreach _cargo;

lbSetCurSel [ 991, 0 ];

waitUntil {!Dialog};

//player setVariable ["btc_int_busy",false];
btc_log_veh_selected = objNull;
