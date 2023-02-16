// by Zorn - Based on ALIAS' Duststorm Script
// Gradual Dust Storm SCRIPT 

if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_ss_fnc_sandstorm};

if (isNil "cvo_ss_running") then 	{cvo_ss_running = false; publicVariable "cvo_ss_running";};
if (cvo_ss_running) exitWith 	{diag_log "[CVO] [Sandstorm] (Start) - Exit: Duststorm already running!";};

params [
	["_duration", 30, [0]],
	["_direction", windDir, [0]],
	["_intensity", 1, [0]]
];


// converts _duration from minutes into secounds.

_duration = _duration * 60;
cvo_ss_duration = _duration;
publicVariable "cvo_ss_duration";

// ######### 
// Establish Killswitch
cvo_ss_running = true;
publicVariable "cvo_ss_running";
sleep 5;
diag_log ("[CVO] [SandStorm] (Storm) - Start - " + format ["Duration: %1sec - Direction: %2", _duration, _direction]);

// ######### 
// Phase Definition
cvo_ss_phasetime = (_duration / 10);
publicVariable "cvo_ss_phasetime";
cvo_ss_phase = 0;


[_duration] spawn {
	params ["_duration"];
	cvo_ss_remaining = _duration;
	while {cvo_ss_running} do {
				cvo_ss_remaining = cvo_ss_remaining - 1;
				publicVariable "cvo_ss_remaining";
				sleep 1;
	};
	cvo_ss_remaining = 0;
};


// ######### 
// Pace Maker
[_duration] spawn {
	params ["_duration"];

		diag_log ("[CVO] [SandStorm] (PaceMaker) - Init");

	
	while { cvo_ss_running && ( cvo_ss_phase <= 10 ) } do {
		cvo_ss_phase = cvo_ss_phase + 1;
		publicVariable "cvo_ss_phase";
		sleep cvo_ss_phasetime;
		diag_log ("[CVO] [SandStorm] (Phase) - " + format ["Current Phase: %1 ", cvo_ss_phase]);
	};

	cvo_ss_running = false;
	publicVariable "cvo_ss_running";

	diag_log ("[CVO] [SandStorm] (Phase) - " + format ["Current Phase: %1 ", cvo_ss_running]);

	sleep 10;
	cvo_ss_phase = 99;
	publicVariable "cvo_ss_running";
	cvo_ss_duration = 0; 
	publicVariable "cvo_ss_running";

	diag_log ("[CVO] [SandStorm] (PaceMaker) - Exit");
};

// ####################################
// INIT cvo_sandstorm_Effects.sqf for local effects

[[],"cvo\sandstorm\cvo_ss_fnc_effects.sqf"] remoteExec ["execVM",0,true];


// ####################################
// Weather Control



// ######### 
// Store Pre-Storm Weather Data

ss_foglevel			= fogParams;
ss_overcast			= overcast;
ss_rainlevel		= rain;
ss_thundlevel		= lightnings;
ss_wind				= wind;
ss_windstr			= windStr;
ss_windgusts		= gusts;


// ######### 
// Simple Weather Control during the Storm


(cvo_ss_phasetime * 4) setOvercast 1;
[] spawn {
	(cvo_ss_phasetime * 1) setRain 0;
	waitUntil {sleep (1 * cvo_ss_phasetime); true};
	if (!cvo_ss_running) 	exitWith {};
	(cvo_ss_phasetime * 7) setRain 0;
	waitUntil {sleep (7 * cvo_ss_phasetime); true};
	if (!cvo_ss_running) 	exitWith {};
	(cvo_ss_phasetime * 4) setOvercast ss_overcast;
	(cvo_ss_phasetime * 8) setRain ((5 + floor random 5)/10);
};


// #########
// FOG CONTROL

