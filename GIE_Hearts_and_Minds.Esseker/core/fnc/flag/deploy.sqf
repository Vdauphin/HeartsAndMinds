
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

private _condition = if (btc_p_flag isEqualTo 2) then {
    {leader player isEqualTo player};
} else {
    {true};
};

btc_flag_textures apply {
    private _action = ["btc_flag" + _x, "", _x, _childStatement, _condition, {}, _x] call ace_interact_menu_fnc_createAction;
    [_action, [], _target]
}
