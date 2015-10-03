class btc_dlg_progressBar 
{
	idd = -1;
	movingEnable = false;
	onLoad = "uiNamespace setVariable ['btc_dlg_ctrlProgressBar', (_this select 0) displayCtrl 1]; uiNamespace setVariable ['btc_dlg_title', (_this select 0) displayCtrl 2];";
	objects[] = {};

	class controlsBackground 
	{
		class btc_background 
		{
			idc = -1;
			moving = 0;
			font = "TahomaB";
			text = "";
			sizeEx = 0;
			lineSpacing = 0;
			access = 0;
			type = 0;
			style = 0;
			size = 1;
			colorBackground[] = {0, 0, 0, 0.01};
			colorText[] = {0, 0, 0, 0};
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};

		class btc_progressBar
		{
			idc = 1;
			moving = 0;
			text = "";
			font = "PuristaMedium";
			sizeEx = "1 / 40 / (getResolution select 5)";// * safezoneX / safezoneXAbs";
			lineSpacing = 0;
			access = 0;
			type = 0;
			style = 2;
			size = 1;
			colorBackground[] = {1, 0.647, 0, 0.5};
			colorText[] = {1,1,1,1};
			x = "safezoneX + 0.1 * safezoneW";
			y = "safezoneY + 0.1 * safezoneH";
			w = "0.0 * safezoneW";
			h = "0.01 * safezoneH";
		};

		class btc_titleBar : btc_progressBar 
		{
			idc = 2;
			//type = 13;
			//size = 1;
			colorBackground[] = {0, 0, 0, 0};
			x = "safezoneX + 0.1 * safezoneW";
			y = "safezoneY + 0.05 * safezoneH";
			w = "0.8 * safezoneW";
			h = "0.05 * safezoneH";
		};
	};
};