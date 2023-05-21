
/* ----------------------------------------------------------------------------
Function: btc_spect_fnc_electronicFailure

Description:
    Apply electronic failure.

Parameters:
    _vehicles - Array of vehicles. [Array]

Returns:

Examples:
    (begin example)
        [[vehicle (allPlayers select 0)]] call btc_spect_fnc_electronicFailure;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicles", [], [[]]]
];

{
    if (_x isKindOf "Air") then  {
        if (selectRandom [false, true] && {_x getHitPointDamage "hitavionics" < 1}) then {
            [_x, ["hitavionics", 1.0]] remoteExecCall ["setHitPointDamage", _x];
        } else {
            if (isCollisionLightOn _x && selectRandom [false, true]) then {
                [_x, false] remoteExecCall ["setCollisionLight", _x];
            };
        };
    };
    if (isLightOn _x && selectRandom [false, true]) then {
        [_x, false] remoteExecCall ["setPilotLight", _x];
    } else {
        if (isEngineOn _x && selectRandom [false, true]) then {
            [_x, false] remoteExecCall ["engineOn", _x];
        };
    };
} forEach _vehicles;
