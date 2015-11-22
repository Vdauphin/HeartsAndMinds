class btc_log_dlg
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""btc_log_dlg"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class btc_log_dlg_background : btc_dlg_RscText 
		{
			idc = -1;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.2 * safezoneH;//1565
			colorBackground[] = {0, 0, 0, 0.7};
			text = "";
		};
		class btc_log_dlg_name : btc_dlg_RscText 
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = 990;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;//w = 0.105 * safezoneW;
			h = 0.0325 * safezoneH;
			text = "Cargo";
		};
		class btc_log_dlg_cargo: btc_dlg_RscListBox
		{
			idc = 991;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.54 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.16 * safezoneH;
		};		
		
		class btc_log_unload : btc_dlg_button 
		{
			idc = 992;
			text = "Unload"; 
			action = "[] spawn btc_fnc_log_unload";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			default = true;
		};
		class btc_log_close : btc_dlg_button 
		{
			idc = 993;
			text = "Close"; 
			action = "closeDialog 0;";
			x = 0.675 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			default = true;
		};
	};
};
class btc_log_dlg_create
{
	idd = -1;
	movingEnable = 1;
	onLoad = "";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class btc_log_dlg_Apply : btc_dlg_button 
		{
			idc = -1;
			text = "Apply"; 
			action = "_spawn = [] spawn btc_fnc_log_create_apply";
			x = 0 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			default = true;
		};
		class btc_log_dlg_Close : btc_dlg_button 
		{
			idc = -1;
			text = "Close"; 
			action = "closeDialog 0;";
			x = 0.2 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			default = true;
		};
		class btc_log_dlg_main_class : btc_dlg_comboBox 
		{
			idc = 71;
			onLBSelChanged = "_spawn = [] spawn btc_fnc_log_create_change_target";
			x = 0 * safezoneW + safezoneX; 
			y = 0 * safezoneH + safezoneY;
			w = 0.4 * safezoneW; 
			h = 0.055 * safezoneH;
		};
		class btc_log_dlg_sub_class : btc_dlg_comboBox 
		{
			idc = 72;
			x = 0 * safezoneW + safezoneX; 
			y = 0.1 * safezoneH + safezoneY;
			w = 0.4 * safezoneW; 
			h = 0.055 * safezoneH;
		};
	};
};