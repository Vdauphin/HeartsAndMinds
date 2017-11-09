private _MainCategory = (localize "STR_BTC_HAM_DOC_TITLE");
player createDiarySubject [_MainCategory, _MainCategory];

//Headless and Data base
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_HEADLESS_TITLE"),(localize "STR_BTC_HAM_DOC_HEADLESS_TEXT")]];

//Wounds
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_WOUNDS_TITLE"),(localize "STR_BTC_HAM_DOC_WOUNDS_TEXT")]];

//Deafness
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_DEAFNESS_TITLE"),(localize "STR_BTC_HAM_DOC_DEAFNESS_TEXT")]];

//Vehicles
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_VEHICLES_TITLE"),(localize "STR_BTC_HAM_DOC_VEHICLES_TEXT")]];

//Side Mission
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_SIDEMISSION_TITLE"),(localize "STR_BTC_HAM_DOC_SIDEMISSION_TEXT")]];

//FOB
player createDiaryRecord [_MainCategory, ["FOB", (localize "STR_BTC_HAM_DOC_FOB_TEXT")]];

//Sling loading
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_SLING_TITLE"),(localize "STR_BTC_HAM_DOC_SLING_TEXT")]];

//Logistic point
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_LOGISTICP_TITLE"),(localize "STR_BTC_HAM_DOC_LOGISTICP_TEXT")]];

//Logistic
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_LOGISTIC_TITLE"),(localize "STR_BTC_HAM_DOC_LOGISTIC_TEXT")]];

//Hideout
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_HIDEOUT_TITLE"),(localize "STR_BTC_HAM_DOC_HIDEOUT_TEXT")]];

//IED
player createDiaryRecord [_MainCategory, ["IED", (localize "STR_BTC_HAM_DOC_IED_TEXT")]];

//Intel
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_INTEL_TITLE"),(localize "STR_BTC_HAM_DOC_INTEL_TEXT")]];

//Reputation
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_REPUTATION_TITLE"),(localize "STR_BTC_HAM_DOC_REPUTATION_TEXT")]];

//Orders
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_ORDERS_TITLE"),(localize "STR_BTC_HAM_DOC_ORDERS_TEXT")]];

//Traffic
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_TRAFFIC_TITLE"),(localize "STR_BTC_HAM_DOC_TRAFFIC_TEXT")]];

//Gear
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_GEAR_TITLE"),(localize "STR_BTC_HAM_DOC_GEAR_TEXT")]];

//Interaction
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_INTERACTION_TITLE"),(localize "STR_BTC_HAM_DOC_INTERACTION_TEXT")]];

//Version
player createDiaryRecord [_MainCategory, [(localize "STR_BTC_HAM_DOC_VERSION_TITLE"),
	format ["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa' width='20' height='20'/> Version %1 <img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\download_ca.paa' width='20' height='20'/>",(str(btc_version) + ".4")]
	]
];
