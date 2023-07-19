/*
*	Author: MrZorn
*
*	Description:
*		Continous change of timeMultiplier at SunSet and SunRise. 
*
*	Parameter(s):
*		0: <number> <range: 0.1 to 120> - (Optional, default 6)  Time Multiplier during Day
*		1: <number> <range: 0.1 to 120> - (Optional, default 60) Time Multiplier during Night
* 		2: <number> <offset in hours> - (Optional, default 0.75) Time Offset Defines the 
*		2: <Array of Strings>  (Optional, Default [""]) Additional modes to be enabled, multiple possible.
*			<"CLEARNIGHT"> - sets Overcast to less then 20% during the night. 
*
*	Returns:
*		<nothing>
*
*	Examples:
*		[] spawn cvo_env_fnc_dayCycle;
*		cvo_env_dayCycle_handle = [20, 120, ["CLEARNIGHT"]] spawn cvo_env_fnc_dayCycle;
*/


if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_env_fnc_dayCycle};


scopeName "main";

waitUntil {sleep 5; time > 0 };

diag_log "[CVO] [ENV] (dayCycle) - Start";

params [
	["_multiDay", 5, [0]],
	["_multiNight", 25, [0]],
	["_multiSunriseSunSet", 1, [0]],
	["_offset", 0.75, [0]],
	["_modes", [""], [""]]
]; 

// Limit timeMultiplier range 0.1 - 120
{	_x = 0.1 max (_x min 120);} forEach [_multiDay, _multiNight];


/* // Modes of Operation
_clearNight = false; 																// Removes/Reduces Cloud Cover during night to ensure certain visibility

if (!(count _modes == 1 && _modes select 0 == "")) then {
	{
		switch (_x) do {
			case "CLEARNIGHT": {_clearNight = true; diag_log "[CVO] [ENV] (dayCycle) ClearNight True";};
		};
	} foreach _modes;
}; */

if (isNil "cvo_env_dayCycle") then {cvo_env_dayCycle = ""; publicVariable "cvo_env_dayCycle";};

(date call BIS_fnc_sunriseSunsetTime) params ["_sunrise", "_sunset"];

private ["_sunriseStart", "_sunriseEnd", "_sunsetStart", "_sunsetEnd", "_isNight", "_isDay", "_isSunset"];
_sunriseStart = _sunrise - _offset;
_sunriseEnd = _sunrise + _offset;

_sunsetStart = _sunset - _offset;
_sunsetEnd = _sunset + _offset;

// Define and Detect Phases
_isNight = daytime >= _sunsetEnd;
_isDay = _sunriseStart < daytime && daytime < _sunsetEnd;
_isSunset = daytime > _sunsetStart && daytime < _sunsetEnd;

cvo_env_dayCycle_rl_day_duration = round ( (24 - _sunsetEnd + _sunriseStart ) / _multiNight * 60) + round ( (_sunriseEnd - _sunriseStart ) / _multiSunriseSunSet * 60) + round ( (_sunsetStart - _sunriseEnd ) / _multiDay * 60) + round ( (_sunsetEnd - _sunsetStart ) / _multiSunriseSunSet * 60 );

diag_log ("[CVO] [ENV] (dayCycle) - CurrentTime: " + str daytime );
diag_log ("[CVO] [ENV] (dayCycle) -   NightTime: " + (_sunsetEnd 	toFixed 2 )+ " --0--> " 	+( _sunriseStart  toFixed 2) +	" Realtime Duration: " + str round ( (24 - _sunsetEnd + _sunriseStart ) / _multiNight * 60)+ " min.");
diag_log ("[CVO] [ENV] (dayCycle) -     Sunrise: " + (_sunriseStart  toFixed 2 ) + " -----> " 	+( _sunriseEnd  	toFixed 2) +	" Realtime Duration: " + str round ( (_sunriseEnd - _sunriseStart ) / _multiSunriseSunSet * 60)+ " min.");
diag_log ("[CVO] [ENV] (dayCycle) -     DayTime: " + (_sunriseEnd  	toFixed 2) + " -----> " 	+( _sunsetStart  	toFixed 2) +	" Realtime Duration: " + str round ( (_sunsetStart - _sunriseEnd ) / _multiDay * 60)+ " min.");
diag_log ("[CVO] [ENV] (dayCycle) -      Sunset: " + (_sunsetStart 	toFixed 2) + " -----> " 	+( _sunsetEnd  	toFixed 2) +	" Realtime Duration: " + str round ( (_sunsetEnd - _sunsetStart ) / _multiSunriseSunSet * 60 )+ " min.");
diag_log ("[CVO] [ENV] (dayCycle) -      Daytime Duration in Reallife Time: " + str cvo_env_dayCycle_rl_day_duration);

