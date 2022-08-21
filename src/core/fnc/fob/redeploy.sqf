
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_redeploy

Description:
    Create child statement to redeploy.

Parameters:
    _target - Is the object being interacted with. [Object]
    _player - Is ace_player. [Object]
    _params - Is the optional action parameters. (default [])

Returns:
    _actions - ACE action generated for redeploy. [Boolean]

Examples:
    (begin example)
        [] call btc_fob_fnc_redeploy;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    "_target",
    "_player",
    "_params"
];

private _actions = [];
private _childStatement = {
    params ["_target", "_player", "_params"];

    if ([] call btc_fob_fnc_redeployCheck) then {[_player, _params, false] call BIS_fnc_moveToRespawnPosition};
};

if (_params isEqualTo "") then { // Redeploy on marker like rallypoints
    {
        private _action = [markerText _x, markerText _x, "\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target];
    } forEach (([btc_player_side, false] call BIS_fnc_getRespawnMarkers) - [btc_respawn_marker]);
} else { // Redeploy on object like FOB/Vehicles
    private _getRespawnPositions = _player call BIS_fnc_getRespawnPositions;
    private _positions = if (_params isEqualTo "Base") then {
        _getRespawnPositions inAreaArray [getMarkerPos "btc_base", btc_fob_minDistance, btc_fob_minDistance]
    } else {
        private _center = [worldSize / 2, worldsize / 2, 0];
        _params params ["_min", "_max"];
        _getRespawnPositions select {
            if (
                alive _x && {!(_x inArea [getMarkerPos "btc_base", btc_fob_minDistance, btc_fob_minDistance, 0, false])}
            ) then {
                private _dir = _center getDir _x;
                _min <= _dir &&
                {_dir < _max}
            } else {
                false
            };
        };
    };

    {
        private ["_identity", "_name", "_pic", "_showName", "_respawnPositions", "_respawnPositionNames", "_respawnPositionNameShow", "_pos"];
        (_x call BIS_fnc_showRespawnMenuPositionName) params ["_FOBName", "_icon"];
        private _action = [_FOBName, _FOBName, _icon, _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target];
    } forEach _positions;
};

_actions