[] spawn {
	diag_log ("[CVO] [SandStorm] (FogControl) - Init");

	//  ######## Definition
	_ss_fog_stage	= [0.03, 0.005, 200];
	_ss_fog_max 	= [0.03, 0.006, 600];
	_ss_fog_post	= [0.03, 0.005, 400];
	
	//  ######## Execution
	[(2 * cvo_ss_phasetime), _ss_fog_stage, true] 	spawn cvo_ss_fnc_setFogFlexible;
	waitUntil {sleep (2 * cvo_ss_phasetime); true};
	if (!cvo_ss_running) 	exitWith {};


	[(2 * cvo_ss_phasetime), _ss_fog_max,true] 		spawn cvo_ss_fnc_setFogFlexible;
	waitUntil {sleep (2 * cvo_ss_phasetime);true};
	if (!cvo_ss_running) 	exitWith {};


	[(2 * cvo_ss_phasetime), _ss_fog_max,true] 		spawn cvo_ss_fnc_setFogFlexible;
	waitUntil {sleep (8 * cvo_ss_phasetime);true};
	if (!cvo_ss_running) 	exitWith {};

	[(4 * cvo_ss_phasetime), _ss_fog_post,true] 	spawn cvo_ss_fnc_setFogFlexible;
	diag_log ("[CVO] [SandStorm] (FogControl) - Exit");
};

// #########
//  WIND CONTROL ## This is some Blackmagic voodoo shit taken directly from Alias' Sandstorm script. Only addition is is the 1. Line to avoid Devide by Zero error.

[_direction] spawn {
	waitUntil {sleep 1; cvo_ss_phase >= 1};

	diag_log ("[CVO] [SandStorm] (WindControl) - Init"); 			
	params ["_direction"];

	//  ######## Definition
	if (_direction == 0) then {_direction = 360};
	raport = 360/_direction;
	raport = round (raport * (10 ^ 2)) / (10 ^ 2);
	if (raport >= 4) then {fctx = 1; fcty = 1;}	else {if (raport >= 2) then {fctx = 1; fcty = -1;}else { if (raport >=1.33) then {fctx = -1; fcty = -1;}else {fctx = -1; fcty = 1;};};};
	if ((raport <= 2) and (raport >= 1.33)) then {fctx = -1; fcty = -1;};
	_unx	= ((_direction - floor (_direction/90)*90))*fctx;
	vx = floor (_unx * 0.6);
	vy = (54 - vx)*fcty;
	// mareste incremental vantul  ## Incremental increase of windspeed
	inx = 0;
	iny = 0;
	incr = true;
	incrx = false;
	incry = false;
 
	//  ######## Execution
	while {incr && cvo_ss_running} do 
	{
		sleep 1;
		if (inx < abs vx) then {inx = inx+0.1;} else {incrx = true};
		if (iny < abs vy) then {iny = iny+0.1;} else {incry = true};
		if (incrx and incry) then {incr=false};
		winx = floor (inx*fctx/2);
		winy = floor (iny*fcty/2);
		setWind [winx,winy,false];
	};

	diag_log ("[CVO] [SandStorm] (WindControl) - Increase complete");
};

[] spawn {	// Wind Control @ EXIT
	//  ######## Waiting
	waitUntil {sleep 1; ((cvo_ss_phase >= 7) || !cvo_ss_running ) };
	diag_log ("[CVO] [SandStorm] (WindExit) - Init");

	setWind		[0,0,false];
	//  ######## Execution
	cvo_ss_phasetime setWindStr		ss_windstr;
	cvo_ss_phasetime setGusts		ss_windgusts;
	//  ######## Cleanup
	ss_wind 		= nil;
	ss_windstr 		= nil;
	ss_windgusts	= nil;
	diag_log ("[CVO] [SandStorm] (WindExit) - End");
};

