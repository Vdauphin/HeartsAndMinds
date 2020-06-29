
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_reduceContamination

Description:
    Reduce the contamination level of an object during decontamination.

Parameters:
    _unit - Unit to reduce contamination level. [Object]
    _decreaseLevel - By how much the contamination level should decrease (Default: 0.1). [Number]

Returns:
    _isDecontaminated - Is the target decontaminated. [Boolean]

Examples:
    (begin example)
        [player] call btc_fnc_chem_reduceContamination;
    (end)

Author:
    Zakant

---------------------------------------------------------------------------- */

params [
    ["_unit", player, [objNull]],
    ["_decreaseLevel", 0.1, [0]]
];

// Reduce chem level instead of instant decontamine.
private _chemlevel = _unit getVariable ["btc_chem_level", 0];
_chemlevel = 0 max (_chemlevel - _decreaseLevel);  // Chem level can only decrease to 0
_unit setVariable["btc_chem_level", _chemlevel, true];  // Needs to be synced for clients to perform damage checks.

_chemlevel == 0
