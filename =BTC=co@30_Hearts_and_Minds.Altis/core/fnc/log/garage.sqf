
if (count (nearestObjects [_this select 0,["All"],5]) > 1) exitWith {hint (localize "STR_BTC_HAM_LOG_BASICS_CLEARAREA")}; //Clear the area before create another object!

disableSerialization;
uiNamespace setVariable [ "current_garage", ( _this select 0 ) ];
private _fullVersion = missionNamespace getVariable [ "BIS_fnc_arsenal_fullGarage", false ];
if !( isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) ) exitwith { "Garage Viewer is already running" call bis_fnc_logFormat; };
private _veh = createVehicle [ "Land_HelipadEmpty_F", getPos ( _this select 0 ), [], 0, "CAN_COLLIDE" ];
_veh setPosASL getPosASL ( _this select 0 );
uiNamespace setVariable [ "garage_pad", _veh ];
missionNamespace setVariable [ "BIS_fnc_arsenal_fullGarage", [ true, 0, false, [ false ] ] call bis_fnc_param ];
with missionNamespace do { BIS_fnc_garage_center = _veh };
with uiNamespace do {
	private _displayMission = [] call ( uiNamespace getVariable "bis_fnc_displayMission" );
	if !( isNull findDisplay 312 ) then { _displayMission = findDisplay 312; };
	_displayMission createDisplay "RscDisplayGarage";
	uiNamespace setVariable [ "running_garage", true ];
	waitUntil { sleep 0.25; isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) };
	private _logistic_point = uiNamespace getVariable "current_garage";
	private _pad = uiNamespace getVariable "garage_pad";
	deleteVehicle _pad;
	private _veh_list = _logistic_point nearEntities 5;
	{
		{deleteVehicle _x;} forEach crew _x;

		private _type = typeOf _x;
		private _pos = getPosASL _x;
		private _dir = getDir _x;
		private _textures = getObjectTextures _x;
		deleteVehicle _x;
		[_type, _pos, _dir, _textures] remoteExec ["btc_fnc_log_createVehicle", 2];
		[_type] remoteExec ["btc_fnc_eh_veh_init", -2];
	} forEach _veh_list;
};
