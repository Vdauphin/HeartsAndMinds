
/* ----------------------------------------------------------------------------
Function: btc_debug_fnc_marker

Description:
    Fill me when you edit me !

Parameters:
    _display - [Control]

Returns:

Examples:
    (begin example)
        _result = [] call btc_debug_fnc_marker;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_display", controlNull, [controlNull]]
];

private _units = btc_units_owners apply {_x select 0};
private _owners = btc_units_owners apply {_x select 1};

private _cfgVehicles = configFile >> "CfgVehicles";
{
    private _typeof = typeOf _x;

    private _alpha = 1;
    if ((_owners select _forEachindex) isNotEqualTo 2) then {
        _alpha = 0.3;
    };

    private _color = [];
    switch (side _x) do {
        case (west) : {_color = [0, 0, 1, _alpha]};
        case (east) : {_color = [1, 0, 0, _alpha]};
        case (independent) : {_color = [0, 1, 0, _alpha]};
        default {_color = [1, 1, 1, _alpha]};
    };

    private _text = "";
    if (leader group _x isEqualTo _x) then {
        _text = format ["%1 (%2)", _typeof, group _x getVariable ["btc_patrol_id", ""]];
    } else {
        if ((_x isKindOf "car") OR (_x isKindOf "tank") OR (_x isKindOf "ship") OR (_x isKindOf "air")) then {
            _text = "";
            _color = [1, 0, 0.5, _alpha];
        } else {
            _text = format ["%1", _typeof];
        };
    };

    _display drawIcon [
        getText (_cfgVehicles >> _typeof >> "Icon"),
        _color,
        visiblePosition _x,
        20,
        20,
        direction _x,
        _text,
        0,
        0.05
    ];
} forEach _units;

{
    private _agent = agent _x;
    if !(isNull _agent) then {
        _display drawIcon [
            getText (configOf _agent >> "Icon"),
            [0.5, 0.5, 0.5, [1, 0.3] select (local _agent)],
            visiblePosition _agent,
            20,
            20,
            direction _agent,
            "",
            0,
            0.05
        ];
    };
} forEach agents;
