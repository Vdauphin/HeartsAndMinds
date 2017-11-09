
private ["_new","_class","_selected"];

closeDialog 0;

btc_log_create_obj = _this select 0;

if ({!((_x isKindOf "Animal") || (_x isKindOf "Module_F") || (_x isKindOf "WeaponHolder"))} count (nearestObjects [btc_log_create_obj,["All"],5]) > 1) exitWith {hint (localize "STR_BTC_HAM_LOG_BASICS_CLEARAREA")}; //Clear the area before create another object!

disableSerialization;
closeDialog 0;
createDialog "btc_log_dlg_create";

waitUntil {dialog};

call btc_fnc_log_create_load;

//_class = lbText [72,lbCurSel 72];
_class = lbData [72, lbCurSel 72];
_selected = _class;
if (getText (configFile >> "cfgVehicles" >> _selected >> "displayName") isEqualTo "") then {
	_new = "Box_NATO_Ammo_F" createVehicleLocal getPosASL btc_log_create_obj;
} else {
	_new = _class createVehicleLocal getPosASL btc_log_create_obj;
};
while {dialog} do
{
	//if (_class != lbData [72, 1]) then
	if (_class != lbData [72, lbCurSel 72]) then
	{
		deleteVehicle _new; sleep 0.1;
		_class = lbData [72, lbCurSel 72];
		//_class = lbText [72,lbCurSel 72];
		_selected = _class;
		if (getText (configFile >> "cfgVehicles" >> _selected >> "displayName") isEqualTo "") then {
			_new = "Box_NATO_Ammo_F" createVehicleLocal getPosASL btc_log_create_obj;
		} else {
			_new = _class createVehicleLocal getPosASL btc_log_create_obj;
		};
		_new setDir (getDir btc_log_create_obj);
		_new setPosASL getPosASL btc_log_create_obj;
	};
	sleep 0.1;
};
deleteVehicle _new;
