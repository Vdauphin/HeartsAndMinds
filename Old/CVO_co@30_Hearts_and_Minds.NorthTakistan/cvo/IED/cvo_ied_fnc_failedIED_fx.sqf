if (!hasInterface) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_ied_fnc_failedIED_fx};

params [
	["_obj", 	[0,0,0], 	[objNull,[]], [2,3]	],
	["_duration", 	7, 		[0]					]
];

private "_pos";

if (_obj isEqualType objNull) then { _pos = getPos _obj; } else { _pos = _obj; };
_pos set [2, _pos#2 + 0.1];

private  _particleSource = "#particlesource" createVehicleLocal _pos;
_pos set [2, _pos#2 + 0.5];
private 	_lightSource = "#lightpoint" 	 createVehicleLocal _pos;

_particleSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,0,32,0],"","Billboard",1,1,[0,0,0],[0,0,4],1,0.4,0.45,0,[0.01,0.5,1,1,1.5,0.01,0.001],[[1,1,1,-4],[1,1,1,-3],[1,1,1,-2],[1,1,1,-1],[1,1,1,0]],[1],5,1,"","","",0,true,0.6,[[0,0,0,0]]];
_particleSource setParticleRandom [0,[0,0,0],[1,1,2],3,0.1,[0,0,0,2],1,2,0,0];
_particleSource setParticleCircle [0,[2,2,2]];
_particleSource setParticleFire [0,0,0];
_particleSource setDropInterval 0.004;

_lightSource setLightColor 				[0.407936,0.419473,0.451201];
_lightSource setLightAmbient 			[0.407936,0.425242,0.445433];
_lightSource setLightIntensity 			500;
_lightSource setLightUseFlare 			true;
_lightSource setLightFlareSize 			3;
_lightSource setLightFlareMaxDistance 	500;
_lightSource setLightDayLight 			true;
_lightSource setLightAttenuation 		[5,10,0.5,0.1,100,1000];
_lightSource setLightIR 				false;

private _startTime = time;

private _intensity = 0.01;
private _multi = 1;


while {time < _startTime + _duration} do {

	_intensity = _intensity + _multi * 0.02;

	switch (_intensity) do
	{
		case 0: { _multi =  1; };
		case 1: { _multi = -1; };
		default { if ((random 1) > 0.8) then { _multi = -1 * _multi; } };
	};


	_lightIntensity = 100 	+ 1500 	* _intensity;
	_lightFlare 	= 3 	+ 7		* _intensity;
	_lightFlareDist = 50 	+ 50	* _intensity;
	_lightAtten		= 1 	+ 10	* _intensity;
	


	_lightSource setLightIntensity 			_lightIntensity;
	_lightSource setLightFlareSize 			_lightFlare;
	_lightSource setLightFlareMaxDistance 	_lightFlareDist;
	_lightSource setLightAttenuation 		[_lightAtten,10,0.5,0.1,100,1000];

	sleep 0.05;
};

deleteVehicle _particleSource;
deleteVehicle    _lightSource;