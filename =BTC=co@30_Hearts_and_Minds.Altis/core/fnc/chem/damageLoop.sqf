
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
        [{
            ["btc_chem_applydamage", [_this], _this] call CBA_fnc_targetEvent;
        }, _x, random 2] call CBA_fnc_WaitAndExecute;
    } forEach _contaminated;
}, 3, [btc_chem_contaminated]] call CBA_fnc_addPerFrameHandler;
