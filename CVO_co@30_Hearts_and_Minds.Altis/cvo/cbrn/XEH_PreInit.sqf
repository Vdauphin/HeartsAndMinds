// Chemical detector default sound mode
[	
	"cvo_cbrn_set_detector_defaultMode", "LIST", // _setting - unique setting name, matches the resulting variable name <STRING>, _settingType - type of setting <STRING>
	["Default detector mode", "The default sound setting of chemical detector."], // _title - display name or display name + tooltip <STRING, ARRAY>
	["Hearts and Minds", "CBRN"], // _category - category for the setting menu + optional subcategory <STRING, ARRAY>
	[[2, 1, 0], ["Speakers", "Headphones", "Disabled"], 0], // _valueInfo - properties of the setting depending on _settingType
	2 // _isGlobal - 1: all clients have the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;

// Chemical detector sound volume
[	
	"cvo_cbrn_set_detector_volume", "SLIDER", // _setting - unique setting name, matches the resulting variable name <STRING>, _settingType - type of setting <STRING>
	["Detector volume", "The volume of sound in headphones mode."], // _title - display name or display name + tooltip <STRING, ARRAY>
	["Hearts and Minds", "CBRN"], // _category - category for the setting menu + optional subcategory <STRING, ARRAY>
	[0.5, 5, 1, 1], // _valueInfo - properties of the setting depending on _settingType
	2 // _isGlobal - 1: all clients have the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;
