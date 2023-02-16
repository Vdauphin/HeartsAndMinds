/* WIP
 * Author: Zorn
 * Creates local Area Markers.
 *
 * Arguments:
 * 0: <_locInput> 	< ARRAY of: <Objects> or <Positions ([x,y] or [x,y,z]> > List of positions where the markers will be drawn
 * 1: <_radus> 		< number > - Radius in meters for the Markers
 * 
 * Return Value:
 * _markerArray - Array of Markers (for later deletion for example)
 *
 * Example:
 * [(btc_fobs#1 + [btc_gear_object]), 100] call cvo_FTVic_fnc_drawMarker;
 * 
 *
 * Public: maybe idfk
 *
 *
 */


params [
	["_locInput", [], [[]]],
	["_radius", 100, [0]]
];

if (count _locInput == 0) exitWith {};

private _markerArray 	= [];
private _locations 		= [];


// Check _locInput if objects or positions, if objects, getPos in 2D format.
// Create sanitsed _locations array = [[x,y], [x,y]];

{
	if (_x isEqualType objNull) then {
		_pos3D = getPos _x;
		_locations pushBack [_pos3D#0, _pos3D#1];
	};

	if (_x isEqualType []) then {
		if (count _x == 2) then {	_locations pushBack _x;			};
		if (count _x == 3) then {	_locations pushBack [_x#0,_x#1];	};
	};

} forEach _locInput;

// drawing of Markers + creation of aray _markerArray
{
	_i = _forEachIndex;
	_name = "FTVic_Area_" + (str _i);
	_position = _locations select _i;
	_markerArray pushBack (createMarkerLocal [_name,_position]);
	_name setMarkerSizeLocal [_radius, _radius];
	_name setMarkerShapeLocal "ELLIPSE";
	_name setMarkerBrushLocal "Solid"; 
	_name setMarkerColorLocal "ColorOrange";
	_name setMarkerAlphaLocal 1;


} forEach _locations;

// return
_markerArray
