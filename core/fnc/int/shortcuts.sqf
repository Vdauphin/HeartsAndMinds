
/* ----------------------------------------------------------------------------
Function: btc_fnc_int_shortcuts

Description:
    Fill me when you edit me !

Parameters:

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_int_shortcuts;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

#include "\a3\editor_f\Data\Scripts\dikCodes.h"
#define BTC_PLAY_FBSOUND true    //set false if you do not want a "key-pressed-feedback" (sound)
#define BTC_FBSOUND "ClickSoft"  //really quiet sound

//Order Stop
["Hearts and Minds: Mission", "btc_HaM_Action_civStop", [localize "STR_BTC_HAM_O_SHORTC_STOP_TITLE", localize "STR_BTC_HAM_O_SHORTC_STOP_NOTE"], { //"Civil Order: Stop", "Order a civilian to stop"
    if (isNull objectParent player) then {
        [1] call btc_fnc_int_orders;
        if (BTC_PLAY_FBSOUND) then {
            playSound BTC_FBSOUND;
        };
    };
}, {}] call CBA_fnc_addKeybind;

//Order Get down
["Hearts and Minds: Mission", "btc_HaM_Action_civGetDown", [localize "STR_BTC_HAM_O_SHORTC_GETDOWN_TITLE", localize "STR_BTC_HAM_O_SHORTC_GETDOWN_NOTE"], { //"Civil Order: Get down", "Order a civilian to get down"
    if (isNull objectParent player) then {
        [2] call btc_fnc_int_orders;
        if (BTC_PLAY_FBSOUND) then {
            playSound BTC_FBSOUND;
        };
    };
}, {}] call CBA_fnc_addKeybind;

//Order Go away
["Hearts and Minds: Mission", "btc_HaM_Action_civGoAway", [localize "STR_BTC_HAM_O_SHORTC_GOAWAY_TITLE", localize "STR_BTC_HAM_O_SHORTC_GOAWAY_NOTE"], { //"Civil Order: Go Away", "Order a civilian to go away"
    if (isNull objectParent player) then {
        [3] call btc_fnc_int_orders;
        if (BTC_PLAY_FBSOUND) then {
            playSound BTC_FBSOUND;
        };
    };
}, {}] call CBA_fnc_addKeybind;
