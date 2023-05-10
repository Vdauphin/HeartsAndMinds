
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_create

Description:
    Create dead bodies from a serialized array of bodies.

Parameters:
    _serializedBodies - Serialized bodies. [Array]

Returns:
    _bodies - Bodies. [Array]

Examples:
    (begin example)
        [] call btc_body_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_serializedBodies", [], [[]]]
];

private _group = createGroup btc_player_side;
_bodies  = _serializedBodies apply {
    _x params ["_type", "_pos", "_dir", "_loadout", "_dogtag", "_isContaminated",
        ["_flagTexture", "", [""]]
    ];
    private _body = _group createUnit [_type, ASLToAGL _pos, [], 0, "CAN_COLLIDE"];
    _body setUnitLoadout _loadout;
    [_body, _dogtag] call btc_body_fnc_dogtagSet;

    if (_isContaminated) then {
        if ((btc_chem_contaminated pushBackUnique _body) > -1) then {
            publicVariable "btc_chem_contaminated";
        };
    };
    _body setDamage 1;
    _body setVariable ["btc_dont_delete", true];
    _body forceFlagTexture _flagTexture;

    [{
        params ["_body", "_dir", "_pos"];
        _body setDir _dir;
        _body setPosASL _pos;
    }, [_body, _dir, _pos], 3] call CBA_fnc_waitAndExecute;

    if (btc_p_body_timeBeforeShowMarker >= 0) then {
        _body call btc_body_fnc_createMarker;
    };

    _body
};
deleteGroup _group;

_bodies
