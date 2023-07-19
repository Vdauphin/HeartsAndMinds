private _greenTab = "('greenmag' in configName _x) && !('core' in configName _x)" configClasses (configFile >> "CfgWeapons") apply {configName _x}; 

[_greenTab, "greenMag", getMissionPath "\cvo\img\greenMag.paa"] call ace_arsenal_fnc_addRightPanelButton;
diag_log "[CVO] [ARSENAL] - Green Tab Applied";





