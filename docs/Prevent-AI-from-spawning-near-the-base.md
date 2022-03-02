@Giallustio implemented it by two way, the simpler, for me, is explain here:
- in arma editor: create your base where you want.
- in arma editor: create a marker next to your base name for exemple : YOUR_MARKER_AREA
- open with your text editor file [core/fnc/city/init.sqf L66-L69](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/fnc/city/init.sqf#L66-L69) , uncomment (remove `/*` and `*/` command):

>     /*
>     //if you want a safe area
>     if (_position distance getMarkerPos "YOUR_MARKER_AREA" < 500) exitWith {};
>     */

Note : you can tweak radius of desactivation by changing `500` meters by more or less. Make sure your marker radius is large enough to reach out and overlap the epicenter of the town you want to black out.

![107410_20170403172205_1](https://cloud.githubusercontent.com/assets/14364400/24616751/5158449c-1892-11e7-901c-47747c9c349d.png)
