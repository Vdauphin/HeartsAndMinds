# InGame Documentation

## Headless & Database
This mission automatically uses one Headless client when available.

This mission has a database system. Enemy units, towns, hideouts, cache, objects created or static weapons assembled by players or Zeus, vehicles, vehicle in vehicle, tag, players markers on global channel are saved. All admin can save mission progress at any time with his self interaction key.

## Chemical Warfare
### Chemical agent:
A chemical agent can be found in the battlefield at cache location for example. When an object is contaminated, the chemical agent propagates to people around (in a circle of 3m). Those people will be hurt constantly until they died or found a decontaminating shower (available at the logistic point) to clean up their body. When they are contaminated, they can propagate it to other people around (in a circle of 1.5m) or vehicle if they get inside. Keep in mind, dead body stay contaminated but body bag will isolate it. Also, a contaminated object loaded as cargo will contaminate the container or vehicle.
### Protection:
Use CBRN gear (uniform, respirator mask and breather backpack) for full protection from the contamination effect. But, don't forget to take a shower for more than 5s before removing your CBRN gear. Be aware, even with a CBRN equipment you can propagate the agent to people or vehicle, you are just protected from the effect. Simple mask and simple uniform can reduce from 65% to 80% the probability to take damage.
### Decontaminate:
You can use a small shower to decontaminate units only. Use the big shower for objects, vehicles and objects loaded as cargo. To activate them, just stay under the shower.
### Detection:
You can analyze an object, vehicle or man with ED-1E drone to determine if it is contaminated (Note: The drone will never be contaminated.). You can also check if you are in a contaminated area by using a chemical detector (THREAT from 0.1 to 0.9: contaminated objects are around, THREAT at 1: you are in the propagating range (you will be contaminated)).


## Spectrum devices
### Electromagnetic field:
There are two types of electromagnetic field from UAV or electromagnetic pulse (EMP). UAV emit electromagnetic field from 390MHz to 500MHz due to device transmission. Electromagnetic pulse are used as weapon to create electronic failure to vehicles. The range of frequency is from 78MHz to 89MHz and is powerfull enough to turn off light, engine and avionic devices.
### Protection:
Electromagnetic field from UAV are safe but EMP have a range of 500m where vehicles with engine turn ON will be affected.
### Detection:
You can detect the origin of electromagnetic field with spectrum devices. The amplitude of the peak depend on the distance and angle between the emiter and the antenna. The maximum range is 1000m.


## Vehicles
### Respawn:
When a vehicle is destroyed it will not respawn in base, you need to tow, use vehicle in vehicle or lift it back to base and repair it near the logistic point (Interact with the red box). Helicopter wrecks can only be lifted. The Chinook is the only exception, it will respawn after 30 seconds.
### Rearm:
You can also rearm them by spawning the corresponding caliber at logistic point (Interact with the red box, select the vehicle type and caliber). Carry the ammo created and interact with the vehicle to rearm. This only works if rearming is setting on entire magazine or amount based on caliber (not for entire vehicle setting).


## Side Mission
Side missions are really useful to raise your reputation level.
A side mission can be requested by the officer with his self interaction menu.
If you don't want to complete a task, you can always abort it with the self interaction menu.


## Respawn position
- FOB:
	In this mission a FOB is a forward spawn point, to create a FOB approach the red box at the logistic point and require a blue container.
	- Deploy:
		Move it where you want to deploy a new FOB and interact with it to set it up. Keep in mind that you can not deploy a FOB close to the main base (2.500m) and the terrain needs to be flat.
	- Dismantle:
		You can dismantle a FOB by interacting with the flag on the HQ roof.
- Rallypoint:
	You can also use the Zeus rallypoint backpack available in Arsenal but they have some limitation. After some times or after player disconnected, rallypoint will self-destruct.


