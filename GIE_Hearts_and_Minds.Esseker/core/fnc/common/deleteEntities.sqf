
/* ----------------------------------------------------------------------------
Function: btc_fnc_deleteEntities

Description:
    This delete objects or groups when they are far away from a player.

Parameters:
    _entities - Entities deleted when _playableUnits are far. [Array]
    _playableUnits - Objects needed to be far before entities are deleted. [Array]

Returns:

Examples:
    (begin example)
        _result = [_entities] call btc_fnc_deleteEntities;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params [
        ["_entities", [], [[]]],
        ["_playableUnits", playableUnits, [[]]]
    ];

    private _entity = _entities deleteAt 0;
    private _entity_obj = if (_entity isEqualType grpNull) then {
        leader _entity
    } else {
        _entity
    };

    if (_playableUnits inAreaArray [getPosWorld _entity_obj, 1000, 1000] isEqualTo []) then {
        _entity call CBA_fnc_deleteEntity;
    } else {
        _entities pushBack _entity;
    };

    if (_entities isNotEqualTo []) exitWith {
        _this call btc_fnc_deleteEntities;
    };
}, _this, 1] call CBA_fnc_waitAndExecute;
