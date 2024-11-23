
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_grave

Description:
    Add reputation when a player put dead civil in grave.

Parameters:
    _restingPlace - Resting Place [Object]
    _medic - Medic [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] call btc_rep_fnc_grave;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_restingPlace", "_medic"];

private _church = nearestTerrainObjects [_restingPlace, ["CHURCH", "CHAPEL"], 50];
if (_church isEqualTo []) exitWith {};
_church = _church select 0;

[btc_rep_bonus_grave, _medic] call btc_rep_fnc_change;

private _city = [_church, values btc_city_all, false] call btc_fnc_find_closecity;
private _cachingRadius = _city getVariable "cachingRadius";

if (_city distance _church < _cachingRadius) then {
    private _graveList = _city getVariable ["btc_rep_graves", []];
    _graveList pushBack [
        getPosASL _restingPlace,
        getDir _restingPlace,
        typeOf _restingPlace
    ];
    _city setVariable ["btc_rep_graves", _graveList];

    private _graveList = _city getVariable ["btc_civ_graves", []];
    _graveList pushBack _restingPlace;
    _city setVariable ["btc_civ_graves", _graveList];
};
