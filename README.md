### DEVELOPMENT NOTES:

Process for successful github use!

1. CREATE A BRANCH!
2. Begin work on your branch, one step at a time.
3. After each step is completed, remember to "Commit" your changes to your branch locally. Do this with a note on 
   each commit exsplaining what you've done.
4. "Push" to your branch.
5. After your branch is complted, and you feel the feature is ready to be added, create a "Pull Request".
6. Once a "pull" is submited another member of the team will organise a test of that branch, focusing on testing
   the specific features which were modified/added.
7. After a sucessfull test the Pull can be accepted and added into main.

For Player Release!

A player release is any test or gameplay involving members outside of the development team. These players should only ever interact with the
 "Release" branch of gitgub, this branch is specifically setup for the players to enjoy, heavily tested for bugs etc. Players should never be hotseating the server for fixes. If a bug is found, it should be noted and repaired in the main branch for a seperate test. Repeated hotfixes on a live player test will not be tolerated.

Also note: We will no longer be removing stale branches once they are merged. Instead they will just be left alone in a "merged" state for tracability.

<p align="center">
    <img src="https://data.bistudio.com/assets/img/badges/medal/MWFMP.png" width="85">
    <img src="https://user-images.githubusercontent.com/14364400/120066018-bd52ed80-c074-11eb-87d6-61cdeada32f8.png" width="210">
    <img src="https://data.bistudio.com/assets/img/badges/medal/MWFMP.png" width="85">
</p>

<p align="center">
    <a href="https://github.com/Vdauphin/HeartsAndMinds/releases/tag/1.21.5">
        <img src="https://img.shields.io/badge/Version-1.21.5-blue.svg?style=flat-square" alt="H&M Version">
    </a>
    <a href="https://somsubhra.github.io/github-release-stats/?username=vdauphin&repository=HeartsAndMinds&page=1&per_page=300">
        <img src="https://img.shields.io/github/downloads/Vdauphin/HeartsAndMinds/total.svg?style=flat-square&label=Downloads" alt="H&M Downloads">
    </a>
</p>

Hearts and Minds is a cooperative Military Simulation (MilSim) mission that aims to recreate a post war environment based on an insurgency gameplay.
CSAT forces retreated from Altis and NATO deployed units and vehicles to help the local population.
A new formed group, known as "Oplitas", is against the NATO intervention and is ready to fight.

Online [wiki available](http://vdauphin.github.io/HeartsAndMinds/).

### The mission has a lot of features:

- **Dedicated server support only**
- Dynamic battlefield
    - Enemies, civilian and animals spawn randomly
    - Random patrol and [traffic](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#traffic)
    - Dynamic caching system to save performance
    - Extend battlefield to sea (you are not safe on sea!)
- [Reputation system](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#reputation)
    - Realistic IED/Suicide/Drone bomber system
    - Civilian interaction
        - [Orders/drop leaflets](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#civil-orders)
        - Request a lift
        - Discussion ([interpreter](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#intel))
        - Fleeing
    - More than 19 [side mission](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#side-mission)
- Deep ACE3 support
    - Use mainly ACE interaction
    - Rearm system
    - ACEX Fortify
- Logistic system
    - [Tow](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#towing-system)
    - [Vehicle in vehicle](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#towing-system) extended
    - [Sling loading](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#sling-loading)
    - Repair [destroyed vehicles](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#respawn)
    - [FOB/Rallypoints](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#fobrallypoint)
- Gameplay elements
    - [Intel](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#intel) about cache and hideout
    - [Chemical Warfare](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#chemical-warfare)
    - [Spectrum devices](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#spectrum-devices)
- Under the hood
    - A lot of optional gameplay
    - More than 332 enemies and 31 civilians factions available
    - Full saving Database ([even player markers](http://vdauphin.github.io/HeartsAndMinds/InGame-documentation#headless--database))
    - Easy map change (See [here](http://vdauphin.github.io/HeartsAndMinds/Change-MAP-of-Hearts-and-Minds))
    - Auto Headless support
- Something I forgot for sure


Your main task is to defeat the "Oplitas" group and restore peace and order in Altis.
The militia has an unknown number of hideouts in the island that need to be destroyed.
They have also ammo caches in various locations, destroy them to weaken its power.

Bad actions cause bad effects.
Infact there's a reputation system: helping the local population, fighting the "Oplitas", disarming IED will rise your reputation; killing civilians, mutilate alive/dead civilian, firing near civilians for no reason, remove banana, damaging/destroying buildings, breaking locked door, losing vehicles, respawns will decrease your reputation.
At the beginning you have a very low reputation level, so civilians won't help you revealing important information about Oplitas, they will likely lie instead.

<p align="center">
    <img src="https://user-images.githubusercontent.com/14364400/28997116-bfcec8a6-7a0d-11e7-911f-b52edb841ae3.png" width="400">
    <img src="https://user-images.githubusercontent.com/14364400/29193966-d8306378-7e27-11e7-97cb-df76dfc08e53.png" width="400">
</p>

Any support or feedback is always welcome and appreciated!

### Credits:
- ALL CREDIT FOR THE ORIGINAL MISSION GOES TO Vdaphin AND HIS TEAM!(https://github.com/Vdauphin/HeartsAndMinds)
- =BTC= clan
- [Contributors](https://github.com/Vdauphin/HeartsAndMinds/graphs/contributors)
- Karmakut Development Team (DEVOPS) [NoACE,Tetlys]
