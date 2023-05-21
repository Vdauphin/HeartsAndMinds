
/* ----------------------------------------------------------------------------
Function: btc_fnc_roof

Description:
    Get roof.

Parameters:
    _house - House to find the roof. [Group]

Returns:
    _spawnPos - Roof position. [Array]
    _surfaceNormal - Surface normal. [Array]

Examples:
    (begin example)
        _result = [(([position player, 30] call btc_fnc_getHouses) select 0) select 0] call btc_fnc_roof;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_house", objNull, [objNull]]
];

private _positions = _house buildingPos -1;
private "_ASL";
if (_positions isEqualTo []) then {
    private _bbr = (0 boundingBoxReal _house);
    private _p1 = _bbr select 0;
    private _p2 = _bbr select 1;
    private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
    _ASL = (getPosASL _house) vectorAdd [0, 0, _maxHeight];
} else {
    {
        reverse _x
    } forEach _positions;
    _positions sort false;
    private _higherPos = _positions select 0;
    reverse _higherPos;
    _ASL = AGLToASL _higherPos;
};

private _surface = lineIntersectsSurfaces [_ASL vectorAdd [0, 0, 10], _ASL];

private _spawnPos = _ASL;
private _surfaceNormal = [0, 0, 1];
if (_surface isEqualTo []) then { // Try to find again the roof with house position
    _surface = lineIntersectsSurfaces [_ASL vectorAdd [0, 0, 10], getPosASL _house];
};

if (_surface isNotEqualTo []) then {
    private _intersect = _surface select 0;
    if (
        _house in _intersect &&
        {(_spawnPos select 2) + 0.5 < (_intersect select 0 select 2)}
    ) then {
        _spawnPos = (_intersect select 0) vectorAdd [0, 0, 0.2];
        _surfaceNormal = _intersect select 1;
    };
};

[_spawnPos, _surfaceNormal]
