/**
 * @name addZeusToPlayerLocal
 * Remote version of addZeusToPlayer function for multiplayer.
 *
 * @param {object} [_player = player], player linked to zeus
 *
 * @returns {Bool} true if successfull
 *
 * @author Migoyan
 */
params [
	["_player", player, [objNull]]
];

private _error = [_player] remoteExecCall ["gie_zeus_fnc_addZeusToPlayer", 2];
if (isNil "_error") exitWith {
	false
};

true