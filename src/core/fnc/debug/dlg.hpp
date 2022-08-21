class TER_fpscounter
{
    idd = 73001;
    duration = 1e+1000;
    onLoad = "_this call btc_debug_fnc_graph;";
    class controls
    {
        class IGUIBack_2200: IGUIBack
        {
            idc = 2200;
            x = 0.5525 * safezoneW + safezoneX;
            y = 0.71 * safezoneH + safezoneY;
            w = 0.433125 * safezoneW;
            h = 0.266 * safezoneH;
        };
        class GRP_frames: RscControlsGroupNoScrollbars
        {
            idc = 9901;
            x = 0.5525 * safezoneW + safezoneX;
            y = 0.71 * safezoneH + safezoneY;
            w = 0.433125 * safezoneW;
            h = 0.266 * safezoneH;
        };
        class TXT_fps: RscText
        {
            idc = 1000;
            text = "FPS SERVER: 60";
            colorText[] = {1,0.64,0,1};
            x = 0.5525 * safezoneW + safezoneX;
            y = 0.71 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.028 * safezoneH;
        };
        class RscText_1001: RscText
        {
            idc = 1001;
            text = "Time";
            x = 0.933125 * safezoneW + safezoneX;
            y = 0.948 * safezoneH + safezoneY;
            w = 0.0459375 * safezoneW;
            h = 0.028 * safezoneH;
        };
        class TXT_units: RscText
        {
            idc = 1002;
            text = "DELAY:0s UNITS:0 NOT-ON-SERVER:0 | GROUPS:0 | Patrol:0 Traffic:0";
            x = (0.5525 + 0.085)  * safezoneW + safezoneX;
            y = 0.71 * safezoneH + safezoneY;
            w = (0.0590625 + 0.4) * safezoneW;
            h = 0.028 * safezoneH;
        };
    };
};
