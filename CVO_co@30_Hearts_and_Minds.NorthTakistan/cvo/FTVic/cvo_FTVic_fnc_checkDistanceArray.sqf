/* ----------------------------------------------------------------------------
Function: cvo_FTVic_fnc_checkDistanceArray

Description:
    Returns True if _input is within given Range of one of other given objects in the Array


Parameters:
    <_input>                <object>                           <object to check condition on, if empty will return nothing>
	<_distance>             <number>                           <distance in meters>
    <_reference>            <Array of Objects or Positions>    <Array of Objects t

Returns:
	boolean

Examples:
    (begin example)
        [_input, _distance, _reference] call cvo_FTVic_fnc_checkDistanceArray;
    (end)

Author:
    Zorn

---------------------------------------------------------------------------- */

params [
    ["_input",     objNull,    [objNull,[]], [2,3]  ],
    ["_distance",   0,         [0]                  ],
    ["_reference", [],         [[]]                 ]
];


// Param Adjustments
if (_input isEqualTo objNull    )   exitWith { false };
if (_distance isEqualTo 0       )   exitWith { false };
if (count _reference isEqualTo 0)   exitWith { false };

private _result = false;

private "_pos1";

if ( _input isEqualType objNull)    then { _pos1 = getPos _input;   };
if ( _input isEqualType [])         then { _pos1 = _input;          };

{
    _pos2 = getPos _x;
    _dis  = round (_pos1 distance _pos2);

    if (_dis <= _distance) exitWith {
        _result = true;
    };

} forEach _reference;

_result