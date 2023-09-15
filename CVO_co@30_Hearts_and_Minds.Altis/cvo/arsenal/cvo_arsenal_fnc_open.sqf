/*
Script Runs when the players open the arsenal.
1.
If the player opens the arsenal for the first time,
it creates the cvo_virtual_arsenal box and updates the content of said arsenal.
If the player opened it before and the cvo_virtual_arsenal exists already, it will 
*/

if (isNull cvo_virtual_arsenal) then { cvo_virtual_arsenal = ni;};

if (isNil "cvo_virtual_arsenal") then {

// Creates Virtual Arsenal box for the player locally if none has been existing before

	cvo_virtual_arsenal = createVehicleLocal ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];

	player setVariable ["cvo_arsenal", cvo_virtual_arsenal, false];

	[cvo_virtual_arsenal, false] 				call ace_dragging_fnc_setDraggable;			// Disables Dragging
	[cvo_virtual_arsenal, false] 				call ace_dragging_fnc_setCarryable;			// Disables Carrying
	[cvo_virtual_arsenal, -1] 					call ace_cargo_fnc_setSize;					// Disables Ace Cargo Loading
	cvo_virtual_arsenal setVariable ["ace_cargo_noRename", true];							// Disables Ace Cargo Renaming

//	hideObject cvo_vitual_arsena;															// Hides the Object

	clearBackpackCargo cvo_virtual_arsenal;													// Empties the ArsenalBox
	clearMagazineCargo cvo_virtual_arsenal;
	clearWeaponCargo cvo_virtual_arsenal;
	clearItemCargo cvo_virtual_arsenal;

	cvo_virtual_arsenal enableSimulation false;												// Disables Simulation


	[cvo_virtual_arsenal, false, false] call ace_arsenal_fnc_initBox;

} else {

	// Removes current content	
	[cvo_virtual_arsenal, true, false] call ace_arsenal_fnc_removeVirtualItems;

};

// Retrieving the updated Arsenal List
_updatedArray = [] call cvo_a_fnc_update;


[cvo_virtual_arsenal, _updatedArray, false] call ace_arsenal_fnc_addVirtualItems;

// Opens the Arsenal remotely for the players
[cvo_virtual_arsenal, player, false] call ace_arsenal_fnc_openBox;