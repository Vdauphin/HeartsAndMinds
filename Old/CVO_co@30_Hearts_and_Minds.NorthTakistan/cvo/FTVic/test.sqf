test.sqf

_condition = {
    true
};

_statement = {
    params ["_target", "_player", "_params"];
    diag_log format ["_statement [%1, %2, %3]", _target, _player, _params];

    // Run on hover:
    ["ace_common_displayTextStructured", ["someone is thinking of giving you items", 1.5, _target], [_target]] call CBA_fnc_targetEvent;
};

_insertChildren = {
    params ["_target", "_player", "_params"];
    diag_log format ["_insertChildren [%1, %2, %3]", _target, _player, _params];

    // Add children to this action
    private _actions = [];
    {
        private _childStatement = {diag_log format ["givingItem %1", _this]; _target addItem (_this select 2);};
        private _action = [format ["item:%1",_x], _x, "", _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
        _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
    } forEach (items _player);

    _actions
};
_modifierFunc = {
    params ["_target", "_player", "_params", "_actionData"];
    diag_log format ["_modifierFunc [%1, %2, %3]", _target, _player, _params];

    // Modify the action - index 1 is the display name, 2 is the icon...
    _actionData set [1, format ["Give Items: %1", count (items player)]];
};

_action = ["GiveItems", "?","",_statement,_condition,_insertChildren,[123],"",4,[false, false, false, true, false], _modifierFunc] call ace_interact_menu_fnc_createAction;
[q3, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
