/* WIP
 * Author: Zorn
 * Spawns a Drone that travels to a certain position which will be returning back to base under other certain conditions.
 *
 * Arguments:
 * 0: _vehicleClass		<CLASS as STRING>																								ClassName of the desired Drone
 * 1: _start			<Position [0,0] or [0,0,0]> <OBJ> <Group> <Location> <STRING for Marker or var name of an object>				Reference for Spawn Position of Drone 
 * 2: _destination		<Position [0,0] or [0,0,0]> <OBJ> <Group> <Location> <STRING for Marker or var name of an object>				Reference for Desination Position. Drone will enter Loitering behavior at said Position
 * 3: _targetSide 		<Side> 																											Side of the Drone during Deployment, should be player's side so they can connect the UAV Terminal to it
 * 4: _travelSide 		<Side>																											Side of the Drone during Infil and Exfil, denying Control over UAV during said Period  																										
 *
 * Optional Arguments:
 *
 * 5: _transit			<Position [0,0] or [0,0,0]> <OBJ> <Group> <Location> <STRING for Marker or var name of an object> 			 	Additional Waypoint to Transit via
 * 6: _removeNV			<Bool>
 * 7: _removeTI			<Bool>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [_vehicleClass,_start,_destination,_targetSide,_travelSide,_transit,_removeNV,_removeTI] spawn cvo_support_fnc_spawnDrone;
 * ["rhs_pchela1t_vvs",[14073.1,21245.4,0],cvo_gaz66_radio,btc_player_side,independent,btc_gear_object,true,true] spawn cvo_support_fnc_spawnDrone;
 * 
 *
 * Public: maybe idfk
 *
 *
*/

diag_log format ["[CVO] [Support] (spawnDrone) - test 1: %1", _this];

// ###### Definition

if (!isServer) 	 exitWith {_this remoteExec ["cvo_Support_fnc_spawnDrone",2,true];};
if (!canSuspend) exitWith {_this spawn cvo_Support_fnc_spawnDrone;};


if (isNil "cvo_support_drones") then {cvo_support_drones = [0]};
//if ((count cvo_support_drones) > 0) then {};

// Definition
params [
	["_vehicleClass",	"",			[""]										], 
	["_startPos",		[0,0,0],	[[],objNull,grpNull,locationNull,""],[2,3]	], 
	["_destination",	[0,0,0], 	[[],objNull,grpNull,locationNull,""],[2,3]	], 
	["_targetSide",		sideEmpty,	[west]										], 
	["_travelSide",		sideEmpty,	[west]										],
	// Optionals
	["_transit",		[0,0,0],	[[],objNull,grpNull,locationNull,""],[2,3]	], 
	["_removeNV", 		false, 		[false]										],
	["_removeTI", 		false, 		[false]										]
];


_startPos		= _startPos		call BIS_fnc_position;
_transit 		= _transit 		call BIS_fnc_position;
_destination 	= _destination 	call BIS_fnc_position;


if (_vehicleClass isEqualTo "") 		exitWith {diag_log format ["[CVO] [Support] (spawnDrone) - Error: %1", "_vehicleClass not defined!"];};
if (_startPos isEqualTo [0,0,0]) 		exitWith {diag_log format ["[CVO] [Support] (spawnDrone) - Error: %1", "_startPos not defined!"];};
if (_destination isEqualTo [0,0,0]) 	exitWith {diag_log format ["[CVO] [Support] (spawnDrone) - Error: %1", "_destination not defined!"];};
if (_targetSide isEqualTo sideEmpty)	exitWith {diag_log format ["[CVO] [Support] (spawnDrone) - Error: %1", "_targetSide not defined!"];};


_direction = _startPos getDir _transit;

// ## spawn drone on Green
private _return = [_startPos, _direction, _vehicleClass, _travelSide] call BIS_fnc_spawnVehicle;

