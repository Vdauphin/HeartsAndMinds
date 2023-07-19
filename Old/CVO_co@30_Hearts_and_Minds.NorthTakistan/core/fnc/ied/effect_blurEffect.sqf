
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_effect_blurEffect

Description:
    Add blur effect on player camera.

Parameters:
    _pos - Position of the explosion. [Array]
    _caller - Player. [Object]

Returns:

Examples:
    (begin example)
        [getPos player, player] call btc_ied_fnc_effect_blurEffect;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_caller", objNull, [objNull]]
];

if !(isPlayer _caller) exitWith {};
if (alive _caller) then {
    private _distance = (getPos _caller) distance _pos;

    //blurry screen with cam shake
    if (_distance < 40) then {
        [] spawn {
            addCamShake [1, 3, 3];

            private _blur = ppEffectCreate ["DynamicBlur", 474];
            _blur ppEffectEnable true;
            _blur ppEffectAdjust [0];
            _blur ppEffectCommit 0;

            waitUntil {ppEffectCommitted _blur};

            _blur ppEffectAdjust [10];
            _blur ppEffectCommit 0;

            _blur ppEffectAdjust [0];
            _blur ppEffectCommit 5;

            waitUntil {ppEffectCommitted _blur};

            _blur ppEffectEnable false;
            ppEffectDestroy _blur;
        };
    };
};
