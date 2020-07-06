
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_damageLoop

Description:
    Apply chemical damage constantly.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_chem_damageLoop;
    (end)

Author:
    Vdauphin, Zakant

---------------------------------------------------------------------------- */

if !(btc_p_chem) exitWith {};

private _bodyParts = ["head","body","hand_l","hand_r","leg_l","leg_r"];
private _handle = [{
    params ["_args", "_handle"];
    _args params ["_contaminated", "_bodyParts", "_cfgGlasses"];

    if (_contaminated isEqualTo []) exitWith {};

    private _periode = 3 / ({local _x} count _contaminated);
    private _aiCounter = 0;

    {
        if (local _x) then {
            [{
                _this call btc_fnc_chem_damage;
            }, [_x, _bodyParts, _cfgGlasses], _aiCounter * _periode] call CBA_fnc_waitAndExecute;
            _aiCounter = _aiCounter + 1;
        } else {
            ["btc_chem_applyDamage", [_x], _x] call CBA_fnc_targetEvent;
        };

        if (btc_debug || btc_debug_log) then {
            [format ["Applying chemical damage to: %1", _x], __FILE__, [btc_debug, btc_debug_log]] call btc_fnc_debug_message;
        };
    } forEach _contaminated;
}, 3, [btc_chem_contaminated, _bodyParts, configFile >> "CfgGlasses"]] call CBA_fnc_addPerFrameHandler;
