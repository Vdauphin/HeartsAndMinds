
/* ----------------------------------------------------------------------------
Function: btc_fnc_show_hint

Description:
    Show CBA_fnc_notify.

Parameters:
    _type - Type of CBA_fnc_notify to show. [Number]
    _custom - Argument for custom text. [String, Number]

Returns:

Examples:
    (begin example)
        [0] call btc_fnc_show_hint;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if (isDedicated) exitWith {};

params [
    ["_type", 0, [0]],
    ["_custom", 0, [0, "", []]]
];

private _text = switch (_type) do {
    case 0 : {
        localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_0";
    };
    case 1 : {
        [
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_1"],
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_MU"],
            ['\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa', 0.8, [1, 0, 0]]
        ];
    };
    case 2 : {
        format [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_2", _custom];
    };
    case 3 : {
        localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_3";
    };
    case 5 : {
        [
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_5"],
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_MU"],
            ['\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa', 0.8, [1, 0, 0]]
        ];
    };
    case 7 : {
        format [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_7", _custom];
    };
    case 8 : {
        localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_8";
    };
    case 9 : {
        localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_9";
    };
    case 10 : {
        localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_10";
    };
    case 12 : {
        localize "STR_BTC_HAM_SIDE_CONVOY_STARTCHAT";
    };
    case 14 : {
        [
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_14"],
            [getText (configfile >> "CfgVehicles" >> _custom >> "editorPreview"), 8]
        ];
    };
    case 15 : {
        [
            [localize "STR_BTC_HAM_O_COMMON_SHOWHINTS_15"],
            [getText (configfile >> "CfgVehicles" >> _custom >> "editorPreview"), 8]
        ];
    };
    case 16 : {
        [
            [localize "STR_BTC_HAM_LOG_RWRECK_ISHELO"],
            ["\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"]
        ];
    };
    case 17 : {
        [
            [localize "STR_BTC_HAM_LOG_LPDELETE"],
            ["\z\ace\addons\arsenal\data\iconClearContainer.paa"]
        ];
    };
    case 18 : {
        localize "STR_BTC_HAM_O_FOB_DISMANTLE_H_PROC";
    };
    case 19 : {
        [
            format [localize "STR_BTC_HAM_O_COMMON_REBOOT", _custom], 1.5, [1, 0, 0]
        ];
    };
    case 20 : {
        _custom params ["_color", "_player"];
        [
            [[name _player], [" "]] select (isNull _player),
            ["\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa", 4, _color],
            [" "]
        ];
    };
    case 21 : {
        _custom params ["_color", "_player"];
        [
            [[name _player], [" "]] select (isNull _player || (side group _player isNotEqualTo btc_player_side)),
            ["\a3\Ui_f\data\GUI\Cfg\Debriefing\endDefault_ca.paa", 4, _color],
            [" "]
        ];
    };
    case 22 : {
        localize "STR_BTC_HAM_O_COMMON_TICKETADD";
    };
    case 23 : {
        localize "STR_BTC_HAM_O_COMMON_NOBODYBAG";
    };
    case 24 : {
        format [localize "STR_BTC_HAM_O_COMMON_TICKETSLEFT", _custom];
    };
    case 25 : {
        localize "STR_BTC_HAM_O_COMMON_NOPLAYERFTICKET";
    };
};

_text call CBA_fnc_notify;
