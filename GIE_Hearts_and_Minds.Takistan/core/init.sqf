enableSaving [false, false];

[] call compileScript ["core\def\mission.sqf"];
[] call compileScript ["define_mod.sqf"];

if (isServer) then {
    [] call compileScript ["core\init_server.sqf"];
};

[] call compileScript ["core\init_common.sqf"];

if (!isDedicated && hasInterface) then {
    [] call compileScript ["core\init_player.sqf"];
};

if (!isDedicated && !hasInterface) then {
    [] call compileScript ["core\init_headless.sqf"];
};
