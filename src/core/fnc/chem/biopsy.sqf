
/* ----------------------------------------------------------------------------
Function: btc_chem_fnc_biopsy

Description:
    Do a biopsy to determine if the object is contaminated.

Parameters:
    _data - Data collected. [Array]
    _success - Does the biopsy has been correctly done. [Boolean]

Returns:

Examples:
    (begin example)
        [[player, "head", 50], true] call btc_chem_fnc_biopsy;
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
([
    localize "STR_BTC_HAM_O_CHEM_NOTCONTA",
    localize "STR_BTC_HAM_O_CHEM_CONTA"
] select (_obj in btc_chem_contaminated)) call CBA_fnc_notify;

_this
