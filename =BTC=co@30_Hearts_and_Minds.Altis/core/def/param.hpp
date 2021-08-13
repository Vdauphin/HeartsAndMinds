class Params {
    class btc_p_time_title { // << Time options >>
        title = $STR_BTC_HAM_PARAM_TIME_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_time { // Set the start time:
        title = __EVAL(format ["      %1", localize "STR_A3_CFGVEHICLES_MODULEDATE_F_ARGUMENTS_HOUR_0"]);
        values[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
        texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
        default = 12;
    };
    class btc_p_acctime { // Acceleration time multiplier:
        title = __EVAL(format ["      %1", localize "STR_USRACT_TIME_INC"]);
        values[]={1,2,3,4,5,6,7,8,9,10,11,12};
        texts[]={"1","2","3","4","5","6","7","8","9","10","11","12"};
        default = 3;
    };
    class btc_p_load { // Load the savegame (if available)
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_LOAD"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_auto_db { // Auto savegame when all players disconnected
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_ASAVE"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED}; // texts[]={"Off","On"};
        default = 0;
    };
    class btc_p_db_autoRestart { // Auto restart/shutdown server (Must define in server.cfg: serverCommandPassword = "btc_password")
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_ARESTART"]);
        values[]={0,1,2,3,4};
        texts[]={$STR_DISABLED,$STR_DISP_MP_DS_RESTART,$STR_BTC_HAM_PARAM_DB_SHUTDOWN,$STR_BTC_HAM_PARAM_DB_SAVERESTART, $STR_BTC_HAM_PARAM_DB_SAVESHUTDOWN}; // texts[]={"Off","Restart", "Shutdown","Save and restart", "Save and shutdown"};
        default = 4;
    };
    class btc_p_db_autoRestartTime { // Time before auto restart/shutdown server
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_ARESTARTTIME"]);
        values[]={1,2,3,4,5,6,7,8,9,10,11,12,24,48,72};
        texts[]={"1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","24h","48h","72h"};
        default = 48;
    };
    class btc_p_respawn_title { // << Respawn options >>
        title = $STR_BTC_HAM_RESP_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_respawn_location { // Respawn locations available:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_LOCATION"]);
        values[]={0,1,2,3,4};
        texts[]={$STR_BTC_HAM_RESP_FOBRALLY, $STR_BTC_HAM_RESP_FOBRALLYHELO, $STR_BTC_HAM_RESP_FOBRALLYHELI, $STR_BTC_HAM_RESP_FOBRALLYHELIVEHI, $STR_BTC_HAM_RESP_FOBRALLYHELIVEHILEADER};
        default = 0;
    };
    class btc_p_respawn_fromFOBToBase { // Allow respawn from FOB to base:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_FOBTOBASE"]);
        values[]={0,1};
        texts[]={$STR_DISABLED, $STR_ENABLED};
        default = 1;
    };
    class btc_p_rallypointTimer { // Time before rallypoint self-destruction:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_RALLYTIMER"]);
        values[]={0,5,10,30,60};
        texts[]={$STR_DISABLED,"5 min","10 min","30 min","60 min"};
        default = 30;
    };
    class btc_p_respawn_arsenal { // ACE Arsenal available on respawn after been killed:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_ENABLEARSENAL"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 0;
    };
    class btc_p_type_title { // << Faction options >>
        title = $STR_BTC_HAM_PARAM_FAC_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_en { // Enemy type:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_ETYPE"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325};
        texts[]={"0 - 00VTN Bohemia Interactive: U.S.M.C. (MARPAT Woodland) (Side: WEST)","1 - 01VTN Bohemia Interactive: U.S.M.C. (MARPAT Desert) (Side: WEST)","2 - 05VTN Bohemia Interactive: TIA-SF (Side: WEST)","3 - AFR BIS/IceBreakr: Afrenian Army (Side: WEST)","4 - ARA Bohemia Interactive: Abramian Rebel Alliance (Side: WEST)","5 - ARL BIS/IceBreakr: ARL Lingor Rebels (Side: EAST)","6 - BLU Community Upgrade Project and ATLAS Mod: 2035 NATO (Side: WEST)","7 - Bohemia Interactive: 2035 AAF (Side: GUER)","8 - Bohemia Interactive: 2035 CSAT (Side: EAST)","9 - Bohemia Interactive: 2035 FIA (Side: EAST)","10 - Bohemia Interactive: 2035 FIA (Side: GUER)","11 - Bohemia Interactive: 2035 FIA (Side: WEST)","12 - Bohemia Interactive: LDF (Side: GUER)","13 - Bohemia Interactive: Looters (Side: GUER)","14 - CEC HcPookie: Cecanian Army (Side: EAST)","15 - CFP CFP: Chadian Armed Forces (Side: WEST)","16 - CFP CFP: Iraqi Army (Hussein Regime) (Side: EAST)","17 - CFP CFP: Israeli Defense Force (Side: WEST)","18 - CFP CFP: Nigerian Army (Side: WEST)","19 - CFP CFP: Sudan Rapid Support Forces / Janjaweed (Side: EAST)","20 - CFP Drew: Abu Sayyaf Group (Side: EAST)","21 - CFP Drew: Afghan Police (Side: WEST)","22 - CFP Drew: Al Qaeda (Side: EAST)","23 - CFP Drew: al-Nusra Front (Side: GUER)","24 - CFP Drew: Al-Shabaab (Side: EAST)","25 - CFP Drew: Boko Haram (Side: EAST)","26 - CFP Drew: Central African Rebels (Side: EAST)","27 - CFP Drew: Hamas Al Qassam Brigades (Side: EAST)","28 - CFP Drew: Hezbollah (Side: EAST)","29 - CFP Drew: Iraqi Army (Side: WEST)","30 - CFP Drew: Iraqi Police (Side: WEST)","31 - CFP Drew: Islamic Republic of Iran Army (Side: EAST)","32 - CFP Drew: Islamic State (Side: EAST)","33 - CFP Drew: Islamic State (Side: GUER)","34 - CFP Drew: Kenyan Defense Force (Side: WEST)","35 - CFP Drew: Malian Government Forces (Side: WEST)","36 - CFP Drew: Peshmerga (Side: WEST)","37 - CFP Drew: Somali Rebels (Side: EAST)","38 - CFP Drew: South Sudan People's Defense Force (Side: GUER)","39 - CFP Drew: Sudan People's Liberation Movement In Opposition (Side: EAST)","40 - CFP Drew: Sudan People's Liberation Movement North (Side: GUER)","41 - CFP Drew: Sudan Revolutionary Front (Side: GUER)","42 - CFP Drew: Sudanese Armed Forces (Side: EAST)","43 - CFP Drew: Syrian Arab Army (Side: EAST)","44 - CFP Drew: Taliban Insurgents (Side: EAST)","45 - CFP Drew: Tuareg Rebels (Side: GUER)","46 - CFP Drew: Uganda People's Defense Force (Side: WEST)","47 - CFP Drew: US 75th Rangers (Jungle/Woodland) (Side: WEST)","48 - CFP Drew: US Navy Seals (Arid / Desert) (Side: WEST)","49 - CFP Drew: US Navy Seals (Jungle / Woodland) (Side: WEST)","50 - CFP Drew: YPG (Side: WEST)","51 - CFP Tupolov: Ansar Allah (Houthis) (Side: EAST)","52 - CFP Tupolov: Army of the Czech Rep. (Jungle / Woodland) (Side: WEST)","53 - CFP Tupolov: Western Ultranationalists (Side: GUER)","54 - CUP Community Upgrade Project: Army of the Czech Rep. (Arid / Desert) (Side: WEST)","55 - CUP Community Upgrade Project: British Army (Arid / Desert) (Side: WEST)","56 - CUP Community Upgrade Project: Chernarus Defense Forces (Side: WEST)","57 - CUP Community Upgrade Project: Chernarussian Movement of the Red Star (Side: EAST)","58 - CUP Community Upgrade Project: CUP Static Ships (Side: WEST)","59 - CUP Community Upgrade Project: Horizon Islands Legion (Side: WEST)","60 - CUP Community Upgrade Project: National Party of Chernarus (Side: GUER)","61 - CUP Community Upgrade Project: Royal Army Corps of Sahrani (Side: GUER)","62 - CUP Community Upgrade Project: Royal New Zealand Navy (Side: WEST)","63 - CUP Community Upgrade Project: Russian Ground Forces (Jungle / Woodland) (Side: EAST)","64 - CUP Community Upgrade Project: Sahrani Liberation Army (Side: EAST)","65 - CUP Community Upgrade Project: Takistani Army (Side: EAST)","66 - CUP Community Upgrade Project: Takistani Militia (Side: EAST)","67 - CUP Community Upgrade Project: United Nations (Side: GUER)","68 - CUP Community Upgrade Project: US Army (Arid / Desert) (Side: WEST)","69 - CUP Community Upgrade Project: US Marine Corps (Jungle / Woodland) (Side: WEST)","70 - CUP_Units Community Upgrade Project: British Army (Jungle / Woodland) (Side: WEST)","71 - CUP_Units Community Upgrade Project: Bundeswehr (Arid / Desert) (Side: WEST)","72 - CUP_Units Community Upgrade Project: Bundeswehr (Jungle / Woodland) (Side: WEST)","73 - CUP_Units Community Upgrade Project: ION PMC (Side: GUER)","74 - CUP_Units Community Upgrade Project: Russian Ground Forces (Arid / Desert) (Side: EAST)","75 - CUP_Units Community Upgrade Project: Takistani Locals (Side: GUER)","76 - CUP_Units Community Upgrade Project: US Marine Corps (Arid / Desert) (Side: WEST)","77 - CUP_Units Drew: Chernarus Defense Forces [Winter] (Side: WEST)","78 - CUP_Units Drew: PMC Wagner (Arid / Desert) (Side: EAST)","79 - CUP_Units Drew: PMC Wagner (Arid / Desert) (Side: GUER)","80 - CUP_Units Drew: PMC Wagner (Winter) (Side: EAST)","81 - CUP_Units Drew: PMC Wagner (Winter) (Side: GUER)","82 - CUP_Units Drew: PMC Wagner (Woodland) (Side: EAST)","83 - CUP_Units Drew: PMC Wagner (Woodland) (Side: GUER)","84 - CUP_Units Drew: US Army 1991 [Arid/Desert] (Side: WEST)","85 - CUP_Units Drew: US Army 1991 [Woodland] (Side: WEST)","86 - CUP_Units Drew: US Army 2003 [Arid/Desert] (Side: WEST)","87 - CUP_Units Drew: US Army 2003 [Woodland] (Side: WEST)","88 - CUP_Units Tupolov: Russian National Guard (Side: EAST)","89 - CUP_Units Tupolov: US CIA (Middle East) (Side: WEST)","90 - CUP_Vehicles Community Upgrade Project: US Army (Jungle / Woodland) (Side: WEST)","91 - CUP_Vehicles Drew: Afghan Army (Side: WEST)","92 - CUP_Vehicles Drew: Chernarussian Movement of the Red Star [Winter] (Side: EAST)","93 - Enoch Bohemia Interactive: Spetsnaz (Side: EAST)","94 - EricJ: Taliban (Side: EAST)","95 - Expansion Bohemia Interactive: 2035 CTRG (Side: WEST)","96 - Expansion Bohemia Interactive: 2035 Gendarmerie (Side: EAST)","97 - Expansion Bohemia Interactive: 2035 Gendarmerie (Side: WEST)","98 - Expansion Bohemia Interactive: 2035 NATO (Pacific) (Side: WEST)","99 - Expansion Drew: Korean People's Army (Side: EAST)","100 - FAP nzdfcrash/icebreakr: Fapovian Army (Side: EAST)","101 - FOW Bohemia Interactive: [DE] Heer (Side: WEST)","102 - FOW Bohemia Interactive: [JP] Navy Air Service (Side: WEST)","103 - FOW Bohemia Interactive: [UK] Fleet Air Arm (Side: GUER)","104 - FOW Bohemia Interactive: [US] Navy (Side: GUER)","105 - FOW FOW Team: [DE] Waffen-SS (Side: WEST)","106 - fow_mod Bohemia Interactive: [AUS] Army (Pacific) (Side: GUER)","107 - fow_mod Bohemia Interactive: [DE] Luftwaffe (Side: WEST)","108 - fow_mod Bohemia Interactive: [HI] Army (Side: GUER)","109 - fow_mod Bohemia Interactive: [UK] Army (Side: GUER)","110 - fow_mod Bohemia Interactive: [US] Army (Pacific) (Side: GUER)","111 - fow_mod FOW team: [JP] Imperial Army (Side: WEST)","112 - fow_mod FOW team: [US] Army (Europe) (Side: GUER)","113 - fow_mod FOW team: [US] Marines Corps (Side: GUER)","114 - GAL HcPookie: GAL (Government Army of Lingor) (Side: WEST)","115 - GANGBLUE BIS/IceBreakr: Blue Gang (Side: WEST)","116 - GANGRED BIS/IceBreakr: Red Gang (Side: EAST)","117 - gm Global Mobilization: Denmark (Side: WEST)","118 - gm Global Mobilization: East Germany (Borderguards) (Side: EAST)","119 - gm Global Mobilization: East Germany (Side: EAST)","120 - gm Global Mobilization: Poland (Side: EAST)","121 - gm Global Mobilization: West Germany (Borderguards) (Side: WEST)","122 - gm Global Mobilization: West Germany (Side: WEST)","123 - IBR Bohemia Interactive: Alienz (Side: GUER)","124 - IBR Lord Frith/IceBreakr: Robots (Side: EAST)","125 - ISC Bohemia Interactive: [ISC] al-Nusra Front (Side: GUER)","126 - ISC Bohemia Interactive: [ISC] Iraqi Police (Side: WEST)","127 - ISC Bohemia Interactive: [ISC] Islamic State (Side: EAST)","128 - ISC Bohemia Interactive: [ISC] Islamic State (Side: GUER)","129 - ISC Bohemia Interactive: [ISC] Peshmerga (Side: WEST)","130 - ISC Bohemia Interactive: [ISC] YPG (Side: WEST)","131 - jarrad96: Central African Rebels (Side: EAST)","132 - Jets Bravo Zero One Studios: [OPCAN] United Rebel Army (Side: EAST)","133 - LIB AWAR & Lennard: [Winter] Red Army (Side: EAST)","134 - LIB AWAR & Lennard: [Winter] Wehrmacht (Side: WEST)","135 - LIB AWAR & Lennard: ARR (Side: WEST)","136 - LIB AWAR & Lennard: MKHL (Side: WEST)","137 - LIB AWAR & Lennard: RBAF (Side: WEST)","138 - LIB AWAR: ACI (Side: GUER)","139 - LIB AWAR: Home Army (Polish) (Side: GUER)","140 - LIB AWAR: RAAF (Side: GUER)","141 - LIB AWAR: Red Army (Side: EAST)","142 - LIB AWAR: Wehrmacht (Side: WEST)","143 - LIB El Tyranos: 101st Airborne Division (Side: GUER)","144 - LIB El Tyranos: 82nd Airborne Division (Side: GUER)","145 - LIB El Tyranos: [Winter] UK Airborne (Side: GUER)","146 - LIB El Tyranos: [Winter] UK Army (Side: GUER)","147 - LIB El Tyranos: [Winter] US Army (Side: GUER)","148 - LIB IFA3 Team: FallschirmjÃ¤ger (Side: WEST)","149 - LIB IFA3 Team: UK Airborne (Side: GUER)","150 - LIB IFA3 Team: UK Army (Side: GUER)","151 - LIB IFA3 Team: UK Desert Rats (Side: GUER)","152 - LIB IFA3 team: US Army (Side: GUER)","153 - LIB Lennard: Deutsches Afrikakorps (Side: WEST)","154 - LIB Lennard: NKVD (Side: EAST)","155 - LIB Lennard: US 2nd Ranger Battalion (Side: GUER)","156 - LIB Lennard: US North African Corps (Side: GUER)","157 - LIB Reyhard & Joarius: FFI (Side: GUER)","158 - LM J.Burgess: [OPCAN] Colonial Guard Corps (Woodland) (Side: WEST)","159 - LM J.Burgess: [OPCAN] Colonial Military Authority (Side: GUER)","160 - LM J.Burgess: [OPCAN] Colonial Police Force (Side: GUER)","161 - LM J.Burgess: [OPCAN] Fridens (Desert) (Side: EAST)","162 - LM J.Burgess: [OPCAN] Fridens (Side: EAST)","163 - LM J.Burgess: [OPCAN] Fridens (Woodland) (Side: EAST)","164 - LM J.Burgess: [OPCAN] Koslovics (Side: EAST)","165 - LM J.Burgess: [OPCAN] Secessionist Union (Side: EAST)","166 - LM J.Burgess: [OPCAN] UNSC Army (Desert) (Side: WEST)","167 - LM J.Burgess: [OPCAN] UNSC Army (Mixed) (Side: WEST)","168 - LM J.Burgess: [OPCAN] UNSC Army (Woodland) (Side: WEST)","169 - LM J.Burgess: [OPCAN] UNSC Army Peace Corps (Side: WEST)","170 - LM J.Burgess: [OPCAN] UNSC Marine Corps (CE:A) (Side: WEST)","171 - LM J.Burgess: [OPCAN] UNSC Marine Corps (Desert) (Side: WEST)","172 - LM J.Burgess: [OPCAN] UNSC Marine Corps (Infinite) (Side: WEST)","173 - LM J.Burgess: [OPCAN] UNSC Marine Corps (Woodland) (Side: WEST)","174 - LOP_LeightsOPFOR Project OPFOR: Afghan National Army and Police (Side: WEST)","175 - LOP_LeightsOPFOR Project OPFOR: African Militia (Side: EAST)","176 - LOP_LeightsOPFOR Project OPFOR: African Militia (Side: GUER)","177 - LOP_LeightsOPFOR Project OPFOR: Boko Haram (Side: EAST)","178 - LOP_LeightsOPFOR Project OPFOR: CDF (Project OPFOR) (Side: WEST)","179 - LOP_LeightsOPFOR Project OPFOR: ChDKZ (Project OPFOR) (Side: EAST)","180 - LOP_LeightsOPFOR Project OPFOR: Chernarussian National Insurgents (Side: GUER)","181 - LOP_LeightsOPFOR Project OPFOR: Hellenic Armed Forces (Side: WEST)","182 - LOP_LeightsOPFOR Project OPFOR: Iranian Armed Forces (Side: GUER)","183 - LOP_LeightsOPFOR Project OPFOR: Iraqi Armed Forces (Side: WEST)","184 - LOP_LeightsOPFOR Project OPFOR: Irish Republican Army (Side: EAST)","185 - LOP_LeightsOPFOR Project OPFOR: Islamic State (Side: EAST)","186 - LOP_LeightsOPFOR Project OPFOR: Islamic State (Side: GUER)","187 - LOP_LeightsOPFOR Project OPFOR: Korean People's Army (Side: EAST)","188 - LOP_LeightsOPFOR Project OPFOR: Kurdish Peshmerga Forces (Side: GUER)","189 - LOP_LeightsOPFOR Project OPFOR: Kurdish Peshmerga Forces (Side: WEST)","190 - LOP_LeightsOPFOR Project OPFOR: Middle Eastern Militia (Side: EAST)","191 - LOP_LeightsOPFOR Project OPFOR: Middle Eastern Militia (Side: GUER)","192 - LOP_LeightsOPFOR Project OPFOR: Private Military Company (Side: GUER)","193 - LOP_LeightsOPFOR Project OPFOR: Royal Army Corps of Sahrani (Side: GUER)","194 - LOP_LeightsOPFOR Project OPFOR: Sahrani Liberation Army (Side: EAST)","195 - LOP_LeightsOPFOR Project OPFOR: Syrian Armed Forces (Side: EAST)","196 - LOP_LeightsOPFOR Project OPFOR: Takistani Armed Forces (Side: EAST)","197 - LOP_LeightsOPFOR Project OPFOR: Turkish Armed Forces (Side: GUER)","198 - LOP_LeightsOPFOR Project OPFOR: Ukrainian Armed Forces (Side: GUER)","199 - LOP_LeightsOPFOR Project OPFOR: Ulster Volunteer Force (Side: GUER)","200 - LOP_LeightsOPFOR Project OPFOR: Ultranationalists (Side: GUER)","201 - LOP_LeightsOPFOR Project OPFOR: United Armed Forces of Novorossiya (Side: EAST)","202 - LOP_LeightsOPFOR Project OPFOR: United Nations (Side: GUER)","203 - Mark Bohemia Interactive: NATO (Woodland) (Side: WEST)","204 - MOL HcPookie: Molatian Army (Side: EAST)","205 - OPF Community Upgrade Project: 2035 CSAT (Pacific) (Side: EAST)","206 - OPTRE Article 2 Studios: Colonial Police (Side: GUER)","207 - OPTRE Article 2 Studios: Covenant (Side: EAST)","208 - OPTRE Article 2 Studios: Insurrectionists (Side: EAST)","209 - OPTRE Article 2 Studios: UNSCDF (Side: WEST)","210 - RHS_AFRF Red Hammer Studios: [ISC] Iraqi Army (Side: WEST)","211 - RHS_AFRF Red Hammer Studios: Russia (MSV) (Side: EAST)","212 - RHS_AFRF Red Hammer Studios: Russia (RVA) (Side: EAST)","213 - RHS_AFRF Red Hammer Studios: Russia (TV) (Side: EAST)","214 - RHS_AFRF Red Hammer Studios: Russia (VDV) (Side: EAST)","215 - RHS_AFRF Red Hammer Studios: Russia (VMF) (Side: EAST)","216 - RHS_AFRF Red Hammer Studios: Russia (VV) (Side: EAST)","217 - RHS_AFRF Red Hammer Studios: Russia (VVS - Camo) (Side: EAST)","218 - RHS_AFRF Red Hammer Studios: Russia (VVS - Grey) (Side: EAST)","219 - RHS_AFRF RHS: Russia (VPVO) (Side: EAST)","220 - RHS_GREF Red Hammer Studios: [ISC] Syrian Arab Army (Side: EAST)","221 - RHS_GREF Red Hammer Studios: CDF (Air Forces) (Side: WEST)","222 - RHS_GREF Red Hammer Studios: ChDKZ (Side: EAST)","223 - RHS_GREF RHS (A2 port): CDF (Air Forces) (Side: GUER)","224 - RHS_SAF Red Hammer Studios: SAF (KOV) (Side: GUER)","225 - RHS_SAF RHS (A2 port): SAF (KOV) (Side: EAST)","226 - RHS_SAF RHS (A2 port): SAF (RVIPVO) (Side: EAST)","227 - RHS_SAF RHS (A2 port): SAF (RVIPVO) (Side: GUER)","228 - RHS_SAF RHS (A2 port): SAF (UN Peacekeepers) (Side: GUER)","229 - RHS_USAF Red Hammer Studios: USA (Army - D) (Side: WEST)","230 - RHS_USAF Red Hammer Studios: USA (Army - W) (Side: WEST)","231 - RHS_USAF Red Hammer Studios: USA (Navy) (Side: WEST)","232 - RHS_USAF Red Hammer Studios: USA (SOCOM) (Side: WEST)","233 - RHS_USAF Red Hammer Studios: USA (USAF) (Side: WEST)","234 - RHS_USAF Red Hammer Studios: USA (USMC - D) (Side: WEST)","235 - RHS_USAF Red Hammer Studios: USA (USMC - W) (Side: WEST)","236 - RHSGREF Red Hammer Studios: CDF (UN) (Side: GUER)","237 - RHSGREF Red Hammer Studios: NAPA (Side: GUER)","238 - RHSGREF Red Hammer Studios: Tanoan Liberation Army (Side: EAST)","239 - RHSGREF Red Hammer Studios: Tanoan Liberation Army (Side: GUER)","240 - RHSGREF www.3commandobrigade.com: CDF (Ground Forces) (Side: GUER)","241 - RHSGREF www.3commandobrigade.com: CDF (Ground Forces) (Side: WEST)","242 - Savage Game Design: ARVN (Side: GUER)","243 - Savage Game Design: MACV (Side: WEST)","244 - Savage Game Design: PAVN (Side: EAST)","245 - Savage Game Design: Viet Cong (Side: EAST)","246 - SG Stagler: Sturmtroopers (Side: WEST)","247 - SG Stagler: Tank Sturmtroopers (Side: WEST)","248 - Tank Bohemia Interactive: 2035 Syndikat (Side: GUER)","249 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: EAST)","250 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: GUER)","251 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: WEST)","252 - UK3CB_Factions www.3commandobrigade.com: 3CB Afghan National Army (Side: WEST)","253 - UK3CB_Factions www.3commandobrigade.com: 3CB Afghan National Police (Side: WEST)","254 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: EAST)","255 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: GUER)","256 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: WEST)","257 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: EAST)","258 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: GUER)","259 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: WEST)","260 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: EAST)","261 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: GUER)","262 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: WEST)","263 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: EAST)","264 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: GUER)","265 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: WEST)","266 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Extremists (Side: EAST)","267 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Extremists (Side: GUER)","268 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: EAST)","269 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: GUER)","270 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: WEST)","271 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: EAST)","272 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: GUER)","273 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: WEST)","274 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDKZ (Chernarussian Movement of the Red Star) (Side: EAST)","275 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDSZ (Chernarussian Movement of the Blue Star) (Side: WEST)","276 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDZZ (Chernarussian Movement of the Green Star) (Side: GUER)","277 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: EAST)","278 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: GUER)","279 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: WEST)","280 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Communist Militia (Side: EAST)","281 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Local Defence Volunteers (Side: WEST)","282 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Nationalist Militia (Side: GUER)","283 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: EAST)","284 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: GUER)","285 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: WEST)","286 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War US - Early (Side: WEST)","287 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War US - Late (Side: WEST)","288 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War USSR - Early (Side: EAST)","289 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War USSR - Late (Side: EAST)","290 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: EAST)","291 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: GUER)","292 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: WEST)","293 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: EAST)","294 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: GUER)","295 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: WEST)","296 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Insurgents (Side: EAST)","297 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: EAST)","298 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: GUER)","299 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: WEST)","300 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: EAST)","301 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: GUER)","302 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: WEST)","303 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Pro-Government Militia (Side: WEST)","304 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Tribal Fighters (Side: GUER)","305 - UK3CB_Factions www.3commandobrigade.com: 3CB UN Peacekeepers (Side: GUER)","306 - UK3CB_Factions www.3commandobrigade.com: 3CB UN Peacekeepers (Side: WEST)","307 - UK3CB_Factions www.3commandobrigade.com: CDF (National Guard) (Side: GUER)","308 - UK3CB_Factions www.3commandobrigade.com: CDF (National Guard) (Side: WEST)","309 - UK3CB_Factions www.3commandobrigade.com: ChDKZ (Side: GUER)","310 - UK3CB_Factions www.3commandobrigade.com: Horizon Islands Defence Force (Side: WEST)","311 - UNSUNG Bohemia Interactive: Australia (UNSUNG) (Side: WEST)","312 - UNSUNG Bohemia Interactive: New Zealand (UNSUNG) (Side: WEST)","313 - UNSUNG Bohemia Interactive: R.O.K. (UNSUNG) (Side: WEST)","314 - UNSUNG Bohemia Interactive: U.S. (UNSUNG) (Side: WEST)","315 - UNSUNG Bohemia Interactive: V.C. (UNSUNG) (Side: EAST)","316 - UNSUNG Razorback: N.V.A. (UNSUNG) (Side: EAST)","317 - UNSUNG UNSUNG: A.R.V.N. (UNSUNG) (Side: GUER)","318 - VTN VTN: GRU SSPB (Side: EAST)","319 - VTN VTN: Insurgents (Side: GUER)","320 - VTN VTN: ISIL (Side: GUER)","321 - VTN VTN: Mechanized infantry (EMR) (Side: EAST)","322 - VTN VTN: Mechanized infantry (VSR-98) (Side: EAST)","323 - VTN VTN: Militia (Side: GUER)","324 - VTN VTN: MVD SPPU (Side: EAST)","325 - VTN VTN: Takistan national guard (Side: EAST)"};
        default = 297;
    };
    class btc_p_AA { // Anti-Air infantry:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_EAA"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_tank { // Enemy uses Tank:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_ETANK"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_civ { // Civil type:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_CTYPE"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28};
        texts[]={"0 - Bohemia Interactive: Civilians (Side: CIV)","1 - Bohemia Interactive: Other (Side: CIV)","2 - CFP Drew: Civilians (Afghanistan) (Side: CIV)","3 - CFP Drew: Civilians (African Christian) (Side: CIV)","4 - CFP Drew: Civilians (African Islamic) (Side: CIV)","5 - CFP Drew: Civilians (Asian) (Side: CIV)","6 - CFP Drew: Civilians (Chernarus Winter) (Side: CIV)","7 - CFP Drew: Civilians (Malden) (Side: CIV)","8 - CFP Drew: Civilians (Middle Eastern) (Side: CIV)","9 - CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","10 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Chernarus) (Side: CIV)","11 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Sahrani) (Side: CIV)","12 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Takistan) (Side: CIV)","13 - EricJ: Afghan Civilians (Side: CIV)","14 - gm Global Mobilization: East Germany (Civilians) (Side: CIV)","15 - gm Global Mobilization: West Germany (Civilians) (Side: CIV)","16 - LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","17 - LOP_LeightsOPFOR Project OPFOR: Civilians (African) (Side: CIV)","18 - LOP_LeightsOPFOR Project OPFOR: Civilians (Eastern European) (Side: CIV)","19 - LOP_LeightsOPFOR Project OPFOR: Civilians (Middle Eastern) (Side: CIV)","20 - OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","21 - OPTRE Article 2 Studios: IDAP (Side: CIV)","22 - RDS_CIV_PACK RDS (BIS A2 Port): Polish (Side: CIV)","23 - RDS_CIV_PACK RDS (BIS A2 Port): Russians (Side: CIV)","24 - Savage Game Design: Vietnamese (Side: CIV)","25 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: CIV)","26 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: CIV)","27 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: CIV)","28 - UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)"};
        default = 26;
    };
    class btc_p_civ_veh { // Civil vehicle type:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_CTYPEVEH"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28};
        texts[]={"0 - Bohemia Interactive: Civilians (Side: CIV)","1 - Bohemia Interactive: Other (Side: CIV)","2 - CFP Drew: Civilians (Afghanistan) (Side: CIV)","3 - CFP Drew: Civilians (African Christian) (Side: CIV)","4 - CFP Drew: Civilians (African Islamic) (Side: CIV)","5 - CFP Drew: Civilians (Asian) (Side: CIV)","6 - CFP Drew: Civilians (Chernarus Winter) (Side: CIV)","7 - CFP Drew: Civilians (Malden) (Side: CIV)","8 - CFP Drew: Civilians (Middle Eastern) (Side: CIV)","9 - CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","10 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Chernarus) (Side: CIV)","11 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Sahrani) (Side: CIV)","12 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Takistan) (Side: CIV)","13 - EricJ: Afghan Civilians (Side: CIV)","14 - gm Global Mobilization: East Germany (Civilians) (Side: CIV)","15 - gm Global Mobilization: West Germany (Civilians) (Side: CIV)","16 - LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","17 - LOP_LeightsOPFOR Project OPFOR: Civilians (African) (Side: CIV)","18 - LOP_LeightsOPFOR Project OPFOR: Civilians (Eastern European) (Side: CIV)","19 - LOP_LeightsOPFOR Project OPFOR: Civilians (Middle Eastern) (Side: CIV)","20 - OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","21 - OPTRE Article 2 Studios: IDAP (Side: CIV)","22 - RDS_CIV_PACK RDS (BIS A2 Port): Polish (Side: CIV)","23 - RDS_CIV_PACK RDS (BIS A2 Port): Russians (Side: CIV)","24 - Savage Game Design: Vietnamese (Side: CIV)","25 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: CIV)","26 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: CIV)","27 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: CIV)","28 - UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)"};
        default = 26;
    };
    class btc_p_spawn_title { // << Spawn options >>
        title = $STR_BTC_HAM_PARAM_SPAWN_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_is_free_prob { // Probability for a city to be free:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ISFREE_PROB"]);
        values[]={0,10,20,30,40,45,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","45%","50%","60%","70%","80%","90%","100%"};
        default = 45;
    };
    class btc_p_mil_group_ratio { // Enemy density:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ENEMY_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 100;
    };
    class btc_p_mil_static_group_ratio { // Enemy static density:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ENEMY_STATIC_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 100;
    };
    class btc_p_civ_group_ratio { // Civilian density:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_CIVILIAN_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 100;
    };
    class btc_p_animals_group_ratio { // Animal density:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ANIMALS_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 100;
    };
    class btc_p_wp_house_probability { // Density of military in house:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_MIL_INHOUSE_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 30;
    };
    class btc_p_veh_armed_ho { // Add armed vehicles in Hideout:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPAWN_ARMEDHIDEOUT"]);
        values[] = {0,1};
        texts[] = {$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_veh_armed_spawn_more { // Add armed vehicles in Side mission/Cache:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPAWN_ARMEDOTHER"]);
        values[] = {0,1};
        texts[] = {$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_patrol_max { // Maximum number of military patrol:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_PATROL_MAX"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"1","2","3","4","5","6","7","8","9","10"};
        default = 15;
    };
    class btc_p_civ_max_veh { // Maximum number of civilian patrol:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_CIV_MAX_VEH"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"1","2","3","4","5","6","7","8","9","10"};
        default = 20;
    };
    class btc_p_IED_title { // << IED options >>
        title = $STR_BTC_HAM_PARAM_IED_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_ied { // IEDs ratio:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_IED_RATIO"]);
        values[]={0, 1, 2, 3};
        texts[]={$STR_DISABLED,$STR_A3_TIME_TRIALS_MISCTT_ROF_25,$STR_3DEN_ATTRIBUTES_SPEEDMODE_NORMAL,$STR_A3_TIME_TRIALS_MISCTT_ROF_21}; //texts[]={"Off","Low","Normal","High"};
        default = 2;
    };
    class btc_p_ied_spot { // IEDs spotting difficulty:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_IED_SPOT"]);
        values[]={0, 1, 2};
        texts[]={$STR_BTC_HAM_PARAM_IED_SPOT_VERYEASY,$STR_BTC_HAM_PARAM_IED_SPOT_EASY,$STR_3DEN_ATTRIBUTES_SPEEDMODE_NORMAL}; //texts[]={"Very easy","Easy","Normal"};
        default = 2;
    };
    class btc_p_ied_placement { // IEDs type of placement:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_IED_PLACEMENT"]);
        values[]={2, -1, 3};
        texts[]={$STR_BTC_HAM_PARAM_IED_PLACEMENT_ROADSIDE,$STR_BTC_HAM_PARAM_IED_PLACEMENT_MIDDLE,$STR_3DEN_ATTRIBUTES_OBJECTTEXTURE_RANDOM_TEXT}; //texts[]={"Roadside", "Middle", "Random"};
        default = 3;
    };
    class btc_p_ied_drone { // Drone bomber:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_IED_DRONE"]);
        values[]={0, 1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_hideout_cache_title { // << Hideout/Cache options >>
        title = $STR_BTC_HAM_PARAM_HIDE_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_hideout_n { // Hideout numbers:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_HIDE_NUMBERS"]);
        values[]={99,1,2,3,4,5,7};
        texts[]={$STR_3DEN_ATTRIBUTES_OBJECTTEXTURE_RANDOM_TEXT,"1","2","3","4","5"}; //texts[]={"Random","1","2","3","4","5"};
        default = 7;
    };
    class btc_p_cache_info_def { // Info cache distance:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_CACHE_DISTANCE"]);
        values[]={500,1000,1500,2000,2500,3000,3500,4000,5000};
        texts[]={"500 m","1000 m","1500 m","2000 m","2500 m","3000 m","3500 m","4000 m","5000 m"};
        default = 1000;
    };
    class btc_p_cache_info_ratio { //Cache info ratio:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_CACHE_RATIO"]);
        values[]={50,100};
        texts[]={"50 m","100 m"};
        default = 100;
    };
    class btc_p_info_chance { // Intel from dead bodies chance:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_CACHE_DEADINFO"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"100 %","90 %","80 %","70 %","60 %","50 %","40 %","30 %","20 %","10 %","0 %"};
        default = 90;
    };
    class btc_p_skill_title { // << A3 Skill options >>
        title = $STR_BTC_HAM_PARAM_SKILL_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_set_skill { // Set skill?
        title = __EVAL(format ["      %1?", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_set_skill_general { // Set skill, general
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_3DEN_SCENARIO_TEXTSINGULAR"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 4;
    };
    class btc_p_set_skill_aimingAccuracy { // Set skill, aimingAccuracy
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_AIMACC"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 5;
    };
    class btc_p_set_skill_aimingShake { // Set skill, aimingShake
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_AIMSKILL"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 4;
    };
    class btc_p_set_skill_aimingSpeed { // Set skill, aimingSpeed
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_AIMSPEED"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 5;
    };
    class btc_p_set_skill_endurance { // Set skill, endurance
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_A3_VR_STAMINA"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 4;
    };
    class btc_p_set_skill_spotDistance { // Set skill, spotDistance
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_SPOTDIST"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 5;
    };
    class btc_p_set_skill_spotTime { // Set skill, spotTime
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_SPOTTIME"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 5;
    };
    class btc_p_set_skill_courage { // Set skill, courage
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_COURAGE"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 6;
    };
    class btc_p_set_skill_reloadSpeed { // Set skill, reloadSpeed
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_RELOAD"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 10;
    };
    class btc_p_set_skill_commanding { // Set skill, commanding
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_A3_CFGHINTS0"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 10;
    };
    class btc_p_gameplay_title { // << Gameplay options >>
        title = $STR_BTC_HAM_PARAM_GAMEPLAY_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_sea { // Extend battlefield to sea:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_GAMEPLAY_SEA"]);
        values[] = {0,1};
        texts[] = {$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_chem { // Chemical warfare
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_GAMEPLAY_CHEM"]);
        values[] = {0,1};
        texts[] = {$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_spect { // Spectrum devices
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_GAMEPLAY_SPECT"]);
        values[] = {0,1};
        texts[] = {$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_side_mission_cycle { // Side mission cycle:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_GAMEPLAY_SIDEM"]);
        values[] = {0,1,2,3,4};
        texts[] = {$STR_DISABLED,1,2,3,4};
        default = 3;
    };
    class btc_p_arsenal_title { // << Arsenal options >>
        title = $STR_BTC_HAM_PARAM_ARSENAL_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_arsenal_Type { // Type of the arsenal:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE"]);
        values[]={0,1,2,3,4};
        texts[]={$STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE_BIS,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE_BA,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE_BA_PLUS,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE_ACE,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALTYPE_ACE_PLUS}; //texts[]={"BIS - Vanilla","BIS - Vanilla and ACE 3","BIS - Vanilla and ACE 3 (scroll wheel action)","ACE 3","ACE 3 (scroll wheel action)"};
        default = 4;
    };
    class btc_p_arsenal_Restrict { // Restricted arsenal (See /define_mod.sqf):
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR"]);
        values[]={0,1,2,3};
        texts[] = {$STR_DISABLED,$STR_3DEN_ATTRIBUTES_SPEEDMODE_FULL,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR_REMOVEONLY,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR_FILTER}; //texts[]={"Off","Full","Remove only (works only with ACE3-Arsenal)","Filter on player role (works only with ACE3-Arsenal)"};
        default = 3;
    };
    class btc_p_autoloadout { // loadout:
        title = __EVAL(format ["      %1:", localize "STR_ACE_Interaction_Equipment"]);
        values[]={0,1,2};
        texts[]={$STR_DISABLED,$STR_BTC_HAM_PARAM_ARSENAL_AUTOLOADOUT, $STR_BTC_HAM_PARAM_ARSENAL_RMVWEAPONS};
        default = 0;
    };
    class btc_p_garage { // Activate garage for admin:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_ARSENAL_GARAGEADMIN"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_main_title { // << Other options >>
        title = $STR_BTC_HAM_PARAM_OTHER_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_rep { // Reputation at start:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_REPSTART"]);
        values[]={0, 200, 500, 750};
        texts[]={$STR_ACE_ViewDistance_object_verylow,$STR_A3_TIME_TRIALS_MISCTT_ROF_25,$STR_3DEN_ATTRIBUTES_SPEEDMODE_NORMAL,$STR_A3_TIME_TRIALS_MISCTT_ROF_21}; //texts[]={"Very Low","Low","Normal","High"};
        default = 200;
    };
    class btc_p_rep_notify { // Show reputation change:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_SHOWREP"]);
        values[]={0, 1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_city_radius { // Spawn city radius offset:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_SPAWNRAD"]);
        values[]={0,1,2,3,4,5,6,7,8};
        texts[]={"0 m","100 m","200 m",$STR_BTC_HAM_PARAM_OTHER_SPAWNRAD_DEF,"400 m","500 m (Takistan)","600 m","700 m","800 m"}; // texts[]={"0 m","100 m","200 m","300 m","400 m","500 m (Takistan)","600 m","700 m","800 m"};
        default = 1;
    };
    class btc_p_trigger { // Disable city activation when a plane or helicopter (>190Km/h) is flying above:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_DISABLESPAWN"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_auto_headless { // Autodetect Headless client:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_AUTOHEADLESS"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_debug { // Debug:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_DEBUG"]);
        values[]={0,1,2};
        texts[]={$STR_DISABLED,$STR_ENABLED, $STR_BTC_HAM_PARAM_OTHER_DEBUG_LOGONLY}; // texts[]={"Off","On","Log only"};
        default = 0;
    };
};
