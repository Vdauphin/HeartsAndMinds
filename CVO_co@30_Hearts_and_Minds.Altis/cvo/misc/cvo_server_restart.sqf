if (!isServer) exitWith {};
diag_log ("[CVO] [SRV] (restart) - Init.");

// At which full hour server System Time will the start happen?
private _resH = 17;

// Check if current servertime is before MorningRestart or after this Restart
if (systemTime select 3 >= _resH) 	exitWith {diag_log ("[CVO] [SRV] (restart) - Exit: Past Restart.");};
if (systemTime select 3 <= 7) 		exitWith {diag_log ("[CVO] [SRV] (restart) - Exit: Before Morning Restart.");};

diag_log ("[CVO] [SRV] (restart) - post Exit Check");

diag_log ("[CVO] [SRV] (restart) - Waiting until 1h before Restart");
waitUntil {	sleep 120;((systemTime select 3) == (_resH - 1))};
diag_log ("[CVO] [SRV] (restart) - Wait complete 1h before Restart");

/* 
Warn people:
60 Minutes - 15 Minutes before: every 15 minutes.
15 Minutes - 5 Minutes before: Every 5 Minutes.
5 Minutes - 0 Minutes: Every 1 Minute.
*/
_sleep = 1;

while {sleep 1; (systemTime select 4) <= 55 } do {
	private _varMin = 60 - (systemTime select 4);
	private _str = format ["Server Restart in %1 Minutes", _varMin];
	[_str] remoteExec ["systemChat"];
	diag_log ("[CVO] [SRV] (restart) - " + _str);
	if ((systemTime select 4) < 45) then {	_sleep = 900; };
	if ((systemTime select 4) > 45) then {	_sleep = 300; };
	sleep _sleep;
};

//execute a Save.
waitUntil {
	sleep 1;
	((systemTime select 4) >= 55)
};
diag_log ("[CVO] [SRV] (restart) - Saving.");
[] call btc_db_fnc_save;

while { 
	sleep 1; 
	((systemTime select 4) <= 60)
} do {
	private _varMin = 60 - (systemTime select 4);
	private _str = format ["Server Restart in %1 Minutes", _varMin];
	[_str] remoteExec ["hintC"];
	diag_log ("[CVO] [SRV] (restart) - " + _str);
	sleep 60;
};
diag_log ("[CVO] [SRV] (restart) - END.");
