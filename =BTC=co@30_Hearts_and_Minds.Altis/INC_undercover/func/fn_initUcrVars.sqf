/* ----------------------------------------------------------------------------
Function: initUcrVars

Description: Sets variables that are required by other scripts in Incon Undercover.

Parameters:
0: Unit - the first unit to run the Incon Undercover script <OBJECT>

Returns: Nil

Examples:

[player] call INCON_ucr_fnc_initUcrVars;

Author: Incontinentia
---------------------------------------------------------------------------- */

_this spawn {

	private ["_trespassMarkers","_highSecMarkers","_civilianVests","_civilianUniforms","_civilianBackpacks","_civFactions","_civPackArray","_incogVests","_incogUniforms","_highSecurityUniforms","_incogFactions"];

	params [["_unit",player]];

	#include "..\UCR_setup.sqf"

	diag_log "Incon Undercover initialising...";

	if (isNil "_asymEnySide") then {_asymEnySide = sideEmpty};

	if (isNil "_regEnySide") then {_asymEnySide = sideEmpty};

	if (_regEnySide == _asymEnySide) exitWith {

		diag_log "Incon Undercover: regular and asym enemy sides must be different, exiting.";
		systemChat "Incon Undercover: regular and asym enemy sides must be different, exiting.";
	};

	if ((_regEnySide != sideEmpty && {_asymEnySide != sideEmpty}) && {[_regEnySide, _asymEnySide] call BIS_fnc_sideIsEnemy}) then {

		diag_log "Incon Undercover: Enemy Incognito mode disabled - regular and asym enemy sides must be friendly to each other for Enemy Incognito mode to work.";
		systemChat "Incon Undercover: Enemy Incognito mode disabled - regular and asym enemy sides must be friendly to each other for Enemy Incognito mode to work.";
		_incogFactions = [];
	};

	if (side _unit == _regEnySide || {side _unit == _asymEnySide}) then {

		diag_log "Incon Undercover: undercover unit side different to enemy sides, switching.";
		systemChat "Incon Undercover: undercover unit side different to enemy sides, switching.";
	};

	sleep 0.2;

	missionNamespace setVariable ["INC_regEnySide",_regEnySide,true];
	missionNamespace setVariable ["INC_asymEnySide",_asymEnySide,true];
	missionNamespace setVariable ["INC_civilianRecruitEnabled",_civRecruitEnabled,true];
	sleep 0.1;
	missionNamespace setVariable ["INC_incogIdentities",(["possibleIdentities",_incogFactions] call INCON_ucr_fnc_getConfigInfo),true];
	sleep 0.1;
	missionNamespace setVariable ["INC_civIdentities",(["possibleIdentities",_civFactions] call INCON_ucr_fnc_getConfigInfo),true];
	sleep 0.1;

	if (_debug) then {
		diag_log format ["Incon undercover variable INC_regEnySide: %1", INC_regEnySide ];
		diag_log format ["Incon undercover variable INC_asymEnySide: %1", INC_asymEnySide ];
		diag_log format ["Incon undercover variable INC_civilianRecruitEnabled: %1", INC_civilianRecruitEnabled];
		diag_log format ["Incon undercover variable INC_incogIdentities: %1", INC_incogIdentities ];
		diag_log format ["Incon undercover variable INC_civIdentities: %1", INC_civIdentities ];
	};

	//Initial stuff
	_civVests = _civilianVests + [""] + (["vests",_civFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_civUniforms = _civilianUniforms + [""] + (["uniforms",_civFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_civHeadgear = _civilianHeadgear + [""] + (["headgear",_civFactions] call INCON_ucr_fnc_getConfigInfo) + (["possibleHeadgear",_civFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_civPacks = _civilianBackpacks +  [""] + _civPackArray;
	sleep 0.1;
	_civVeh =  ([[_civFactions],"getFacVehs"] call INCON_ucr_fnc_ucrMain) + _civilianVehicleArray;
	sleep 0.1;

	missionNamespace setVariable ["INC_civilianVests",_civVests,true];
	missionNamespace setVariable ["INC_civilianUniforms",_civUniforms,true];
	missionNamespace setVariable ["INC_civilianHeadgear",_civHeadgear,true];
	sleep 0.1;
	missionNamespace setVariable ["INC_civilianBackpacks",_civPacks,true];
	missionNamespace setVariable ["INC_civilianVehicleArray",_civVeh,true];
	sleep 0.1;

	if (_debug) then {
		diag_log format ["Incon undercover variable INC_civilianVests: %1", INC_civilianVests ];
		diag_log format ["Incon undercover variable INC_civilianUniforms: %1", INC_civilianUniforms ];
		diag_log format ["Incon undercover variable INC_civilianHeadgear: %1", INC_civilianHeadgear ];
		diag_log format ["Incon undercover variable INC_civilianBackpacks: %1", INC_civilianBackpacks ];
		diag_log format ["Incon undercover variable INC_civilianVehicleArray: %1",INC_civilianVehicleArray  ];
	};

	sleep 0.5;

	_incogVests =  _incognitoVests + [""] + (["vests",_incogFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_incogUniforms = _incognitoUniforms + _highSecurityUniforms + (["uniforms",_incogFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_incogHeadgear = _incognitoHeadgear + [""] + (["headgear",_incogFactions] call INCON_ucr_fnc_getConfigInfo) + (["possibleHeadgear",_incogFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_incogBackpacks =  _incognitoBackpacks +  [""] + (["backpacks",_incogFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_incogWpns = [""] + (["weapons",_incogFactions] call INCON_ucr_fnc_getConfigInfo);
	sleep 0.1;
	_incogVeh = ([[_incogFactions],"getFacVehs"] call INCON_ucr_fnc_ucrMain) + _incogVehArray + _highSecVehicles;
	sleep 0.1;
	missionNamespace setVariable ["INC_incogVests",_incogVests,true];
	missionNamespace setVariable ["INC_incogUniforms",(_incogUniforms - [""]),true];
	missionNamespace setVariable ["INC_highSecUniforms",_highSecurityUniforms,true];
	missionNamespace setVariable ["INC_highSecItems",(_highSecItems + [""]),true];
	missionNamespace setVariable ["INC_incogHeadgear",_incogHeadgear,true];
	missionNamespace setVariable ["INC_incogBackpacks",_incogBackpacks,true];
	missionNamespace setVariable ["INC_incogVehArray",_incogVeh,true];
	missionNamespace setVariable ["INC_incogHighSecVeh",_highSecVehicles,true];
	missionNamespace setVariable ["INC_incogWpns",_incogWpns,true];

	sleep 0.2;

	if (_debug) then {
		diag_log format ["Incon undercover variable INC_incogVests: %1", INC_incogVests ];
		diag_log format ["Incon undercover variable INC_incogUniforms: %1", INC_incogUniforms ];
		diag_log format ["Incon undercover variable INC_highSecUniforms: %1", INC_highSecUniforms ];
		diag_log format ["Incon undercover variable INC_highSecItems: %1", INC_highSecItems ];
		diag_log format ["Incon undercover variable INC_incogHeadgear: %1", INC_incogHeadgear ];
		diag_log format ["Incon undercover variable INC_incogBackpacks: %1", INC_incogBackpacks ];
		diag_log format ["Incon undercover variable INC_incogVehArray: %1", INC_incogVehArray ];
		diag_log format ["Incon undercover variable INC_incogHighSecVeh: %1", INC_incogHighSecVeh ];
		diag_log format ["Incon undercover variable INC_incogWpns: %1", INC_incogWpns ];
	};

	sleep 0.5;

	missionNamespace setVariable ["INC_sunrise",((date call BIS_fnc_sunriseSunsetTime) select 0),true];
	missionNamespace setVariable ["INC_sunset",((date call BIS_fnc_sunriseSunsetTime) select 1),true];

	if (_debug) then {
		diag_log format ["Incon undercover variable INC_sunrise: %1", INC_sunrise ];
		diag_log format ["Incon undercover variable INC_sunset: %1", INC_sunset ];
	};

	_daylightDuration = INC_sunset - INC_sunrise;
	_lightFactor = _daylightDuration / 12;

	missionNamespace setVariable ["INC_firstLight",(INC_sunrise - _lightFactor),true];
	missionNamespace setVariable ["INC_lastLight",(INC_sunset + _lightFactor),true];

	if (_debug) then {
		diag_log format ["Incon undercover variable INC_firstLight: %1",INC_firstLight  ];
		diag_log format ["Incon undercover variable INC_lastLight: %1",INC_lastLight  ];
	};

	sleep 0.2;

	if ((count (missionNamespace getVariable ["INC_trespassMarkers",[]])) == 0) then {
		//Find trespass markers
		{

		    _trespassMarkers pushBack _x;

		} forEach (allMapMarkers select {
		    ((_x find "INC_tre") >= 0)
		});

		{

		    _highSecMarkers pushBack _x;

		} forEach (allMapMarkers select {
		    ((_x find "INC_highSec") >= 0)
		});

		{_trespassMarkers pushBack _x} forEach _highSecMarkers;

		{_x setMarkerAlpha 0} forEach _trespassMarkers;

		missionNamespace setVariable ["INC_trespassMarkers",_trespassMarkers,true];
		missionNamespace setVariable ["INC_highSecMarkers",_highSecMarkers,true];
		missionNamespace setVariable ["INC_highSecCheckActive",!(count _highSecMarkers == 0),true];

		if (_debug) then {
			diag_log format ["Incon undercover variable INC_trespassMarkers: %1", INC_trespassMarkers ];
			diag_log format ["Incon undercover variable INC_highSecMarkers: %1", INC_highSecMarkers ];
			diag_log format ["Incon undercover high security check active: %1", !(count _highSecMarkers == 0) ];
		};
	};

	sleep 0.5;

	//Spawn the rebel commader
	[_unit,"spawnRebelCommander"] remoteExecCall ["INCON_ucr_fnc_ucrMain",2];

	missionNamespace setVariable ["INC_ucrInitComplete",true,true];

	diag_log "Incon Undercover init complete.";

	_incogWpnsFinal = _incogWpns;

	{
		_incogWpnsFinal pushBackUnique ([_x] call BIS_fnc_baseWeapon);
		sleep 0.1;
	} forEach _incogWpns;

	missionNamespace setVariable ["INC_incogWpns",_incogWpnsFinal,true];
};
