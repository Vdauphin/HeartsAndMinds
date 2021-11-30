
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_suicider_activeLoop

Description:
    Detect and force the suicider to run in the direction of the soldier nearby.

Parameters:
    _suicider - Suicider. [Object]
    _trigger - Trigger triggring the suicider explosion. [Object]

Returns:

Examples:
    (begin example)
        [_suicider, _trigger] call btc_ied_fnc_suicider_activeLoop;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

[{
    params ["_suicider", "_trigger"];

    if (alive _suicider) then {
        private _array = _suicider nearEntities [btc_player_type, 30];
        if (_array isNotEqualTo []) then {
            _suicider doMove (position (_array select 0));
        };
        _this call btc_ied_fnc_suicider_activeLoop;
    } else {
        deleteVehicle _trigger;
        group _suicider setVariable ["suicider", false];

        if (btc_debug_log) then {
            [format ["_suicider = %1 POS %2 END LOOP", _suicider, getPos _suicider], __FILE__, [false]] call btc_debug_fnc_message;
        };
    };
}, _this, 0.5] call CBA_fnc_waitAndExecute;
