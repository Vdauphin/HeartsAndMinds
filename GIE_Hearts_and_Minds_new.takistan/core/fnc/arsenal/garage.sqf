
/* ----------------------------------------------------------------------------
Function: btc_arsenal_fnc_garage

Description:
    Open virtual Arsenal garage on object position.

Parameters:
    _current_garage - Object where the vehicle from garage will spawn. [Object]

Returns:

Examples:
    (begin example)
        [btc_create_object_point] spawn btc_arsenal_fnc_garage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_current_garage", objNull, [objNull]]
];

if ([_current_garage] call btc_fnc_checkArea) exitWith {};

disableSerialization;
uiNamespace setVariable ["current_garage", _current_garage];
private _fullVersion = missionNamespace getVariable ["BIS_fnc_arsenal_fullGarage", false];
if !(isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])) exitwith {
    "Garage Viewer is already running" call bis_fnc_logFormat;
};
private _veh = createVehicle ["Land_HelipadEmpty_F", getPos _current_garage, [], 0, "CAN_COLLIDE"];
_veh setPosASL getPosASL _current_garage;
uiNamespace setVariable ["garage_pad", _veh];
missionNamespace setVariable ["BIS_fnc_arsenal_fullGarage", [true, 0, false, [false]] call BIS_fnc_param];
with missionNamespace do {BIS_fnc_garage_center = _veh};

with uiNamespace do {
    private _displayMission = [] call (uiNamespace getVariable "bis_fnc_displayMission");
    if !(isNull findDisplay 312) then {_displayMission = findDisplay 312;};
    _displayMission createDisplay "RscDisplayGarage";
    uiNamespace setVariable ["running_garage", true];
    waitUntil {sleep 0.25; isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])};
    private _logistic_point = uiNamespace getVariable "current_garage";
    private _pad = uiNamespace getVariable "garage_pad";
    deleteVehicle _pad;
    private _veh_list = _logistic_point nearEntities 5;
    {
        private _type = typeOf _x;
        private _pos = getPosASL _x;
        private _dir = getDir _current_garage;
        private _customization = [_x] call BIS_fnc_getVehicleCustomization;

        _x call CBA_fnc_deleteEntity;
        [_type, _pos, _dir, _customization] remoteExecCall ["btc_log_fnc_createVehicle", 2];
        [_type] remoteExecCall ["btc_veh_fnc_init", -2];
    } forEach _veh_list;
};
