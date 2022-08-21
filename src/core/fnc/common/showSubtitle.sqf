
/* ----------------------------------------------------------------------------
Function: btc_fnc_showSubtitle

Description:
    Show text as a subtitle.

Parameters:
    _from - Name of the person speaking [String]
    _text - Contents of the subtitle [String]
    _lineBreak - Add a line break [Boolean]
    _colorFrom - HEX color for speaker (#RGB or #ARGB) [String]
    _colorText - HEX color for content (#RGB or #ARGB) [String]
    _fontText - Font (https://community.bistudio.com/wiki/FXY_File_Format#Available_Fonts) [String]

Returns:

Examples:
    (begin example)
        ["Some Guy","How do yo do?"] call btc_fnc_showSubtitle;
        ["Darth Vader","Come to the dark side. We have cookies!", false, "#ed2939"] call btc_fnc_showSubtitle;
        ["Luke Skywalker","Whhhhhhyyyyyyyy", true, "#1768d3", nil, "PuristaBold"] call btc_fnc_showSubtitle;
    (end)

Author:
    Thomas Ryan

---------------------------------------------------------------------------- */

#define WAIT         10
#define POS_W        (0.4 * safeZoneW)
#define POS_H        (safeZoneH)
#define POS_X        (0.5 - POS_W / 2)
#define POS_Y        (safeZoneY + (6/8) * safeZoneH)
#define POS_Y_CAM    (safeZoneY + (31/32) * safeZoneH)

disableSerialization;
// Create display and control
"btc_fnc_showSubtitle" cutRsc ["RscDynamicText", "PLAIN"];
[{private _display = uiNamespace getVariable "BIS_dynamicText"; !(isNull _display)}, {

    params [
        ["_from", "", [""]],
        ["_text", "", [""]],
        ["_lineBreak", false, [false]],
        ["_colorFrom", "#d4cd00", [""]], //default color: gold
        ["_colorText", "#FFFFFF", [""]], //default color: white
        ["_fontText", "RobotoCondensedBold", [""]]
    ];

    private _display = uiNamespace getVariable "BIS_dynamicText";
    private _ctrl = _display ctrlCreate ["RscStructuredText",-1];
    uiNamespace setVariable ["BIS_dynamicText", displayNull];

    _ctrl ctrlSetBackgroundColor (["Subtitles","Background"] call bis_fnc_displayColorGet);
    //_ctrl ctrlSetBackgroundColor [0, 0, 0, 0.5]; //optional? - for better readability
    _ctrl ctrlSetTextColor (["Subtitles", "Text"] call bis_fnc_displayColorGet);
    _ctrl ctrlSetPosition [POS_X, POS_Y, POS_W, POS_H];
    _ctrl ctrlCommit 0;

    // Show subtitle
    _ctrl ctrlSetStructuredText parseText format [
        if (_from isEqualTo "") then {
            "<t align='center' shadow='1' color='%5' size='%3' font=%6>%2</t>"
        } else {
            if (_lineBreak) then {
                "<t align='center' shadow='1' color='%4' size='%3' font=%6>%1: <br /></t><t align='center' color='%5' shadow='1' size='%3' font=%6>%2</t>"
            } else {
                "<t align='center' shadow='1' color='%4' size='%3' font=%6>%1: </t><t align='center' color='%5' shadow='1' size='%3' font=%6>%2</t>"
            };
        },
        toUpper _from, _text, (safezoneH * 0.65) max 1, _colorFrom, _colorText, _fontText
    ];

    private _textHeight = ctrlTextHeight _ctrl;
    _ctrl ctrlSetPosition [POS_X, POS_Y - _textHeight, POS_W, _textHeight];
    _ctrl ctrlcommit 0;

    [{
        params ["_ctrl"];

        // Hide subtitle
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0.5;
    }, [_ctrl], WAIT] call CBA_fnc_waitAndExecute;
}, _this] call CBA_fnc_waitUntilAndExecute;
