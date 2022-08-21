
/* ----------------------------------------------------------------------------
Function: btc_tag_fnc_create

Description:
    Create tag stored in city namespace under "data_tags".

Parameters:
    _city - City to initialise. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_tag_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]]
];

private _array = _city getVariable ["data_tags", []];
{
    _x params ["_tagPosASL", "_vectorDirAndUp", "_texture", "_tagModel"];

    [AGLToASL _tagPosASL, _vectorDirAndUp, _texture, objNull, _city, "", _tagModel] call ace_tagging_fnc_createTag;
} forEach _array;
