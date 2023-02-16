
/* ----------------------------------------------------------------------------
Function: btc_fnc_typeOfPreview

Description:
    Return the picture of a class name.

Parameters:
    _typeOf - Class name of the object to preview. [String]
    _width - Width in pixel. [Number]
    _height - Height in pixel. [Number]

Returns:

Examples:
    (begin example)
        [typeOf player] call btc_fnc_typeOfPreview;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_typeOf", "Land_PowerGenerator_F", [""]],
    ["_width", 355, [0]],
    ["_height", 200, [0]]
];

format [
    "<br/><img image='%1' width='%2' height='%3'/>",
    getText (configfile >> "CfgVehicles" >> _typeOf >> "editorPreview"),
    _width,
    _height
];
