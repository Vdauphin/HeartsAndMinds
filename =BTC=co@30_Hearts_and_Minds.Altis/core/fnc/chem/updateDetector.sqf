
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_updateDetector

Description:
    Refresh chemical level on the chemical detector screen when it is open.

Parameters:
    _objt - Screen control. [Control]

Returns:

Examples:
    (begin example)
        private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
        private _obj = _ui displayCtrl 101;
        [_obj] call btc_fnc_chem_updateDetector;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params ["_arguments", "_idPFH"];
    _arguments params [
        ["_obj", controlNull, [controlNull]]
    ];

    if !(visibleWatch) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    if (btc_chem_contaminated isEqualTo []) exitWith {
        _obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
    };

    private _level = selectMax (btc_chem_contaminated apply {[_x, _x getVariable ["btc_chem_level", 0], player] call  btc_fnc_chem_getSpreadLevel});
    _obj ctrlAnimateModel ["Threat_Level_Source", _level, true]; //Displaying a threat level (value between 0.0 and 1.0)
}, 0.3, _this] call CBA_fnc_addPerFrameHandler;
