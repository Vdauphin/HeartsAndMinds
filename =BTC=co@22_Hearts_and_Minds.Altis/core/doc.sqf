player createDiarySubject ["Documentation","Documentation"];

player createDiaryRecord ["Documentation", ["Wounds", "
Use the interaction menu to treat your wounds.<br/>Keep in mind that all the actions will be available, even if you do not need them. It is always recommended examine first.
	"]
];

player createDiaryRecord ["Documentation", ["Deafness", "
Use the earplugs to protext your ears and avoid combat deafness.<br/>
You can put them on with your self interaction key.<br/><br/>
Note: the playSound ['',true] command is bugged, so if you are deaf you will not hear any ring sound.
	"]
];

player createDiaryRecord ["Documentation", ["Vehicles", "
When a vehicle is destroyed it will not respawn in base, you need to tow or lift it back to base and repair it near the logistic point (Interact with the red box). Helicopter wreck can only be lifted. <br/>
The Chinook is the only exception, it will respawn after 30 seconds.
	"]
];

player createDiaryRecord ["Documentation", ["Side Mission", "
Side missions are really usefull to rise your reputation level.<br/>
A side mission can be requested by the officer with his self interaction menu.<br/>
If you don't want to complete a task, you can always abort it with the self interaction menu.
	"]
];

player createDiaryRecord ["Documentation", ["FOB", "
FOB<br/><br/>
In this mission a FOB is a forward spawn point, to create a FOB approach the red box at the logistic point and require a blue container.<br/>
Move it where you want to deploy a new FOB and interact with it to set it up. Keep in mind that you can not deploy a FOB close to the main base (2.500m) and the terrain needs to be flat.<br/><br/>
You can re-deploy at the new location interacting with the flag.
	"]
];

player createDiaryRecord ["Documentation", ["Sling loading", "
=BTC= Lift will not replace the A3 sling loading, you can use both.<br/><br/>
Lifting an object is pretty simple. Get in a chopper as pilot, hover above the object and use your self interaction menu to deploy ropes.<br/>
When you are in the right position a new scroll wheel action will appear ('HOOK'). If you want you can open the HUD to facilitate the operation.<br/>
To release an object open you self interaction menu and select 'CUT ROPES'
	"]
];

player createDiaryRecord ["Documentation", ["Logistic point", "
At the logistic point you can require new objects (like ammo, fortifications, supplies for the side missions...) and repair destroyed vehicles.
	"]
];

player createDiaryRecord ["Documentation", ["Logistic", "
Cargo System<br/><br/>
You can load objects inside vehicles. Approach the object you want to load and interact with it.<br/>
Select 'LOAD IN' option.<br/>Afer that interact with the vehicle and select 'LOAD object IN vehicle' option.<br/>
The object has to be close to the vehicle.<br/><br/>
You can unload an object from a vehicle interacting with it. You can be inside the vehicle (user action 1) or outside (user action 2).<br/>
Select the option 'CHECK CARGO', then choose the object you want to unload from the list, and click 'UNLOAD'.<br/>
If you are inside a chopper the object will be paradropped with a chute. If your height is too low, the object will crash down.<br/>
Every vehicle has a 'CARCO CAPACITY' (CC in game), and every object has a 'REQUIRED CAPACITY' value (RC in game.)<br/>
You can check those values in game with 'LOAD IN' and 'CHECK CARGO' options.<br/><br/><br/>
Towing system<br/><br/>
To tow a vehicle interact with it and select the option 'HOOK'.<br/>After that place the tow vehicle in front of it and select 'TOW' in the interaction menu.<br/>
If the two vehicles are too far away or the vehicle can't tow that load, the option will be disabled.<br/>
To unhook interact with one of the two vehicles and select the option 'UNHOOK'.

Place option<br/><br/>
With this option you can move heavy objects to build small outpost or base.<br/>
When you select the option an hint will show all the keys required to move the object.
	"]
];

player createDiaryRecord ["Documentation", ["Hideout", "
The hideouts are the place where the Oplitas organize their movement.<br/> They send reinforcement from here and can attack the closest city.<br/>
If you notice a lot of activity in an area, probably there is an hideout closeby.<br/>
If you want to defeat the Oplitas tou need to destroy all their hideouts.<br/>
Here an example of an hideout:<br/><br/>
<img image='core\img\hideout.jpg' width='256' height='256'/><br/><br/>
To destroy an hideout just place a satchel near the ammo box and blow it off!
	"]
];

player createDiaryRecord ["Documentation", ["IED", "
Any object could be an IED,	approach it carefully and examine it with your interaction menu.<br/>
If you have a defusal kit you can try to disarm it, remember that engineers have better chances to disarm an IED.<br/>
You can also blow them off with high caliber and explosive satchels.
	"]
];

player createDiaryRecord ["Documentation", ["Intel", "
Intel can be retrieved in two ways:<br/>
- Searching dead bodies<br/>
- Interrogate prisoner<br/>
- Talking to civilians<br/><br/>
Keep in mind that only the interpreter can talk to civilians and they can lie if your reputation level is low.<br/><br/>
When you find an intel from a dead body or interrogate a prisoner, a marker will appear in the map. Remember, prisoner have a random number of intel more or less interesting.<br/>
There are two types of marker:<br/>
- Red question mark: ammo cache intel<br/>
- Red esclamation mark: hideout intel<br/><br/><br/>
When you destroy an hideout or an ammo cache, all the markers related to it will be deleted.
	"]
];

player createDiaryRecord ["Documentation", ["Reputation", "
Reputation can be ask to civilian<br/>
	"]
];

player createDiaryRecord ["Documentation", ["Orders", "
Any player can give orders to civilians.<br/>
Open your self interaction menu and select 'ORDERS'.<br/>
Your options are:<br/>
- STOP<br/>
- GET DOWN<br/>
- GO AWAY<br/><br/>

If you want to give an order just to one unit, interact with it (user action 2).
	"]
];

player createDiaryRecord ["Documentation", ["Traffic", "
Civilian are travelling by car across cities. If your reputation is higher than normal, you can ask a lift to a location choosed on map. If you bump into enemies, don't worry, the civilian driver will do the best to hide you in the car. <br/>
	"]
];

player createDiaryRecord ["Documentation", ["Gear", "
You can choose your gear at the red box inside the base.<br/>
Use your user action 2 to change your gear.
 	"]
];

player createDiaryRecord ["Documentation", ["Interaction", "
Use ACE 3 interactions system.
	"]
];

player createDiaryRecord ["Documentation", [
	"Version",
	format ["Version %1",btc_version]
	]
];
