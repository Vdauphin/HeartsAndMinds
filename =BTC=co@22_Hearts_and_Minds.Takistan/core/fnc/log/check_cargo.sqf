
private ["_veh","_cargo","_text","_ui"];

_veh = _this;

if (isNull _veh) exitWith {};

btc_log_veh_selected = _veh;

btc_int_ask_data = nil;
[[3,_veh,player],"btc_fnc_int_ask_var",false] spawn BIS_fnc_MP;

waitUntil {!(isNil "btc_int_ask_data")};
closeDialog 0;
disableSerialization;
createDialog "btc_log_dlg";

waitUntil {Dialog};

_ui = uiNamespace getVariable "btc_log_dlg";

//player setVariable ["btc_int_busy",true];

_cargo = btc_int_ask_data;
_text = ("Vehicle: " + getText (configFile >> "cfgVehicles" >> typeof _veh >> "displayName") + format ["  CC: %1/%2",[_veh,_cargo] call btc_fnc_log_check_cc,[_veh] call btc_fnc_log_get_cc]);

(_ui displayCtrl 990) ctrlSetText _text;
	
{
	private ["_index","_displayName"];
	_displayName = getText (configFile >> "cfgVehicles" >> typeof _x >> "displayName");
	_index = lbAdd [ 991, _displayName ];
	lbSetData [ 991, _index, typeOf _x ];
	lbSetTooltip [ 991, _index, _displayName ];	
} foreach _cargo;

lbSetCurSel [ 991, 0 ];

waitUntil {!Dialog};

//player setVariable ["btc_int_busy",false];
btc_log_veh_selected = objNull;