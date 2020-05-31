[] call compile preprocessFileLineNumbers "core\doc.sqf";

if !(isNil "btc_custom_loc") then {
    {
        _x params ["_pos", "_cityType", "_cityName", "_sizeX", "_sizeY"];
        private _location = createLocation [_cityType, _pos, _sizeX, _sizeY];
        _location setText _cityName;
    } forEach btc_custom_loc;
};

[{!isNull player}, {

    player addRating 9999;
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

    [player] call btc_fnc_eh_player;

    private _arsenal_trait = player call btc_fnc_arsenal_trait;
    if (btc_p_arsenal_Restrict isEqualTo 3) then {
        [_arsenal_trait select 1] call btc_fnc_arsenal_weaponsFilter;
    };
    [] call btc_fnc_int_add_actions;
    [] call btc_fnc_int_shortcuts;

    if (player getVariable ["interpreter", false]) then {
        player createDiarySubject ["btc_diarylog", localize "STR_BTC_HAM_CON_INFO_ASKHIDEOUT_DIARYLOG"];
    };

    switch (btc_p_autoloadout) do {
        case 1: {
            player setUnitLoadout ([_arsenal_trait select 0] call btc_fnc_arsenal_loadout);
        };
        case 2: {
            removeAllWeapons player;
        };
        default {
        };
    };
}] call CBA_fnc_waitUntilAndExecute;

if (btc_debug) then {

    onMapSingleClick "vehicle player setPos _pos";
    player allowDamage false;

    waitUntil {!isNull (findDisplay 12)};
    private _eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", btc_fnc_debug_marker];
};
