
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_add_veh

Description:
    Add vehicle to the wreck system.

Parameters:
    _veh - Vehicle to add in wreck system. [Object]
    _p_chem - Activate chemical propagation. [Boolean]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_db_add_veh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]],
    ["_p_chem", btc_p_chem, [false]]
];

if !(isServer) exitWith {
    _veh remoteExecCall ["btc_fnc_db_add_veh", 2];
};

btc_vehicles pushBackUnique _veh;
_veh addMPEventHandler ["MPKilled", {
    params ["_unit"];
    if (
        isServer &&
        {_unit getVariable ["btc_killed", true]} // https://feedback.bistudio.com/T149510
    ) then {
        _unit setVariable ["btc_killed", false];
        _this call btc_fnc_eh_veh_killed;
    };
}];
if ((isNumber (configfile >> "CfgVehicles" >> typeOf _veh >> "ace_fastroping_enabled")) && !(typeOf _veh isEqualTo "RHS_UH1Y_d")) then {
    [_veh] call ace_fastroping_fnc_equipFRIES
};

if (_p_chem) then {
    _veh addEventHandler ["GetIn", {
        [_this select 0, _this select 2] call btc_fnc_chem_propagate;
        _this
    }];
};
