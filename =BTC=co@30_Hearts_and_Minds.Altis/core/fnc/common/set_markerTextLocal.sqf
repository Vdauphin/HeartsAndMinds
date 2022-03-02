
/* ----------------------------------------------------------------------------
Function: btc_fnc_set_markerTextLocal

Description:
    Add local text to a marker.

Parameters:
    _marker - Marker to add text locally [String]
    _text - Text to add locally. [String]
    _arg - Argument for custom text. [String, Number]

Returns:

Examples:
    (begin example)
        [] call btc_fnc_set_markerTextLocal;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_marker", "", [""]],
    ["_text", "", [""]],
    ["_arg", "", ["", 0]]
];

_text = if (isLocalized _text) then {localize _text};

_marker setMarkerTextLocal format [_text, _arg];
