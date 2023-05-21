
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_foodRemoved

Description:
    Change reputation if food is removed.

Parameters:
    _caller - Caller (player). [Object]
    _unit - Target. [Object]
    _listOfItemsToRemove - Classnames. [Array]
    _numberOfItems - Number of removed items. [Number]

Returns:

Examples:
    (begin example)
        [player, cursorObject, ["ACE_Banana"], 2] call btc_rep_fnc_foodRemoved;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_caller", "_target", "_listOfItemsToRemove",
    ["_numberOfItems", 2, [0]]
];


private _removedItem = _listOfItemsToRemove select 0;
if (
    (side group _target) isEqualTo civilian &&
    {_removedItem isKindOf ["ACE_Banana", configFile >> "CfgWeapons"]}
) then {
    private _repChange = btc_rep_malus_foodRemove * _numberOfItems;
    if (isServer) then {
        [_repChange, _caller] call btc_rep_fnc_change;
    } else {
        [_repChange, _caller] remoteExecCall ["btc_rep_fnc_change", 2];
    };
};
