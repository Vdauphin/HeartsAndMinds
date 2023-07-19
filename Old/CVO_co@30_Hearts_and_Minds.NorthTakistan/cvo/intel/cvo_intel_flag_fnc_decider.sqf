/*
* The Goal of this Function is to identifiy the provided flag and decide what to do with it
*
*	Params:
*	0 <_flag> <object>
*   1 <_color> <string> <Optional> 
*/

params [
	["_flag", objNull, [objNull]],
	["_color", "", [""]]
];

private _makeMarker = false;

if (isNull _flag) exitWith {};

if (_color == "green" || typeOf _flag == "ace_marker_flags_green") then {
	diag_log ("[CVO] [INTEL] [FLAGS] (DEC) Green Flag -> Marker");
	_makeMarker = true;
};

if (_color == "red" || typeOf _flag == "ace_marker_flags_red") then {
	diag_log ("[CVO] [INTEL] [FLAGS] (DEC) Red Flag -> Marker");
	_makeMarker = true;
};

if (_makeMarker) then {[cvo_intel_flag_fnc_createMarker, [_flag,_color], cvo_p_intel_flag_timer] call CBA_fnc_waitAndExecute;};
