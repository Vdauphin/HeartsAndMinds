
closeDialog 0;

btc_log_create_obj = _this select 0;

if (count (nearestObjects [getpos btc_log_create_obj,["All"],5]) > 1) exitWith {hint "Clear the area before create another object!"};

disableSerialization;
closeDialog 0;
createDialog "btc_log_dlg_create";

waitUntil {dialog};

call btc_fnc_log_create_load;

//_class = lbText [72,lbCurSel 72];
_class = lbData [72, lbCurSel 72];
_selected = _class;
_new = _class createVehicleLocal [getpos btc_log_create_obj select 0,getpos btc_log_create_obj select 1,0];
while {dialog} do
{
	//if (_class != lbData [72, 1]) then
	if (_class != lbData [72, lbCurSel 72]) then
	{
		deleteVehicle _new; sleep 0.1;
		_class = lbData [72, lbCurSel 72];
		//_class = lbText [72,lbCurSel 72];
		_selected = _class;
		_new = _class createVehicleLocal [getpos btc_log_create_obj select 0,getpos btc_log_create_obj select 1,0];
		_new setDir (getDir btc_log_create_obj);
		_new setPos [getpos btc_log_create_obj select 0,getpos btc_log_create_obj select 1,0];
	};
	sleep 0.1;
};
deleteVehicle _new;
