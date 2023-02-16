
/* ----------------------------------------------------------------------------
Function: cvo_flag_fnc_createMarker

Description:
    Create a colored Flag Marker marker on placed colored flags.

Parameters:
    _flag -  <Object>
    _color - <string> <can be: "GREEN", "RED"> 

Returns:

Examples:
    (begin example)
        [_flag, _color] call cvo_flag_fnc_createMarker;
    (end)

Author:
    Zorn

---------------------------------------------------------------------------- */

params [
    ["_flag", objNull, [objNull]],
    ["_color", "", [""]]
];
private _colorMarker = "";

switch (_color) do 
{
    case "green":   {_colorMarker = "ColorGreen";};
    case "red":     {_colorMarker = "ColorRed";};
    default         {_colorMarker = "";};
};

if (isNull _flag || _colorMarker == "") exitwith {};

private _marker = createMarker [format ["cvo_flag_%1_%2", CVO_flag_counter, _colorMarker],_flag];

CVO_flag_counter = CVO_flag_counter + 1;

_marker setMarkerTypeLocal "mil_flag";
_marker setMarkerSizeLocal [0.5, 0.5];
_marker setMarkerAlphaLocal 0.5;
_marker setMarkerColor _colorMarker;

diag_log ("[CVO] [INTEL] [FLAGS] (createMarker) markerCreated: " + _marker);

_flag setVariable ["CVO_Flag_MarkerName", _marker];

// Adding EventHandler on Object on deleted

_flag addEventHandler ["Deleted", {	params ["_flag"];

    private _marker = _flag getVariable ["CVO_Flag_MarkerName", ""];
   
    if (_marker == "") exitWith {diag_log ("[CVO] [INTEL] [FLAGS] (delEH) CVO_Flag_MarkerName not found");};
    
    diag_log ("[CVO] [INTEL] [FLAGS] (delEH) Deleted Marker: "+ _marker);
    deleteMarker _marker;
}];
diag_log ("[CVO] [INTEL] [FLAGS] (createMarker) delEH added: " + _marker);
