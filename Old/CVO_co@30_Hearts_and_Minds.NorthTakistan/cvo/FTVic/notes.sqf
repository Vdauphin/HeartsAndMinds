/*

btc_fobs = [["My FOB","My FOB 2"],[27975b24100# 1173377: mast_f.p3d,2797620f580# 1174030: mast_f.p3d],[bis_o3,bis_o4]];
btc_fobs#1

_locInput = [btc_gear_object];
_locInput append btc_fobs#1;
*/

create ACE Player Self Intaction



Teleport action = 
x		Condition =	If player in vehicle && driver seat && within 200m of FOB/BASE;

		code = 
x			1. = Draw marker on map (clientsite) around FOBS and BASE. Range 200m.										==> Function cvo_FTVic_drawMarker. Input: [[array of locations], range, [array of marker settings]];
x			2. = Open Map for client.
x			3. = HINT / MSG / Instruction to the client. "Click on a spot within the area around the base / FOB"
			4. Take player input click.
x			5. Check if within range of FOBS / base. 
						If yes => setPos player vehicle player input.
						If no  => Remove Markers, Close Map, HINT "Invalid coordinate", cancel process.

Plan of action:

x 1. Do the marker function (how to delete?)
x 2. Do the condition (to be defined in init.sqf)


// Debug Loop to get "safe" teleport Function

_targetObj = vehicle player;
_radius = 200;

_roadSegmentArray = (_targetObj nearRoads _radius);

while {(count _roadSegmentArray) isEqualTo 0} do {

if (count _roadSegmentArray isEqualTo 0) then { 
	_radius = _radius + 100; 
	_roadSegmentArray = (_targetObj nearRoads _radius);
};

_roadSegmentArray = (_targetObj nearRoads _radius);

_roadSegment = selectRandom _roadSegmentArray;
_roadInfo = getRoadInfo _roadSegment; 

if (_roadInfo#2) then { continue };
if (_roadInfo#8) then { continue };
if (! (_roadInfo#0 in ["TRACK", "ROAD", "MAIN ROAD"])  ) then  { continue };
_width = (_roadInfo#1) / 3;
_dir = _roadInfo#6 getDir _roadInfo#7;
_targetObj allowDamage false;
_targetObj setDir _dir;
_targetObj setVehiclePosition [(getPos _roadSegment), [], _width, "NONE"];
sleep 5;
_targetObj allowDamage true;





// Open map, provide text hint,









//////////////////////

cvo_eh_mapOpen = addMissionEventHandler ["Map", {

	params ["_mapIsOpened", "_mapIsForced"];

	if (_mapIsOpened) then
	{
		systemChat "GPS active";
		J_var_GPSOn = true;

		// no sheduled environment -> create one
		/* Triggered when map is opened or closed either by user action or script command openMap. */
		[] spawn {
		waitUntil {
			// ... // do something as long as map is open
			not J_var_GPSOn
		};
		};
	} else {
		J_var_GPSOn = false;
		systemChat "GPS inactive";
	};
}];