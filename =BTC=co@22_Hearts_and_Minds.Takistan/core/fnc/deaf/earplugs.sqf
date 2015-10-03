closeDialog 0;

_hasEarplugs = player getVariable ["btc_hasEarplugs",false];

_show_img = 
{
	_img = "<img image=" + str(_this) + " size='3' align='center'/>";
	hintSilent parseText (_img + " ");
	sleep 2;
	hintSilent "";
};

if (_hasEarplugs) then
{
	//Remove
	player setVariable ["btc_hasEarplugs",false];
	2 fadeSound 1;
	hintSilent "Earplugs removed";
	//if (btc_wounds_mod) then {player addItem "BTC_w_earplugs";};
}
else
{
	//Add
	player setVariable ["btc_hasEarplugs",true];
	2 fadeSound btc_earplugs_value;
	hintSilent "Earplugs on";
	playSound "Click";sleep 0.5;playSound "Click";//Find better
	//if (btc_wounds_mod) then {player removeItem "BTC_w_earplugs";};
};