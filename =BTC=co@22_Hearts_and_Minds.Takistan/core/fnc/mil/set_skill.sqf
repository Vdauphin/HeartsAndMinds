
if (typeName _this == "OBJECT") then {_this = [_this];} else {_this = units _this;};

{
	_x setskill ["general",(btc_AI_skill select 0)];
	_x setskill ["aimingAccuracy",(btc_AI_skill select 1)];
	_x setskill ["aimingShake",(btc_AI_skill select 2)];
	_x setskill ["aimingSpeed",(btc_AI_skill select 3)];
	_x setskill ["endurance",(btc_AI_skill select 4)];
	_x setskill ["spotDistance",(btc_AI_skill select 5)];
	_x setskill ["spotTime",(btc_AI_skill select 6)];
	_x setskill ["courage",(btc_AI_skill select 7)];
	_x setskill ["reloadSpeed",(btc_AI_skill select 8)];
	_x setskill ["commanding",(btc_AI_skill select 9)];
} foreach _this;