
/* ----------------------------------------------------------------------------
Function: btc_fnc_moveOut

Description:
    Move out crew of a vehicle each frame to avoid dead body colliding.

Parameters:
    _crew - Crew array. [Array]

Returns:

Examples:
    (begin example)
        crew cursorObject call btc_fnc_moveOut;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (_this isEqualTo []) exitWith {};

moveOut (_this deleteAt 0);
[btc_fnc_moveOut, _this] call CBA_fnc_execNextFrame;
