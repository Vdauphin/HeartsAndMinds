/*
    File: fn_day_night_job.sqf
    Author: Spoffy
    Date: 2020-06-25
    Last Update: 2020-06-25
    Public: No

    Description:
        Runs periodically to maintain the day/night cycle.

    Parameter(s):
		None

    Returns:
        Function reached the end [BOOL]

    Example(s):
		["day_night_cycle", fnc_day_night_job, [], 120] call fnc_scheduler_add_job;
*/

private _hour = date select 3;
private _minute = date select 4;
//Bit of a weird one - we're making a number in the format [0-9].[0-6][0-9], because it's easier to read.
//For example, 17.40 is 5:40pm. 18.15 is 6:15pm.
private _time = _hour + (_minute / 100);
private _isDawn = _time >= 5.15 && _time < 6;
private _isDay = _time >= 6 && _time < 17.15;
private _isDusk = _time >= 17.15 && _time < 18;
private _isNight = _time >= 18 || _time < 5.15;

if (_isDawn && timeMultiplier != day_night_dawnSpeedMultiplier) exitWith {
	setTimeMultiplier day_night_dawnSpeedMultiplier;
};

if (_isDay && timeMultiplier != day_night_daySpeedMultiplier) exitWith {
	setTimeMultiplier day_night_daySpeedMultiplier;
};

if (_isDusk && timeMultiplier != day_night_duskSpeedMultiplier) exitWith {
	setTimeMultiplier day_night_duskSpeedMultiplier;
};

if (_isNight && timeMultiplier != day_night_nightSpeedMultiplier) exitWith {
	setTimeMultiplier day_night_nightSpeedMultiplier;
  [60, 0] remoteExec ["setOvercast", 0];
};
