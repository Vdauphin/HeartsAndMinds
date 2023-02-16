// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons
if (!hasInterface) 			exitWith {};
if (!cvo_ss_running) 		exitWith {};


/*		template

// ##########################
// xyz)
[] spawn {
	if (!cvo_ss_running) 	exitWith {};

	waitUntil {sleep 5; cvo_ss_phase >= ### };

	while {sleep 5; cvo_ss_running && (cvo_ss_phase <= ###)} do {

	};
};

*/

// ##########################
// Post Processing Effects

// Camera Shake (Phase 4 - 8)
[] spawn {
	waitUntil {sleep 5; cvo_ss_phase >= 4};
	diag_log "[CVO] [SandStorm] (CameraShake) Enabled";
	enableCamShake true;

	while {sleep 5; cvo_ss_running && (cvo_ss_phase <= 8)} do {
		addCamShake [0.1,27,17];
		sleep 15+random 120;
	};

	resetCamShake;
	enableCamShake false;
	diag_log "[CVO] [SandStorm] (CameraShake) Disabled";
};


// ##########################
// Film Grain (2-4 Increase to Max ### 5-7 Maintain ###

[] spawn {
	waitUntil {sleep 5; cvo_ss_phase >= 2};
	diag_log "[CVO] [SandStorm] (Filmgrain) Enabled";
	if (!cvo_ss_running) 	exitWith {};
	ppGrain = 	ppEffectCreate ["FilmGrain", 2000]; 
	ppGrain		ppEffectEnable true;
	ppGrain 	ppEffectAdjust [0.1,0.1,2,0.1,0.1,0];
	ppGrain 	ppEffectCommit (3 * cvo_ss_phasetime);
	};

// Film Grain EXIT
[] spawn {
	waitUntil {sleep 5; (!cvo_ss_running)};
	
	ppGrain 	ppEffectAdjust [0,0,0,0,0,0];
	ppGrain 	ppEffectCommit (4 * cvo_ss_phasetime);

	waitUntil {sleep (4 * cvo_ss_phasetime); true};
	ppGrain ppEffectEnable false;
	ppEffectDestroy ppGrain;
	diag_log "[CVO] [SandStorm] (CameraShake) Disabled";
};

// ##########################
// Color Correction
// DEFINING CC Settings
cc_default = [	1,	1,	0,				// Brightness	-	Contrast	-	Contrast Offset
	[	0,	 	0,	 	0,		0],		// RGBA for Blending		 
	[	1,		1,		1,		1],		// RGBA for Colorisation		
	[	0.299,	0.587,	0.114,	0],		// RGBA for Colorisation/Desaturation
	[-1,-1,0,0,0,0,0]];					// Radial Stuff

cc_al = [	0.86,	1,		0.01,		// Brightness	-	Contrast	-	Contrast Offset
   [-0.14,	0.17, 	0.33,	-0.14],		// RGBA for Blending
   [0.86,	-0.4,	0.86,	0.86 ],		// RGBA for Colorisation
   [-0.57,	0.86,  	-1.2,  	0.86 ]];	// RGBA for Colorisation/Desaturation

cc_02 = [	0.98,	0.93,	0.08,		// Brightness	-	Contrast	-	Contrast Offset
   [-0.28,	-0.28, 	-0.81,	-0.04],		// RGBA for Blending
   [1.23,	0.44,	-0.54,	0.57 ],		// RGBA for Colorisation
   [0.33,	0.33,  	0.33,  	0    ]];	// RGBA for Colorisation/Desaturation

// Starting the CC effect
[] spawn {
	waitUntil {sleep 5; cvo_ss_phase >= 2 };
	if (!cvo_ss_running) 	exitWith {};
	ppCC = ppEffectCreate ["ColorCorrections", 1500];
	ppCC ppEffectEnable true;

	ppCC ppEffectAdjust cc_al;
	ppCC ppEffectCommit (2 * cvo_ss_phasetime);
	diag_log "[CVO] [SandStorm] (ColorC) Enabled - Turning to CC_AL ";
	waitUntil {sleep 5; cvo_ss_phase >= 6 };
	if (!cvo_ss_running) 	exitWith {};

	ppCC ppEffectAdjust cc_02;
	ppCC ppEffectCommit (2 * cvo_ss_phasetime);
	diag_log "[CVO] [SandStorm] (ColorC) Enabled - Turning to CC_02 ";
};

// ColorCorrection EXIT
[] spawn {
	waitUntil {sleep 5; !cvo_ss_running};
	ppCC ppEffectAdjust cc_default;
	ppCC ppEffectCommit (4 * cvo_ss_phasetime);
	diag_log "[CVO] [SandStorm] (ColorC) Enabled - Turning to CC_Default";
	waitUntil {sleep 6 * cvo_ss_phasetime; true};
	ppEffectDestroy ppCC;
	diag_log "[CVO] [SandStorm] (ColorC) Disabled";
};



// ##########################
// Particle Spawners

// Leaf Particles
[] spawn {
	diag_log "[CVO] [SandStorm] (ParticleLeaves) Enabled";
	while {sleep 1; cvo_ss_running && (cvo_ss_phase <= 9)} do {

		_offset = 0;
		if (speed player > 35) then {_offset = 2.5 * (speed player);};

		_leaves_p  = "#particlesource" createVehicleLocal (getpos player);
		if (vehicle player != player) then {_leaves_p attachto [vehicle player, [0,_offset,0]];} else {_leaves_p attachto [player, [0,_offset,0]];};
		_leaves_p setParticleCircle [100, [0, 0, 0]]; 
		_leaves_p setParticleRandom [0, [10, 10, 7], [4, 4, 5], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
		_leaves_p setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1], "", "SpaceObject", 1,27,[0,0,0],[50,50,10],2,0.000001,0.0,0.1,[0.1+random 5],[[0.68,0.68,0.68,1]],[1.5,1],13,13,"","",vehicle player,0,true,1,[[0,0,0,0]]];

		_leaves_p_drop			= 0.2+random 0.5;
		_leaves_p setDropInterval _leaves_p_drop;

		sleep (1 + random 6);

		deletevehicle _leaves_p;
	};
	diag_log "[CVO] [SandStorm] (ParticleLeaves) Disabled";
};


