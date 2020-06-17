# Add new faction :

You have two way to add new factions. First one need to know all class name of the desired faction. The second way get automatically class name for you.

## First way
- Get all class names of your faction.
- Replace `_allclasse select` by the corresponding array of faction name in [/core/def/mission.sqf#L590-L598](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L590-L598).

## Second way
- Launch your game with all factions mods you want to have in the H&M and launch the H&M mission.
- Execute locally in [debug console](https://community.bistudio.com/wiki/Mission_Editor:_Debug_Console_(Arma_3)) : `copyToClipboard str (["EN"] call btc_fnc_get_class);`.
- Open a text editor and paste the result.
- You have an array of 4 array: [author name, text entry for mission parameters, faction name array, corresponding number for each faction].
	- text entry for mission parameters (second array): copy and paste it in [/core/def/param.hpp#L41](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/param.hpp#L41).
	- corresponding number for each faction (fourth array): copy and paste it in [/core/def/param.hpp#L40](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/param.hpp#L40).
	- faction name array (third array): copy and paste it in [/core/def/mission.sqf#L585](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L585).

Note: if you don't want some class name take a look here [/core/def/mission.sqf#L600-L621](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L600-L621).