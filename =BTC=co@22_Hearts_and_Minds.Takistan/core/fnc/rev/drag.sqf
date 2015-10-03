
closeDialog 0;

_injured = _this;

if !(_injured getVariable ["btc_rev_isUnc",false]) exitWith {};

player setVariable ["btc_int_busy",true];
player setVariable ["btc_rev_isDragging",true];
player setVariable ["btc_rev_attached",_injured];

_is_prone = false;
if (stance player == "PRONE") then {_is_prone = true;} else {player playMoveNow "AcinPknlMstpSrasWrflDnon";};
if (_is_prone) then {_injured attachTo [player, [0, 1.8, 0.092]];} else {_injured attachTo [player, [0, 1.1, 0.092]];};

[[0,_injured],"btc_fnc_code_on_local",_injured,false] spawn BIS_fnc_MP;

WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb") || _is_prone)};

_id = player addAction [("<t color=""#ED2744"">") + "Release" + "</t>",{player setVariable ["btc_rev_isDragging",false];},[],9,true,false];

while {!isNull player && !(player getVariable ["btc_rev_isUnc",false]) && alive player && !isNull _injured && alive _injured && player getVariable ["btc_rev_isDragging",true]} do
{
	if (_is_prone && stance player != "PRONE") then {player setVariable ["btc_rev_isDragging",false];};
	if (!_is_prone && stance player == "PRONE") then {player setVariable ["btc_rev_isDragging",false];};
	sleep 0.1;
};

player removeAction _id;
if (player getVariable ["btc_rev_isUnc",false]) then {player switchMove "AinjPpneMstpSnonWrflDnon";};

sleep 0.1;

if (stance player != "PRONE" && Alive player) then 
{
	player switchMove "AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";
	sleep 1.3;
	//player playActionNow "PlayerCrouch";
	switch (true) do
	{
		case (currentWeapon player == primaryWeapon player) : {player switchMove "";sleep 0.1;player switchMove "amovpknlmstpsraswrfldnon";};
		case (currentWeapon player == handgunWeapon player) : {player switchMove "";sleep 0.1;player switchMove "amovpknlmstpsraswpstdnon";};
		default {player switchMove "";sleep 0.1;player switchMove "amovpknlmstpsnonwnondnon";};
	};
};

player setVariable ["btc_int_busy",false];
player setVariable ["btc_rev_isDragging",false];
player setVariable ["btc_rev_attached",objNull];

detach _injured;