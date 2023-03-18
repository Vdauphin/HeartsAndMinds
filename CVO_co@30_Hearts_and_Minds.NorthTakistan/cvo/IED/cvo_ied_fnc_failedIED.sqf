/*
*
*
*	Example:
*		[_pos,_classname, 0.01] spawn cvo_ied_fnc_failedIED;
* 		[player,"",false, 40] spawn cvo_ied_fnc_failedIED;
*/

if (!isServer) exitWith {};
if (!canSuspend) exitWith {_this spawn cvo_ied_fnc_failedIED};


params [
	["_obj", 		player,	 			[objNull,[]],[2,3]	],				// object or location where the cookOff will be spawned
	["_classname", 	"", 				["",[]]				],				// string or array of strings of the explosives that will be spawned (need to be self detonating)
	["_meme", 		false, 				[false,0]			],
	["_minimum",	20, 				[0]					]				// boolean or chance of meme to happen <0.01 low chance - 0.99 high chance>
];


//_startTime = time;
//systemChat str _startTime;


private "_pos";
private _arrayGrenades = [];
private _arrayMeme = ["SmokeShellGreen", "F_40mm_White", "O_IRStrobe", "BombDemine_01_DummyAmmo_F",  "G_40mm_SmokePurple"];

// add classnames to the array of grenades

if (_className isEqualTo "") then {
	
	_arrayGrenades = ["mini_Grenade","GrenadeHand", "rhs_charge_tnt_x2_mag", "rhs_charge_sb3kg_mag"];

} else {
	if (_className isEqualType "") then {	_arrayGrenades pushBack _className;		};
	if (_className isEqualType []) then {	_arrayGrenades append   _className;		};
};

if (_meme isEqualType true) then {
	if (_meme) 			then { _arrayGrenades append _arrayMeme };
} else {
	if (random 1 < _meme) then { _arrayGrenades append _arrayMeme };
};


if (_obj isEqualType objNull) then { _pos = getPos _obj; } else { _pos = _obj; };


_nade = (selectRandom _arrayGrenades) createVehicle _pos;


[_pos, 20] remoteExec ["cvo_ied_fnc_failedIED_fx", 0];

playSound3D [getMissionPath "cvo\IED\sound\burning_fuse_23.ogg", _nade,false,(getPos _nade),3,1.4];
sleep 5; 
 
for "_i" from 1 to (_minimum + round random 50) do { 
//	systemChat str _i;  
	_nade = (selectRandom _arrayGrenades) createVehicle _pos;  
	_velX =  selectRandom[-1,1] * (2 + random 8); 
	_velY =  selectRandom[-1,1] * (2 + random 8);  
	_velZ =  (random 10);  
	_nade setVelocity [_velX, _velY, _velZ];
	_pos = getPos _nade;  
	sleep ((random 5)/_i);  
};  

//_endTime = time;
//systemChat str _endTime;

//_timeDiff = _endTime - _startTime;
//systemChat str _timeDiff;