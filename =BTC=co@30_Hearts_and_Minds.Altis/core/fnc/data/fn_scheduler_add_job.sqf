/*
	File: fn_ai_scale_to_player_count.sqf
	Author: Aaron Clark <vbawol>, Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No

	Description:
		Adds a job to the main scheduler.

	Parameter(s):
		_jobId - Job id [String]
		_code - Code to run in the scheduler [Code]
		_parameters - Parameters given to the job [any]
		_tickDelay - Minimum delay in seconds between runs [Number]
		_iterationsToRun - How many time do you want to run it [Number, defaults to -1]

	Returns:
		Job namespace [Location]

	Example(s):
		[_code, _tickDelay] call para_g_fnc_scheduler_add_job
*/


params ["_jobId", "_code", "_parameters", "_tickDelay", ["_iterationsToRun", -1]];

private _job = false call btc_fnc_create_namespace;

_job setVariable ["jobId", _jobId];
_job setVariable ["code", _code];
_job setVariable ["tickDelay", _tickDelay];
_job setVariable ["startTime", diag_tickTime];
_job setVariable ["parameters", _parameters];
_job setVariable ["remainingIterations", _iterationsToRun];

//Do it this way so jobs can be added before the scheduler has started.
para_l_schedulerJobs = (missionNamespace getVariable ["para_l_schedulerJobs", []]) + [[_jobId, _job]];

_job
