
/* ----------------------------------------------------------------------------
Function: btc_fnc_getHouses

Description:
    Get enterable and not enterable houses around a position.

Parameters:
    _pos - Position to search for houses. [Array]
    _radius - Radius of search. [Number]

Returns:
	_enterable - Useful open houses. [Array]
    _notEnterable - Useful not open houses. [Array]

Examples:
    (begin example)
        _useful = [getPos player] call btc_fnc_getHouses;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[], objNull]],
    ["_radius", 100, [0]]
];

private _enterable = [];
private _notEnterable = [];
{
    if (damage _x isNotEqualTo 0) then {continue;};
    if ((_x buildingPos -1) isEqualTo []) then {
        if (
            _x isKindOf "Lamps_base_F" ||
            {_x isKindOf "PowerLines_Small_base_F"} ||
            {_x isKindOf "PowerLines_Wires_base_F"} ||
            {_x isKindOf "Wall"} ||
            {_x isKindOf "Camping_base_F"} ||
            {_x isKindOf "Land_Campfire_F"} ||
            {_x isKindOf "Land_MetalBarrel_empty_F"} ||
            {_x isKindOf "FlagCarrierCore"} ||
            {_x isKindOf "Scrapyard_base_F"} ||
            {_x isKindOf "Shelter_base_F"}
        ) then {continue;};
        _notEnterable pushBack _x;
    } else {
        _enterable pushBack _x;
    };
} forEach (nearestObjects [_pos, ["Building"], _radius]);

[_enterable, _notEnterable]
