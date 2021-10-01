
/* ----------------------------------------------------------------------------
Function: btc_fnc_get_cardinal

Description:
    Get cardinal.

Parameters:
    _n - Degree. [Number]

Returns:
    _card - Cardinal. [String]

Examples:
    (begin example)
        _result = [100] call btc_fnc_get_cardinal;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_n", 0, [0]]
];

private _card = "";
switch (true) do {
    case (_n > 345 || _n <= 15) : {_card = "N";};
    case (_n > 15 && _n <= 75) : {_card = "NE";};
    case (_n > 75 && _n <= 105) : {_card = "E";};
    case (_n > 105 && _n <= 165) : {_card = "SE";};
    case (_n > 165 && _n <= 195) : {_card = "S";};
    case (_n > 195 && _n <= 255) : {_card = "SW";};
    case (_n > 255 && _n <= 285) : {_card = "W";};
    case (_n > 285 && _n <= 345) : {_card = "NW";};
};

_card
