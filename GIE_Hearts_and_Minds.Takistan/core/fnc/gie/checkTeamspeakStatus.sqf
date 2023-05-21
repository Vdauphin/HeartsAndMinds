/* ----------------------------------------------------------------------------
Function: gie_teamspeak_fnc_checkStatus

Description:
    Check TeamSpeak status, and if not connected to TeamSpeak, disable movement and visual

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] spawn gie_teamspeak_fnc_checkStatus;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

private _notConnected = {
	private _color = "#B71C1C";
	private _warningMessage = [
		format ["<t color='%1' align='center' size='2'>Bonjour %2</t>", _color, name player],
		format ["Bienvenue à toi sur le serveur du <t color='%1'>G.I.E</t>", _color],
		format ["Il semblerait que tu ne soit pas connecté à Teamspeak, ce que nous empêche de communiquer avec toi :/", _color],
		"On t'invite à te connecter à l'adresse suivante:",
		format ["<t size='2' color='%1'>ts.team-gie.com</t>", _color],
		"Ou à nous rejoindre sur Discord:",
		format ["<t size='2' color='%1'>https://discord.com/invite/E5fMr3z3kF</t>", _color],
		"Le staff s'engage à répondre à toutes tes questions !",
		format ["<t color='%1' align='center'>Le Staff</t>", _color]
	];
	cutText [_warningMessage joinString "<br/>", "BLACK OUT", 0, true, true];
	player enableSimulation false;
};

private _connected = {
	cutText ["Connecté à Teamspeak !", "BLACK IN", 5, true, true];
	player enableSimulation true;
};

private _checkTeamspeakStatusHandlerId = [{
	if !(missionNamespace getVariable ["acre_sys_io_serverstarted", false] && (getPos player inArea safeZone) && is3DENPreview) then {
		call _notConnected;
	} else {
		call _connected;
	};
}, 5, player] call CBA_fnc_addPerFrameHandler;

missionNamespace setVariable ["GIE_teamspeakStatusHandler", _checkTeamspeakStatusHandlerId, true];