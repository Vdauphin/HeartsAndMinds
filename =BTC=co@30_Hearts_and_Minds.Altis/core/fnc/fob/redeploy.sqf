/*
mapAnimAdd [1, 0.2, [0,0]]; mapAnimCommit;*/

private ["_fobs","_idc","_fob","_marker","_pos","_text"];

closeDialog 0;

btc_int_ask_data = nil;

[6,nil,player] remoteExec ["btc_fnc_int_ask_var", 2];

waitUntil {!(isNil "btc_int_ask_data")};

if (count (btc_int_ask_data select 0) == 0) exitWith {hint (localize "STR_BTC_HAM_O_FOB_REDEPLOY_H_NOFOB");}; //"No FOBs deployed"

_fobs = btc_int_ask_data;

forceMap true;

btc_fob_dlg = false;

createDialog "btc_fob_redeploy";

waitUntil {dialog};

_idc = 778;

{lbAdd [ _idc, _x];} foreach (_fobs select 0);

lbSetCurSel [_idc, 0];
/*
while {!btc_fob_dlg} do {
	if !(dialog) then {hint "Do not close the dialog with esc";createDialog "btc_fob_redeploy";{_index = lbAdd [ _idc, _x ];} foreach _fobs;lbSetCurSel [_idc, 0];};
	sleep 0.1;
};*/

waitUntil {!dialog || btc_fob_dlg};

if (!btc_fob_dlg) exitWith {forceMap false;};

_fob = lbText [_idc, lbCurSel _idc];

_marker = lbText [_idc, lbCurSel _idc];

if (_marker == "Base") then {_marker = btc_respawn_marker;};

forceMap false;

closeDialog 0;

_pos = ((_fobs select 1) select ((_fobs select 0) find _marker)) buildingPos -1;

_text = format [(localize "STR_BTC_HAM_O_FOB_REDEPLOY_H_MOVING"),_fob]; //"Moving to %1"

titleText [_text, "BLACK OUT"];
sleep 3;
titleText [_text, "BLACK FADED"];
player setPosATL selectRandom (_pos select [0, [count _pos,4] select (count _pos >= 4)]);
sleep 2;
titleText ["", "BLACK IN"];
