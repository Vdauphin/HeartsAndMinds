
/* ----------------------------------------------------------------------------
Function: btc_chem_fnc_checkLoop

Description:
    Loop over chemical objects, showers and check if player/objects is around. If yes, decontaminate player/objects or set damage to player.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_chem_fnc_checkLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if !(btc_p_chem) exitWith {};

private _bodyParts = ["head","body","hand_l","hand_r","leg_l","leg_r"];

[{
    params ["_args", "_id"];
    _args params ["_contaminated", "_decontaminate", "_range", "_bodyParts", "_cfgGlasses"];

    if (_contaminated isEqualTo []) exitWith {};

    private _allUnitsUAV = [];
    {
        _allUnitsUAV append crew _x;
    } forEach allUnitsUAV;
    private _units = allUnits - _allUnitsUAV;
    private _objtToDecontaminate = [];
    private _unitsContaminated = _contaminated arrayIntersect _units;
    {
        (0 boundingBoxReal _x) params ["_p1", "_p2"];
        private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
        private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
        private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
        private _sorted = _contaminated;
        if (_x isKindOf "DeconShower_01_F") then {
            _sorted = _unitsContaminated; // Small shower can only decontaminate units
        };
        _objtToDecontaminate append (_sorted inAreaArray [ASLToAGL getPosASL _x, _maxWidth/2, _maxLength/2, getDir _x, true, _maxHeight]);
    } forEach (_decontaminate select {_x animationSourcePhase "valve_source" isEqualTo 1});
    {
        if (!(local _x) && {_x in _units}) then {
            ["btc_chem_decontaminated", [_x], _x] call CBA_fnc_targetEvent;
        };
        _contaminated deleteAt (_contaminated find _x);
        {
            if (!(local _x) && {_x in _units}) then {
                ["btc_chem_decontaminated", [_x], _x] call CBA_fnc_targetEvent;
            };
            _contaminated deleteAt (_contaminated find _x);
            {
                _contaminated deleteAt (_contaminated find _x);
            } forEach (_x getVariable ["ace_cargo_loaded", []]);
        } forEach ((_x getVariable ["ace_cargo_loaded", []]) + crew _x);
        publicVariable "btc_chem_contaminated";
    } forEach _objtToDecontaminate;

    if (_contaminated isEqualTo []) exitWith {};

    private _unitContaminate = [];
    private _tempRange = _range;
    {
        if (_x in _units) then {
            _tempRange = _range / 1.5;
        };
        _unitContaminate append (_units inAreaArray [ASLToAGL getPosASL _x, _tempRange, _tempRange, 0, false, 2]);
    } forEach _contaminated;

    if (_unitContaminate isEqualTo []) exitWith {};

    private _periode = 3 / count _unitContaminate;
    {
        private _notAlready = _contaminated pushBackUnique _x > -1;
        if (_notAlready) then {
            publicVariable "btc_chem_contaminated";
        };
        if (local _x) then {
            [btc_chem_fnc_damage, [_x, _notAlready, _bodyParts, _cfgGlasses], _forEachIndex * _periode] call CBA_fnc_waitAndExecute;
        } else {
            if (_notAlready) then {
                [_x] remoteExecCall ["btc_chem_fnc_damageLoop", _x];
            };
        };
    } forEach _unitContaminate;
}, 3.1, [btc_chem_contaminated, btc_chem_decontaminate, btc_chem_range, _bodyParts, configFile >> "CfgGlasses"]] call CBA_fnc_addPerFrameHandler;
