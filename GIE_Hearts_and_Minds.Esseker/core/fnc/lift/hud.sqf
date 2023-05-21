
/* ----------------------------------------------------------------------------
Function: btc_lift_fnc_hud

Description:
    Fill me when you edit me !

Parameters:

Returns:

Examples:
    (begin example)
        _result = [] call btc_lift_fnc_hud;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

btc_lift_hud = !btc_lift_hud;
if !(btc_lift_hud) exitWith {};

disableSerialization;

939996 cutRsc ["btc_lift_hud", "PLAIN"];
private _ui        = uiNamespace getVariable "btc_lift_hud";
private _radar_background  = _ui displayCtrl 1001;
private _radar     = _ui displayCtrl 1002;
private _obj_img   = _ui displayCtrl 1003;
private _obj_pic   = _ui displayCtrl 1004;
private _arrow     = _ui displayCtrl 1005;
private _obj_name  = _ui displayCtrl 1006;
private _obj_alt    = _ui displayCtrl 1007;
private _array_hud = [_radar_background, _radar, _obj_img, _obj_pic, _arrow, _obj_name, _obj_alt];
{_x ctrlShow true;} forEach _array_hud;
_obj_img ctrlShow false;

private _arrow_up   = "\A3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa";
private _arrow_down = "\A3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa";
private _complete   = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
private _incomplete = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";

[btc_lift_fnc_hudLoop, 0,
    [_arrow_up, _arrow_down, _complete, _incomplete, _obj_img, _obj_pic, _arrow, _obj_name, _obj_alt]
] call CBA_fnc_addPerFrameHandler;
