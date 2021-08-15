
[compileScript ["core\init.sqf"]] call CBA_fnc_directCall;


if isServer then
{
	[] spawn
	{
		while {true} do
		{
			{
				_x addCuratorEditableObjects
				[
				entities [[],["Logic"], true /* Include vehicle crew */,true /* Exclude dead bodies */],
				true
				];
			} count allCurators;
			sleep 60; // Change to whatever fits your needs
		};
	};
};
