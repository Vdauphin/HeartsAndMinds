
if (count ((position _this) isflatempty [1,0,0.9,1,0,false,_this]) == 0) exitWith {hint "Area is not flat enough!"};

if (_this distance (getMarkerPos "btc_base") < 2000) exitWith {hint "Too close at the main base!"};

if (count (nearestObjects [position _this, ["LandVehicle","Air"], 10]) > 0) exitWith {hint "Clear the area before mounting the FOB";hint str((nearestObjects [position _this, ["LandVehicle","Air"], 10]));};

closeDialog 0;

_mat = _this;

btc_fob_dlg = false;

createDialog "btc_fob_create";

waitUntil {dialog};

while {!btc_fob_dlg} do
{
	if !(dialog) then {hint "Do not close the dialog with esc";createDialog "btc_fob_create";};
	sleep 0.1;
};

if (ctrlText 777 == "") exitWith {closeDialog 0;hint "Name your FOB!";_mat spawn btc_fnc_fob_create;};

_name = ctrlText 777;

_name_to_check = ("FOB " + (toUpper(_name)));
_array_markers = [];
{private "_n";_n = toUpper(_x);_array_markers = _array_markers + [_n];} foreach allMapMarkers;

if (_array_markers find _name_to_check >= 0) exitWith {closeDialog 0;hint "Name already in use!";_mat spawn btc_fnc_fob_create;};

hint "Get back! Mounting FOB";

closeDialog 0;

[[_mat,_name],"btc_fnc_fob_create_s",false] spawn BIS_fnc_MP;