class Params {
	class btc_p_time_title {
		title = "<< Time options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_time {
		title = "			Set the start time:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
		default = 12;
	};
	class btc_p_acctime {
		title = "			Acceleration time multiplier:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12};
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12"};
		default = 5;
	};
	class btc_p_load {
		title = "			Load the savegame (if available)";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 1;
	};
	class btc_p_auto_db {
		title = "			Auto savegame (can break player immersion)";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,24,48,72};
		texts[]={"Off","1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","24h","48h","72h"};
		default = 0;
	};
	class btc_p_type_title {
		title = "<< Faction options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_en {
		title = "			Enemy type:";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194};
		texts[]={"0 - Bohemia Interactive: OTAN (Side: WEST)","1 - Bohemia Interactive: FIA (Side: WEST)","2 - jarrad96: Central African Militia (Side: EAST)","3 - Scar and Jmax: SW Galactic Empire (Side: EAST)","4 - Bohemia Interactive: AAF (Side: GUER)","5 - Bohemia Interactive: FIA (Side: GUER)","6 - Bohemia Interactive: CSAT (Side: EAST)","7 - Bohemia Interactive: FIA (Side: EAST)","8 - Bohemia Interactive: SW Rebel Alliance (Side: WEST)","9 - EricJ: Taliban (Side: EAST)","10 - Bohemia Interactive:  (Side: WEST)","11 -AFR BIS/IceBreakr: Afrenian Army (Side: WEST)","12 -ARA Bohemia Interactive: Abramian Rebel Alliance (Side: WEST)","13 -ARL BIS/IceBreakr: ARL Lingor Rebels (Side: EAST)","14 -btc_militia_mod Giallustio: Afghan Militia (Side: EAST)","15 -C SWOP: SW C.I.S. - Separatists (Side: EAST)","16 -CAA SWOP: SW Cartel Hutt (Side: GUER)","17 -CAA_MODs SWOP: SW Galactic Republic (Side: WEST)","18 -CAA_MODs SWOP: SW Boba Fett Syndicate (Side: GUER)","19 -CAA_MODs SWOP: SW Tusken Raiders (Side: GUER)","20 -CAF CAF MOD TEAM: Africa - Pirates (Side: EAST)","21 -CAF CAF MOD TEAM: East Europe - Rebels (Side: EAST)","22 -CAF CAF MOD TEAM: Middle East - Tribal (Side: EAST)","23 -CEC HcPookie: Cecanian Army (Side: EAST)","24 -CUP Community Upgrade Project: Army of the Czech Republic (Side: WEST)","25 -CUP Bohemia Interactive: Bundeswehr (Side: WEST)","26 -CUP Bohemia Interactive: United States Army (Side: WEST)","27 -CUP Bohemia Interactive: National Party of Chernarus (Side: GUER)","28 -CUP Bohemia Interactive: ION PMC (Side: GUER)","29 -CUP Bohemia Interactive: Royal Army Corps of Sahrani (Side: GUER)","30 -CUP Bohemia Interactive: Takistani Army (Side: EAST)","31 -CUP_Units Community Upgrade Project: British Armed Forces (Side: WEST)","32 -CUP_Units Bohemia Interactive: Takistani Locals (Side: GUER)","33 -CUP_Units Community Upgrade Project: United Nations (Side: GUER)","34 -CUP_Units Community Upgrade Project: Chernarussian Movement of the Red Star (Side: EAST)","35 -CUP_Units Bohemia Interactive: Takistani Militia (Side: EAST)","36 -CUP_Vehicles Community Upgrade Project: Chernarus Defense Forces (Side: WEST)","37 -CUP_Vehicles Community Upgrade Project: Royal New Zealand Navy (Side: WEST)","38 -CUP_Vehicles Community Upgrade Project: United States Marine Corps (Side: WEST)","39 -CUP_Vehicles Community Upgrade Project: Armed Forces of the Russian Federation (Side: EAST)","40 -CUP_Vehicles Community Upgrade Project: Sahrani Liberation Army (Side: EAST)","41 -Expansion Bohemia Interactive: CTRG (Side: WEST)","42 -Expansion Bohemia Interactive: Gendarmerie (Side: WEST)","43 -Expansion Bohemia Interactive: OTAN (Pacifique) (Side: WEST)","44 -Expansion Bohemia Interactive: Syndikat (Side: GUER)","45 -Expansion Bohemia Interactive: CSAT (Pacifique) (Side: EAST)","46 -Expansion Burgess: OPCAN (Colonial Police) (Side: WEST)","47 -Expansion Burgess: OPCAN (Colonial Sheriff) (Side: WEST)","48 -FOW Bohemia Interactive: [AUS] Australian Army (Side: GUER)","49 -FOW Bohemia Interactive: [DE] Heer (Side: WEST)","50 -FOW Bohemia Interactive: [IT] Regio Esercito (Side: WEST)","51 -FOW Bohemia Interactive: [DE] Luftwaffe (Side: WEST)","52 -FOW Bohemia Interactive: [UK] Army (Side: GUER)","53 -FOW FOW Team: [DE] Waffen-SS (Side: WEST)","54 -fow_mod FOW team: [JP] Imperial Army (Side: WEST)","55 -fow_mod FOW team: [US] Army (Europe) (Side: GUER)","56 -fow_mod Bohemia Interactive: [US] Army (Pacific) (Side: GUER)","57 -fow_mod FOW team: [US] Marines Corps (Side: GUER)","58 -GAL HcPookie: GAL (Government Army of Lingor) (Side: WEST)","59 -GANGBLUE BIS/IceBreakr: Blue Gang (Side: WEST)","60 -GANGRED BIS/IceBreakr: Red Gang (Side: EAST)","61 -IBR Bohemia Interactive: Alienz (Side: GUER)","62 -ISC Bohemia Interactive: [ISC] Iraqi Police (Side: WEST)","63 -ISC Bohemia Interactive: [ISC] YPG (Side: WEST)","64 -LIB AWAR: ACI (Side: GUER)","65 -LIB AWAR & Lennard: ARR (Side: WEST)","66 -LIB Lennard: Deutsches Afrikakorps (Side: WEST)","67 -LIB AWAR & Joarius: FFI (Side: GUER)","68 -LIB AWAR: Armia Krajowa (Polonais) (Side: GUER)","69 -LIB AWAR: Luftwaffe (Side: WEST)","70 -LIB AWAR & Lennard: [Winter] Luftwaffe (Side: WEST)","71 -LIB AWAR & Lennard: MKHL (Side: WEST)","72 -LIB Lennard: US North African Corps (Side: GUER)","73 -LIB Lennard: NKVD (Side: EAST)","74 -LIB IFA3 Team: Panzerwaffe (Side: WEST)","75 -LIB AWAR & Lennard: [Winter] Panzerwaffe (Side: WEST)","76 -LIB AWAR: RAAF (Side: GUER)","77 -LIB IFA3 Team: RAF (Side: GUER)","78 -LIB AWAR & Lennard: RBAF (Side: WEST)","79 -LIB AWAR: Red Army (Side: EAST)","80 -LIB AWAR & Lennard: [Winter] Red Army (Side: EAST)","81 -LIB El Tyranos & Jove Chiere: 101st Airborne Division (Side: GUER)","82 -LIB El Tyranos: 82nd Airborne Division (Side: GUER)","83 -LIB XXX: US Army Air Forces (Side: GUER)","84 -LIB AWAR: [Winter] US Airforce (Side: GUER)","85 -LIB IFA3 Team: US Army (Side: GUER)","86 -LIB XXX: [Winter] US Army (Side: GUER)","87 -LIB Lennard: US 2nd Ranger Battalion (Side: GUER)","88 -LIB I44: US Tank Troops (Side: GUER)","89 -LIB AWAR & Lennard: [Winter] US Tank Troops (Side: GUER)","90 -LIB AWAR: USSR Airforce (Side: EAST)","91 -LIB AWAR & Lennard: [Winter] USSR Airforce (Side: EAST)","92 -LIB AWAR: Tank troops of USSR (Side: EAST)","93 -LIB AWAR & Lennard: [Winter] Tank troops of USSR (Side: EAST)","94 -LIB AWAR: Wehrmacht (Side: WEST)","95 -LIB AWAR & Lennard: [Winter] Wehrmacht (Side: WEST)","96 -LM Burgess: UNSCMC (Urban) (Side: WEST)","97 -LM Burgess: UNSCMC (Desert) (Side: WEST)","98 -LM Burgess: ONI Security (Side: WEST)","99 -LM Burgess: UNSCMC (Snow) (Side: WEST)","100 -LM Burgess: UNSCMC (Wood) (Side: WEST)","101 -LM Burgess: OPCANTest (Side: WEST)","102 -LOP Project OPFOR: Boko Haram (Side: EAST)","103 -LOP Project OPFOR: Irish Republican Army (Side: EAST)","104 -LOP Project OPFOR: Ulster Volunteer Force (Side: GUER)","105 -LOP_LeightsOPFOR Project OPFOR: Afghan National Army and Police (Side: WEST)","106 -LOP_LeightsOPFOR Project OPFOR: African Militia (Side: GUER)","107 -LOP_LeightsOPFOR Project OPFOR: African Militia (Side: EAST)","108 -LOP_LeightsOPFOR Project OPFOR: Middle Eastern Militia (Side: GUER)","109 -LOP_LeightsOPFOR Project OPFOR: Middle Eastern Militia (Side: EAST)","110 -LOP_LeightsOPFOR Project OPFOR: Chernarussian Defence Forces (Side: WEST)","111 -LOP_LeightsOPFOR Project OPFOR: ChDKZ (Side: EAST)","112 -LOP_LeightsOPFOR Project OPFOR: Iraqi Armed Forces (Side: WEST)","113 -LOP_LeightsOPFOR Project OPFOR: Iranian Armed Forces (Side: GUER)","114 -LOP_LeightsOPFOR Project OPFOR: Islamic State (Side: GUER)","115 -LOP_LeightsOPFOR Project OPFOR: Islamic State (Side: EAST)","116 -LOP_LeightsOPFOR Project OPFOR: Chernarussian National Insurgents (Side: GUER)","117 -LOP_LeightsOPFOR Project OPFOR: Kurdish Peshmerga Forces (Side: WEST)","118 -LOP_LeightsOPFOR Project OPFOR: Kurdish Peshmerga Forces (Side: GUER)","119 -LOP_LeightsOPFOR Project OPFOR: Private Military Company (Side: GUER)","120 -LOP_LeightsOPFOR Project OPFOR: Royal Army Corps of Sahrani (Side: GUER)","121 -LOP_LeightsOPFOR Project OPFOR: Sahrani Liberation Army (Side: EAST)","122 -LOP_LeightsOPFOR Project OPFOR: Takistani Armed Forces (Side: EAST)","123 -LOP_LeightsOPFOR Project OPFOR: Ultranationalists (Side: GUER)","124 -LOP_LeightsOPFOR Project OPFOR: Ukrainian Armed Forces (Side: WEST)","125 -LOP_LeightsOPFOR Project OPFOR: United Nations (Side: GUER)","126 -LOP_LeightsOPFOR Project OPFOR: United Armed Forces of Novorossiya (Side: EAST)","127 -MOL HcPookie: Molatian Army (Side: EAST)","128 -OPTRE Article 2 Studios: Insurrectionists (Side: EAST)","129 -OPTRE Burgess: OPCAN (Side: WEST)","130 -OPTRE Burgess: OPCAN (UEG Colonial Guard) (Side: WEST)","131 -OPTRE Burgess: Colonial Militia (OPCAN) (Side: GUER)","132 -OPTRE Burgess: OPCAN (PMC) (Side: GUER)","133 -OPTRE Burgess: Halo Wars Rebels (OPCAN) (Side: EAST)","134 -OPTRE Burgess: Common Criminals (OPCAN) (Side: EAST)","135 -OPTRE Burgess: OPCAN (UNSC Army) (Side: WEST)","136 -OPTRE Burgess: United Rebel Air Force(OPCAN) (Side: EAST)","137 -OPTRE Burgess: United Rebel Army Desert(OPCAN) (Side: EAST)","138 -OPTRE Burgess: United Rebel Army BattleJumpers (OPCAN) (Side: EAST)","139 -OPTRE Burgess: United Rebel Army Tropic(OPCAN) (Side: EAST)","140 -OPTRE Bohemia Interactive: United Rebel Army Ground Vehicles (OPCAN) (Side: EAST)","141 -OPTRE Burgess: United Rebel Army Wood(OPCAN) (Side: EAST)","142 -OPTRE Burgess: OPCAN (WARZONE BLUE) (Side: WEST)","143 -OPTRE Burgess: OPCAN (WARZONE RED) (Side: EAST)","144 -OPTRE Article 2 Studios: Colonial Police (Side: GUER)","145 -OPTRE Article 2 Studios: UNSCDF (Side: WEST)","146 -RHS_AFRF Bohemia Interactive: [ISC] al-Nusra Front (Side: GUER)","147 -RHS_AFRF Bohemia Interactive: [ISC] Iraqi Army (Side: WEST)","148 -RHS_AFRF Bohemia Interactive: [ISC] Islamic State (Side: GUER)","149 -RHS_AFRF Bohemia Interactive: [ISC] Islamic State (Side: EAST)","150 -RHS_AFRF Bohemia Interactive: [ISC] Peshmerga (Side: WEST)","151 -RHS_AFRF Bohemia Interactive: [ISC] Syrian Arab Army (Side: EAST)","152 -RHS_AFRF Red Hammer Studios: Eastern Militia (Side: GUER)","153 -RHS_AFRF Red Hammer Studios: Russia (MSV) (Side: EAST)","154 -RHS_AFRF Red Hammer Studios: Russia (RVA) (Side: EAST)","155 -RHS_AFRF Red Hammer Studios: Russia (TV) (Side: EAST)","156 -RHS_AFRF Red Hammer Studios: Russia (VDV) (Side: EAST)","157 -RHS_AFRF Red Hammer Studios: Russia (VMF) (Side: EAST)","158 -RHS_AFRF RHS: Russia (VPVO) (Side: EAST)","159 -RHS_AFRF Red Hammer Studios: Russia (VV) (Side: EAST)","160 -RHS_AFRF Bohemia Interactive: Russia (VVS - Grey) (Side: EAST)","161 -RHS_AFRF Red Hammer Studios: Russia (VVS - Camo) (Side: EAST)","162 -RHS_GREF Red Hammer Studios: Chernarus (Air Force) (Side: GUER)","163 -RHS_GREF Red Hammer Studios: Chernarus (Air Force) (Side: WEST)","164 -RHS_GREF RHS (A2 port): Chernarus (Ground Forces) (Side: GUER)","165 -RHS_GREF Red Hammer Studios: Chernarus (Ground Forces) (Side: WEST)","166 -RHS_GREF Red Hammer Studios: Chernarus (National Guard) (Side: GUER)","167 -RHS_GREF Red Hammer Studios: Chernarus (National Guard) (Side: WEST)","168 -RHS_GREF Red Hammer Studios: ChDKZ Insurgents (Side: EAST)","169 -RHS_GREF Red Hammer Studios: ChDKZ Insurgents (Side: GUER)","170 -RHS_GREF Red Hammer Studios: Chernarus (U.N. Peacekeepers) (Side: GUER)","171 -RHS_SAF Red Hammer Studios: SAF (RVIPVO) (Side: GUER)","172 -RHS_SAF Red Hammer Studios: SAF (KOV) (Side: GUER)","173 -RHS_SAF Red Hammer Studios: SAF (Casques Bleus) (Side: GUER)","174 -RHS_USAF Red Hammer Studios: USA (SOCOM) (Side: WEST)","175 -RHS_USAF Red Hammer Studios: USA (USAF) (Side: WEST)","176 -RHS_USAF Red Hammer Studios: USA (Army - D) (Side: WEST)","177 -RHS_USAF Red Hammer Studios: USA (Army - W) (Side: WEST)","178 -RHS_USAF Red Hammer Studios: USA (USMC - D) (Side: WEST)","179 -RHS_USAF Red Hammer Studios: USA (USMC - W) (Side: WEST)","180 -RHS_USAF Red Hammer Studios: USA (Navy) (Side: WEST)","181 -RHSGREF Red Hammer Studios: Horizon Islands Defence Force (Side: WEST)","182 -RHSGREF Red Hammer Studios: Nationalist Troops (Side: GUER)","183 -SG Stagler: Sturmtroopers (Side: WEST)","184 -SG Stagler: [Winter] Sturmtroopers (Side: WEST)","185 -SG Stagler: Tank Sturmtroopers (Side: WEST)","186 -SWOP SWOP: SW Geonosians (Side: EAST)","187 -UNSC Morthon: UNSCMC (Side: WEST)","188 -UNSUNG Bohemia Interactive: Australia (UNSUNG) (Side: WEST)","189 -UNSUNG HCPOOKIE - SAM pack: N.V.A. (UNSUNG) (Side: EAST)","190 -UNSUNG Bohemia Interactive: V.C. (UNSUNG) (Side: EAST)","191 -UNSUNG Bohemia Interactive: A.R.V.N. (UNSUNG) (Side: GUER)","192 -UNSUNG Bohemia Interactive: New Zealand (UNSUNG) (Side: WEST)","193 -UNSUNG Bohemia Interactive: U.S. (UNSUNG) (Side: WEST)","194 -USML segen: Armed Islamic Front (Side: GUER)"};
		default = 7;
	};
	class btc_p_AA {
		title = "			Anti-Air infantry:";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 0;
	};
	class btc_p_tank {
		title = "			Enemy uses Tank:";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 0;
	};
	class btc_p_civ {
		title = "			Civil type:";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
		texts[]={"0 - EricJ: Afghan Civilians (Side: CIV)","1 - Bohemia Interactive: Civils (Side: CIV)","2 -btc_militia_mod Giallustio: Afghan Civilians (Side: CIV)","3 -CAF CAF MOD TEAM: African (Side: CIV)","4 -CAF CAF MOD TEAM: Middle Eastern (Side: CIV)","5 -CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","6 -CUP_Vehicles Community Upgrade Project: Civilians (Chernarus) (Side: CIV)","7 -CUP_Vehicles Bohemia Interactive: Civilians (Sahrani) (Side: CIV)","8 -CUP_Vehicles Community Upgrade Project: Civilians (Takistan) (Side: CIV)","9 -LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","10 -LOP_LeightsOPFOR Project OPFOR: Civilians (African) (Side: CIV)","11 -LOP_LeightsOPFOR Project OPFOR: Civilians (Eastern European) (Side: CIV)","12 -LOP_LeightsOPFOR Project OPFOR: Civilians (Middle Eastern) (Side: CIV)","13 -OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","14 -ORANGE Bohemia Interactive: IDAP (Side: CIV)","15 -RDS_CIV_PACK reyhard: Russians (Side: CIV)","16 -UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)"};
		default = 1;
	};
	class btc_p_civ_veh {
		title = "			Civil vehicle type:";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
		texts[]={"0 - EricJ: Afghan Civilians (Side: CIV)","1 - Bohemia Interactive: Civils (Side: CIV)","2 -btc_militia_mod Giallustio: Afghan Civilians (Side: CIV)","3 -CAF CAF MOD TEAM: African (Side: CIV)","4 -CAF CAF MOD TEAM: Middle Eastern (Side: CIV)","5 -CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","6 -CUP_Vehicles Community Upgrade Project: Civilians (Chernarus) (Side: CIV)","7 -CUP_Vehicles Bohemia Interactive: Civilians (Sahrani) (Side: CIV)","8 -CUP_Vehicles Community Upgrade Project: Civilians (Takistan) (Side: CIV)","9 -LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","10 -LOP_LeightsOPFOR Project OPFOR: Civilians (African) (Side: CIV)","11 -LOP_LeightsOPFOR Project OPFOR: Civilians (Eastern European) (Side: CIV)","12 -LOP_LeightsOPFOR Project OPFOR: Civilians (Middle Eastern) (Side: CIV)","13 -OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","14 -ORANGE Bohemia Interactive: IDAP (Side: CIV)","15 -RDS_CIV_PACK reyhard: Russians (Side: CIV)","16 -UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)"};
		default = 1;
	};
	class btc_p_IED_title {
		title = "<< IED options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_ied {
		title = "			IEDs ratio:";
		values[]={0, 1, 2, 3};
		texts[]={"Off","Low","Normal","High"};
		default = 2;
	};
	class btc_p_engineer {
		title = "			Everybody can disarm IED:";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 0;
	};
	class btc_p_hideout_cache_title {
		title = "<< Hideout/Cache options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_hideout_n {
		title = "			Hideout numbers:";
		values[]={99,1,2,3,4,5};
		texts[]={"Random","1","2","3","4","5"};
		default = 5;
	};
	class btc_p_cache_info_def {
		title = "			Info cache distance:";
		values[]={500,1000,1500,2000,2500,3000,3500,4000,5000};
		texts[]={"500 m","1000 m","1500 m","2000 m","2500 m","3000 m","3500 m","4000 m","5000 m"};
		default = 1000;
	};
	class btc_p_cache_info_ratio {
		title = "			Cache info ratio:";
		values[]={50,100};
		texts[]={"50 m","100 m"};
		default = 100;
	};
	class btc_p_info_chance {
		title = "			Intel from dead bodies chance:";
		values[]={0,10,20,30,40,50,60,70,80,90,100};
		texts[]={"100 %","90 %","80 %","70 %","60 %","50 %","40 %","30 %","20 %","10 %","0 %"};
		default = 70;
	};
	class btc_p_medical_title {
		title = "<< Medical options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_redeploy {
		title = "			Allow re-deploy?";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 1;
	};
	class btc_p_med_level {
	   title = "			Medical Level";
	   values[] = {1,2};
	   texts[] = {"Basic","Advanced"};
	   default = 1;
	};
	class btc_p_adv_wounds {
	   title = "			Advanced Wounds";
	   values[] = {0,1};
	   texts[] = {"Off","On"};
	   default = 1;
	};
	class btc_p_rev {
		title = "			Revive time:";
		values[]={0,60,120,180,240,300,600,900,1200,999999};
		texts[]={"Off","60","120","180","240","300","600","900","1200","999999"};
		default = 600;
	};
	class btc_p_skill_title {
		title = "<< A3 Skill options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_set_skill {
		title = "			Set skill?";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 1;
	};
	class btc_p_set_skill_general {
		title = "			Set skill, general";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 0;
	};
	class btc_p_set_skill_aimingAccuracy {
		title = "			Set skill, aimingAccuracy";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 1;
	};
	class btc_p_set_skill_aimingShake {
		title = "			Set skill, aimingShake";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 4;
	};
	class btc_p_set_skill_aimingSpeed {
		title = "			Set skill, aimingSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 3;
	};
	class btc_p_set_skill_endurance {
		title = "			Set skill, endurance";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 5;
	};
	class btc_p_set_skill_spotDistance {
		title = "			Set skill, spotDistance";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 9;
	};
	class btc_p_set_skill_spotTime {
		title = "			Set skill, spotTime";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 7;
	};
	class btc_p_set_skill_courage {
		title = "			Set skill, courage";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 2;
	};
	class btc_p_set_skill_reloadSpeed {
		title = "			Set skill, reloadSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 10;
	};
	class btc_p_set_skill_commanding {
		title = "			Set skill, commanding";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
		default = 7;
	};
	class btc_p_gameplay_title {
		title = "<< Gameplay options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_sea {
		title = "			Extend battlefield to sea:";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 1;
	};
	class btc_p_veh_armed_ho {
		title = "			Add armed vehicles in Hideout:";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 1;
	};
	class btc_p_veh_armed_spawn_more {
		title = "			Add armed vehicles in Side mission/Cache:";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 1;
	};
	class btc_p_side_mission_cycle {
		title = "			Side mission cycle:";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 0;
	};
	class btc_p_main_title {
		title = "<< Other options >>";
		values[]={0};
		texts[]={""};
		default = 0;
	};
	class btc_p_rep {
		title = "			Reputation at start:";
		values[]={0, 200, 500, 750};
		texts[]={"Very Low","Low","Normal","High"};
		default = 200;
	};
	class btc_p_rearm {
		title = "			Rearm Level:";
		values[]={0,1,2};
		texts[]={"Entire vehicle","Entire magazine","Amount based on caliber"};
		default = 0;
	};
	class btc_p_garage {
		title = "			Activate garage for admin:";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 1;
	};
	class btc_p_city_radius {
		title = "			Spawn city radius offset:";
		values[]={0,1,2,3,4,5,6,7,8};
		texts[]={"0 m","100 m","200 m","300 m (Default: Altis, Tanoa)","400 m","500 m (Takistan)","600 m","700 m","800 m"};
		default = 4;
	};
	class btc_p_trigger {
		title = "			Disable city activation when a plane or helicopter (>190Km/h) is flying above:";
		values[]={0,1};
		texts[]={"Off","On"};
		default = 0;
	};
	class btc_p_debug {
		title = "			Debug:";
		values[]={0,1,2};
		texts[]={"Off","On", "Log only"};
		default = 0;
	};
};