_id = (cvo_support_drones#0) + 1;

cvo_support_drones set [0, _id];


_return pushBack _id;
_return params ["_uav", "_crew", "_group", "_id"];

[[_targetSide, "HQ"], format["Be Advised, the UAV has been deployed and is heading towards %1 - HQ OUT", (mapGridPosition _destination)]] remoteExec ["sidechat"];

if (_removeNV) then {
	_uav disableNVGEquipment true;
	diag_log format ["[CVO] [Support] (spawnDrone) - UAV ID: %1 NightVision Disabled", _id];
};

if (_removeTI) then {
	_uav disableTIEquipment true;
	_uav setVariable ["A3TI_Disable", true];
	diag_log format ["[CVO] [Support] (spawnDrone) - UAV ID: %1 ThermalImaging Disabled", _id];
};

cvo_support_drones pushBack _return;
publicVariable "cvo_support_drones";

_return spawn {
	params ["_uav", "_crew", "_group", "_id", "_startPos", "_targetSide", "_travelSide"];
	waitUntil {sleep 5; not alive _uav};
	cvo_support_drones deleteAt (cvo_support_drones findIf {
		if (_x isEqualType []) then {
			_x#3 isEqualTo _id
			} else {false}
		});
	publicVariable "cvo_support_drones";
	diag_log format ["[CVO] [Support] (spawnDrone) - UAV ID: %1 has been removed from cvo_support_drones", _id];
};


_group deleteGroupWhenEmpty true;
_uav flyInHeight 500;
_uav setFuel random [0.6, 0.75, 0.9];

if (!(_transit isEqualto [0,0,0])) then {
	_wp1 = _group addWaypoint [_transit, 10];
	_wp1 setWaypointSpeed "LIMITED";
};
_wp2 = _group addWaypoint [_destination, 200];
_wp2 setWaypointSpeed "LIMITED";

waitUntil {Sleep 1; (_uav distance2D _destination) < 500};

// Create PlayerSite Group 
_targetSideGroup = createGroup [_targetSide, true];
_crew joinSilent _targetSideGroup;
_return set [2, _targetSideGroup];

[[_targetSide, "HQ"], format["Be Advised, the UAV has reached the Target Area - Control Transfered - HQ OUT", (mapGridPosition _destination)]] remoteExec ["sidechat"];

_wpLoiter = _targetSideGroup addWaypoint [_destination, 200];

_wpLoiter setWaypointType "LOITER";
_wpLoiter setWaypointLoiterRadius 500;
_wpLoiter setWaypointLoiterAltitude 500;

_return pushBack _startPos;
_return pushBack _targetSide;
_return pushBack _travelSide;

// ## spawns the Exit Code
_return spawn {
	params ["_uav", "_crew", "_group", "_id", "_startPos", "_targetSide", "_travelSide"];

	private _active = true;

	while {_active} do {
		sleep 15;

		if ((fuel _uav) < 0.5) then {
			[[_targetSide, "HQ"],"Be Advised, the UAV is running out of fuel and returning to base. - HQ OUT"] remoteExec ["sidechat"];
			_active = false;
		};

		if (selectMax (getAllHitPointsDamage _uav # 2 ) > 0.5) then {
			[[_targetSide, "HQ"], "Be Advised, the UAV has been damaged. Deployment aborted. - HQ OUT"] remoteExec ["sidechat"];
			_active = false;
		};

// Do I really need to check for UAV crew health?
//		if ((_crew findIf {(_x getVariable ["ace_medical_bloodVolume", 6]) > 5.5 }) >= 0) then {
//			[_targetSide, "HQ"] sideChat "Be Advised, the UAV is damaged and returning to base";
//			_active = false;
//		};

	};

	// ## Switch Sides, Return to Spawn, wait 30 and delete.
	_exitGroup = createGroup [_travelSide, true];
	_crew joinSilent _exitGroup;
	_return set [2, _exitGroup];
	_group = _exitGroup;
	sleep 5;
	_wp1 = _exitGroup addWaypoint [_startPos, 10];
	_wp1 setWaypointSpeed "FULL";
	_timeout = (serverTime + 600);
	waitUntil {Sleep 5; ((_uav distance2D _startPos) < 500) OR (serverTime > _timeout)};
	sleep 30;
	deleteVehicleCrew _uav; deleteVehicle _uav;
};

