
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_deleteLoop

Description:
    Remove wreck generated around IED.

Parameters:
    _unit - Not used. [Object]
    _role - Not used. [String]
    _vehicle - Vehice used. [Object]

Returns:

Examples:
    (begin example)
        [vehicle player] call btc_ied_fnc_deleteLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_role", "", [""]],
    ["_vehicle", objNull, [objNull]]
];

if !(_vehicle isKindOf "B_APC_Tracked_01_CRV_F" || _vehicle isKindOf "rhsusf_stryker_m1132_m2_base") exitWith {};

if (btc_ied_deleteOn > -1) exitWith {};

(0 boundingBoxReal _vehicle) params ["_p1", "_p2"];
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));

btc_ied_deleteOn = [{
    params ["_arguments", "_idPFH"];
    _arguments params [
        ["_vehicle", objNull, [objNull]],
        ["_minDistance", 0, [0]]
    ];

    private _ieds = allSimpleObjects [] - allSimpleObjects btc_type_blacklist;
    _ieds = (_ieds inAreaArray [getPosWorld _vehicle, 50, 50]) select {
        !("ace_drop" in ((getModelInfo _x) select 0))
    };
    if (_ieds isEqualTo []) exitWith {};

    _ieds = _ieds apply {[_x distance _vehicle, _x]};
    _ieds sort true;

    (_ieds select 0) params ["_distance", "_ied"];
    (0 boundingBoxReal _ied) params ["_p1", "_p2"];
    private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
    private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
    if (
        _distance < (_minDistance + (_maxWidth max _maxLength) / 2) &&
        {allMines inAreaArray [getPosWorld _ied, 2.5, 2.5] isEqualTo []} &&
        {[getPos _vehicle, getDir _vehicle, 40, getPos _ied] call BIS_fnc_inAngleSector}
    ) then {
        private _pos = getPosATL _ied;
        _ied call CBA_fnc_deleteEntity;
        [btc_rep_bonus_IEDCleanUp, player] remoteExecCall ["btc_rep_fnc_change", 2];
        ["btc_ied_deleted", [_pos, player]] call CBA_fnc_serverEvent;
    };
}, 1, [_vehicle, (_maxWidth max _maxLength) / 2]] call CBA_fnc_addPerFrameHandler;
