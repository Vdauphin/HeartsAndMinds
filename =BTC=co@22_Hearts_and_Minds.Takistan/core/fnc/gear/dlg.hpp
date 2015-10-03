#define backColor 0.65

class btc_gear_dlg
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""btc_gear_dlg"", _this select 0];";
	objects[] = {};
	class controlsBackground 
	{

	};
	class controls 
	{
		class btc_gear_dlg_background_1 : btc_dlg_RscText 
		{
			idc = -1;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.45 * safezoneH;//1565
			colorBackground[] = {0, 0, 0, backColor};
			text = "";
		};
		class btc_gear_dlg_background_2 : btc_dlg_RscText 
		{
			idc = -1;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.45 * safezoneH;//1565
			colorBackground[] = {0, 0, 0, backColor};
			text = "";
		};
		class btc_gear_dlg_slot_0 : btc_dlg_RscText//Uniform
		{
			idc = -1;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.047 * safezoneW;
			h = 0.05 * safezoneH;
			colorBackground[] = {118, 118, 118, 0.1};
			text = "";
		};
		class btc_gear_dlg_slot_1 : btc_gear_dlg_slot_0 {x = 0.55 * safezoneW + safezoneX;};//Vest
		class btc_gear_dlg_slot_2 : btc_gear_dlg_slot_0 {x = 0.6 * safezoneW + safezoneX;};//Backpack
		class btc_gear_dlg_slot_3 : btc_gear_dlg_slot_0 {x = 0.525 * safezoneW + safezoneX;y = 0.27 * safezoneH + safezoneY;};//Head
		class btc_gear_dlg_slot_4 : btc_gear_dlg_slot_0 {x = 0.575 * safezoneW + safezoneX;y = 0.27 * safezoneH + safezoneY;};//Goggles

		class btc_gear_dlg_slot_5 : btc_gear_dlg_slot_0 //P 1
		{
			x = 0.71 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.0335 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class btc_gear_dlg_slot_6 : btc_gear_dlg_slot_5 {x = 0.75 * safezoneW + safezoneX;};//P 2
		class btc_gear_dlg_slot_7 : btc_gear_dlg_slot_5 {x = 0.79 * safezoneW + safezoneX;};//P 3
		class btc_gear_dlg_slot_8 : btc_gear_dlg_slot_5 {x = 0.71 * safezoneW + safezoneX;y = 0.37 * safezoneH + safezoneY;};//S 1
		class btc_gear_dlg_slot_9 : btc_gear_dlg_slot_8 {x = 0.75 * safezoneW + safezoneX;};//S 2
		class btc_gear_dlg_slot_10 : btc_gear_dlg_slot_8 {x = 0.79 * safezoneW + safezoneX;};//S 3
		class btc_gear_dlg_slot_11 : btc_gear_dlg_slot_5 {x = 0.71 * safezoneW + safezoneX;y = 0.43 * safezoneH + safezoneY;};//H 1
		class btc_gear_dlg_slot_12 : btc_gear_dlg_slot_11 {x = 0.75 * safezoneW + safezoneX;};//H 2
		class btc_gear_dlg_slot_13 : btc_gear_dlg_slot_11 {x = 0.79 * safezoneW + safezoneX;};//H 3
		class btc_gear_dlg_class : btc_dlg_comboBox 
		{
			idc = 371;
			onLBSelChanged = "[] call btc_fnc_gear_change_cargo";
			x = 0.25 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;//w = 0.105 * safezoneW;
			h = 0.017 * safezoneH;
		};
		class btc_gear_dlg_cargo: btc_dlg_RscListBox
		{
			idc = 372;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.25 * safezoneH;
			//onMouseButtonClick = "hint str(_this)";
			//onLBSelChanged = "call btc_fnc_gear_check_acc";
			onLBDblClick = "[0] call btc_fnc_gear_handle";
		};
		class btc_gear_dlg_equip: btc_dlg_RscListBox
		{
			idc = 373;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.25 * safezoneH;
			onLBDblClick = "[1] call btc_fnc_gear_handle";
		};
		class btc_gear_dlg_img_uniform : btc_dlg_RscText 
		{
			idc = 374;
			style = 48;
			font = "PuristaMedium";
			x = 0.5 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.05 * safezoneH;//1565
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_uniform_gs.paa";
		};
		class btc_gear_dlg_img_vest : btc_gear_dlg_img_uniform 
		{
			idc = 375;
			x = 0.55 * safezoneW + safezoneX;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_vest_gs.paa";
		};
		class btc_gear_dlg_img_backpack : btc_gear_dlg_img_uniform 
		{
			idc = 376;
			x = 0.6 * safezoneW + safezoneX;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_backpack_gs.paa";
		};
		class btc_gear_dlg_img_headgear : btc_gear_dlg_img_uniform 
		{
			idc = 377;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_helmet_gs.paa";
		};		
		class btc_gear_dlg_img_glasses : btc_gear_dlg_img_uniform 
		{
			idc = 378;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_glasses_gs.paa";
		};
		class btc_gear_uniform_button
		{
			idc = -1;
			text = "";
			type = 1;
			style = 2;
			colorText[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};//{0,0,1,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
			
			x = 0.5 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.05 * safezoneH;
			shadow = 2;
			font = "PuristaMedium";
			sizeEx = 0.03921;
			offsetX = 0.003;
			offsetY = 0.003;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			borderSize = 0;
			onMouseButtonClick = "[(_this select 1),0] call btc_fnc_gear_change_container";
			//action = "0 call btc_fnc_gear_change_container;";
		};
		class btc_gear_vest_button : btc_gear_uniform_button 
		{
			idc = -1;
			//action = "1 call btc_fnc_gear_change_container;";
			onMouseButtonClick = "[(_this select 1),1] call btc_fnc_gear_change_container";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
		};
		class btc_gear_backpack_button : btc_gear_uniform_button 
		{
			idc = -1;
			//action = "2 call btc_fnc_gear_change_container;";
			onMouseButtonClick = "[(_this select 1),2] call btc_fnc_gear_change_container";
			x = 0.6 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
		};
		class btc_gear_headgear_button : btc_gear_uniform_button 
		{
			idc = -1;
			action = "removeHeadgear player;((uiNamespace getVariable 'btc_gear_dlg') displayCtrl 377) ctrlSettext '\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_helmet_gs.paa';";
			x = 0.525 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
		};
		class btc_gear_glasses_button : btc_gear_uniform_button 
		{
			idc = -1;
			action = "removeGoggles player;((uiNamespace getVariable 'btc_gear_dlg') displayCtrl 378) ctrlSettext '\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_glasses_gs.paa';";
			x = 0.575 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
		};
		class btc_gear_progressBar : btc_dlg_RscProgress
		{
			idc = 380;
			access = 0;
			colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			colorFrame[] = {0,0,0,0};
			texture = "\A3\ui_f\data\GUI\RscCommon\RscProgress\progressbar_ca.paa";
			type = 8;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.66 * safezoneH + safezoneY;
			w = "0.2 * safezoneW";
			h = "0.018 * safezoneH";
		};
		class btc_gear_dlg_img_add : btc_gear_dlg_img_uniform 
		{
			x = 0.46 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			colorBackground[] = {0,0,0,backColor};
			sizeEx = 0.01;
			text = "\A3\ui_f\data\gui\RscCommon\RscHTML\arrow_right_ca.paa";
		};
		class btc_gear_dlg_img_remove : btc_gear_dlg_img_uniform 
		{
			x = 0.46 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			colorBackground[] = {0,0,0,backColor};
			sizeEx = 0.01;
			text = "\A3\ui_f\data\gui\RscCommon\RscHTML\arrow_left_ca.paa";
		};
		class btc_gear_add : btc_gear_uniform_button 
		{
			idc = -1;
			text = ">"; 
			action = "[0] call btc_fnc_gear_handle";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.05 * safezoneW;
			default = true;
		};
		class btc_gear_remove : btc_gear_uniform_button 
		{
			idc = -1;
			text = "<"; 
			action = "[1] call btc_fnc_gear_handle";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.03 * safezoneW;
			h = 0.05 * safezoneW;
			default = true;
		};
		class btc_gear_dlg_text_p : btc_dlg_RscText 
		{
			idc = 3910;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.025 * safezoneH;
			text = "";
		};
		class btc_gear_p_button : btc_gear_uniform_button 
		{
			idc = -1;
			action = "[2] call btc_fnc_gear_handle";
			x = 0.71 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0,0,0,0};//{0,0,1,0};
		};
		class btc_gear_dlg_text_s : btc_gear_dlg_text_p 
		{
			idc = 3911;
			y = 0.34 * safezoneH + safezoneY;
		};
		class btc_gear_s_button : btc_gear_p_button 
		{
			idc = -1;
			action = "[3] call btc_fnc_gear_handle";
			y = 0.34 * safezoneH + safezoneY;
		};
		class btc_gear_dlg_text_h : btc_gear_dlg_text_p 
		{
			idc = 3912;
			y = 0.40 * safezoneH + safezoneY;
		};
		class btc_gear_h_button : btc_gear_p_button 
		{
			idc = -1;
			action = "[4] call btc_fnc_gear_handle";
			y = 0.40 * safezoneH + safezoneY;
		};
		class btc_gear_dlg_text_i : btc_gear_dlg_text_p 
		{
			idc = 3913;
			y = 0.465 * safezoneH + safezoneY;
			text = "Ammo and items:";
		};
		class btc_gear_dlg_text_i_p_0 : btc_gear_dlg_img_uniform 
		{
			idc = 3930;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.025 * safezoneH;
			text = "";
		};
		class btc_gear_dlg_text_i_p_1 : btc_gear_dlg_text_i_p_0 
		{
			idc = 3931;
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_text_i_p_2 : btc_gear_dlg_text_i_p_0 
		{
			idc = 3932;
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_text_i_s_0 : btc_gear_dlg_text_i_p_0 
		{
			idc = 3940;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.37 * safezoneH + safezoneY;
		};
		class btc_gear_dlg_text_i_s_1 : btc_gear_dlg_text_i_s_0 
		{
			idc = 3941;
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_text_i_s_2 : btc_gear_dlg_text_i_s_0 
		{
			idc = 3942;
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_text_i_h_0 : btc_gear_dlg_text_i_p_0 
		{
			idc = 3950;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
		};
		class btc_gear_dlg_text_i_h_1 : btc_gear_dlg_text_i_h_0 
		{
			idc = 3951;
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_text_i_h_2 : btc_gear_dlg_text_i_h_0 
		{
			idc = 3952;
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_p_i_0_button : btc_gear_uniform_button 
		{
			idc = -1;
			action = "[0,0] call btc_fnc_gear_remove_w_item";
			x = 0.71 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0,0,0,0};//{0,0,0,0.75};
		};
		class btc_gear_p_i_1_button : btc_gear_p_i_0_button 
		{
			action = "[0,1] call btc_fnc_gear_remove_w_item";
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_p_i_2_button : btc_gear_p_i_0_button 
		{
			action = "[0,2] call btc_fnc_gear_remove_w_item";
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_s_i_0_button : btc_gear_p_i_0_button 
		{
			action = "[1,0] call btc_fnc_gear_remove_w_item";
			x = 0.71 * safezoneW + safezoneX;
			y = 0.37 * safezoneH + safezoneY;
		};
		class btc_gear_s_i_1_button : btc_gear_s_i_0_button 
		{
			action = "[1,1] call btc_fnc_gear_remove_w_item";
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_s_i_2_button : btc_gear_s_i_0_button 
		{
			action = "[1,2] call btc_fnc_gear_remove_w_item";
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_h_i_0_button : btc_gear_p_i_0_button 
		{
			action = "[2,0] call btc_fnc_gear_remove_w_item";
			x = 0.71 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
		};
		class btc_gear_h_i_1_button : btc_gear_h_i_0_button 
		{
			action = "[2,1] call btc_fnc_gear_remove_w_item";
			x = 0.75 * safezoneW + safezoneX;
		};
		class btc_gear_h_i_2_button : btc_gear_h_i_0_button 
		{
			action = "[2,2] call btc_fnc_gear_remove_w_item";
			x = 0.79 * safezoneW + safezoneX;
		};
		class btc_gear_dlg_inv: btc_dlg_RscListBox
		{
			idc = 3921;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.2 * safezoneH;
			colorScrollBar[] = {0,0,0,0};
			colorSelect[] = {0,0,0,0};
			colorSelect2[] = {0,0,0,0};
			class listScrollBar
			{
				//color[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
				//colorActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
				color[] = {0,0,0,0};
				colorActive[] = {0,0,0,0};
				colorDisabled[] = {1, 1, 1, 1};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
				shadow = 1;
				width = 0.2;
			};
		};
	};
};