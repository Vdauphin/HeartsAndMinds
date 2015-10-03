//	((_this select 0) displayCtrl 379) ctrlSetPosition [0.5 * safezoneW + safezoneX,0.655 * safezoneH + safezoneY,0.2 * safezoneW,0.015 * safezoneH];((_this select 0) displayCtrl 379) ctrlCommit 0;

btc_gear_acc_type = 0;

closeDialog 0;
disableSerialization;
_dlg = createDialog "btc_gear_dlg";
_ui = uiNamespace getVariable "btc_gear_dlg";

waitUntil {Dialog};

{_index = lbAdd [ 371, _x ];} foreach ["Uniforms","Vests","Backpacks","HeadGear","Goggles","Weapons","Magazines","Items"];

lbSetCurSel [371, 0];

//[3912,false] call btc_fnc_gear_show_button;

_uniform = uniform player;
_vest = vest player;
_backPack = backPack player;
_headgear = headgear player;
_goggles = goggles player;

if (_uniform != "") then {(_ui displayCtrl 374) ctrlSettext (getText (configFile >> "cfgWeapons" >> _uniform >> "picture"));};
if (_vest != "") then {(_ui displayCtrl 375) ctrlSettext (getText (configFile >> "cfgWeapons" >> _vest >> "picture"));};
if (_backPack != "") then {(_ui displayCtrl 376) ctrlSettext (getText (configFile >> "cfgVehicles" >> _backPack >> "picture"));};
if (_headgear != "") then {(_ui displayCtrl 377) ctrlSettext (getText (configFile >> "cfgWeapons" >> _headgear >> "picture"));};
if (_goggles != "") then {(_ui displayCtrl 378) ctrlSettext (getText (configFile >> "cfgGlasses" >> _goggles >> "picture"));};
//Select uniform
call btc_fnc_gear_get_text;
[0,0] call btc_fnc_gear_change_container;