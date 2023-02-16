// Adding a custom sub item category
//// Adding a Medical Tab
private _medicalTab = [
	"ACE_quikclot", "ACE_packingBandage","ACE_elasticBandage", "ACE_fieldDressing",
	"ACE_tourniquet", "ACE_splint",
    "ACE_morphine","ACE_epinephrine", "ACE_adenosine", 
	"ACE_salineIV", "ACE_salineIV_500","ACE_salineIV_250",
	"ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250",
    "ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250",
    "ACE_personalAidKit","ACE_bodyBag",
	"ACE_surgicalKit","ACE_suture"
];
[_medicalTab, "Medical", getMissionPath "\cvo\img\whiteCrystal.paa"] call ace_arsenal_fnc_addRightPanelButton;
diag_log "[CVO] [ARSENAL] - Medical Tab Applied";
