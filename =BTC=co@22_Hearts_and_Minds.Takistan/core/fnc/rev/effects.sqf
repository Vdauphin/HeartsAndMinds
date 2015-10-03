btc_rev_fx_effects = true;
_bloss = player getVariable "btc_rev_bloss";
_bleed = player getVariable "btc_rev_bleed";
_sleep = 3;

if (_bleed > 0) then
{
	switch (true) do 
	{
		case (_bleed <= 0.2): 
		{
			939997 cutRsc["btc_rev_dlg_bleeding_1","PLAIN"];
			_sleep = 3;
		};
		case (_bleed <= 0.3 && {_bleed > 0.2}): 
		{
			939997 cutRsc["btc_rev_dlg_bleeding_2","PLAIN"];
			_sleep = 2.5;
		};
		case (_bleed <= 0.6 && {_bleed > 0.3}): 
		{
			939997 cutRsc["btc_rev_dlg_bleeding_3","PLAIN"];
			_sleep = 1.9;
		};
		case (_bleed <= 0.8 && {_bleed > 0.6}): 
		{
			939997 cutRsc["btc_rev_dlg_bleeding_4","PLAIN"];
			_sleep = 1.5;
		};
		case (_bleed > 0.8): 
		{
			939997 cutRsc["btc_rev_dlg_Bleeding_5","PLAIN"];
			_sleep = 1.1;
		};
	};
	sleep _sleep;
};
if (_bloss > 0.4 && {_bleed <= 0}) then
{
	switch (true) do 
	{
		case (_bloss > 0.4 && {_bloss < 0.7}): 
		{
			939997 cutRsc["btc_rev_dlg_bloss_1","PLAIN"];
			_sleep = 2;
		};
		case (_bloss <= 0.9 && {_bloss >= 0.7}): 
		{
			939997 cutRsc["btc_rev_dlg_bloss_2","PLAIN"];
			_sleep = 3;
		};
		case (_bloss > 0.9): 
		{
			939997 cutRsc["btc_rev_dlg_bloss_3","PLAIN"];
			_sleep = 4;
		};
	};
	sleep _sleep;
};
btc_rev_fx_effects = false;