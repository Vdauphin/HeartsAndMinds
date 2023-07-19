/*
*	Scans all Objects on the map, then, seperates out required flag colors.
*
*
*
*/

diag_log ("[CVO] [INTEL] [FLAGS] (FAF) start");

private _array = 8 allObjects 0;

diag_log ("[CVO] [INTEL] [FLAGS] (FAF) Total Objects: " + str (count _array));


diag_log ("[CVO] [INTEL] [FLAGS] (FAF) Begin filtering");
private _flag_green = [];
private _flag_red = [];

{
	switch (typeOf _x) do
	{
		case "ace_marker_flags_green": 	{_flag_green pushBack _x};
		case "ace_marker_flags_red":	{_flag_red pushBack _x};
	};
} forEach _array;

diag_log ("[CVO] [INTEL] [FLAGS] (FAF) Green Flags found: " + str (count _flag_green));
diag_log ("[CVO] [INTEL] [FLAGS] (FAF) Red Flags found: "   + str (count _flag_red));


{[_x, "green"] call cvo_intel_flag_fnc_decider;} forEach _flag_green;

{[_x, "red"] call cvo_intel_flag_fnc_decider;} forEach _flag_red;

diag_log ("[CVO] [INTEL] [FLAGS] (FAF) completed");
