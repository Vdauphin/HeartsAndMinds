
/* ----------------------------------------------------------------------------
Function: btc_tag_fnc_initArea

Description:
    Initialize positions of tags.

Parameters:
    _city - City to initialise. [Object]
    _area - Area to create tag. [Number]
    _n - Number of tag. [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_tag_fnc_initArea;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_area", 100, [0]],
    ["_n", 1, [0]]
];

private _array = _city getVariable ["data_tags", []];

private _roads = _city nearRoads 50;
private _road = if (_roads isEqualTo []) then {
    objNull
} else {
    selectRandom _roads
};
for "_i" from 1 to _n do {
    private _sel_pos = [_city, _area] call CBA_fnc_randPos;
    private _sel_dir = 0;
    if !(surfaceIsWater _sel_pos) then {
        if (isNil "_road" || {isNull _road}) then {
            private _roads = _sel_pos nearRoads 50;
            if (_roads isNotEqualTo []) then {
                _road = selectRandom _roads;
            };
        } else {
            private _connected = roadsConnectedTo _road;
            if (_connected isEqualTo []) then {
                _sel_pos = ([_road, -1] call btc_ied_fnc_randomRoadPos) select 0;
                _road = objNull;
            } else {
                _sel_dir = _road getDir (_connected select 0);
                _sel_pos = _road getPos [
                    random (_road distance (_connected select 0)),
                    _sel_dir
                ];
                _sel_pos = _sel_pos getPos [random 1, _sel_dir + 90 * (selectRandom [1, -1])];
                private _writingDirection = ((AGLToASL _sel_pos) select 2) < ((getPosASL (_connected select 0)) select 2);
                _sel_dir = _sel_dir + 90 * ([-1, 1] select _writingDirection);
                _road = _connected select selectRandomWeighted [0, 0.6, (count _connected) - 1, 0.4];
            };
        };

        if (!isNull _road && {random 1 > 0.6}) then { // Draw sentences
            private _sentences = ((localize (selectRandom btc_type_tags_sentences)) splitString " ");
            {
                private _word = _x;
                {
                    private _letterPos = _sel_pos getPos [_forEachIndex * (0.7 + random 0.2), _sel_dir];

                    private _surface = surfaceNormal _letterPos;
                    private _v1 = vectorNormalized (_surface vectorMultiply -1);
                    private _v3 = _v1 vectorCrossProduct [0, 0, 1];
                    private _v2 = _v3 vectorCrossProduct _v1;
                    if (_v2 isEqualTo [0, 0, 0]) then {
                        _v2 = [0, 1, 0];
                    };

                    _letterPos set [2, 0];
                    _array pushBack [_letterPos, [_v1, _v2], format ["\a3\ui_f\data\igui\cfg\simpletasks\letters\%1_ca.paa", _x], "UserTexture1m_F"];
                } forEach (_word splitString "");
                _sel_pos = _sel_pos getPos [1.4, _sel_dir + 90];
            } forEach _sentences;
        } else { // Draw simple tag
            private _surface = surfaceNormal _sel_pos;
            private _v1 = vectorNormalized (_surface vectorMultiply -1);
            private _v3 = _v1 vectorCrossProduct [0, 0, 1];
            private _v2 = _v3 vectorCrossProduct _v1;
            if (_v2 isEqualTo [0, 0, 0]) then {
                _v2 = [0, 1, 0];
            };

            _sel_pos set [2, 0];
            _array pushBack [_sel_pos, [_v1, _v2], "a3\structures_f_epb\civ\graffiti\data\graffiti_ca.paa", selectRandom btc_type_tags];
        };

        if (btc_debug) then {
            private _marker = createMarker [format ["btc_tag_%1", _sel_pos], _sel_pos];
            _marker setMarkerType "mil_dot";
            _marker setMarkerColor "ColorGreen";
            _marker setMarkerText "Tag";
            _marker setMarkerSize [0.8, 0.8];
        };
    };
};

_city setVariable ["data_tags", _array];
