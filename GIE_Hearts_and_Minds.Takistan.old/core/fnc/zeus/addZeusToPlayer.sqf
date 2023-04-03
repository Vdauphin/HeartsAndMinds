/**
 * @name addZeusToPlayer
 * Function that add a zeus module and linked it to the player passed as parameter. Work only on hosting machine.
 *
 * @param {object} [_player = objNull], player linked to zeus
 *
 * @returns [_zeus_module, _player]
 *
 * @author Migoyan
 */
params [
	["_player", player, [objNull, ""]]
];

if (!isServer) exitWith {
	systemChat "not executed";
};

private ["_curator", "_module_group"];
_module_group = createGroup sideLogic;
_curator = _module_group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_curator addCuratorAddons activatedAddons;
_curator addCuratorEditableObjects [allUnits,true];
_curator addCuratorEditableObjects [vehicles,true];
_player assignCurator _curator;

diag_log format ["Zeus module created : %1, unit linked, %2", _curator, _player];
[format["Zeus créé sur le serveur et lié au joueur : %1", name _player]] remoteExec ["systemChat"];

[_curator, _player]