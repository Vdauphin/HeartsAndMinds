
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_cachePicture

Description:
    Add picture to the diary.

Parameters:
    _classname_object - Classe name of the object to show. [String]
    _cache_n - Number of the current cache. [Number]
    _is_building_with_the_cache - Is the building with the cache inside. [Boolean]

Returns:

Examples:
    (begin example)
        [typeOf player, 0] call btc_info_fnc_cachePicture;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_classname_object", "", [""]],
    ["_cache_n", -1, [-1]],
    ["_is_building_with_the_cache", true, [true]]
];

if !(player diarySubjectExists "btc_diarylog") then {
    player createDiarySubject ["btc_diarylog", localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_DIARYLOG", '\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa'];
};

private _string = if (_is_building_with_the_cache) then {
    "STR_BTC_HAM_O_COMMON_SHOWHINTS_14"
} else {
    "STR_BTC_HAM_O_COMMON_SHOWHINTS_15"
};

player createDiaryRecord [
    "btc_diarylog",
    [
        format [localize "STR_BTC_HAM_CON_INFO_PICTURE", _cache_n],
        (localize _string) + ([_classname_object] call btc_fnc_typeOfPreview)
    ]
];
