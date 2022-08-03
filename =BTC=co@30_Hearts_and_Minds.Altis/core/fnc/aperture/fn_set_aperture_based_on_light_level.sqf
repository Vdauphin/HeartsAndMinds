/*
	File: fn_setApertureBasedOnLightLevel.sqf
	Author: Spoffy
	Date: 2021-01-16
	Last Update: 2021-01-16
	Public: Yes
	
	Description:
		Sets the aperture based on ambient light levels to allow for night fighting.
	
	Parameter(s):
		None
	
	Returns:
		None
	
	Example(s):
		[] call para_c_fnc_setApertureBasedOnLightLevel
*/

private _lightBrightness = getLighting select 1;

if (4 < _lightBrightness && _lightBrightness < 120) exitWith {
	setApertureNew [4, 6, 9, 0.9];
};

if (_lightBrightness < 4) exitWith {
	private _minAperture = linearConversion [0, 4, _lightBrightness, 1, 3, true];
	setApertureNew [_minAperture, 6, 9, 0.9];
};

setAperture -1;