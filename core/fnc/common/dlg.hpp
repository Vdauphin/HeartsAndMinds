class btc_dlg_RscText {
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    type = 0;
    style = 0;
    shadow = 1;
    colorShadow[] = {0, 0, 0, 0.5};
    font = "PuristaMedium";
    SizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    text = "";
    colorText[] = {1, 1, 1, 1.0};
    colorBackground[] = {0, 0, 0, 0};
    linespacing = 1;
};

class btc_dlg_shortcutButton {
    idc = -1;
    style = 0;
    default = 0;
    shadow = 1;
    w = 0.183825;
    h = "(        (        ((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
    color[] = {1, 1, 1, 1.0};
    color2[] = {0.95, 0.95, 0.95, 1};
    colorDisabled[] = {1, 1, 1, 0.25};
    colorFocused[] = {0.95, 0.95, 0.95, 1};//{1, 1, 1, 1.0};
    colorBackgroundFocused[] = {0.95, 0.95, 0.95, 1};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
    colorBackground[] = {0.95, 0.95, 0.95, 1};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
    colorBackground2[] = {1, 1, 1, 1};
    animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureDisabled = "\A3\ui_f\data\GUI\scCommon\RscShortcutButton\normal_ca.paa";
    animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
    animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
    animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
    textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
    periodFocus = 1.2;
    periodOver = 0.8;

    class HitZone {
        left = 0.0;
        top = 0.0;
        right = 0.0;
        bottom = 0.0;
    };

    class ShortcutPos {
        left = 0;
        top = "(            (        (        ((safezoneW / safezoneH) min 1.2) / 1.2) / 20) -         (            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        w = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
        h = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    };

    class TextPos {
        left = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
        top = "(            (        (        ((safezoneW / safezoneH) min 1.2) / 1.2) / 20) -         (            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        right = 0.005;
        bottom = 0.0;
    };
    period = 0.4;
    font = "PuristaMedium";
    size = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    sizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    text = "";
    soundEnter[] = {"\A3\ui_f\data\sound\onover", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\sound\new1", 0.0, 0};
    soundClick[] = {"\A3\ui_f\data\sound\onclick", 0.07, 1};
    soundEscape[] = {"\A3\ui_f\data\sound\onescape", 0.09, 1};
    action = "";

    class Attributes {
        font = "PuristaMedium";
        color = "#E5E5E5";
        align = "left";
        shadow = "true";
    };

    class AttributesImage {
        font = "PuristaMedium";
        color = "#E5E5E5";
        align = "left";
    };
};
class btc_dlg_button : btc_dlg_shortcutButton {
    idc = -1;
    type = 16;
    style = "0x02 + 0xC0";
    default = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.15;//0.095589;
    h = 0.039216;
    animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
    animTextureFocused = "#(argb,8,8,3)color(0,0,0,1)";//"#(argb,8,8,3)color(1,1,1,1)";
    animTexturePressed = "#(argb,8,8,3)color(0,0,0,1)";//"#(argb,8,8,3)color(1,1,1,1)";
    animTextureDefault = "#(argb,8,8,3)color(0,0,0,1)";//"#(argb,8,8,3)color(1,1,1,1)";
    colorBackground[] = {0, 0, 0, 0.8};
    colorBackground2[] = {1, 1, 1, 0.5};
    color[] = {1, 1, 1, 1};
    color2[] = {1, 1, 1, 1};
    colorText[] = {1, 1, 1, 1};
    colorDisabled[] = {1, 1, 1, 0.25};
    period = 1.2;
    periodFocus = 1.2;
    periodOver = 1.2;
    size = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    sizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

    class TextPos {
        left = "0.25 *             (            ((safezoneW / safezoneH) min 1.2) / 40)";
        top = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) -         (            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        right = 0.005;
        bottom = 0.0;
    };

    class Attributes {
        font = "PuristaLight";
        color = "#E5E5E5";
        align = "left";
        shadow = "false";
    };

    class ShortcutPos {
        left = "(6.25 *             (            ((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
        top = 0.005;
        w = 0.0225;
        h = 0.03;
    };
};
class btc_dlg_RscListBox {
    type = 5;
    style = "0x10";
    idc=-1;
    font = "puristaMedium";
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.4)";//"(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
    rowHeight=0.025;
    lineSpacing = 1;
    idcRight = -1;
    idcLeft = -1;
    drawSideArrows = 1;
    columns[] = {0.937500,0.968750,1.000000,0.7};
    colorText[] = {1,1,1,0.7};
    colorDisabled[] = {1, 1, 1, 0.6};
    colorScrollBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
    colorSelect[] = {0.937500,0.968750,1.000000,0.7};
    colorSelect2[] = {0.937500,0.968750,1.000000,0.7};
    colorSelectBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
    colorSelectBackground2[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
    colorBackground[] = {1,1,1,0.05};
    maxHistoryDelay = 1.0;
    soundSelect[] = {"",0.1,1};
    period = 1;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    shadow = 0;

    class listScrollBar
    {
        color[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
        colorActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
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
class btc_dlg_comboBox {
    style = 16;
    type = 4;
    x = 0;
    y = 0;
    w = 0.12;
    h = 0.035;
    shadow = 0;
    colorSelect[] = {0,0,0,1};
    colorText[] = {0.95,0.95,0.95,1};
    colorBackground[] = {0,0,0,1};
    colorSelectBackground[] = {1,1,1,0.7};
    colorScrollBar[] = {1,0,0,1};
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    wholeHeight = 0.45;
    color[] = {1,1,1,1};
    colorActive[] = {1,0,0,1};
    colorDisabled[] = {1,1,1,0.25};
    font = "PuristaMedium";
    sizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    class ComboScrollBar
    {
        color[] = {1,1,1,0.6};
        colorActive[] = {1,1,1,1};
        colorDisabled[] = {1,1,1,0.3};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
    soundSelect[] = { "", 0, 1 };
    soundExpand[] = { "", 0, 1 };
    soundCollapse[] = { "", 0, 1 };
    maxHistoryDelay = 0;
};
class btc_dlg_RscEdit {
    type = 2;
    style = 16;
    font = "PuristaMedium";
    shadow = 2;
    sizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    autocomplete = "";
    htmlControl = true;
    lineSpacing = 1;
    colorBackground[] = {0, 0, 0, 0.65};
    colorText[] = {0.95, 0.95, 0.95, 1};
    colorDisabled[] = {1, 1, 1, 0.25};
    colorFocused[] = {1, 1, 1, 1.0};
    colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
    colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
    canModify = 1;
};
