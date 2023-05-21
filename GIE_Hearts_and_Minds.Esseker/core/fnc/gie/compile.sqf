if (isServer) then {
	gie_db_fnc_autoSave = compileScript ["core\fnc\gie\database\autoSave.sqf"];
    gie_db_fnc_exportDatabase_s = compileScript ["core\fnc\gie\database\exportDatabase_s.sqf"];

    gie_discord_activity_fnc_send = compileScript ["core\fnc\gie\discord\sendActivity.sqf"];
    gie_discord_activity_fnc_playerKilled = compileScript ["core\fnc\gie\discord\playerKilled.sqf"];
    gie_discord_activity_fnc_cityCaptured = compileScript ["core\fnc\gie\discord\cityCaptured.sqf"];
    
    gie_patrols_fnc_fob = compileScript ["core\fnc\gie\patrols\fob.sqf"];

	gie_zeus_fnc_addZeusToPlayer = compileScript ["core\fnc\gie\zeus\addZeusToPlayer.sqf"];
};

if (!isDedicated) then {
    gie_db_fnc_exportDatabase = compileScript ["core\fnc\gie\database\exportDatabase.sqf"];

	gie_fnc_interpreter = compileScript ["core\fnc\gie\common\interpreter.sqf"];
	
    // ZEUS
    gie_zeus_fnc_addZeusToPlayerRemote = compileScript ["core\fnc\gie\zeus\addZeusToPlayerRemote.sqf"];

    // PRESENCE (Discord)
    gie_presence_fnc_init = compileScript ["core\fnc\gie\presence\init.sqf"];
    gie_presence_fnc_evaluatePresenceContent = compileScript ["core\fnc\gie\presence\evaluatePresenceContent.sqf"];

    // Scripts GIE
    // gie_teamspeak_fnc_checkStatus = compileScript ["core\fnc\gie\checkTeamspeakStatus.sqf"];
    gie_loadout_fnc_setDefaultLoadout = compileScript ["core\fnc\gie\common\setDefaultLoadout.sqf"];
    gie_loadout_fnc_getParadropLoadout = compileScript ["core\fnc\gie\common\getParadropLoadout.sqf"];

};