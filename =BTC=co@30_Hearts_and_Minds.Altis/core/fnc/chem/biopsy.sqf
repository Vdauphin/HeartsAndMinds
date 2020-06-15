
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_biopsy

Description:
    Do a biopsy to determine if the object is contaminated.

Parameters:
    _data - Data collected. [Array]
    _success - Does the biopsy has been correctly done. [Boolean]

Returns:

Examples:
    (begin example)
        [[player, "head", 50], true] call btc_fnc_chem_biopsy;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_data", [], [[]]],
    ["_success", false, [true]]
];

if !(_success) exitWith {_this};

private _obj = _data select 0;
private _chemlevel = _obj getVariable ["btc_chem_level", 0];
([
    localize "STR_BTC_HAM_O_CHEM_NOTCONTA",
    localize "STR_BTC_HAM_O_CHEM_CONTA"
] select (_chemlevel > 0)) call CBA_fnc_notify;

_this
