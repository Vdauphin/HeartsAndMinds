/*
	File: fn_scheduler_monitor.sqf
	Author: Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No

	Description:
		A simple script that monitors the scheduler, and restarts it if it.

	Parameter(s): none

	Returns: nothing

	Example(s):
		[] spawn para_g_fnc_scheduler_monitor
*/

para_l_monitorScheduler = true;

while {para_l_monitorScheduler} do {
	if (isNil "para_l_schedulerHandle" || { scriptDone para_l_schedulerHandle }) then {
		[] call btc_fnc_scheduler_start;
	};

	uiSleep 1;
};
