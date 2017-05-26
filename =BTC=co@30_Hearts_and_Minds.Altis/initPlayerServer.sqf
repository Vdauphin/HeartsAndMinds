_player = _this select 0;
_uid = getPlayerUID _player;

// allow MG Admins full access to all slots - You can disable it in initServer.sqf!!!
if ( give_MG_admins_full_access && (_uid in MGAdmins) ) exitWith {};

// ========== ZEUS
if ( _player getVariable [ "reservedZEUS", false ] && { !( _uid in allowedZEUS ) } ) then {
	[ [], "fnc_reservedSlot", _player ] call BIS_fnc_MP;
};
// ========== HELI CAS
if ( _player getVariable [ "reservedHeliCAS", false ] && { !( _uid in allowedHeliCAS ) } ) then {
	[ [], "fnc_reservedSlot", _player ] call BIS_fnc_MP;
};
// ========== Snipers
if ( _player getVariable [ "reservedSniper", false ] && { !( _uid in allowedSniper ) } ) then {
	[ [], "fnc_reservedSlot", _player ] call BIS_fnc_MP;
};
