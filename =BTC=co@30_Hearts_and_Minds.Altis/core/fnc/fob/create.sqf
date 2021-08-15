
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_create

Description:
    Create user interface for FOB creation.

Parameters:
    _mat - Object "containing" the FOB. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fob_fnc_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_mat", objNull, [objNull]]
];

if (((position _mat) isFlatEmpty [1, 0, 0.9, 1, 0, false, _mat]) isEqualTo []) exitWith {(localize "STR_BTC_HAM_O_FOB_CREATE_H_AREA") call CBA_fnc_notify;};

if (_mat inArea [getMarkerPos "btc_base", btc_fob_minDistance, btc_fob_minDistance, 0, false]) exitWith {(localize "STR_BTC_HAM_O_FOB_CREATE_H_DBASE") call CBA_fnc_notify;};

if ((nearestObjects [position _mat, ["LandVehicle", "Air"], 10]) findIf {!(_x isKindOf "ace_fastroping_helper")} != -1) exitWith {
    (format [localize "STR_BTC_HAM_O_FOB_CREATE_H_CAREA", (nearestObjects [position _mat, ["LandVehicle", "Air"], 10]) apply {typeOf _x}]) call CBA_fnc_notify
};

closeDialog 0;

btc_fob_dlg = false;

createDialog "btc_fob_create";

waitUntil {dialog};

while {!btc_fob_dlg} do {
    if !(dialog) then {
        (localize "STR_BTC_HAM_O_FOB_CREATE_H_ESC") call CBA_fnc_notify;
        createDialog "btc_fob_create";
    };
    sleep 0.1;
};

if (ctrlText 777 == "") exitWith {
    closeDialog 0;
    (localize "STR_BTC_HAM_O_FOB_CREATE_H_NAME") call CBA_fnc_notify;
    _mat spawn btc_fob_fnc_create;
};

private _name = ctrlText 777;

private _FOB_name = "FOB " + _name;
private _name_to_check = toUpper _FOB_name;
private _array_markers = allMapMarkers apply {toUpper _x};

if (_name_to_check in _array_markers) exitWith {
    closeDialog 0;
    (localize "STR_BTC_HAM_O_FOB_CREATE_H_NAMENOTA") call CBA_fnc_notify;
    _mat spawn btc_fob_fnc_create;
};

(localize "STR_BTC_HAM_O_FOB_CREATE_H_WIP") call CBA_fnc_notify;

closeDialog 0;

[{
    params ["_mat", "_name"];

    if (isNull _mat) exitWith {};

    private _pos = getPosATL _mat;
    private _direction = getDir _mat;
    private _FOB_name = "FOB " + _name;

    deleteVehicle _mat;

    [_pos, _direction, _FOB_name] remoteExecCall ["btc_fob_fnc_create_s", 2];
    [7, _FOB_name] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];
}, [_mat, _name], 5] call CBA_fnc_waitAndExecute;
