/*
	File: fn_scheduler_start.sqf
	Author: Aaron Clark <vbawol>, Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No

	Description:
		Main scheduler. Handles frequent, repetitive, in-expensive tasks that don't need to be spawn'd.
		Nothing scheduled here should ever take a long time to run - as it'll block the scheduler doing anything.

		Tasks are a namespace with the following variables set:
			code - Code to run each tick
			tickDelay - Delay between ticks
			startTime - When the job was added to the scheduler

		These variables are added in the scheduler

			lastTickTime - last time the job was run
			removeFromScheduler - set when the task wants to be removed.


	Parameter(s): none

	Returns: nothing

	Example(s):
		call para_g_fnc_scheduler_start;
*/

if (isNil "para_l_schedulerJobs") then {
	para_l_schedulerJobs = [];
};

para_l_schedulerHandle = [] spawn {
	//Fixes the wrong name showing up in the arma 3 profiler.
	//Without this, this code block ends up named after the first script in the scheduler to run.
	scriptName "Main Scheduler Loop";
	para_l_runScheduler = true;

	while {para_l_runScheduler} do
	{
		private _tickTime = diag_tickTime;
		private _toBeRemoved = [];
		{
			//_schedulerCurrentJob is designed to be accessible from within the code of scheduled jobs.
			//Do not change it without changing all references to it in the project.
			_x params ["_jobId", "_schedulerCurrentJob"];
			//Most defaults shouldn't be used here, but better safe than crash the scheduler.
			private _code = _schedulerCurrentJob getVariable ["code", {}];
			private _parameters = _schedulerCurrentJob getVariable ["parameters", []];
			private _tickDelay = _schedulerCurrentJob getVariable ["tickDelay", 5];
			private _startTime = _schedulerCurrentJob getVariable ["startTime", 0];
			private _lastTickTime = _schedulerCurrentJob getVariable ["lastTickTime", 0];
			private _remainingIterations = _schedulerCurrentJob getVariable ["remainingIterations", -1];

			if ((_tickTime - _lastTickTime) > _tickDelay && {_remainingIterations != 0}) then
			{
				//If debug scheduler is enabled, dump the jobs to the log file.
				if (!isNil "debugScheduler") then {
					["SCHEDULER: Job running - %1", _jobId] call BIS_fnc_logFormat;
				};

				//So, this'll work for infinite iterations too - we'll keep decrementing -1. Not sure I see a need to change it.
				_remainingIterations =	_remainingIterations - 1;
				_schedulerCurrentJob setVariable ["remainingIterations", _remainingIterations];
				_schedulerCurrentJob setVariable ["lastTickTime", _tickTime];

				//This weird little line gives us the name of the currently running script in the Arma 3 profiler.
				//Performance impact is minimal - 0.0077 seconds ish.
				call compile format ["isNil {'%1'}", _jobId];
				_parameters call _code;

				if (!isNil "debugScheduler") then {
					diag_log format ["SCHEDULER: Job iteration done - %1", _jobId];
				};

				//Reload the iterations, in case the code has modified it.
				_remainingIterations = _schedulerCurrentJob getVariable ["remainingIterations", _remainingIterations];

				//We remove only when exactly 0 iterations remain, or we've explicitly said we'd like to exit.
				//Negative iterations are infinite - deliberately so.
				if ( _schedulerCurrentJob getVariable ["removeFromScheduler", false] ||	_remainingIterations == 0) then
				{
					_toBeRemoved pushBack _foreachindex;
				};
			};
		} forEach para_l_schedulerJobs;
		// reverse array and remove from last to first
		reverse _toBeRemoved;
		{
			//Delete the namespace used by the job, so we don't get a bunch lingering around as the mission runs.
			private _job = para_l_schedulerJobs select _x select 1;
			_job call btc_fnc_delete_namespace;
			//Now just remove the job entry from the scheduler.
			para_l_schedulerJobs deleteAt _x;
		} forEach _toBeRemoved;
		uiSleep 0.1;
	};
};
