
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_buildingchanged

Description:
    Change reputation on building damage.

Parameters:
    _from - Previous building object. [Object]
    _to - New building object. [Object]
    _isRuin - If changes to ruins. [Boolean]

Returns:

Examples:
    (begin example)
        _result = [] call btc_rep_fnc_buildingchanged;
    (end)

Author:
    mtusnio

---------------------------------------------------------------------------- */

params [
    ["_from", objNull, [objNull]],
    ["_to", objNull, [objNull]],
    ["_isRuin", false, [false]]
];

private _classname = toUpper typeOf _from;
private _malus = [btc_rep_malus_building_damaged, btc_rep_malus_building_destroyed] select _isRuin;
private _skipCategories = false;

// Accept only static, terrain buildings, discard any dynamically created ones but keep already damaged buildings.
if (
    (getObjectType _from != 1) &&
    !(_from in btc_buildings_changed) ||
    {_classname isEqualTo ""} ||
    {_classname isKindOf "Wall"} ||
    {"GATE" in _classname}
) exitWith {};

btc_buildings_changed pushBack _to;

{
    _x params ["_buildings_classname", "_malus_multipliers"];

    if (_classname find (toUpper _buildings_classname) != -1) exitWith {
        _malus = _malus * _malus_multipliers;
        _skipCategories = true;
    };
} forEach btc_buildings_multipliers;

if (!_skipCategories) then {
    {
        _x params ["_buildings_classname", "_malus_multipliers"];

        if (_classname find (toUpper _buildings_classname) != -1) then {
            _malus = _malus * _malus_multipliers;
        };
    } forEach btc_buildings_categories_multipliers;
};

if (btc_debug) then {
    [format ["%1 to %2. Malus: %3", _classname, typeOf _to, _malus], __FILE__, [btc_debug, false]] call btc_debug_fnc_message;
};

_malus call btc_rep_fnc_change;
