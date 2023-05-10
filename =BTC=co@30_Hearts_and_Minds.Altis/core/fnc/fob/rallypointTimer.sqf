
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_rallypointTimer

Description:
    Create a timer and when timer is up, trigger self destruction.

Parameters:
    _rallypoint - Rallypoint. [Object]
    _delay - Delay before the rallypoint self-destruction. [Number]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fob_fnc_rallypointTimer;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_rallypoint", objNull, [objNull]],
    ["_delay", btc_fob_rallypointTimer, [0]]
];

private _time = serverTime;
_rallypoint setVariable ["btc_fob_assembleTime", _time];

[{
    params [
        ["_rallypoint", objNull, [objNull]],
        ["_time", 0, [0]]
    ];

    if (
        isNull _rallypoint ||
        _time != _rallypoint getVariable ["btc_fob_assembleTime", -1]
    ) exitWith {};
    if (objectParent _rallypoint isEqualTo objNull) then {
        deleteVehicle _rallypoint;
    };
}, [_rallypoint, _time], _delay] call CBA_fnc_waitAndExecute;
