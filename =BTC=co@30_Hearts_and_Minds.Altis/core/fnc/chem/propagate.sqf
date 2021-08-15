
/* ----------------------------------------------------------------------------
Function: btc_chem_fnc_propagate

Description:
    Propagate from the item or vehicle contaminated to the item or vehicle not contaminated.

Parameters:
    _item - Item. [Object]
    _vehicle - Vehicle. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, vehicle player] call btc_chem_fnc_propagate;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_item", objNull, [objNull]],
    ["_vehicle", objNull, [objNull]]
];

if (_item in btc_chem_contaminated) then {
    if ((btc_chem_contaminated pushBackUnique _vehicle) > -1) then {
        publicVariable "btc_chem_contaminated";
    };
} else {
    if (_vehicle in btc_chem_contaminated) then {
        if ((btc_chem_contaminated pushBackUnique _item) > -1) then {
            publicVariable "btc_chem_contaminated";
        };
    };
};

_this
