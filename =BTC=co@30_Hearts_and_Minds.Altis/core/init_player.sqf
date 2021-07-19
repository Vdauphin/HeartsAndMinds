btc_map_mapIllumination = ace_map_mapIllumination;
if !(isNil "btc_custom_loc") then {
    {
        _x params ["_pos", "_cityType", "_cityName", "_radius"];
        private _location = createLocation [_cityType, _pos, _radius, _radius];
        _location setText _cityName;
    } forEach btc_custom_loc;
};
btc_intro_done = [] spawn btc_fnc_intro;

{
    missionNamespace setVariable [_x, false];
} forEach [
    "BIS_respSpecAi",                   // Allow spectating of AI
    "BIS_respSpecAllowFreeCamera",      // Allow moving the camera independent from units (players)
    "BIS_respSpecAllow3PPCamera",       // Allow 3rd person camera
    "BIS_respSpecShowFocus",            // Show info about the selected unit (dissapears behind the respawn UI)
    "BIS_respSpecShowCameraButtons",    // Show buttons for switching between free camera, 1st and 3rd person view (partially overlayed by respawn UI)
    "BIS_respSpecShowControlsHelper",   // Show the controls tutorial box
    "BIS_respSpecShowHeader",           // Top bar of the spectator UI including mission time
    "BIS_respSpecLists"                 // Show list of available units and locations on the left hand side
];
{
    missionNamespace setVariable [_x, true];
} forEach [
    "BIS_respSpecAi",                   // Allow spectating of AI
    "BIS_respSpecShowCameraButtons",    // Show buttons for switching between free camera, 1st and 3rd person view (partially overlayed by respawn UI)
    "BIS_respSpecShowControlsHelper",   // Show the controls tutorial box
    "BIS_respSpecShowHeader",           // Top bar of the spectator UI including mission time
    "BIS_respSpecLists"                 // Show list of available units and locations on the left hand side
];


[{!isNull player}, {
    [] call compileScript ["core\doc.sqf"];

    btc_respawn_marker setMarkerPosLocal player;
    player addRating 9999;
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

    [player] call btc_eh_fnc_player;

    private _arsenal_trait = player call btc_arsenal_fnc_trait;
    if (btc_p_arsenal_Restrict isEqualTo 3) then {
        [_arsenal_trait select 1] call btc_arsenal_fnc_weaponsFilter;
    };
    [] call btc_int_fnc_add_actions;
    [] call btc_int_fnc_shortcuts;

    if (player getVariable ["interpreter", false]) then {
        player createDiarySubject ["btc_diarylog", localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_DIARYLOG"];
    };

    switch (btc_p_autoloadout) do {
        case 1: {
            player setUnitLoadout ([_arsenal_trait select 0] call btc_arsenal_fnc_loadout);
        };
        case 2: {
            removeAllWeapons player;
        };
        default {
        };
    };

    if (btc_debug) then {
        onMapSingleClick "vehicle player setPos _pos";
        player allowDamage false;

        [{!isNull (findDisplay 12)}, {
            ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", btc_debug_fnc_marker];
        }] call CBA_fnc_waitUntilAndExecute;
    };
}] call CBA_fnc_waitUntilAndExecute;
