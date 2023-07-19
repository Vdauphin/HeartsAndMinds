/* ----------------------------------------------------------------------------
Function: Fast Travel with Vehicle for Driver

Description:
    Takes the input position and teleports the player's vehicle to a random Road Segment within given radius.


Parameters:
	<_obj>				<obj>							   <obj's vehicle to be teleported>
    <_pos>              <Array [x,y] or [x,y,z]>           <position given by player input>
	<_radius>         	<number>                           <radius in meters>

Returns:
	boolean

Examples:
    (begin example)
        [_obj, [0,0], 100] spawn cvo_FTVic_fnc_teleport;
    (end)

Author:
    Zorn

---------------------------------------------------------------------------- */


if (!canSuspend) exitWith {_this spawn cvo_FTVic_fnc_teleport};
if (!hasInterface) exitWith {};

params [
	["_obj", 		objNull, 	[objNull]			],
	["_pos", 		[0,0], 		[[]], 		[2,3]	],
	["_radius", 	50, 		[0]					]
];

private _startPos = getPos _obj;

if (_obj isEqualTo (vehicle player)) then {	disableUserInput true;	};

// insert Screen Effect fadeIn Black + Text about fast travelling


/* WIP: Execute "cutscene" for anyone in teleporting vehicle.
_players = call BIS_fnc_listPlayers;

{
	if (vehicle _x isEqualTo _obj) then {

	};	
} forEach _players;
*/

_obj setVelocity [0,0,0];

[0, "BLACK", 5, 1] spawn BIS_fnc_fadeEffect;

sleep 2;

["<t color='#ff0000' size='1'>You're deploying to your destination </t>", -1, -1, 18, 3] spawn BIS_fnc_dynamicText;

// wait x amount of time
sleep 15;

// Find Road and Teleport

_roadSegmentArray = (_pos nearRoads _radius);

while {(count _roadSegmentArray) isEqualTo 0} do {

	// Increases Radius if no roadSegment found
	if (_radius > 100) then {_radius = _radius + 10; } else { _radius = _radius + 100; };

	_roadSegmentArray = (_pos nearRoads _radius);

};

private ["_roadSegment","_roadInfo"];

while {true} do {
	_roadSegment = selectRandom _roadSegmentArray;
	_roadInfo = getRoadInfo _roadSegment; 
	if (_roadInfo#2) then { continue };
	if (_roadInfo#8) then { continue };
	if (! (_roadInfo#0 in ["TRACK", "ROAD", "MAIN ROAD"])  ) then  { continue };
	break;
};

_width = (_roadInfo#1) / 3;
_dir = _roadInfo#6 getDir _roadInfo#7;
_obj allowDamage false;

_obj setFuel ((fuel _obj) -0.1);

_obj setDir _dir;
_obj setVehiclePosition [(getPos _roadSegment), [], _width, "NONE"];
sleep 3;
disableUserInput false;
sleep 3;
_obj allowDamage true;
// Fade Out
[1, "BLACK", 5, 1] spawn BIS_fnc_fadeEffect;
