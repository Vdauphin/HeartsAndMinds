[] spawn
{
	while {true} do
	{
		uiSleep 2;
		[] call btc_fnc_aperture;
	};
};

if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};
