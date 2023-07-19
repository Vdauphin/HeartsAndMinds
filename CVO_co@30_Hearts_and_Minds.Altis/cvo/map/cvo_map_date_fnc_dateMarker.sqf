
/*


["INIT", [_startDate]] 		spawn cvo_map_date_fnc_dateMarker;
["INIT", [btc_startDate]] 	spawn cvo_map_date_fnc_dateMarker;


*/


params [
	["_mode", "", [""]],
	["_params",[],[]]
];

if (!isServer) exitWith {};

if (_mode isEqualTo "") exitWith {diag_log format["[CVO] [Map] (dateMarker) - %1", "No Mode Provided."];};

if (_mode isEqualTo "INIT") exitWith {

	diag_log format["[CVO] [Map] (dateMarker) - %1", "INIT Detected."];
	diag_log format["[CVO] [Map] (dateMarker) - Init Params: %1", _this];

	_position = [(worldSize * 0.05), (worldSize * 1.05)];
	cvo_dateMarker = createMarkerLocal ["cvo_dateMarker", _position];
	"cvo_dateMarker" setMarkerTypeLocal "EmptyIcon";
	"cvo_dateMarker" setMarkerColorLocal "ColorRed";
	"cvo_dateMarker" setMarkerShapeLocal "ICON";
	"cvo_dateMarker" setMarkerShadow true;
	"cvo_dateMarker" setMarkerText	"placeholder";
	diag_log format["[CVO] [Map] (dateMarker) - %1", "marker placed."];
	cvo_dateMarker_active = true;
	_params spawn {
		params [["_startDate", missionStart]];
		while {cvo_dateMarker_active} do {
			date params ["_year", "_month", "_day", "_hours", "_minutes"];
			_pastDays = floor ([_startDate, date, "d"] call BIS_fnc_calculateDateTime);
			_dateString = format ["Date: %1-%2-%3 # %4:%5 #  Day %6", _year, _month, _day, _hours, _minutes, _pastDays];
			"cvo_dateMarker" setMarkerText _dateString;
			sleep 60;
		};
	};
};