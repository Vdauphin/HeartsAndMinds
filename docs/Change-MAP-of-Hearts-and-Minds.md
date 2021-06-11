# Change Map :

- Extract mission from the zip file download here [=BTC=co@30_Hearts_and_Minds.Altis.pbo.zip](https://github.com/Vdauphin/HeartsAndMinds/releases)
- Extract the .pbo file with your favorite [pbo software](https://pbo-manager-v-1-4.software.informer.com/download/).
- Replace folder name [=BTC=co@30_Hearts_and_Minds.Altis](https://github.com/Vdauphin/HeartsAndMinds/releases) by [=BTC=co@30_Hearts_and_Minds.Takistan](https://github.com/Vdauphin/HeartsAndMinds/releases) (or .Stratis etc).
- Edit the mission with Arma editor to place correctly the base.
- Repack the .pbo from the [=BTC=co@30_Hearts_and_Minds.Takistan](https://github.com/Vdauphin/HeartsAndMinds/releases) folder
- Send your [=BTC=co@30_Hearts_and_Minds.Takistan.pbo](https://github.com/Vdauphin/HeartsAndMinds/releases) to your server
- Enjoy !


# Tips :
- Some map does not provide enough city. You can add new cities by using `btc_custom_loc` in [/define_mod.sqf#L1](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/define_mod.sqf#L1) like it has been talk [here](https://forums.bohemia.net/forums/topic/165948-mp-btc-hearts-and-minds/?page=39&tab=comments#comment-3280136).
- For small map, you should tweak the safezone for hideout spawn ([/core/def/mission.sqf#L141](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L141)).
- [Some map](https://forums.bohemia.net/forums/topic/165948-mp-btc-hearts-and-minds/?page=52&tab=comments#comment-3348268) use only NameCity for the type of locations but H&M hideouts system looks for "NameLocal", "Hill", "NameVillage", "Airport". You should add in the array the "NameCity" [here](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/fnc/mil/create_hideout.sqf#L50).
