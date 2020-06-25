
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

private _handle = [{
    params ["_args", "_handle"];
    private _contaminated = _args select 0;
    
    {
        if (btc_debug || btc_debug_log) then {
            [format ["Applying chemical damage to: %1", _x], __FILE__, [btc_debug, btc_debug_log]] call btc_fnc_debug_message;
        };
        ["btc_chem_applydamage", [_x], _x] call CBA_fnc_targetEvent;
    } forEach _contaminated;
}, 3, [btc_chem_contaminated]] call CBA_fnc_addPerFrameHandler;
