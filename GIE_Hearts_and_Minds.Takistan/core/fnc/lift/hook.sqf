
/* ----------------------------------------------------------------------------
Function: btc_lift_fnc_hook

Description:
    Hook a cargo in a diameter of 30m.

Parameters:
    _chopper - Chopper lifting. [Object]

Returns:

Examples:
    (begin example)
        [] spawn btc_lift_fnc_hook;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_chopper", vehicle player, [objNull]]
];

private _array = [_chopper] call btc_lift_fnc_getLiftable;
private _cargo_array = nearestObjects [_chopper, _array, 30];
_cargo_array = _cargo_array - [_chopper];
_cargo_array = _cargo_array select {!(
    _x isKindOf "ACE_friesBase" OR
    _x isKindOf "ace_fastroping_helper"
)};
if (_cargo_array isEqualTo []) exitWith {};
private _cargo = _cargo_array select 0;

{ropeDestroy _x;} forEach ropes _chopper;

private _bbr = getArray (configOf _cargo >> "slingLoadCargoMemoryPoints");
private _ropes_check = [];
if (_bbr isNotEqualTo []) then {
    {
        _ropes_check pushBack (ropeCreate [_chopper, "slingload0", _cargo, _x, 11]);
    } forEach _bbr;
};

private _rope_length = 10;
if ((_bbr isEqualTo []) OR (_ropes_check select {!isNull _x} isEqualTo [])) then {

    _bbr = boundingBoxReal _cargo;
    if (abs((_bbr select 0) select 0) > 5) then {
        _rope_length = 10 + abs((_bbr select 0) select 0);
    };
    ([_cargo] call btc_log_fnc_get_corner_points) params [
        "_rearCorner",
        "_rearCorner2",
        "_frontCorner",
        "_frontCorner2"
    ];

    private _support = _cargo;
    private _bbr_z = 0;
    if (!alive _cargo) then {
        _support = [btc_lift_fnc_hookFake, [_cargo, _chopper]] call CBA_fnc_directCall;
        _bbr_z = _support distance _cargo;
        sleep 0.3;
    };

    ropeCreate [_chopper, "slingload0", _support, [_rearCorner select 0, _rearCorner select 1, _bbr_z], _rope_length];
    ropeCreate [_chopper, "slingload0", _support, [_rearCorner2 select 0, _rearCorner2 select 1, _bbr_z], _rope_length];
    ropeCreate [_chopper, "slingload0", _support, [_frontCorner select 0, _frontCorner select 1, _bbr_z], _rope_length];
    ropeCreate [_chopper, "slingload0", _support, [_frontCorner2 select 0, _frontCorner2 select 1, _bbr_z], _rope_length];
};

if (btc_debug) then {
    [format ["boundingBoxReal : %1 rope length : %2", _bbr, _rope_length], __FILE__, [btc_debug, false]] call btc_debug_fnc_message;
};

private _max_cargo  = getNumber (configOf _chopper >> "slingLoadMaxCargoMass");
private _mass = getMass _cargo;

[_cargo, clientOwner] remoteExecCall ["setOwner", 2];
btc_lifted = true;
sleep 1;
if ((_mass + 400) > _max_cargo) then {
    private _new_mass = _max_cargo - 1000;
    if (_new_mass < 0) then {_new_mass = 50;};
    [_cargo, _new_mass] remoteExecCall ["setMass", _cargo];
};

_chopper setVariable ["cargo", _cargo];

waitUntil {sleep 5; (!alive player || !alive _cargo || !btc_lifted || vehicle player isEqualTo player)};

[_cargo, _mass] remoteExecCall ["setMass", _cargo];
