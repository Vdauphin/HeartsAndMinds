
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_add_grenade

Description:
    Add grenade to a unit.

Parameters:
    _unit - Unit where a grenade will be added. [Object]

Returns:

Examples:
    (begin example)
        [_unit] call btc_civ_fnc_add_grenade;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

_unit addMagazines [selectRandom btc_g_civs, 1];

_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon"];

    if (_weapon isEqualTo "Throw") then {
        _unit removeEventHandler ["Fired", _thisEventHandler];

        private _group = createGroup [civilian, true];
        _group setVariable ["btc_city", group _unit getVariable ["btc_city", objNull]];
        [_unit] joinSilent _group;

        [{
            params ["_unit"];

            [group _unit] call btc_civ_fnc_addWP;
        }, [_unit], 20] call CBA_fnc_waitAndExecute;
    };
}];
