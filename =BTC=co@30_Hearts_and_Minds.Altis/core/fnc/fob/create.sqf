
private ["_mat","_name","_array_markers","_name_to_check"];

// "Area is not flat enough!"
if (count ((position _this) isflatempty [1,0,0.9,1,0,false,_this]) == 0) exitWith {hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_AREA");};

//"Too close at the main base!"
if (_this distance (getMarkerPos "btc_base") < 2000) exitWith {hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_DBASE");};

//"Clear the area before mounting the FOB, %1"
if ({!(_x isKindOf "ace_fastroping_helper")} count (nearestObjects [position _this, ["LandVehicle","Air"], 10]) > 0) exitWith {
	hint format [(localize "STR_BTC_HAM_O_FOB_CREATE_H_CAREA"), (nearestObjects [position _this, ["LandVehicle","Air"], 10]) apply {typeof _x}]
};

closeDialog 0;

_mat = _this;

btc_fob_dlg = false;

createDialog "btc_fob_create";

waitUntil {dialog};

while {!btc_fob_dlg} do
{
	if !(dialog) then {
			hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_ESC"); //"Do not close the dialog with esc"
			createDialog "btc_fob_create";
	};
	sleep 0.1;
};

if (ctrlText 777 == "") exitWith {
	closeDialog 0;
	hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_NAME"); // "Name your FOB!"
	_mat spawn btc_fnc_fob_create;
};

_name = ctrlText 777;

_name_to_check = ("FOB " + (toUpper(_name)));
_array_markers = [];
{private "_n";_n = toUpper(_x);_array_markers pushBack _n;} foreach allMapMarkers;

if (_array_markers find _name_to_check >= 0) exitWith {
	closeDialog 0;
	hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_NAMENOTA"); //"Name already in use!"
	_mat spawn btc_fnc_fob_create;
};

hint (localize "STR_BTC_HAM_O_FOB_CREATE_H_WIP");//"Get back! Mounting FOB"

closeDialog 0;

[_mat,_name] remoteExec ["btc_fnc_fob_create_s", 2];
