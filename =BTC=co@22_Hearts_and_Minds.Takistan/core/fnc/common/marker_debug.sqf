_units = allunits;
if !(btc_marker_debug_cond) exitWith {};
_color = "";_markers = [];
{
	if (Alive _x) then
	{
		_marker = createmarkerLocal [format ["%1", _x], position _x];
		format ["%1", _x] setmarkertypelocal "mil_Dot";
		format ["%1", _x] setMarkerTextLocal format ["%1", typeOf _x];
		if (leader group _x == _x) then {format ["%1", _x] setMarkerTextLocal format ["%1 (%2) (%3)", typeOf _x,group _x getVariable "btc_patrol_id",group _x getVariable "btc_traffic_id"];};
		switch (true) do {case (side _x == west) : {_color = "ColorBlue"};case (side _x == east) : {_color = "ColorRed"};case (side _x == independent) : {_color = "ColorGreen"}; default {_color = "ColorWhite"};};
		format ["%1", _x] setmarkerColorlocal _color;
		format ["%1", _x] setMarkerSizeLocal [0.7, 0.7];
		_markers = _markers + [_marker];
	};
} foreach _units;
player sideChat format ["UNITS:%1 - GROUPS:%2", count allunits, count allgroups];
sleep 1;
{deleteMarker _x} foreach _markers;
_marker = [] spawn btc_fnc_marker_debug;