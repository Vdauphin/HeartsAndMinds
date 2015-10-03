class btc_fob_create
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""btc_fob_create"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class btc_fob_dlg_background : btc_dlg_RscText 
		{
			idc = -1;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.125 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.65};
			text = "";
		};
		class btc_fob_dlg_text : btc_dlg_RscText 
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.35 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.025 * safezoneH;
			colorText[] = {1, 1, 1, 1};
			text = "Name the FOB:";
		};
		class btc_fob_dlg_name : btc_dlg_RscEdit
		{
			idc = 777;
			text = "";
			x = 0.35025 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class btc_fob_dlg_apply : btc_dlg_button 
		{
			text = "Apply"; 
			action = "btc_fob_dlg = true;";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			default = true;
		};
	};
};
class btc_fob_redeploy
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""btc_fob_redeploy"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class btc_fob_dlg_re_background : btc_dlg_RscText 
		{
			idc = -1;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.05 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.1 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.65};
			text = "";
		};
		class btc_fob_dlg_re_text : btc_dlg_RscText 
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.4 * safezoneW + safezoneX;
			y = 0.05 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.025 * safezoneH;
			colorText[] = {1, 1, 1, 1};
			text = "Select the FOB:";
		};
		class btc_fob_dlg_re_fobs: btc_dlg_comboBox
		{
			idc = 778;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.017 * safezoneH;
			onLBSelChanged  = "[] call btc_fnc_fob_lb_change";
		};
		class btc_fob_dlg_apply : btc_dlg_button 
		{
			text = "Apply"; 
			action = "btc_fob_dlg = true;";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.125 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			default = true;
		};
	};
};