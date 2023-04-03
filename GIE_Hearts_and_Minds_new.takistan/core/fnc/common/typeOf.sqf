
/* ----------------------------------------------------------------------------
Function: btc_fnc_typeOf

Description:
    Get the classe name of an object. Very usefull for terrain objects.

Parameters:
    _object - Object to get the typeOf. [Object]

Returns:
    _calssenameArray - Array of classename. [Array]

Examples:
    (begin example)
        a = nearestTerrainObjects [player, [], 3, false];
        [[a select 0]] call btc_fnc_typeOf;
    (end)

Author:
    PabstMirror

---------------------------------------------------------------------------- */

params [
    ["_objectArray", [], [[]]]
];

if (isNil "btc_modelNamespace") then {
    btc_modelNamespace = createHashMap;
};

private _cfgVehicles = configFile >> "cfgVehicles";

_objectArray apply {
    private _type = typeOf _x;

    if (_type == "") then {
        private _model = (getModelInfo _x) select 1;
        if (_model == "") exitWith {""};
        _type = btc_modelNamespace get _model;
        if (isNil "_type") then {
            private _objects = configProperties [
                _cfgVehicles,
                "(isClass _x) && {(((getText (_x >> 'model')) select [1]) == _model) || {(getText (_x >> 'model')) == _model}}",
                true
            ];
            if (_objects isEqualTo []) then {
                _type = "";
            } else {
                _type = configName (_objects select 0);
            };
            btc_modelNamespace set [_model, _type];
        };
    };
    _type
};
