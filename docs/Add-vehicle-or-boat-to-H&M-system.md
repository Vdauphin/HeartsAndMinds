This explain how to add a new vehicle to the H&M system (cargo, reputation, data base (save vehicle status, cargo ammo and objects loaded)...).

### 1: Add new vehicle to H&M
If the vehicle is destroyed, a wreck will be left. You will need to tow or lift it to the logistic point for a fully repair.
#### 1: By mission editing:
You can add new vehicle in the mision.sqm :
- Open the mission in the editor (mission.sqm).
- Add vehicles.
- Give a unique name like: `btc_veh_16`,`btc_veh_17` ...
- Add in the init field : `this setVariable ["btc_dont_delete",true]`
- Save.
- Open the [/core/def/mission.sqf L285](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L285)
- Add names you gave to your vehicles.
- Save.

#### 2: In game
A garage is available for admin only. Activate the garage through mission parameter. Then if you are admin, you will be allow to spawn a vehicle by interacting with the logisitc point box.

### 2: Add respawn to vehicle or boat

You can add a new vehicle/boat to respawn system by :
- in the editor, name it like **btc_helo_2**
- in the [core/def/mission.sqf L286](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/def/mission.sqf#L286) file, add **btc_helo_2** to the list of btc_helo.

    like : btc_helo = [btc_helo_1,**btc_helo_2**];

Note: you can tweak respawn time here: [/core/init_server.sqf L46](https://github.com/Vdauphin/HeartsAndMinds/blob/master/%3DBTC%3Dco%4030_Hearts_and_Minds.Altis/core/init_server.sqf#L46) by changing 30s to what you want.
