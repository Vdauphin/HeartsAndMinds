
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_place_destroy_camera

Description:
    Fill me when you edit me !

Parameters:

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_place_destroy_camera;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

player cameraEffect ["TERMINATE", "BACK"];
camDestroy btc_log_place_camera;
btc_log_place_camera = objNull;
btc_log_place_camera_cond = false;
btc_log_place_camera_created = false;
btc_log_place_camera_nvg = false;
