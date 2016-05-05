class Params {
    class btc_p_time {
	//paramsArray[0]
        title = "Set the start time:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
		default = 12;
	};
    class btc_p_acctime {
	//paramsArray[1]
        title = "Acceleration time multiplier:";
		values[]={1,2,3,4,5,6,7,8,9,10,11,12};
		texts[]={"1","2","3","4","5","6","7","8","9","10","11","12"};
		default = 5;
	};
	class btc_p_load {
    //paramsArray[2]
        title = "Load the savegame (if available)";
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
	class btc_p_en {
	//paramsArray[3]
        title = "Enemy type:";
		values[]={0,1,2,3};
		texts[]={"Guerrilla (A3)","CAF","AAF (A3)","RHS Insurgents"};
		default = 0;
	};
	class btc_p_ied {
	//paramsArray[4]
        title = "IEDs ratio:";
		values[]={0, 0.5, 1, 1.5};
		texts[]={"Off","Low","Normal","High"};
		default = 1;
	};
	class btc_p_engineer {
    //paramsArray[5]
        title = "Everybody can disarm IED with the same chances:";
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 0;
    };
	class btc_p_hideout_n {
	//paramsArray[6]
        title = "Hideout numbers:";
		values[]={99,1,2,3,4,5};
		texts[]={"Random","1","2","3","4","5"};
		default = 5;
	};
    class btc_p_cache_info_def {
	//paramsArray[7]
        title = "Info cache distance:";
		values[]={500,1000,1500,2000,2500,3000,3500,4000,5000};
		texts[]={"500 m","1000 m","1500 m","2000 m","2500 m","3000 m","3500 m","4000 m","5000 m"};
		default = 1000;
	};
    class btc_p_cache_info_ratio {
	//paramsArray[8]
        title = "Cache info ratio:";
		values[]={50,100};
		texts[]={"50 m","100 m"};
		default = 100;
	};
    class btc_p_info_chance {
	//paramsArray[9]
        title = "Intel from dead bodies chance:";
		values[]={0,10,20,30,40,50,60,70,80,90,100};
		texts[]={"100 %","90 %","80 %","70 %","60 %","50 %","40 %","30 %","20 %","10 %","0 %"};
		default = 70;
	};
	class btc_p_rep {
	//paramsArray[10]
        title = "Reputation at start:";
		values[]={0, 200, 500, 750};
		texts[]={"Very Low","Low","Normal","High"};
		default = 200;
	};
    class btc_p_redeploy {
	//paramsArray[11]
        title = "Allow re-deploy?";
		values[]={0,1};
		texts[]={"No","Yes"};
		default = 1;
	};
	class btc_p_med_level {
		//paramsArray[12]
	   title = "Medical Level";
	   values[] = {1,2};
	   texts[] = {"Basic","Advanced"};
	   default = 1;
	};
	class btc_p_adv_wounds {
		//paramsArray[13]
	   title = "Advanced Wounds";
	   values[] = {0,1};
	   texts[] = {"Off","On"};
	   default = 1;
	};
	class btc_p_rev {
    //paramsArray[14]
        title = "Revive time:";
        values[]={0,60,120,180,240,300,600,900,1200,999999};
        texts[]={"0","60","120","180","240","300","600","900","1200","999999"};
        default = 600;
    };
    class btc_p_set_skill {
	//paramsArray[15]
        title = "Set skill?";
		values[]={0,1};
		texts[]={"No","Yes"};
		default = 1;
	};
    class btc_p_set_skill_general {
	//paramsArray[16]
        title = "Set skill, general";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 0;
	};
    class btc_p_set_skill_aimingAccuracy {
	//paramsArray[17]
        title = "Set skill, aimingAccuracy";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 1;
	};
    class btc_p_set_skill_aimingShake {
	//paramsArray[18]
        title = "Set skill, aimingShake";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 7;
	};
    class btc_p_set_skill_aimingSpeed {
	//paramsArray[19]
        title = "Set skill, aimingSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 2;
	};
    class btc_p_set_skill_endurance {
	//paramsArray[20]
        title = "Set skill, endurance";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 7;
	};
    class btc_p_set_skill_spotDistance {
	//paramsArray[21]
        title = "Set skill, spotDistance";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 100;
	};
    class btc_p_set_skill_spotTime {
	//paramsArray[22]
        title = "Set skill, spotTime";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 100;
	};
    class btc_p_set_skill_courage {
	//paramsArray[23]
        title = "Set skill, courage";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 1;
	};
    class btc_p_set_skill_reloadSpeed {
	//paramsArray[24]
        title = "Set skill, reloadSpeed";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 20;
	};
    class btc_p_set_skill_commanding {
	//paramsArray[25]
        title = "Set skill, commanding";
		values[]={0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100};
		texts[]={"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1","2","3","4","5","6","7","8","9","10"};
		default = 80;
	};
    class btc_p_debug {
	//paramsArray[26]
        title = "Debug:";
		values[]={0,1,2};
		texts[]={"No","Yes", "Log only"};
		default = 0;
	};
    class btc_p_sea {
    //paramsArray[27]
		title = "Extend battlefield to sea:";
		values[] = {0,1};
		texts[] = {"Off","On"};
		default = 1;
    };
	class btc_p_civ {
	//paramsArray[28]
        title = "Civil type:";
		values[]={0,1};
		texts[]={"Civilian (A3)","Afghan (@Ericj_Taliban)"};
		default = 0;
	};
};