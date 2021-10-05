private ["_veh","_vehType"];
_veh = _this select 0;
_vehType = getText(configFile>>"CfgVehicles">>typeOf _veh>>"DisplayName");

if (_veh isKindOf "Air") exitWith { 

	_veh sidechat format ["Service en cours %1.", _vehType];
	_veh setFuel 0;
	sleep 3;
	
	_veh setVehicleAmmo 1;	
	_veh sidechat format ["%1 Rearmé.", _vehType];
	sleep 3;
	
	_veh setDamage 0;	
	_veh sidechat format ["%1 Reparé.", _vehType];	
	sleep 3;
	
	_veh setFuel 1;
	_veh sidechat format ["%1 Réapprovisionné.", _vehType];
	sleep 2;
	

	_veh sidechat format ["Service Completé", _vehType];
	
};
