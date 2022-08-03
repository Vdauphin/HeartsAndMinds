/*
    File: fn_day_night_subsystem_init.sqf
    Author: Spoffy
    Date: 2020-06-25
    Last Update: 2020-06-25
    Public: Yes

    Description:
        The day/night cycle subsystem manages speeding up/slowing down the day-night cycle.
		Due to Arma constraints, the shortest possible day or night is 12 minutes.
		This initialises the subsystem.

    Parameter(s):
        _dawnLength - Length of dawn in seconds [NUMBER]
        _dayLength - Length of each day in seconds [NUMBER]
        _duskLength - Length of dusk in seconds [NUMBER]
		_nightLength - Length of each night in seconds [NUMBER]

    Returns:
        Function reached the end [BOOL]

    Example(s):
		//Initialises the day night subsystem with 24 minute days and 12 minute nights.
        [1440, 0.5] call fnc_day_night_subsystem_init
*/

params ["_dawnLength", "_dayLength", "_duskLength", "_nightLength"];

//Date used: 1968, February 21st
//Dawn - Defined as 5.15am to 6am
//Day - Defined as 6am to 6.15pm
//Dusk - Defined as 5.15pm to 6pm
//Night - Defined as 7pm to 5.15am

#define SECONDS_OF_DAWN 2700
#define SECONDS_OF_DAY 40500
#define SECONDS_OF_DUSK 2700
#define SECONDS_OF_NIGHT 40500

day_night_dawnSpeedMultiplier = SECONDS_OF_DAWN / _dawnLength;
day_night_daySpeedMultiplier = SECONDS_OF_DAY / _dayLength;
day_night_duskSpeedMultiplier = SECONDS_OF_DUSK / _duskLength;
day_night_nightSpeedMultiplier = SECONDS_OF_NIGHT / _nightLength;

["day_night_cycle", btc_day_night_job, [], 120] call btc_fnc_scheduler_add_job;

true