// Dust Particles
[] spawn {

	cvo_dustParticleHigh = [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.01, [10, 10, 20], 	[[0.65, 0.5, 0.5, 0], [0.65, 0.6, 0.5, 0.5], [1, 0.95, 0.8, 0]], [0.08], 1, 0, "", "", vehicle player,0,true];
	cvo_dustParticleLow  = [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.01, [3, 4, 7], 		[[0.65, 0.5, 0.5, 0], [0.65, 0.6, 0.5, 0.2], [1, 0.95, 0.8, 0]], [0.08], 1, 0, "", "", vehicle player,0,true];

	waitUntil {sleep 5; cvo_ss_phase >= 2 };

	cvo_dustParticle = cvo_dustParticleLow;
	diag_log "[CVO] [SandStorm] (ParticleDust) Low Mode";

	[] spawn {		// turns particle "density" high
		waitUntil {sleep 5; cvo_ss_phase >= 4};
		cvo_dustParticle = cvo_dustParticleHigh;
		publicVariable "cvo_dustParticle";
		diag_log "[CVO] [SandStorm] (ParticleDust) High Mode";
	};
	[] spawn {		// turns particle "density" low
		waitUntil {sleep 5; cvo_ss_phase >= 7};
		cvo_dustParticle = cvo_dustParticleLow;
		publicVariable "cvo_dustParticle";
		diag_log "[CVO] [SandStorm] (ParticleDust) Low Mode"
	};

	
	diag_log "[CVO] [SandStorm] (ParticleDust) Enabled";
	private _i = 0;
	while {cvo_ss_running} do {

		_offset = 0;
		if (speed player > 35) then {_offset = 3 * (speed player);};

		_local_fog_array = [];

		
		if ((cvo_ss_phase >= 3) && (cvo_ss_phase <= 8)) then {
			_alias_local_fog_1 = "#particlesource" createVehicleLocal (getpos player); 
			_alias_local_fog_1 setParticleParams cvo_dustParticle;
			_alias_local_fog_1 setParticleCircle [20, [3, 3, 0]];
			_alias_local_fog_1 setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
			if (vehicle player != player) then {_alias_local_fog_1 attachto [vehicle player, [0,_offset,0]];} else {_alias_local_fog_1 attachto [player, [0,_offset,0]];};
			_local_fog_array pushback _alias_local_fog_1;
		};

		if (cvo_ss_phase >= 5 && cvo_ss_phase <= 8) then {
			_alias_local_fog_2 = "#particlesource" createVehicleLocal (getpos player); 
			if (vehicle player != player) then {_alias_local_fog_2 attachto [vehicle player, [0,_offset,0]];} else {_alias_local_fog_2 attachto [player, [0,_offset,0]];};
			_alias_local_fog_2 setParticleCircle [60, [3, 3, 0]];
			_alias_local_fog_2 setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
			_alias_local_fog_2 setParticleParams cvo_dustParticle;
			_local_fog_array pushback _alias_local_fog_2;
		};

		if (cvo_ss_phase >= 3) then {
			_alias_local_fog_3 = "#particlesource" createVehicleLocal (getpos player); 
			if (vehicle player != player) then {_alias_local_fog_3 attachto [vehicle player, [0,_offset,0]];} else {_alias_local_fog_3 attachto [player, [0,_offset,0]];};
			_alias_local_fog_3 setParticleCircle [90, [3, 3, 0]];
			_alias_local_fog_3 setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
			_alias_local_fog_3 setParticleParams cvo_dustParticle;
			_local_fog_array pushback _alias_local_fog_3;
		};

		if (cvo_ss_phase >= 4 && cvo_ss_phase <= 7) then {
			_alias_local_fog_4 = "#particlesource" createVehicleLocal (getpos player); 
			if (vehicle player != player) then {_alias_local_fog_4 attachto [vehicle player, [0,_offset,0]];} else {_alias_local_fog_4 attachto [player, [0,_offset,0]];};
			_alias_local_fog_4 setParticleCircle [130, [3, 3, 0]];
			_alias_local_fog_4 setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
			_alias_local_fog_4 setParticleParams cvo_dustParticle;
			_local_fog_array pushback _alias_local_fog_4;
		};
		
		if (true) then {
			_alias_local_fog_5 = "#particlesource" createVehicleLocal (getpos player); 
			if (vehicle player != player) then {_alias_local_fog_5 attachto [vehicle player, [0,_offset,0]];} else {_alias_local_fog_5 attachto [player, [0,_offset,0]];};
			_alias_local_fog_5 setParticleCircle [170, [3, 3, 0]];
			_alias_local_fog_5 setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
			_alias_local_fog_5 setParticleParams cvo_dustParticle;	
			_local_fog_array pushback _alias_local_fog_5;
		};


		{
			_alias_drop_fog_factor	= 0.01+random 0.1;
			_x setDropInterval _alias_drop_fog_factor;
		} foreach _local_fog_array;
		
		sleep (1 + random 6);

		{	deleteVehicle _x;	} forEach _local_fog_array;
		_i = _i + 1;
	};
	cvo_dustParticle = nil;
	cvo_dustParticleLow = nil;
	cvo_dustParticleLow = nil;
	diag_log "[CVO] [SandStorm] (ParticleDust) Disabled";
};