/*
 * Author: Mike
 * Switches ACRE spoken language on unconsciousness
 * Call from initPlayerLocal.sqf.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call FUNC(unconscious);
 */

params ["_player"];

diag_log "[CVO] [ACRE] (Acre Unconcious) - Init Start";

if (!hasInterface) exitWith {};


//// ################# DEFINE #################

// Init Languages
["alt", "Altian"]       call acre_api_fnc_babelAddLanguageType;

["en", "English"]       call acre_api_fnc_babelAddLanguageType;

["un", "Unconscious"]   call acre_api_fnc_babelAddLanguageType;

private _cvo_babel_playerDefault = "alt";
cvo_babel_zeusLanguages = ["alt", "en"];

//// ################# CODE #################

cvo_babel_localPlayerLanguages = [];
// Local Language
    _cvo_babel_localLanguage = "alt";


// Player Languages
    _cvo_babel_player getVariable ["CVO_Player_Languages", []];

// Default Language for everyone
    cvo_babel_localPlayerLanguages pushBackUnique _cvo_babel_playerDefault;

// Local Languages via Translator
    if (player getVariable ["interpreter", false]) then {
        cvo_babel_localPlayerLanguages pushBackUnique _cvo_babel_localLanguage;
    };


// Custom Languages via Custom Player
    {
        if (_x in _cvo_babel_player) then {
            cvo_babel_localPlayerLanguages pushBackUnique _x;
        };
    } forEach ["alt","en"];



//// APPLY

// Set spoken
cvo_babel_localPlayerLanguages call acre_api_fnc_babelSetSpokenLanguages;

// Switch language on unconscious toggle
["ace_unconscious", {
    params ["_unit", "_state"];

    if (_unit != ACE_player) exitWith {}; // Ignore if remote unit

    if (_state) then {
        ["un"] call acre_api_fnc_babelSetSpokenLanguages;
    } else {
        cvo_babel_localPlayerLanguages call acre_api_fnc_babelSetSpokenLanguages;
    };
}] call CBA_fnc_addEventHandler;

// Handle unit change (including death)
["unit", {
    params ["_newUnit", "_oldUnit"];

    if (call CBA_fnc_getActiveFeatureCamera != "") exitWith {}; // Ignore if feature camera active (eg. Zeus)

    if (_newUnit getVariable ["ACE_isUnconscious", false]) then {
        ["un"] call acre_api_fnc_babelSetSpokenLanguages;
    } else {
        cvo_babel_localPlayerLanguages call acre_api_fnc_babelSetSpokenLanguages;
    };
}, false] call CBA_fnc_addPlayerEventHandler;

// Handle feature camera (eg. Zeus)
["featureCamera", {
    params ["_unit", "_newCamera"];

    if (_newCamera == "" && {ACE_player getVariable ["ACE_isUnconscious", false]}) then {
        ["un"] call acre_api_fnc_babelSetSpokenLanguages;
    } else {
        if (player != ace_player) then {
            cvo_babel_zeusLanguages call acre_api_fnc_babelSetSpokenLanguages;
        } else {
            cvo_babel_localPlayerLanguages call acre_api_fnc_babelSetSpokenLanguages;
        };
    };
}, false] call CBA_fnc_addPlayerEventHandler;
diag_log "[CVO] [ACRE] (Acre Unconcious) - Init End";
