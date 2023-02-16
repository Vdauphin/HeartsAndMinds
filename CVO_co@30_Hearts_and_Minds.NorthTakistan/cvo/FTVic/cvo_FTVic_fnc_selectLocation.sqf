/* ----------------------------------------------------------------------------
Function: Opens the Map for the player to choose a target to Fast Travel to.

Description:
    Draw Markers on the Map for valid Locations, 
	opens the Map for the Player, 
	provides Instructions, 
	adds eventHandler "onMapSingleClick",
	spawns watcher for 

Parameters:
	<_obj>				<obj>							   <obj to be teleported>

Returns:

Examples:
    (begin example)
        [player vehicle] spawn cvo_FTVic_fnc_selectLocation;
    (end)

Author:
    Zorn

---------------------------------------------------------------------------- */

params [
	["_obj", objNull, [objNull]]
];

// draws marker for the client that wants to fast travel
[([] + [btc_gear_object] + btc_fobs#1), cvo_FTVic_radius] call cvo_FTVic_fnc_drawMarker;
openMap [true, false];
["<t color='#FFFF00' size='1'>## Deploying with Vehicle ## <br /> Click on Destination</t> <br /> <t color='#ffa500' size='0.75'>Orange Circle </t>", -1, -1, 10, 1] spawn BIS_fnc_dynamicText;


cvo_FTVic_EHID = addMissionEventHandler ["MapSingleClick", 
	{
		params ["_units", "_pos", "_alt", "_shift"];
		private _obj = _thisArgs#0;
		

		if ([ _pos , cvo_FTVic_radius, (btc_fobs#1 + [btc_gear_object]) ] call cvo_FTVic_fnc_checkDistanceArray) then {

			removeMissionEventHandler ["MapSingleClick", _thisEventHandler];

			// terminates the "closed map watcher" and the variable
			terminate cvo_FTVic_handle_waitUntil;
			cvo_FTVic_EHID = nil;
			cvo_FTVic_handle_waitUntil = nil;


			openMap [false, false];

			[_obj, _pos, cvo_FTVic_radius] spawn cvo_FTVic_fnc_teleport;

		} else {

			["<t color='#ff0000' size='1'>## Invalid Location ## </t> <br /><t color='#ffa500' size='1'> Click on Destination</t> <br /> <t color='#ffa500' size='0.75'>Orange Circle </t>", -1, -1, 10, 1] spawn BIS_fnc_dynamicText;
		
		};
	},
	[_obj]
];

// Watcher to check if user closes the map to remove the MissionEventHandler

cvo_FTVic_handle_waitUntil = [] spawn {
	waitUntil {!visibleMap};
	removeMissionEventHandler ["MapSingleClick", cvo_FTVic_EHID];
	cvo_FTVic_EHID = nil;
	cvo_FTVic_handle_waitUntil = nil;
};