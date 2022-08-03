/*
    File: fn_scheduler_subsystem_init.sqf
    Author: Spoffy
    Date: 2021-04-05
    Last Update: 2021-04-05
    Public: Yes

    Description:
		Starts the scheduler subsystem

    Parameter(s):
		None

    Returns:
		None

    Example(s):
		call para_g_fnc_scheduler_subsystem_init
*/

// Covers the case where it's called on client AND server
if (!isNil "para_l_schedulerHandle") exitWith {};
localNamespace setVariable ["para_l_scheduler_initialised", true];

call btc_fnc_scheduler_start;
0 spawn btc_fnc_scheduler_monitor;
