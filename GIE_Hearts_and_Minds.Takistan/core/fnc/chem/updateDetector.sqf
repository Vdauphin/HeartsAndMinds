
/* ----------------------------------------------------------------------------
Function: btc_chem_fnc_updateDetector

Description:
    Refresh chemical level on the chemical detector screen when it is open.

Parameters:
    _objt - Screen control. [Control]

Returns:

Examples:
    (begin example)
        private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
        private _obj = _ui displayCtrl 101;
        [_obj] call btc_chem_fnc_updateDetector;
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

    private _level = selectMin (btc_chem_contaminated apply {player distance _x});
    if (_level < btc_chem_range) then {
        _level = 1;
    } else {
        _level = (floor (btc_chem_range / _level * 10)) / 10;
    };

    _obj ctrlAnimateModel ["Threat_Level_Source", _level, true]; //Displaying a threat level (value between 0.0 and 1.0)
}, 0.3, _this] call CBA_fnc_addPerFrameHandler;
