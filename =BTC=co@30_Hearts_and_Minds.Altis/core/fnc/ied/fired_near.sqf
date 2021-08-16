
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_fired_near

Description:
    This check if bullets/grenade are trow around IED created during the mission and trigger them.

Parameters:
    _ied_list - List of IED created in any city. [Array]

Returns:
    _PFH_id - Id of the CBA_fnc_addPerFrameHandler. [Number]

Examples:
    (begin example)
        _PFH_id = [btc_ied_list] call btc_ied_fnc_fired_near;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_ied_list", btc_ied_list, [[]]]
];

private _cfgAmmo = configFile >> "cfgAmmo";

[{
    params ["_args", "_id"];
    _args params [
        ["_ied_list", [], [[]]],
        ["_cfgAmmo", configNull, [configNull]],
        ["_detected_grenade", [], [[]]]
    ];

    {
        _x params ["_ied", "_wreck", "_pos"];

        if (alive _ied && !isNull _ied) then {
            private _list = _pos nearObjects ["Default", 2];
            _list = _list select {
                private _object = _x;
                _object != _ied &&
                {(["SmokeShell", "FlareCore", "IRStrobeBase", "GrenadeHand_stone", "Smoke_120mm_AMOS_White", "TMR_R_DG32V_F"] findIf {_object isKindOf _x} isEqualTo -1)}
            };
            {
                private _bullet = _x;
                if (["TimeBombCore", "BombCore", "Grenade"] findIf {_bullet isKindOf _x} != -1) then {
                    if !(_bullet in _detected_grenade) then {
                        _detected_grenade pushBack _bullet;
                        [{!alive (_this select 2)}, {
                            params ["_wreck", "_ied", "_bullet", "_detected_grenade"];

                            if (alive _ied) then {
                                [_wreck, _ied] call btc_ied_fnc_boom;
                                if (0.5 < random 1) then {
                                    [getPos _wreck] call btc_rep_fnc_call_militia;
                                };
                            };
                            {
                                if (isNull _x) then {
                                    _detected_grenade deleteAt _forEachIndex;
                                };
                            } forEach _detected_grenade;
                        }, [_wreck, _ied, _bullet, _detected_grenade]] call CBA_fnc_waitUntilAndExecute;
                    };
                } else {
                    private _bullet_type = typeOf _bullet;
                    private _explosive = getNumber (_cfgAmmo >> _bullet_type >> "explosive") > 0;
                    private _caliber = getNumber (_cfgAmmo >> _bullet_type >> "caliber") > 1.6;
                    if (_explosive || _caliber) then {
                        if (alive _ied) then {
                            [_wreck, _ied] call btc_ied_fnc_boom;
                            if (0.5 < random 1) then {
                                [getPos _wreck] call btc_rep_fnc_call_militia;
                            };
                        };
                    };
                };
            } forEach _list;
        } else {
            _ied_list deleteAt _forEachIndex;
        };
    } forEach _ied_list;
}, 0.01, [_ied_list, _cfgAmmo, []]] call CBA_fnc_addPerFrameHandler;
