
#define _isDeaf player getVariable ["btc_isDeaf",false]
#define _ring "combat_deafness"

btc_deaf_isRinging = false;
_limit_deaf_value = (btc_deaf_value + 15);
_old_value = 0;
_deaf_min_time = 20;
_recover_ratio = 0.15;
_can_recover_from_deaf = true;

player setVariable ["btc_deafness",0];

_recover_sound =
{
	player setVariable ["btc_isDeaf",false];player setVariable ["tf_globalVolume", 1];if (player getVariable ["btc_hasEarplugs",false]) then {4 fadeSound btc_earplugs_value;} else {4 fadeSound 1;};
};

_play_sound =
{
	btc_deaf_isRinging = true;
	//playSound [_ring, true];
	playSound _ring;
	sleep 15;
	btc_deaf_isRinging = false;
};

_min_deaf_time = 
{
	_can_recover_from_deaf = false;
	sleep _deaf_min_time;
	_can_recover_from_deaf = true;
};

while {true} do
{
	private "_deafness";
	_deafness = player getVariable ["btc_deafness",0];
	if (_deafness > _limit_deaf_value) then {_deafness = _limit_deaf_value;player setVariable ["btc_deafness",_limit_deaf_value];};
	
	if (_isDeaf) then
	{
		0 fadeSound 0;
		if (_deafness < btc_deaf_value) then {[] call _recover_sound;};
	}
	else
	{
		if (_deafness > btc_deaf_value) then 
		{
			player setVariable ["btc_isDeaf",true];
			0 fadeSound 0;
			[] spawn _play_sound;
			player setVariable ["tf_globalVolume", 0];
		};
	};
	//is ringing? old value -> new value = sta aumentando o scendendo
	if (!btc_deaf_isRinging && {_deafness > btc_deaf_ring} && {_deafness > _old_value}) then {[] spawn _play_sound;};
	if (!btc_deaf_isRinging && {_deafness <= _old_value} && {_can_recover_from_deaf} && {_deafness > 0}) then {player setVariable ["btc_deafness",(_deafness - _recover_ratio)];};
	_old_value = _deafness;
	
	sleep 0.1;
};

/*
	Debug
	[] spawn
	{
		while {true} do 
		{
			hintSilent format ["Deaf: %1; Value: %2; Ring: %3",player getVariable ["btc_isDeaf",false],player getVariable ["btc_deafness",0],btc_deaf_isRinging];
			sleep 0.01;
		};
	};
*/