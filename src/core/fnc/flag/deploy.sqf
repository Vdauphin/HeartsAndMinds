
/* ----------------------------------------------------------------------------
Function: btc_flag_fnc_deploy

Description:
    Create actions with all flag from btc_flag_textures.

Parameters:
    _target - Is the object being interacted with. [Object]
    _player - Is ace_player. [Object]
    _params - Is the optional action parameters. (default [])

Returns:
    _actions - ACE action generated for redeploy. [Boolean]

Examples:
    (begin example)
        [] call btc_flag_fnc_deploy;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    "_target",
    "_player",
    "_params"
];

private _childStatement = {
    params ["_target", "_player", "_params"];
    _target forceFlagTexture _params;
};

btc_flag_textures apply {
    private _action = ["btc_flag" + _x, "", _x, _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
    [_action, [], _target]
}
