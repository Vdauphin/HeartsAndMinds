
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_place

Description:
    Carry and place an object with keys.

Parameters:
    _placing_obj - Object to place. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_log_fnc_place;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_placing_obj", objNull, [objNull]]
];

btc_log_placing_obj = _placing_obj;

[btc_log_placing_obj, clientOwner] remoteExecCall ["setOwner", 2];

hint composeText [
    localize "STR_BTC_HAM_LOG_PLACE_HINT1", //Q/Z to raise/lower the object
    lineBreak,
    localize "STR_BTC_HAM_LOG_PLACE_HINT2", //X/C to rotate the object
    lineBreak,
    localize "STR_BTC_HAM_LOG_PLACE_HINT3", //F/R to tilt the object
    lineBreak,
    localize "STR_BTC_HAM_LOG_PLACE_HINT4" //SHIFT to increase the movement
];

btc_log_placing = true;
btc_log_placing_dir = 180;
btc_log_rotating_dir = 0;
btc_log_ptich_dir = 0;

//add action ACE
private _actionEH = [player, "DefaultAction", {true}, {btc_log_placing = false;}] call ace_common_fnc_addActionEventHandler;

//show mouse hint for release
[localize "STR_BTC_HAM_LOG_PLACE_RELEASE", ""] call ace_interaction_fnc_showMouseHint;

//add actions to keys
private _place_EH_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", btc_log_fnc_place_key_down];

[player] call ace_weaponselect_fnc_putWeaponAway;
player forceWalk true;

[btc_log_placing_obj, false] remoteExecCall ["enableSimulationGlobal", 2];

private _bbr = 0 boundingBoxReal btc_log_placing_obj;

btc_log_placing_h = (btc_log_placing_obj modelToWorldVisual [0, 0, 0] select 2) - (player modelToWorldVisual [0, 0, 0] select 2);
btc_log_placing_d = 1.5 + abs(((_bbr select 1) select 1) - ((_bbr select 0) select 1));

[{local _this}, {
    _this attachTo [player, [0, btc_log_placing_d, btc_log_placing_h]];
    _this setDir btc_log_placing_dir;
}, btc_log_placing_obj] call CBA_fnc_waitUntilAndExecute;

[{
    params ["_arguments", "_idPFH"];

    if (!alive player || player getVariable ["ACE_isUnconscious", false] || !btc_log_placing || (vehicle player != player)) then {
        _arguments params ["_placing_obj", "_actionEH", "_place_EH_keydown"];

        //remove PFH
        [_idPFH] call CBA_fnc_removePerFrameHandler;

        [_placing_obj, true] remoteExecCall ["enableSimulationGlobal", 2];
        detach _placing_obj;

        player forceWalk false;

        btc_log_placing_obj = objNull;
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", _place_EH_keydown];

        hintSilent "";

        //remove mouse hint
        call ace_interaction_fnc_hideMouseHint;

        // remove drop action
        [player, "DefaultAction", _actionEH, -1] call ace_common_fnc_removeActionEventHandler;

        btc_log_placing = false; // reset flag
    };
}, 0.5, [_placing_obj, _actionEH, _place_EH_keydown]] call CBA_fnc_addPerFrameHandler;