// NightTime Past Midnight
if (daytime <= _sunriseStart) then {
	cvo_env_dayCycle = "NIGHT";
	publicVariable "cvo_env_dayCycle";
	diag_log ("[CVO] [ENV] (dayCycle) - Past MidNight detected");
	setTimeMultiplier _multiNight;
	diag_log ("[CVO] [ENV] (dayCycle) - Multiplier Night applied");
	diag_log ("[CVO] [ENV] (dayCycle) - Waiting until Next Phase");
	waitUntil {sleep 60; daytime > _sunriseStart};
};

// Sunrise
if (daytime > _sunriseStart && daytime < _sunriseEnd ) then {
	cvo_env_dayCycle = "SUNRISE"; publicVariable "cvo_env_dayCycle";
	diag_log ("[CVO] [ENV] (dayCycle) - Sunrise detected");
	setTimeMultiplier _multiSunriseSunSet;
	diag_log ("[CVO] [ENV] (dayCycle) - Multiplier Sunrise applied");
	diag_log ("[CVO] [ENV] (dayCycle) - Waiting until Next Phase");
	waitUntil {sleep 60; daytime > _sunriseEnd};

};

// Daytime
if (_sunriseStart < daytime && daytime < _sunsetEnd ) then {
	cvo_env_dayCycle = "DAY"; publicVariable "cvo_env_dayCycle";
	diag_log ("[CVO] [ENV] (dayCycle) - Sunrise detected");
	setTimeMultiplier _multiDay;
	diag_log ("[CVO] [ENV] (dayCycle) - Multiplier Sunrise applied");
	diag_log ("[CVO] [ENV] (dayCycle) - Waiting until Next Phase");
	waitUntil {sleep 60; daytime > _sunsetStart};
};

// Sunset
if (daytime > _sunsetStart && daytime < _sunsetEnd ) then {
	cvo_env_dayCycle = "SUNSET"; publicVariable "cvo_env_dayCycle";
	diag_log ("[CVO] [ENV] (dayCycle) - Sunset detected");
	setTimeMultiplier _multiSunriseSunSet;
	diag_log ("[CVO] [ENV] (dayCycle) - Multiplier Sunset applied");
	diag_log ("[CVO] [ENV] (dayCycle) - Waiting until Next Phase");
	waitUntil {sleep 60; daytime > _sunsetEnd};
};

// NightTime Past Evening
if (daytime > _sunsetEnd) then {
	cvo_env_dayCycle = "NIGHT"; publicVariable "cvo_env_dayCycle";
	diag_log ("[CVO] [ENV] (dayCycle) - Night detected");
	setTimeMultiplier _multiNight;
	diag_log ("[CVO] [ENV] (dayCycle) - Multiplier Night applied");
	diag_log ("[CVO] [ENV] (dayCycle) - Waiting until Midnight");
	waitUntil {sleep 60; daytime < _sunriseStart};
};

diag_log ("[CVO] [ENV] (dayCycle) - Midnight passed");

cvo_env_dayCycle_handle = _this spawn cvo_env_fnc_dayCycle;
diag_log ("[CVO] [ENV] (dayCycle) - Re-Started");
