
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_force

Description:
    Force player respawn.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_force;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

player setPos [10, 10, 10];
player hideObject true;
player enableSimulation false;
forceRespawn player;
