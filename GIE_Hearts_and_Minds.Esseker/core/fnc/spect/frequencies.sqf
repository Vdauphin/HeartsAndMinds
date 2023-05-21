
/* ----------------------------------------------------------------------------
Function: btc_spect_fnc_frequencies

Description:
    Generate an array of frequency and amplitude based on object netID and position.

Parameters:
    _player - Player. [Object]
    _objects - Liste of objects emmiting electromagnetic field. [Array]
    _freq - Frequency range. [Array]

Returns:
    _signalFrequencies - Array of frequencies and amplitudes. [freq1, amp1, freq2, amp2] [Array]

Examples:
    (begin example)
        [player, allUnitsUAV] call btc_spect_fnc_frequencies;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]],
    ["_objects", [], [[]]],
    ["_freq", [390, 500], [[]]]
];

private _frequencyRange = (_freq select 1) - (_freq select 0);

private _signalFrequencies = [];
{
    private _distance = _player distance _x;
    private _level = 100 - 100 * (_distance / btc_spect_range);
    private _angle = _player getRelDir _x;
    if (_level < 0 || (_angle > 90 && _angle < 270)) then {
        _level = 0;
    } else {
        _level = _level * (cos _angle);
    };

    private _side = switch (side _x) do {
        case (west) : {1};
        case (btc_enemy_side) : {3};
        default {2};
    };
    private _maxSubFreq = _frequencyRange * _side / 3;
    private _minSubFreq = _frequencyRange * (_side - 1) / 3;
    private _netID = netId _x;
    private _unit = parseNumber (_netID select [count _netID - 1, 1]);
    private _deci = parseNumber (_netID select [count _netID - 2, 1]) / 10;

    _signalFrequencies append [
        (_unit + _deci) * (_maxSubFreq - _minSubFreq) / 9 + _minSubFreq + (_freq select 0), // Generate a custom frequency base on UAV netID and side
        _level
    ];
} forEach _objects;

_signalFrequencies
