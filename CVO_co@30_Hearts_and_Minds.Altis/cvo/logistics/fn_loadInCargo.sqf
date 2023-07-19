/*
    Author: Skippie

    Description:
    	Loads an object into a vehicle's ViV cargo.

    Parameter(s):
        0: OBJECT - object that will be initialized
        1: OBJECT - vehicle that will receive the object


    Returns:
        NOTHING

    Examples:
        [cursorObject, nearestObjects [cursorObject, ["Car", "Truck"], 10] select 0] call cvo_logistics_fnc_loadInCargo;
*/

params [
    ["_obj", objNull, [objNull]],
    ["_vehicle", objNull, [objNull]]
];

private ["_objType", "_objSize", "_timeToLoad", "_possibleToLoad"];

_objType = typeOf _obj;
_objSize = sizeOf _objType;
_timeToLoad = ((5 max (_objSize*2)) min 20);
_possibleToLoad = (_vehicle canVehicleCargo _obj) select 0;

if (!_possibleToLoad) exitWith { hint "The vehicle doesn't have enough room for this cargo" };

[
	_timeToLoad,
	[_vehicle, _obj],
	{
		params ["_args"];
		_args params ["_targetVehicle", "_cargo"];
		_targetVehicle setVehicleCargo _cargo;
	},
	{}
] call ace_common_fnc_progressBar;
