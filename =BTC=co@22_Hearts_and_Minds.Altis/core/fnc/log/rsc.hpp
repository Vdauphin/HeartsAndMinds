
	class btc_log_hud
	{
		idd = 1000;
		movingEnable=0;
		duration=1e+011;
		name = "btc_log_hud";
		onLoad = "uiNamespace setVariable [""btc_log_hud"", _this select 0];";
		controlsBackground[] = {};
		objects[] = {};
		class controls 
		{
			class Radar
			{
				type = 0;
				idc = 1001;
				style = 48;
				
				x = 0.75 * safezoneW + safezoneX;
				y = 0.75 * safezoneH + safezoneY;
				w = 0.2 * safezoneW;
				h = 0.2 * safezoneH;
				
				font = "PuristaMedium";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "core\img\rsc\lift\igui_radar_air_ca.paa";
			};
			class Img_Obj
			{
				type = 0;
				idc = 1002;
				style = 48;
				
				x = 0.85 * safezoneW + safezoneX;
				y = 0.85 * safezoneH + safezoneY;
				w = 0.01 * safezoneW;
				h = 0.01 * safezoneH;
				
				font = "PuristaMedium";
				sizeEx = 0.04;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "core\img\rsc\lift\obj.paa";
			};
			class Pic_Obj
			{
				type = 0;
				idc = 1003;
				style = 48;
				
				x = 0.75 * safezoneW + safezoneX;
				y = 0.7 * safezoneH + safezoneY;
				w = 0.05 * safezoneW;
				h = 0.05 * safezoneH;

				font = "PuristaMedium";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Arrow
			{
				type = 0;
				idc = 1004;
				style = 48;
				
				x = 0.95 * safezoneW + safezoneX;
				y = 0.75 * safezoneH + safezoneY;
				w = 0.05 * safezoneW;
				h = 0.05 * safezoneH;
				
				font = "PuristaMedium";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Type_Obj
			{
				type = 0;
				idc = 1005;
				style = 0x00;
				
				x = 0.8 * safezoneW + safezoneX;
				y = 0.65 * safezoneH + safezoneY;
				w = 0.3 * safezoneW;
				h = 0.1 * safezoneH;

				font = "PuristaMedium";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
		};   
	};