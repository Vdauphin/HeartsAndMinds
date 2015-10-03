
closeDialog 0;

_injured = _this;

if !(_injured getVariable ["btc_rev_isUnc",false]) exitWith {};

player setVariable ["btc_int_busy",true];
player setVariable ["btc_rev_isCarrying",true];
player setVariable ["btc_rev_attached",_injured];

detach _injured;

player playMoveNow "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon";

_healer = player;
[[1,_injured, _healer],"btc_fnc_code_on_local",_injured,false] spawn BIS_fnc_MP;

WaitUntil {!Alive player || player getVariable ["btc_rev_isUnc",false] || ((animationstate player == "acinpercmstpsraswrfldnon") || (animationstate player == "acinpercmrunsraswrfldf") || (animationstate player == "acinpercmrunsraswrfldr") || (animationstate player == "acinpercmrunsraswrfldl"))};

if ((player getVariable ["btc_rev_isUnc",false]) || !Alive player) exitWith {};
_injured attachto [player,[-0.2, 0.1, 0.1]];
_id = player addAction [("<t color=""#ED2744"">") + "Release" + "</t>",{player setVariable ["btc_rev_isCarrying",false];},[],9,true,false];

WaitUntil {!Alive player || player getVariable ["btc_rev_isUnc",false] || isNull _injured || !Alive _injured || !(player getVariable ["btc_rev_isCarrying",false])};

if (vehicle _injured ==_injured) then {[[2,_injured],"btc_fnc_code_on_local",_injured,false] spawn BIS_fnc_MP;};

player removeAction _id;
if (player getVariable ["btc_rev_isUnc",false]) then {player switchMove "AinjPpneMstpSnonWrflDnon";} else {player playAction "released"};
detach _injured;

player setVariable ["btc_int_busy",false];
player setVariable ["btc_rev_isCarrying",false];
player setVariable ["btc_rev_attached",objNull];