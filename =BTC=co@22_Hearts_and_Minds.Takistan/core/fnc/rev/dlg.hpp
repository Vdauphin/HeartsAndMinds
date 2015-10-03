class btc_rev_dlg_unconscious
{
	name = btc_rev_dlg_unconscious;
	idd = -1;
	movingEnable = 1;
	controlsBackground[] = {Background};
	objects[] = {};
	controls[] = {Respawn};

	onLoad = "uiNamespace setVariable [""btc_rev_dlg_unconscious"", _this select 0];";

	class Background 
	{
		colorBackground[] = {0, 0, 0, 0};
		type = 0;
		colorText[] = {1, 1, 1, 1};
		sizeEx = 0.04;
		style = 48;
		font = "PuristaMedium";
		idc=-1;
		x = "safeZoneXAbs";
		y = "SafeZoneY";
		w = "safeZoneWAbs + 0.05";
		h = "SafeZoneH + 0.05";
		text = "img\rsc\i_unc.paa";
	};
	class Respawn 
	{
		onMouseButtonClick = "player setDamage 1;closeDialog 0;";
		idc = 1103;
		type = 1;
		style = 2;
		colorText[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.25};
		colorBackground[] = {0, 0, 1, 0.1};
		colorBackgroundDisabled[] = {0,0,1,0};
		colorBackgroundActive[] = {0,0,1,0};
		colorFocused[] = {0,0,1,0};
		colorShadow[] = {0,0,0,0};
		colorBorder[] = {0,0,0,0};
		soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
		soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
		soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
		soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
		
		x = 0.4 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.18 * safezoneW;
		h = 0.0286915 * safezoneH;
		shadow = 2;
		font = "PuristaMedium";
		sizeEx = 0.03921;
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		borderSize = 0;
		text = "Respawn";
		action = "";			
	};
};