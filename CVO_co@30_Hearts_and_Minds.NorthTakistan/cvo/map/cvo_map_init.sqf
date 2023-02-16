// Store Functions
cvo_map_date_fnc_dateMarker = compile preprocessFile "cvo\map\cvo_map_date_fnc_dateMarker.sqf";

// init Function
["INIT",[btc_startDate]] remoteExec ["cvo_map_date_fnc_dateMarker",2];