## Sling loading
=BTC= Lift will not replace the A3 sling loading, you can use both.
Lifting an object is pretty simple. Get in a chopper as pilot, hover above the object and interact with the chopper to deploy ropes.
When you are in the right position a new scroll wheel action will appear ('HOOK'). If you want you can open the HUD to facilitate the operation.
To release an object open you self interaction menu and select 'CUT ROPES'.


## Logistic point
At the logistic point you can require new objects (like ammo, fortifications, supplies for the side missions...) and repair destroyed vehicles.


## Logistic
### Cargo System:
- Use ACE 3 Cargo system.

### Towing system:
To tow a vehicle interact with it and select the option 'HOOK'. After that place the tow vehicle in front of it and select 'TOW' in the interaction menu.
If the two vehicles are too far away or the vehicle can't tow that load (Car can't tow truck or tank), the option will be disabled.
To unhook interact with one of the two vehicles and select the option 'UNHOOK'.

### Vehicle in vehicle system:
BI Vehicle in Vehicle (ViV) system is extended to allow load of any vehicle in a vehicle. To move ViV use the towing system. To unload, move in driver seat of the tower vehicle and select in scroll menu "unload all objects".

### Place option:
With this option you can move heavy objects to build small outpost or base.
When you select the option an hint will show all the keys required to move the object.


## Hideout
The hideouts are a place where the Oplitas organize their movements.
They send reinforcements from here and can attack the closest city.
If you notice a lot of activity in an area, probably there is an hideout closeby.
If you want to defeat the Oplitas, you need to destroy all their hideouts.
To destroy an hideout just place a satchel near the ammo box, it's close to the flag and blow it off!


## IED
Any object could be an IED or a fake IED.

### Detection:
Approach IED carefully (DO NOT rotate while you are walking: prefer walk, stop, rotate, walk again etc). Turn On your mine detector (VMH3 or VMMH3) and search for a charge in a circle of 2 meter around.

### Defuse:
If you are an engineer and have a defusal kit, you can disarm it. You can also blow them off with high caliber and explosive satchels.

### Clean up
You can remove wreck or object around IED or fake IED by driving a Nemmera in their direction.


## Intel
Intel can be retrieved in the following:
- Searching dead bodies
- Interrogate prisoner
- Talking to civilians

Keep in mind that only the interpreter can talk to civilians and they can lie if your reputation level is low.
When you find an intel from a dead body or interrogate a prisoner, a marker will appear in the map. Remember, prisoner have a random number of intel more or less interesting.

There are two types of intel:
- Red question mark and pictures under diary log map menu: ammo cache intel
- Red exclamation mark: hideout intel

When you destroy an hideout or an ammo cache, all the markers related to it will be deleted.


## Reputation
### System:
At the beginning you have a very low reputation level, so civilians won't help you in revealing important information about the Oplitas, they will likely lie instead. Reputation can be ask to civilian.
### Good actions:
Helping the local population by fighting the Oplitas, disarming IED's, heal civilians, remove tag with spraypaint red, succed side mission and destroy cache/hideout will rise your reputation.
### Bad actions:
Bad actions cause bad effects: killing civilians/animals, mutilating alive/dead civilians/animals, firing near civilians for no reason, firing to civilian car, damaging/destroying buildings, losing player's vehicles and player respawns will decrease your reputation. Aborting a side mission does not affect reputation.

## Civil Orders
Any player can give orders to civilians. To do this, just open your self interaction menu and select 'ORDERS' or use one of the shortcuts. Shortcuts can changed under 'configure >> controls>> configure addons >> Hearts and Minds: Mission (drop down menu)'. Your options are:
- STOP
- GET DOWN
- GO AWAY

If you want to give an order to just one unit, interact with it (object interaction).

You can also drop leaflets to ask all civilians in a circle of 200m to evacuate to a religious building (if not available a safe area) with a AR-2 drone.

## Traffic
Civilians are travelling by vehicle across cities. If your reputation is higher than normal, you can ask for a lift to a location chosen on the map. If you bump into a Oplitas patrol, don't worry, the civilian driver will do their best to hide you in the car.
