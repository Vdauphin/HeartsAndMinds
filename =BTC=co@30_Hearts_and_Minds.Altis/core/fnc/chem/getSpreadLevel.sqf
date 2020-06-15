
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_getSpreadLevel

Description:
    Get the cbrn spread from the source with the given chem level to the target.

Parameters:
    _source - Source object. [Object]
	_chemlevel - Chemical contamination level of the source unit. [Number]
    _target - Target object. [Object]

Returns:
	_spreadLevel - Chemical contamination level for the target unit from the source. [Number]

Examples:
    (begin example)
        [player, cursorObject] call btc_fnc_chem_getSpreadLevel;
    (end)

Author:
    Zakant

---------------------------------------------------------------------------- */

params [
    ["_source", objNull, [objNull]],
	["_chemlevel", 0, [0]],
	["_target", objNull, [objNull]]
];
