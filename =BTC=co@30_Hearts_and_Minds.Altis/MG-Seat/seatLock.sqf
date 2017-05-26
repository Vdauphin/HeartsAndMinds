BAKE_VREST_RESTRICTIONS = [
"btc_helo_1",[["driver"],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"],
"btc_veh_14",[["driver"],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"],
"btc_veh_10",[["driver"],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"],
"btc_helo_1",[["Turret",[0]],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"],
"btc_veh_14",[["Turret",[0]],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"],
"btc_veh_10",[["Turret",[0]],["mg2_heli_pilot_1","mg2_heli_pilot_2"],"Only Seasoned Pilots are allowed to fly this Helicopter!"]
];

/*====================================================================================
----------------------------DO NOT EDIT PAST THIS POINT-------------------------------
====================================================================================*/

//Exit if we are not a player client
if !( hasInterface ) exitWith {};

TAG_fnc_checkVehicleRestrictions = {
	params[
		"_unit",
		"_position",
		"_vehicle",
		"_turretPath",
		[ "_switched", false ]
	];

	//Are we switching seats
	_canSwitchBack = if !( _switched ) then {

		//If not then we must be getting in a vehicle
		//Store players vehicle role
		_unit setVariable [ "BAKE_lastPosition", [ _position, _turretPath ] ];

		//Flag as unable to switch back to an internal vehicle position
		{ false }
	}else{
		//Return function that switches player back to his previous vehicle position
		{
			params[ "_unit", "_vehicle" ];
			( _unit getVariable "BAKE_lastPosition" ) params[ "_position", [ "_turretPath", [] ] ];

			//If we dont have a turret path
			if ( _turretPath isEqualTo [] ) then {

				//Find our position name
				switch toLower _position do {

					case "driver" : {
						//If there is no current driver
						if ( isNull ( driver _vehicle ) ) then {
							//Fix as we cannot move in from an internal position
							_unit setPos [0,0,0];
							//Move the player back in as driver
							_unit moveInDriver _vehicle;
							//Move was successful
							true
						}else{
							//Move was unsuccessful
							false
						};
					};

					case "cargo" : {
						//If there are empty cargo positions
						if ( _vehicle emptyPositions "cargo" > 0 ) then {
							//Fix as we cannot move in from an internal position
							_unit setPos [0,0,0];
							//Move player into cargo
							_unit moveInCargo _vehicle;
							//Move was successful
							true
						}else{
							//Move was unsuccessful
							false
						};
					};
				};
			}else{
				//Is the previous turret unoccupied
				if ( isNull ( _vehicle turretUnit _turretPath ) ) then {
					//Fix as we cannot move in from an internal position
					_unit setPos [0,0,0];
					//Move player into turret
					_unit moveInTurret[ _vehicle, _turretPath ];
					//Move was successful
					true
				}else{
					//Move was unsuccessful
					false
				};
			};
		}
	};

	//For each restirction
	for "_index" from 0 to (( count BAKE_VREST_RESTRICTIONS ) - 1 ) step 2 do {
		//If its relevant to this vehicle
		if ( BAKE_VREST_RESTRICTIONS select _index == vehicleVarName _vehicle ) then {

			//Get the restriction data
			( BAKE_VREST_RESTRICTIONS select ( _index + 1 )) params[ "_restricted", "_whiteList", "_message" ];

			if (
				//For each restricted position
				{
					( _x isEqualType "" && { _x == _position } ) ||					//If its a STRING and is equal to the players position
					{ _x isEqualType [] && { ( _x select 0 ) isEqualType "" } &&	//OR its an ARRAY and the first index is a STRING
						{
							( _x select 0 ) == _position &&			//AND the first index is equal to the players position
							( _x select 1 ) isEqualTo _turretPath	//AND the second index is equal to the players turret path
						}
					} ||
					{ _x isEqualTo _turretPath }					//OR is just a turret path equal to player turretPath
				}count _restricted > 0 && //If we have a restriction
				//AND for each white list
				{
					{
						_x == vehicleVarName _unit ||			//If its the players var name
						{ _x == getPlayerUID _unit } ||			//OR his UID
						{ _unit getUnitTrait _x }				//OR he has a trait
					}count _whiteList isEqualTo 0 //If he is not in the white list
				}
			) exitWith {
				//See if the player can switch back to a previous position
				if !( [ _unit, _vehicle ] call _canSwitchBack ) then {
					//If not kick him out of the vehicle
					moveOut player;
					_unit setVariable [ "BAKE_lastPosition", nil ];
				};
				//and show him a message why
				titleText [_message, "PLAIN", 0.2];
			};
		};
	};

	//If hes still in the vehicle
	if ( _unit in _vehicle ) then {
		//Update his saved previous position to his current
		_unit setVariable [ "BAKE_lastPosition", assignedVehicleRole _unit ];
	};
};

//Add event for when player enter vehicle
player addEventHandler [ "GetInMan", TAG_fnc_checkVehicleRestrictions ];

//Add event to handle internal seat switching
player addEventHandler [ "SeatSwitchedMan", {
	params[ "_unit", "", "_vehicle" ];

	assignedVehicleRole _unit params[ "_position", [ "_turretPath", [] ] ];

	[ _unit, _position, _vehicle, _turretPath, true ] call TAG_fnc_checkVehicleRestrictions;
}];

//For teamSwitch testing
if ( !isMultiplayer && { teamSwitchEnabled } ) then {
	{
		//Add event for when unit enter vehicle
		_x addEventHandler [ "GetInMan", TAG_fnc_checkVehicleRestrictions ];

		//Add event to handle internal seat switching
		_x addEventHandler [ "SeatSwitchedMan", {
			params[ "_unit", "", "_vehicle" ];

			assignedVehicleRole _unit params[ "_position", [ "_turretPath", [] ] ];

			[ _unit, _position, _vehicle, _turretPath, true ] call TAG_fnc_checkVehicleRestrictions;
		}];
	}forEach ( switchableUnits - [ player ] );
};
