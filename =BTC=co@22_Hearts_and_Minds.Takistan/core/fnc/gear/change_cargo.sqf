disableSerialization;
_ui = uiNamespace getVariable "btc_gear_dlg";

_type = lbText [371, lbCurSel 371];

switch _type do
{
	case "Uniforms" : {[372,btc_uniforms] call btc_fnc_gear_lb_fill;};
	case "Vests" : {[372,btc_vests] call btc_fnc_gear_lb_fill;};
	case "Backpacks" : {[372,btc_backpacks] call btc_fnc_gear_lb_fill;};
	case "Goggles" : {[372,btc_goggles] call btc_fnc_gear_lb_fill;};
	case "Weapons" : {[372,btc_weapons] call btc_fnc_gear_lb_fill;};
	case "Magazines" : {[372,btc_magazines] call btc_fnc_gear_lb_fill;};
	case "Items" : {[372,btc_items] call btc_fnc_gear_lb_fill;};
	case "HeadGear" : {[372,btc_headgears] call btc_fnc_gear_lb_fill;};
};