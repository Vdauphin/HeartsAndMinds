diag_log ("[CVO] [INTEL] [FLAGS] (INIT) - start");


// Defining Functions

cvo_intel_flag_fnc_findAllFlags = compile preprocessFile "cvo\intel\cvo_intel_flag_fnc_findAllFlags.sqf";
cvo_intel_flag_fnc_decider = compile preprocessFile "cvo\intel\cvo_intel_flag_fnc_decider.sqf";
cvo_intel_flag_fnc_createMarker = compile preprocessFile "cvo\intel\cvo_intel_flag_fnc_createMarker.sqf";

cvo_p_intel_flag_timer = 60;
CVO_flag_counter = 0;

CVO_flag_red = [];
CVO_flag_green = [];

// Adding Event on flags placed

diag_log ("[CVO] [INTEL] [FLAGS] (INIT) - functions defined");

private _codeEH = {
	params ["_unit", "_flag"];
	private _color = "";

		switch (typeOf _flag) do
		{
			case "ace_marker_flags_green": 	{_color = "green";};
			case "ace_marker_flags_red":	{_color = "red";};
		};

	diag_log ("[CVO] [INTEL] [FLAGS] (EH_placed) - " + str _unit + " placed " + _color + " Flag at: " + str(getPos _flag));

	[_flag, _color] call cvo_intel_flag_fnc_decider;
	
}; ["ace_marker_flags_placed", _codeEH] call CBA_fnc_addEventHandler;

diag_log ("[CVO] [INTEL] [FLAGS] (INIT) - flags_placed EH added");


// Calling findAllFlags

[cvo_intel_flag_fnc_findAllFlags, [], 60] call CBA_fnc_waitAndExecute;
// [] call cvo_intel_flag_fnc_findAllFlags;

diag_log ("[CVO] [INTEL] [FLAGS] (INIT) - completed");
