{
    if (_y getVariable ["type", ""] != "NameMarine") then {
        if (_y getVariable ["marker", ""] != "") then {
            deleteMarker (_y getVariable ["marker", ""]);
        };
        private _cachingRadius = _y getVariable ["cachingRadius", 500];

        private _marker = createMarker [format ["city_%1", position _y], position _y];
        _marker setMarkerShape "ELLIPSE";
        _marker setMarkerBrush "SolidBorder";
        _marker setMarkerSize [_cachingRadius, _cachingRadius];
        _marker setMarkerAlpha 0;
        if (_y getVariable ["occupied", false]) then {
            _marker setMarkerColor "colorRed";
        } else {
            _marker setMarkerColor "colorBLUFOR";
        };
        _y setVariable ["marker", _marker];
    };
} forEach btc_city_all;