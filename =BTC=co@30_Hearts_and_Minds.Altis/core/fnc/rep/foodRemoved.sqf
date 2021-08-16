
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_foodRemoved

Description:
    Change reputation if food is removed.

Parameters:
    _caller - Caller (player). [Object]
    _unit - Target. [Object]
    _listOfItemsToRemove - Classnames. [Array]
    _listOfTextItems - Array of number of removed items. [Array]

Returns:

Examples:
    (begin example)
        [player, cursorObject, ["ACE_Banana"], ["2"]] call btc_rep_fnc_foodRemoved;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_caller", "_target", "_listOfItemsToRemove",
    ["_listOfTextItems", ["2"], [[]]]
];

if (
    (side group _target) isEqualTo civilian &&
    {"ACE_Banana" in _listOfItemsToRemove}
) then {
    private _cfgWeapons = configFile >> "CfgWeapons";
    private _posItemInArray = _listOfItemsToRemove findIf {_x isKindOf ["ACE_Banana", _cfgWeapons]};
    private _repChange = btc_rep_malus_foodRemove * parseNumber (_listOfTextItems select _posItemInArray);
    if (isServer) then {
        [_repChange, _caller] call btc_rep_fnc_change;
    } else {
        [_repChange, _caller] remoteExecCall ["btc_rep_fnc_change", 2];
    };
};
