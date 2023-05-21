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
        default = 5;
    };
    class btc_p_change_time { // Enable change day time for officer on the arsenal box:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_CHANGE_TIME_ENABLEARSENAL"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };    
    class btc_p_change_weather { // Enable change weather for officer on the arsenal box
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_CHANGE_WEATHER_ENABLEARSENAL"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_db_title { // << Server management >>
        title = $STR_BTC_HAM_PARAM_DB_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
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
        default = 1;
    };
    class btc_p_db_autoRestartTime { // Time before auto restart/shutdown server
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_ARESTARTTIME"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,24,48,72};
        texts[]={$STR_DISABLED, "1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","24h","48h","72h"};
        default = 0;
    };
    class btc_p_db_autoRestartHour1 { // Hour of auto restart/shutdown server
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_HRESTARTTIME"]);
        values[]={-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
        texts[]={$STR_DISABLED,"00h00","01h00","02h00","03h00","04h00","05h00","06h00","07h00","08h00","09h00","10h00","11h00","12h00","13h00","14h00","15h00","16h00","17h00","18h00","19h00","20h00","21h00","22h00","23h00"};
        default = 3;
    };
    class btc_p_db_autoRestartHour2 { // Hour of auto restart/shutdown server
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_HRESTARTTIME"]);
        values[]={-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
        texts[]={$STR_DISABLED,"00h00","01h00","02h00","03h00","04h00","05h00","06h00","07h00","08h00","09h00","10h00","11h00","12h00","13h00","14h00","15h00","16h00","17h00","18h00","19h00","20h00","21h00","22h00","23h00"};
        default = -1;
    };
    class btc_p_db_autoRestartType { // Auto restart/shutdown server (Must define in server.cfg: serverCommandPassword = "btc_password")
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_DB_ARESTART"]);
        values[]={1,2,3,4};
        texts[]={$STR_DISP_MP_DS_RESTART,$STR_BTC_HAM_PARAM_DB_SHUTDOWN,$STR_BTC_HAM_PARAM_DB_SAVERESTART, $STR_BTC_HAM_PARAM_DB_SAVESHUTDOWN}; // texts[]={"Off","Restart", "Shutdown","Save and restart", "Save and shutdown"};
        default = 3;
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
        default = 0;
    };
    class btc_p_respawn_ticketsAtStart { // Number of tickets at mission start:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_TICKETSATSTART"]);
        values[]={-1,0,1,2,3,4,5,10,15,20,25,30,50,70,100,150,200};
        texts[]={$STR_DISABLED,"0","1","2","3","4","5","10","15","20","25","30","50","70","100","150","200"};
        default = 100;
    };
    class btc_p_respawn_ticketsLost { // Number of tickets lost per death:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_TICKETSLOST"]);
        values[]={1,2,3,4,5,6,7,8,9,10};
        texts[]={"1","2","3","4","5","6","7","8","9","10"};
        default = 1;
    };
    class btc_p_respawn_ticketsShare { // Tickets are share between:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_TICKETSHARE"]);
        values[]={0,1};
        texts[]={$STR_BTC_HAM_RESP_SAMEFACTION, $STR_BTC_HAM_RESP_NOTSHARE};
        default = 0;
    };
    class btc_p_respawn_ticketsFromPrisoners { // Attribute tickets from prisoners to (Enable only if tickets are not share):
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_TICKETPRISONER"]);
        values[]={1,2,3,4};
        texts[]={$STR_BTC_HAM_RESP_ALLCONNECTED, $STR_BTC_HAM_RESP_PLAYER, $STR_BTC_HAM_RESP_DEADPLAYER, $STR_BTC_HAM_RESP_LOWESTPLAYER};
        default = 2;
    };
    class btc_p_body_timeBeforeShowMarker { // Time before showing marker of dead player's body:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_TIMEBEFORESHOWMARKER"]);
        values[]={-1,0,5,10,30,60};
        texts[]={$STR_DISABLED,"0 min","5 min","10 min","30 min","60 min"};
        default = 60;
    };
    class btc_p_respawn_arsenal { // ACE Arsenal available on respawn after been killed:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_RESP_ENABLEARSENAL"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 1;
    };
    class btc_p_slot_isShare { // Each slot is share between players
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SLOT_ISSHARE"]);
        values[]={0,1};
        texts[]={$STR_DISABLED, $STR_ENABLED};
        default = 1;
    };
    class btc_p_type_title { // << Faction options >>
        title = $STR_BTC_HAM_PARAM_FAC_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_en { // Enemy type:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_ETYPE"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339};
        texts[]={"0 - ÄŒSLA Studio: ÄŒSLA (Side: EAST)","1 - ÄŒSLA Studio: AFMC (Side: WEST)","2 - ÄŒSLA Studio: FIA [ÄŒSLA] (Side: GUER)","3 - ÄŒSLA Studio: US â€˜85 (Side: WEST)","4 - : Awakened (Side: EAST)","5 - AFR BIS/IceBreakr: Afrenian Army (Side: WEST)","6 - ARA Bohemia Interactive: Abramian Rebel Alliance (Side: WEST)","7 - ARL BIS/IceBreakr: ARL Lingor Rebels (Side: EAST)","8 - BLU Bohemia Interactive: US (Side: WEST)","9 - Bohemia Interactive: 2035 AAF (Side: GUER)","10 - Bohemia Interactive: 2035 CTRG (Side: WEST)","11 - Bohemia Interactive: 2035 FIA (Side: EAST)","12 - Bohemia Interactive: 2035 FIA (Side: GUER)","13 - Bohemia Interactive: 2035 FIA (Side: WEST)","14 - Bohemia Interactive: 2035 Syndikat (Side: GUER)","15 - Bohemia Interactive: LDF (Side: GUER)","16 - Bohemia Interactive: Looters (Side: GUER)","17 - CEC HcPookie: Cecanian Army (Side: EAST)","18 - CFP CFP: Chadian Armed Forces (Side: WEST)","19 - CFP CFP: Iraqi Army (Hussein Regime) (Side: EAST)","20 - CFP CFP: Israeli Defense Force (Side: WEST)","21 - CFP CFP: Nigerian Army (Side: WEST)","22 - CFP CFP: Sudan Rapid Support Forces / Janjaweed (Side: EAST)","23 - CFP Drew: Abu Sayyaf Group (Side: EAST)","24 - CFP Drew: Afghan Police (Side: WEST)","25 - CFP Drew: Al Qaeda (Side: EAST)","26 - CFP Drew: al-Nusra Front (Side: GUER)","27 - CFP Drew: Al-Shabaab (Side: EAST)","28 - CFP Drew: Boko Haram (Side: EAST)","29 - CFP Drew: Central African Rebels (Side: EAST)","30 - CFP Drew: Hamas Al Qassam Brigades (Side: EAST)","31 - CFP Drew: Hezbollah (Side: EAST)","32 - CFP Drew: Iraqi Army (Side: WEST)","33 - CFP Drew: Iraqi Police (Side: WEST)","34 - CFP Drew: Islamic Republic of Iran Army (Side: EAST)","35 - CFP Drew: Islamic State (Side: EAST)","36 - CFP Drew: Islamic State (Side: GUER)","37 - CFP Drew: Kenyan Defense Force (Side: WEST)","38 - CFP Drew: Malian Government Forces (Side: WEST)","39 - CFP Drew: Peshmerga (Side: WEST)","40 - CFP Drew: Somali Rebels (Side: EAST)","41 - CFP Drew: South Sudan People's Defense Force (Side: GUER)","42 - CFP Drew: Sudan People's Liberation Movement In Opposition (Side: EAST)","43 - CFP Drew: Sudan People's Liberation Movement North (Side: GUER)","44 - CFP Drew: Sudan Revolutionary Front (Side: GUER)","45 - CFP Drew: Sudanese Armed Forces (Side: EAST)","46 - CFP Drew: Syrian Arab Army (Side: EAST)","47 - CFP Drew: Taliban Insurgents (Side: EAST)","48 - CFP Drew: Tuareg Rebels (Side: GUER)","49 - CFP Drew: Uganda People's Defense Force (Side: WEST)","50 - CFP Drew: US 75th Rangers (Jungle/Woodland) (Side: WEST)","51 - CFP Drew: US Navy Seals (Arid / Desert) (Side: WEST)","52 - CFP Drew: US Navy Seals (Jungle / Woodland) (Side: WEST)","53 - CFP Drew: YPG (Side: WEST)","54 - CFP Tupolov: Ansar Allah (Houthis) (Side: EAST)","55 - CFP Tupolov: Army of the Czech Rep. (Jungle / Woodland) (Side: WEST)","56 - CFP Tupolov: Western Ultranationalists (Side: GUER)","57 - CUP Community Upgrade Project: Army of the Czech Rep. (Arid / Desert) (Side: WEST)","58 - CUP Community Upgrade Project: British Army (Arid / Desert) (Side: WEST)","59 - CUP Community Upgrade Project: Chernarus Defense Forces (Side: WEST)","60 - CUP Community Upgrade Project: Chernarussian Movement of the Red Star (Side: EAST)","61 - CUP Community Upgrade Project: CUP Static Ships (Side: WEST)","62 - CUP Community Upgrade Project: National Party of Chernarus (Side: GUER)","63 - CUP Community Upgrade Project: Royal Army Corps of Sahrani (Side: GUER)","64 - CUP Community Upgrade Project: Royal New Zealand Navy (Side: WEST)","65 - CUP Community Upgrade Project: Russian Ground Forces (Jungle / Woodland) (Side: EAST)","66 - CUP Community Upgrade Project: Sahrani Liberation Army (Side: EAST)","67 - CUP Community Upgrade Project: Takistani Army (Side: EAST)","68 - CUP Community Upgrade Project: Takistani Militia (Side: EAST)","69 - CUP Community Upgrade Project: United Nations (Side: GUER)","70 - CUP Community Upgrade Project: US Army (Arid / Desert) (Side: WEST)","71 - CUP Community Upgrade Project: US Marine Corps (Jungle / Woodland) (Side: WEST)","72 - CUP CUP: Bundeswehr (Arid / Desert) (Side: WEST)","73 - CUP joker006 + CUP: Horizon Islands Legion (Side: WEST)","74 - CUP joker006 + CUP: ION PMC (Side: GUER)","75 - CUP_Units Community Upgrade Project: British Army (Jungle / Woodland) (Side: WEST)","76 - CUP_Units Community Upgrade Project: Bundeswehr (Jungle / Woodland) (Side: WEST)","77 - CUP_Units Community Upgrade Project: Russian Ground Forces (Arid / Desert) (Side: EAST)","78 - CUP_Units Community Upgrade Project: Takistani Locals (Side: GUER)","79 - CUP_Units Community Upgrade Project: US Marine Corps (Arid / Desert) (Side: WEST)","80 - CUP_Units Drew: Chernarus Defense Forces [Winter] (Side: WEST)","81 - CUP_Units Drew: PMC Wagner (Arid / Desert) (Side: EAST)","82 - CUP_Units Drew: PMC Wagner (Arid / Desert) (Side: GUER)","83 - CUP_Units Drew: PMC Wagner (Winter) (Side: EAST)","84 - CUP_Units Drew: PMC Wagner (Winter) (Side: GUER)","85 - CUP_Units Drew: PMC Wagner (Woodland) (Side: EAST)","86 - CUP_Units Drew: PMC Wagner (Woodland) (Side: GUER)","87 - CUP_Units Drew: US Army 1991 [Arid/Desert] (Side: WEST)","88 - CUP_Units Drew: US Army 1991 [Woodland] (Side: WEST)","89 - CUP_Units Drew: US Army 2003 [Arid/Desert] (Side: WEST)","90 - CUP_Units Drew: US Army 2003 [Woodland] (Side: WEST)","91 - CUP_Units Tupolov: Russian National Guard (Side: EAST)","92 - CUP_Units Tupolov: US CIA (Middle East) (Side: WEST)","93 - CUP_Vehicles Community Upgrade Project: US Army (Jungle / Woodland) (Side: WEST)","94 - CUP_Vehicles Drew: Afghan Army (Side: WEST)","95 - CUP_Vehicles Drew: Chernarussian Movement of the Red Star [Winter] (Side: EAST)","96 - cwr3_dlc CWR III Modification: FIA (CWR III) (Side: GUER)","97 - cwr3_dlc CWR III Modification: Rebels (CWR III) (Side: EAST)","98 - cwr3_dlc CWR III Modification: Rebels (CWR III) (Side: WEST)","99 - cwr3_dlc CWR III Modification: Soviet Army (CWR III) (Side: EAST)","100 - cwr3_dlc CWR III Modification: United States Army (CWR III) (Side: WEST)","101 - cwr3_dlc CWR III Modification: United States Army, Desert (CWR III) (Side: WEST)","102 - Enoch Bohemia Interactive: Russia (Side: EAST)","103 - Enoch Ravenholme: LDF (Arid) (Side: GUER)","104 - Expansion AveryTheKitty: BAF (Pacific) (Side: WEST)","105 - Expansion AveryTheKitty: BAF (Side: WEST)","106 - Expansion AveryTheKitty: BAF (Woodland) (Side: WEST)","107 - Expansion AveryTheKitty: Russia (Arid) (Side: EAST)","108 - Expansion Bohemia Interactive: 2035 Gendarmerie (Side: WEST)","109 - Expansion Bohemia Interactive: 2035 Viper (Side: EAST)","110 - Expansion Bohemia Interactive: CTRG (Pacific) (Side: WEST)","111 - Expansion Bohemia Interactive: US (Pacific) (Side: WEST)","112 - Expansion Bohemia Interactive: Viper (Pacific) (Side: EAST)","113 - Expansion Drew: Korean People's Army (Side: EAST)","114 - FAP nzdfcrash/icebreakr: Fapovian Army (Side: EAST)","115 - FOW Bohemia Interactive: [DE] Heer (Side: WEST)","116 - FOW Bohemia Interactive: [JP] Navy Air Service (Side: WEST)","117 - FOW Bohemia Interactive: [UK] Fleet Air Arm (Side: GUER)","118 - FOW Bohemia Interactive: [US] Navy (Side: GUER)","119 - FOW FOW Team: [DE] Waffen-SS (Side: WEST)","120 - fow_mod Bohemia Interactive: [AUS] Army (Pacific) (Side: GUER)","121 - fow_mod Bohemia Interactive: [DE] Luftwaffe (Side: WEST)","122 - fow_mod Bohemia Interactive: [HI] Army (Side: GUER)","123 - fow_mod Bohemia Interactive: [UK] Army (Side: GUER)","124 - fow_mod Bohemia Interactive: [US] Army (Pacific) (Side: GUER)","125 - fow_mod FOW team: [JP] Imperial Army (Side: WEST)","126 - fow_mod FOW team: [US] Army (Europe) (Side: GUER)","127 - fow_mod FOW team: [US] Marines Corps (Side: GUER)","128 - GAL HcPookie: GAL (Government Army of Lingor) (Side: WEST)","129 - GANGBLUE BIS/IceBreakr: Blue Gang (Side: WEST)","130 - GANGRED BIS/IceBreakr: Red Gang (Side: EAST)","131 - gm Global Mobilization: Denmark (Side: WEST)","132 - gm Global Mobilization: East Germany (Borderguards) (Side: EAST)","133 - gm Global Mobilization: East Germany (Side: EAST)","134 - gm Global Mobilization: Poland (Side: EAST)","135 - gm Global Mobilization: West Germany (Borderguards) (Side: WEST)","136 - gm Global Mobilization: West Germany (Side: WEST)","137 - Howard: Taliban Force 2021 (Side: EAST)","138 - IBR Bohemia Interactive: Alienz (Side: GUER)","139 - IBR Lord Frith/IceBreakr: Robots (Side: EAST)","140 - IND Heliotrope: Raven Security (Side: GUER)","141 - LIB AWAR & Lennard: [Winter] Red Army (Side: EAST)","142 - LIB AWAR & Lennard: [Winter] Wehrmacht (Side: WEST)","143 - LIB AWAR & Lennard: ARR (Side: WEST)","144 - LIB AWAR & Lennard: MKHL (Side: WEST)","145 - LIB AWAR & Lennard: RBAF (Side: WEST)","146 - LIB AWAR: ACI (Side: GUER)","147 - LIB AWAR: Home Army (Polish) (Side: GUER)","148 - LIB AWAR: RAAF (Side: GUER)","149 - LIB AWAR: Red Army (Side: EAST)","150 - LIB AWAR: Wehrmacht (Side: WEST)","151 - LIB El Tyranos: 101st Airborne Division (Side: GUER)","152 - LIB El Tyranos: 82nd Airborne Division (Side: GUER)","153 - LIB El Tyranos: [Winter] UK Airborne (Side: GUER)","154 - LIB El Tyranos: [Winter] UK Army (Side: GUER)","155 - LIB El Tyranos: [Winter] US Army (Side: GUER)","156 - LIB IFA3 Team: FallschirmjÃ¤ger (Side: WEST)","157 - LIB IFA3 Team: UK Airborne (Side: GUER)","158 - LIB IFA3 Team: UK Army (Side: GUER)","159 - LIB IFA3 Team: UK Desert Rats (Side: GUER)","160 - LIB IFA3 team: US Army (Side: GUER)","161 - LIB Lennard: Deutsches Afrikakorps (Side: WEST)","162 - LIB Lennard: NKVD (Side: EAST)","163 - LIB Lennard: US 2nd Ranger Battalion (Side: GUER)","164 - LIB Lennard: US North African Corps (Side: GUER)","165 - LIB Reyhard & Joarius: FFI (Side: GUER)","166 - lxWS Rotators Collective: UNA (Side: WEST)","167 - Mark Bohemia Interactive: US (Woodland) (Side: WEST)","168 - MOL HcPookie: Molatian Army (Side: EAST)","169 - OPF Bohemia Interactive: Argana (Side: EAST)","170 - OPF Bohemia Interactive: Iran (Side: EAST)","171 - OPF Community Upgrade Project: China (Side: EAST)","172 - OPF Heliotrope: Raven Security (Side: EAST)","173 - OPTRE Article 2 Studios: CAA (Side: GUER)","174 - OPTRE Article 2 Studios: Colonial Police (Side: GUER)","175 - OPTRE Article 2 Studios: Covenant (Side: EAST)","176 - OPTRE Article 2 Studios: Insurrectionists (Side: EAST)","177 - OPTRE Article 2 Studios: UNSCDF (Side: WEST)","178 - RHS Red Hammer Studios: Russia (VMF) (Side: EAST)","179 - RHS_AFRF Red Hammer Studios: Russia (MSV) (Side: EAST)","180 - RHS_AFRF Red Hammer Studios: Russia (RVA) (Side: EAST)","181 - RHS_AFRF Red Hammer Studios: Russia (TV) (Side: EAST)","182 - RHS_AFRF Red Hammer Studios: Russia (VDV) (Side: EAST)","183 - RHS_AFRF Red Hammer Studios: Russia (VPVO) (Side: EAST)","184 - RHS_AFRF Red Hammer Studios: Russia (VV) (Side: EAST)","185 - RHS_AFRF Red Hammer Studios: Russia (VVS - Camo) (Side: EAST)","186 - RHS_AFRF Red Hammer Studios: Russia (VVS - Grey) (Side: EAST)","187 - RHS_GREF Red Hammer Studios: CDF (Air Forces) (Side: WEST)","188 - RHS_GREF RHS (A2 port): CDF (Air Forces) (Side: GUER)","189 - RHS_SAF Red Hammer Studios: SAF (KOV) (Side: GUER)","190 - RHS_SAF RHS (A2 port): SAF (KOV) (Side: EAST)","191 - RHS_SAF RHS (A2 port): SAF (RVIPVO) (Side: EAST)","192 - RHS_SAF RHS (A2 port): SAF (RVIPVO) (Side: GUER)","193 - RHS_SAF RHS (A2 port): SAF (UN Peacekeepers) (Side: GUER)","194 - RHS_USAF Red Hammer Studios: USA (Army - D) (Side: WEST)","195 - RHS_USAF Red Hammer Studios: USA (Army - W) (Side: WEST)","196 - RHS_USAF Red Hammer Studios: USA (Navy) (Side: WEST)","197 - RHS_USAF Red Hammer Studios: USA (SOCOM) (Side: WEST)","198 - RHS_USAF Red Hammer Studios: USA (USAF) (Side: WEST)","199 - RHS_USAF Red Hammer Studios: USA (USMC - D) (Side: WEST)","200 - RHS_USAF Red Hammer Studios: USA (USMC - W) (Side: WEST)","201 - RHSGREF Red Hammer Studios: CDF (UN) (Side: GUER)","202 - RHSGREF Red Hammer Studios: NAPA (Side: GUER)","203 - RHSGREF Red Hammer Studios: Tanoan Liberation Army (Side: EAST)","204 - RHSGREF Red Hammer Studios: Tanoan Liberation Army (Side: GUER)","205 - RHSGREF www.3commandobrigade.com: CDF (Ground Forces) (Side: GUER)","206 - RHSGREF www.3commandobrigade.com: CDF (Ground Forces) (Side: WEST)","207 - SC : Archons (Side: GUER)","208 - SC Scion Conflict Mod Team: Amalgamate Republic (Side: WEST)","209 - SC Scion Conflict Mod Team: Atlas Corporation (Side: GUER)","210 - SC Scion Conflict Mod Team: Martian Defence Force (Side: EAST)","211 - SC Scion Conflict Mod Team: Scion Empire (Side: EAST)","212 - SG Stagler: Sturmtroopers (Side: WEST)","213 - SG Stagler: Tank Sturmtroopers (Side: WEST)","214 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: EAST)","215 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: GUER)","216 - UK3CB_Factions www.3commandobrigade.com: 3CB AAF (Side: WEST)","217 - UK3CB_Factions www.3commandobrigade.com: 3CB Afghan National Army (Side: WEST)","218 - UK3CB_Factions www.3commandobrigade.com: 3CB Afghan National Police (Side: WEST)","219 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: EAST)","220 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: GUER)","221 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army (Side: WEST)","222 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: EAST)","223 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: GUER)","224 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Army Paramilitary (Side: WEST)","225 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: EAST)","226 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: GUER)","227 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilian Militia (Side: WEST)","228 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: EAST)","229 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: GUER)","230 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: WEST)","231 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Extremists (Side: EAST)","232 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Extremists (Side: GUER)","233 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: EAST)","234 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: GUER)","235 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Militia (Side: WEST)","236 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: EAST)","237 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: GUER)","238 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert National Police (Side: WEST)","239 - UK3CB_Factions www.3commandobrigade.com: 3CB Ardistan Army (Side: EAST)","240 - UK3CB_Factions www.3commandobrigade.com: 3CB Ardistan Army (Side: GUER)","241 - UK3CB_Factions www.3commandobrigade.com: 3CB Ardistan Army (Side: WEST)","242 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDKZ (Chernarussian Movement of the Red Star) (Side: EAST)","243 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDKZ Winter (Chernarussian Movement of the Red Star) (Side: EAST)","244 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDSZ (Chernarussian Movement of the Blue Star) (Side: WEST)","245 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDSZ Winter (Chernarussian Movement of the Blue Star) (Side: WEST)","246 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDZZ (Chernarussian Movement of the Green Star) (Side: GUER)","247 - UK3CB_Factions www.3commandobrigade.com: 3CB ChDZZ Winter (Chernarussian Movement of the Green Star) (Side: GUER)","248 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: EAST)","249 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: GUER)","250 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: WEST)","251 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Communist Militia (Side: EAST)","252 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Local Defence Volunteers (Side: WEST)","253 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Nationalist Militia (Side: GUER)","254 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: EAST)","255 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: GUER)","256 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Police Department (Side: WEST)","257 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War US - Early (Side: WEST)","258 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War US - Late (Side: WEST)","259 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War USSR - Early (Side: EAST)","260 - UK3CB_Factions www.3commandobrigade.com: 3CB Cold War USSR - Late (Side: EAST)","261 - UK3CB_Factions www.3commandobrigade.com: 3CB Karzeghistan Royal Guard (Side: EAST)","262 - UK3CB_Factions www.3commandobrigade.com: 3CB Karzeghistan Royal Guard (Side: GUER)","263 - UK3CB_Factions www.3commandobrigade.com: 3CB Karzeghistan Royal Guard (Side: WEST)","264 - UK3CB_Factions www.3commandobrigade.com: 3CB Kolgujev Defence Force (Side: EAST)","265 - UK3CB_Factions www.3commandobrigade.com: 3CB Kolgujev Defence Force (Side: GUER)","266 - UK3CB_Factions www.3commandobrigade.com: 3CB Kolgujev Defence Force (Side: WEST)","267 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Defence Force (Side: EAST)","268 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Defence Force (Side: GUER)","269 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Defence Force (Side: WEST)","270 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Forest Rangers (Side: EAST)","271 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Forest Rangers (Side: GUER)","272 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Forest Rangers (Side: WEST)","273 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Separatist Militia (Side: EAST)","274 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Separatist Militia (Side: GUER)","275 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonia Separatist Militia (Side: WEST)","276 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonian Nationalist Militia (Side: EAST)","277 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonian Nationalist Militia (Side: GUER)","278 - UK3CB_Factions www.3commandobrigade.com: 3CB Livonian Nationalist Militia (Side: WEST)","279 - UK3CB_Factions www.3commandobrigade.com: 3CB Malden Defence Force (Side: EAST)","280 - UK3CB_Factions www.3commandobrigade.com: 3CB Malden Defence Force (Side: GUER)","281 - UK3CB_Factions www.3commandobrigade.com: 3CB Malden Defence Force (Side: WEST)","282 - UK3CB_Factions www.3commandobrigade.com: 3CB Middle East Extremists (Side: EAST)","283 - UK3CB_Factions www.3commandobrigade.com: 3CB Middle East Extremists (Side: GUER)","284 - UK3CB_Factions www.3commandobrigade.com: 3CB Middle East Insurgents (Side: EAST)","285 - UK3CB_Factions www.3commandobrigade.com: 3CB Middle East Insurgents (Side: GUER)","286 - UK3CB_Factions www.3commandobrigade.com: 3CB Middle East Insurgents (Side: WEST)","287 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: EAST)","288 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: GUER)","289 - UK3CB_Factions www.3commandobrigade.com: 3CB NAPA (The National Party) (Side: WEST)","290 - UK3CB_Factions www.3commandobrigade.com: 3CB NFA (Nogovan Freedom Alliance) (Side: EAST)","291 - UK3CB_Factions www.3commandobrigade.com: 3CB NFA (Nogovan Freedom Alliance) (Side: GUER)","292 - UK3CB_Factions www.3commandobrigade.com: 3CB NFA (Nogovan Freedom Alliance) (Side: WEST)","293 - UK3CB_Factions www.3commandobrigade.com: 3CB Nogova Police Department (Side: EAST)","294 - UK3CB_Factions www.3commandobrigade.com: 3CB Nogova Police Department (Side: GUER)","295 - UK3CB_Factions www.3commandobrigade.com: 3CB Nogova Police Department (Side: WEST)","296 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: EAST)","297 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: GUER)","298 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: WEST)","299 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Insurgents (Side: EAST)","300 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: EAST)","301 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: GUER)","302 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Army (Side: WEST)","303 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: EAST)","304 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: GUER)","305 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan National Police (Side: WEST)","306 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Pro-Government Militia (Side: WEST)","307 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Tribal Fighters (Side: GUER)","308 - UK3CB_Factions www.3commandobrigade.com: 3CB UN Peacekeepers (Side: GUER)","309 - UK3CB_Factions www.3commandobrigade.com: 3CB UN Peacekeepers (Side: WEST)","310 - UK3CB_Factions www.3commandobrigade.com: CDF (National Guard) (Side: GUER)","311 - UK3CB_Factions www.3commandobrigade.com: CDF (National Guard) (Side: WEST)","312 - UK3CB_Factions www.3commandobrigade.com: ChDKZ (Side: EAST)","313 - UK3CB_Factions www.3commandobrigade.com: ChDKZ (Side: GUER)","314 - UK3CB_Factions www.3commandobrigade.com: Horizon Islands Defence Force (Side: WEST)","315 - UNSUNG Bohemia Interactive: A.R.V.N. (UNSUNG) (Side: GUER)","316 - UNSUNG Bohemia Interactive: Australia (UNSUNG) (Side: WEST)","317 - UNSUNG Bohemia Interactive: New Zealand (UNSUNG) (Side: WEST)","318 - UNSUNG Bohemia Interactive: R.O.K. (UNSUNG) (Side: WEST)","319 - UNSUNG Bohemia Interactive: U.S. (UNSUNG) (Side: WEST)","320 - UNSUNG Bohemia Interactive: V.C. (UNSUNG) (Side: EAST)","321 - UNSUNG Razorback: N.V.A. (UNSUNG) (Side: EAST)","322 - VN Savage Game Design: ARVN (Side: GUER)","323 - VN Savage Game Design: Australia (Side: WEST)","324 - VN Savage Game Design: Laos (Side: GUER)","325 - VN Savage Game Design: MACV (Side: WEST)","326 - VN Savage Game Design: New Zealand (Side: WEST)","327 - VN Savage Game Design: Pathet Lao (Side: EAST)","328 - VN Savage Game Design: PAVN (Side: EAST)","329 - VN Savage Game Design: Republic Of Korea (Side: WEST)","330 - VN Savage Game Design: US CIA (Side: WEST)","331 - VN Savage Game Design: Viet Cong (Side: EAST)","332 - ws Rotators Collective: 2035 Gendarmerie (Side: EAST)","333 - ws Rotators Collective: ION Services (Side: WEST)","334 - ws Rotators Collective: SFIA (Side: EAST)","335 - ws Rotators Collective: SFIA (Side: GUER)","336 - ws Rotators Collective: Tura (Side: EAST)","337 - ws Rotators Collective: Tura (Side: GUER)","338 - ws Rotators Collective: Tura (Side: WEST)","339 - ws Rotators Collective: USMC (Desert) (Side: WEST)"};
        default = 11;
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
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26};
        texts[]={"0 - Bohemia Interactive: Civilians (Side: CIV)","1 - Bohemia Interactive: Other (Side: CIV)","2 - CFP Drew: Civilians (Afghanistan) (Side: CIV)","3 - CFP Drew: Civilians (African Christian) (Side: CIV)","4 - CFP Drew: Civilians (African Islamic) (Side: CIV)","5 - CFP Drew: Civilians (Asian) (Side: CIV)","6 - CFP Drew: Civilians (Chernarus Winter) (Side: CIV)","7 - CFP Drew: Civilians (Malden) (Side: CIV)","8 - CFP Drew: Civilians (Middle Eastern) (Side: CIV)","9 - CIV joker006 + CUP: IDAP (Side: CIV)","10 - CSLA ÄŒSLA Studio: Civilians [ÄŒSLA] (Side: CIV)","11 - CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","12 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Chernarus) (Side: CIV)","13 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Sahrani) (Side: CIV)","14 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Takistan) (Side: CIV)","15 - cwr3_dlc CWR III Modification: Civilians (CWR III) (Side: CIV)","16 - gm Global Mobilization: East Germany (Civilians) (Side: CIV)","17 - gm Global Mobilization: West Germany (Civilians) (Side: CIV)","18 - LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","19 - OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","20 - RDS_CIV_PACK RDS (BIS A2 Port): Polish (Side: CIV)","21 - RDS_CIV_PACK RDS (BIS A2 Port): Russians (Side: CIV)","22 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: CIV)","23 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: CIV)","24 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: CIV)","25 - UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)","26 - VN Savage Game Design: Vietnamese (Side: CIV)"};
        default = 0;
    };
    class btc_p_civ_veh { // Civil vehicle type:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_FAC_CTYPEVEH"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26};
        texts[]={"0 - Bohemia Interactive: Civilians (Side: CIV)","1 - Bohemia Interactive: Other (Side: CIV)","2 - CFP Drew: Civilians (Afghanistan) (Side: CIV)","3 - CFP Drew: Civilians (African Christian) (Side: CIV)","4 - CFP Drew: Civilians (African Islamic) (Side: CIV)","5 - CFP Drew: Civilians (Asian) (Side: CIV)","6 - CFP Drew: Civilians (Chernarus Winter) (Side: CIV)","7 - CFP Drew: Civilians (Malden) (Side: CIV)","8 - CFP Drew: Civilians (Middle Eastern) (Side: CIV)","9 - CIV joker006 + CUP: IDAP (Side: CIV)","10 - CSLA ÄŒSLA Studio: Civilians [ÄŒSLA] (Side: CIV)","11 - CUP_Units Community Upgrade Project: Civilians (Russian) (Side: CIV)","12 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Chernarus) (Side: CIV)","13 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Sahrani) (Side: CIV)","14 - CUP_Vehicles $CUP_AUTHOR_STRING: Civilians (Takistan) (Side: CIV)","15 - cwr3_dlc CWR III Modification: Civilians (CWR III) (Side: CIV)","16 - gm Global Mobilization: East Germany (Civilians) (Side: CIV)","17 - gm Global Mobilization: West Germany (Civilians) (Side: CIV)","18 - LIB Reyhard & Joarius: 40s Civilians (Side: CIV)","19 - OPTRE Article 2 Studios: Civilians (UEG) (Side: CIV)","20 - RDS_CIV_PACK RDS (BIS A2 Port): Polish (Side: CIV)","21 - RDS_CIV_PACK RDS (BIS A2 Port): Russians (Side: CIV)","22 - UK3CB_Factions www.3commandobrigade.com: 3CB African Desert Civilians (Side: CIV)","23 - UK3CB_Factions www.3commandobrigade.com: 3CB Chernarus Civilians (Side: CIV)","24 - UK3CB_Factions www.3commandobrigade.com: 3CB Takistan Civilians (Side: CIV)","25 - UNSUNG Bohemia Interactive: Vietnamese (UNSUNG) (Side: CIV)","26 - VN Savage Game Design: Vietnamese (Side: CIV)"};
        default = 0;
    };
    class btc_p_spawn_title { // << Spawn options >>
        title = $STR_BTC_HAM_PARAM_SPAWN_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class btc_p_density_of_occupiedCity { // Density of city occupied:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ISOCCUPIED_DENSITY"]);
        values[]={0,10,20,30,40,45,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","45%","50%","60%","70%","80%","90%","100%"};
        default = 60;
    };
    class btc_p_mil_group_ratio { // Enemy density:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_ENEMY_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 80;
    };
    class btc_p_wp_houseDensity { // Density of military in house: (Can't be above 100%)
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_MIL_INHOUSE_DENSITY"]);
        values[]={0,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 40;
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
        default = 10;
    };
    class btc_p_civ_max_veh { // Maximum number of civilian patrol:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_SPWAN_CIV_MAX_VEH"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
        texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"};
        default = 10;
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
	class btc_p_ied_power { // Power of IED explosion:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_IED_POWER"]);
        values[]={0, 1};
        texts[]={$STR_MEDIUM,$STR_SMALL};
        default = 0;
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
        values[]={99,0,1,2,3,4,5,6,7,8,9,10};
        texts[]={$STR_3DEN_ATTRIBUTES_OBJECTTEXTURE_RANDOM_TEXT,"0","1","2","3","4","5","6","7","8","9","10"}; //texts[]={"Random","0","1","2","3","4","5"};
        default = 5;
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
        default = 50;
    };
    class btc_p_info_houseDensity { // Density of intel in house:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_CACHE_HOUSEINFO"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
        texts[]={"0%","1%","2%","3%","4%","5%","6%","7%","8%","9%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"};
        default = 10;
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
        default = 0;
    };
    class btc_p_set_skill_aimingAccuracy { // Set skill, aimingAccuracy
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_AIMACC"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 1;
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
        default = 3;
    };
    class btc_p_set_skill_endurance { // Set skill, endurance
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_A3_VR_STAMINA"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 5;
    };
    class btc_p_set_skill_spotDistance { // Set skill, spotDistance
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_SPOTDIST"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 9;
    };
    class btc_p_set_skill_spotTime { // Set skill, spotTime
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_SPOTTIME"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 7;
    };
    class btc_p_set_skill_courage { // Set skill, courage
        title = __EVAL(format ["      %1, %2", localize "STR_A3_CFGVEHICLES_MODULESKILL_F_0", localize "STR_BTC_HAM_PARAM_SKILL_COURAGE"]);
        values[]={0,1,2,3,4,5,6,7,8,9,10};
        texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
        default = 2;
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
        default = 7;
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
        default = 2;
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
        default = 3;
    };
    class btc_p_arsenal_Restrict { // Restricted arsenal (See /define_mod.sqf):
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR"]);
        values[]={0,1,2,3};
        texts[] = {$STR_DISABLED,$STR_3DEN_ATTRIBUTES_SPEEDMODE_FULL,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR_REMOVEONLY,$STR_BTC_HAM_PARAM_ARSENAL_ARSENALRESTR_FILTER}; //texts[]={"Off","Full","Remove only (works only with ACE3-Arsenal)","Filter on player role (works only with ACE3-Arsenal)"};
        default = 0;
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
    class btc_p_rep_notify { // Show reputation change above of:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_SHOWREP"]);
        values[]={-1, 0, 1, 2, 3, 5, 10, 25, 50, 100, 200};
        texts[]={$STR_DISABLED, 0, 1, 2, 3, 5, 10, 25, 50, 100, 200};
        default = 3;
    };
    class btc_p_city_radiusOffset { // Spawn city radius offset:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_SPAWNRAD"]);
        values[]={0,1,2,3,4,5,6,7,8};
        texts[]={"0 m","100 m","200 m",$STR_BTC_HAM_PARAM_OTHER_SPAWNRAD_DEF,"400 m","500 m (Takistan)","600 m","700 m","800 m"}; // texts[]={"0 m","100 m","200 m","300 m","400 m","500 m (Takistan)","600 m","700 m","800 m"};
        default = 5;
    };
    class btc_p_trigger { // Disable city activation when a plane or helicopter (>190Km/h) is flying above:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_DISABLESPAWN"]);
        values[]={0,1};
        texts[]={$STR_DISABLED,$STR_ENABLED};
        default = 0;
    };
    class btc_p_city_free_trigger { // City will be free if number of enemies is equal or lower than:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_CITYFREE"]);
        values[]={0,1,2,3,5};
        texts[]={$STR_DISABLED,"1","2","3","5"};
        default = 5;
    };
    class btc_p_flag { // Allow the use of flag:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_ALLOWFLAG"]);
        values[]={0,1,2,3};
        texts[]={$STR_DISABLED,$STR_BTC_HAM_PARAM_OTHER_FLAGVEH,$STR_BTC_HAM_PARAM_OTHER_FLAGVEHLEADER,$STR_BTC_HAM_PARAM_OTHER_FLAGVEHPLAYER};
        default = 1;
    };
    class btc_p_debug { // Debug:
        title = __EVAL(format ["      %1", localize "STR_BTC_HAM_PARAM_OTHER_DEBUG"]);
        values[]={0,1,2};
        texts[]={$STR_DISABLED,$STR_ENABLED, $STR_BTC_HAM_PARAM_OTHER_DEBUG_LOGONLY}; // texts[]={"Off","On","Log only"};
        default = 0;
    };
};