[] spawn {			// Weather Control @ EXIT
	//  ######## Waiting
	diag_log ("[CVO] [SandStorm] (WeatherExit) - Init");
	waitUntil {sleep 1; !cvo_ss_running};

	//  ######## Execution
	(4 * cvo_ss_phasetime) setOvercast 		ss_overcast;
	(5 * cvo_ss_phasetime) setFog 			ss_foglevel;
	(4 * cvo_ss_phasetime) setRain 			ss_rainlevel;
	(4 * cvo_ss_phasetime) setLightnings 	ss_thundlevel;

	//  ######## Cleanup
	ss_overcast		= nil;
	ss_foglevel 	= nil;
	ss_rainlevel 	= nil;
	ss_thundlevel 	= nil;
	diag_log ("[CVO] [SandStorm] (WeatherExit) - End");
};

// ####################################
// AI SKILL CONTROL

[] spawn {
	diag_log ("[CVO] [SandStorm] (AISkill) - Init");

	// Definition of Variables
	private _subSkillModifier = [
		["general",			0.40], 
		["aimingAccuracy",	0.15], 
		["aimingShake",		0.50], 
		["aimingSpeed",		0.40], 
		["endurance",		0.80], 
		["spotDistance",	0.10], 
		["spotTime",		0.10], 
		["courage",			0.30], 
		["reloadSpeed",		0.50], 
		["commanding",		0.40]
		];


	//  ######## Waiting for Start
	waitUntil {sleep 10; cvo_ss_phase >= 2};								/// EXECUTE @ Phase 2

	//  ######## Execution
	{
		private _unit = _x;
		{
			_subSkill = _x#0;
			_modifier = _x#1;
			
			_unit setSkill [_subSkill, ((_unit skill _subSkill) * _modifier)];
		} forEach _subSkillModifier;
	} forEach allUnits;
	diag_log ("[CVO] [SandStorm] (AISkill) - AI Skill Debuff Applied");
	

	//  ######## Waiting for End
	waitUntil {sleep 1; (!cvo_ss_running || cvo_ss_phase >= 9)};		/// REVERT @ Phase 9 or when Killswitch
	//  ######## Reverting Debuff
	{
		private _unit = _x;
		{
			private _subSkill = _x#0;
			private _modifier = _x#1;
			_unit setSkill [_subSkill, ((_unit skill _subSkill) / _modifier)];
		} forEach _subSkillModifier;
	} forEach allUnits;

	diag_log ("[CVO] [SandStorm] (AISkill) - AI Skill normal");
	diag_log ("[CVO] [SandStorm] (AISkill) - Exit");
};

// ##################################
// SOUND - WIND 1 (Phase 1 to 10)

[] spawn {
	
	diag_log ("[CVO] [SandStorm] (Wind 1) - Init");
	
	while {cvo_ss_running} do {
		["strong_wind"] remoteExec ["playSound"];
		sleep 67;
	};

	diag_log ("[CVO] [SandStorm] (Wind 1) - End");
};

// #########
// SOUND - WIND 2 (Phase 3 to 8)

[] spawn {
	waitUntil {sleep 1; cvo_ss_phase >= 3};
	diag_log ("[CVO] [SandStorm] (Wind 2) - Init");

	while {cvo_ss_running && (cvo_ss_phase <= 8)} do {
		_rafale = ["windburst_1","windburst_2","windburst_3_dr","windburst_4_st"] call BIS_fnc_selectRandom;
		[_rafale] remoteExec ["playSound"];
		sleep 15+random 60;
	};
	diag_log ("[CVO] [SandStorm] (Wind 2) - End");
};

// #########
// SOUND - WIND 3 (Phase 5,6,7)

[] spawn {
	waitUntil {sleep 1; (cvo_ss_phase >= 5)};
	diag_log ("[CVO] [SandStorm] (Wind 3) - Init");

	while {cvo_ss_running && (cvo_ss_phase <= 7)} do {
		["hurricane"] remoteExec ["playSound"];
		sleep 50;
	};

	diag_log ("[CVO] [SandStorm] (Wind 3) - End");
};
