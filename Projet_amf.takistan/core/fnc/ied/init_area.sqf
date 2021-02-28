
/* ----------------------------------------------------------------------------
Function: btc_fnc_ied_init_area

Description:
    Initialize positions of IEDS.

Parameters:
    _city - [Object]
    _area - [Number]
    _n - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_ied_init_area;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_area", 100, [0]],
    ["_n", 1, [0]]
];

private _pos = getPos _city;
private _array = _city getVariable ["ieds", []];

private _active = true;

for "_i" from 1 to _n do {
    private _sel_pos = _pos;
    _sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
    _sel_pos = [_sel_pos, 30, 150, 1, false] call btc_fnc_findsafepos;

    private _type_ied = selectRandom btc_model_ieds;

    private _dir = random 360;

    if (random 1 > 0.3) then {
        private _roads = _sel_pos nearRoads _area;
        if !(_roads isEqualTo []) then {
            private _obj = selectRandom _roads;

            private _arr = _obj call btc_fnc_ied_randomRoadPos;
            _sel_pos = _arr select 0;
            _dir = _arr select 1;
        };
    } else {
        if (isOnRoad _sel_pos) then {
            private _roads = _sel_pos nearRoads 15;
            if !(_roads isEqualTo []) then {
                private _obj = selectRandom _roads;

                if (isNull _obj) exitWith {};

                private _arr = _obj call btc_fnc_ied_randomRoadPos;
                _sel_pos = _arr select 0;
                _dir = _arr select 1;
            };
        };
    };


    if (btc_debug) then {
        private _marker = createMarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
        _marker setMarkerType "mil_warning";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerText "IED";
        _marker setMarkerSize [0.8, 0.8];
    };

    if (btc_debug_log) then {
        [format ["_this = %1  POS %2  N %3(%4)", _this, _sel_pos, _i, _n], __FILE__, [false]] call btc_fnc_debug_message;
    };

    _array pushBack [_sel_pos, _type_ied, _dir, _active];
};

_active = false;

for "_i" from 1 to _n do {
    private _sel_pos = _pos;
    _sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
    _sel_pos = [_sel_pos, 30, 150, 1, false] call btc_fnc_findsafepos;

    private _type_ied = selectRandom btc_model_ieds;

    private _dir = random 360;

    if (random 1 > 0.3) then {
        private _roads = _sel_pos nearRoads _area;
        if !(_roads isEqualTo []) then     {
            private _obj = selectRandom _roads;

            private _arr = _obj call btc_fnc_ied_randomRoadPos;
            _sel_pos = _arr select 0;
            _dir = _arr select 1;
        };
    };


    if (btc_debug) then {
        private _marker = createMarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
        _marker setMarkerType "mil_warning";
        _marker setMarkerColor "ColorBlue";
        _marker setMarkerText "IED (fake)";
        _marker setMarkerSize [0.8, 0.8];
    };

    if (btc_debug_log) then {
         [format ["_this = %1 ; POS %2 ; N %3(%4)", _this, _sel_pos, _i, _n], __FILE__, [false]] call btc_fnc_debug_message;
    };

    _array pushBack [_sel_pos, _type_ied, _dir, _active];
};

_city setVariable ["ieds", _array];
