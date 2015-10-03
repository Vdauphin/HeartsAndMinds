enableSaving [false,false];
//Server
call compile preprocessFile "core\def\mission.sqf";
call compile preprocessFile "define_mod.sqf";
call compile preprocessFile "core\fnc\compile.sqf";

if (isServer) then {
	call compile preprocessFile "core\init_server.sqf";
};

call compile preprocessFile "core\init_common.sqf";

if (!isDedicated) then {
	call compile preprocessFile "core\init_player.sqf";
};