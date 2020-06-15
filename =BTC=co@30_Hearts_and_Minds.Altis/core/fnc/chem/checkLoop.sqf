
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_checkLoop

Description:
    Loop over chemical objects, showers and check if player/objects is around. If yes, decontaminate player/objects or set damage to player.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_chem_checkLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if !(btc_p_chem) exitWith {};

private _bodyParts = ["head","body","hand_l","hand_r","leg_l","leg_r"];

[{
    params ["_args", "_id"];
    _args params ["_contaminated", "_decontaminate", "_bodyParts", "_cfgGlasses"];

    if (_contaminated isEqualTo []) exitWith {};
    
    // Check if all contaminated units are alive
    {
        if(!alive _x) then {

        };
    } forEach _contaminated;

    private _allUnitsUAV = [];
    {
        _allUnitsUAV append crew _x;
    } forEach allUnitsUAV;

    private _units = allUnits - _allUnitsUAV;
    private _objtToDecontaminate = [];
    private _unitsContaminated = _contaminated select {_x in _units};

    // Check if objects are within a shower and are losing chem level
    {
        (0 boundingBoxReal _x) params ["_p1", "_p2"];
        private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
        private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
        private _pos = getPosWorld _x;
        private _maxHeight = abs ((_p2 select 2) - (_p1 select 2)) + (_pos select 2);
        private _sorted = _contaminated;
        if (_x isKindOf "DeconShower_01_F") then {
            _sorted = _unitsContaminated; // Small shower can only decontaminate units
        };
        _objtToDecontaminate append (_sorted inAreaArray [_pos, _maxWidth/2, _maxLength/2, getDir _x, true, _maxHeight]);
    } forEach (_decontaminate select {_x animationSourcePhase "valve_source" isEqualTo 1});

    // Loop through all objects that have been identified to be decontaminated
    {
        if([_x] call btc_fnc_chem_reduceContamination) then {
            _contaminated deleteAt (_contaminated find _x);
        };

        {
            if([_x] call btc_fnc_chem_reduceContamination) then {
                _contaminated deleteAt (_contaminated find _x);
                {
                    _x setVariable ["btc_chem_level", 0, true];  // On the second layer, objects are either _contamined or not.
                    _contaminated deleteAt (_contaminated find _x);
                } forEach (_x getVariable ["ace_cargo_loaded", []]);   
            };
        } forEach ((_x getVariable ["ace_cargo_loaded", []]) + crew _x);
    } forEach _objtToDecontaminate;

    // Send new list of contaminated objects to all players
    publicVariable "btc_chem_contaminated";

    // If no contaminated units remain, no propagation can happen so exit now
    if (_contaminated isEqualTo []) exitWith {};

    // Array to store new contaminated units
    private _unitContaminate = [];

    // Loop over all units contaminated
    {
        // Assign the current source to variable
        private _source = _x;

        // Get source position and chem level
        private _pos = getPosWorld _source;
        private _chemlevel = _source getVariable ["btc_chem_level", 0];

        // Find all possible targets within range and loop through them
        {
            private _spreadLevel = [_source, _chemlevel, _x] call btc_fnc_chem_getSpreadLevel;
            private _targetChemlevel = _x getVariable ["btc_chem_level", 0];
            _x setVariable ["btc_chem_level", _spreadLevel max _targetChemlevel, true];

            if (!(_x in _contaminated)) then {
                _unitContaminate append _x;
            }
        } forEach _units inAreaArray [_pos, btc_chem_maxrange, btc_chem_maxrange, 0, false, btc_chem_maxrange];
    } forEach _contaminated;

    // If no units get contaminated stop here
    if (_unitContaminate isEqualTo []) exitWith {};

    // Add the new contaminated units to the global list
    {
        _contaminated pushBackUnique _x;
        if (btc_debug || btc_debug_log) then {
            [format ["Start: %1", _x], __FILE__, [btc_debug, btc_debug_log]] call btc_fnc_debug_message;
        };
    } forEach _unitContaminate;

    // Send new list of contaminated objects to all players
    publicVariable "btc_chem_contaminated";

}, 3.1, [btc_chem_contaminated, btc_chem_decontaminate, _bodyParts, configFile >> "CfgGlasses"]] call CBA_fnc_addPerFrameHandler;
