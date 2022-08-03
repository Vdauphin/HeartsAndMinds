/* ----------------------------------------------------------------------------
Function: recruitHandler

Description: Handles all functions relating to civilian recruitment.

Parameters:
0: Input <ANY>
0: Operation <STRING>

Returns: Nil

Examples:

[[_civ,_undercoverUnit],"recruitAttempt"] remoteExecCall ["INCON_ucr_fnc_recruitHandler",_civ];

Author: Incontinentia
---------------------------------------------------------------------------- */

params ["_input",["_operation","recruitAttempt"]];

switch (_operation) do {

    case "recruitCiv": {

        _input params [["_unit",objNull],["_armedCivPercentage",70]];

        if (_unit getVariable ["isPrisonGuard",false]) exitWith {};

        [_unit, [
        	"<t color='#33FFEC'>Recruit</t>", {
        		params ["_civ","_undercoverUnit"];

        		if !((currentWeapon _undercoverUnit == "") || (currentWeapon _undercoverUnit == "Throw")) exitWith {
        		    private _civComment = selectRandom ["Put your weapon away.","Get that thing out of my face","I don't like being threatened.","Put your gun away."];
        		    [[_civ, _civComment] remoteExec ["globalChat",0]];
        		};

        		[[_civ,_undercoverUnit],"recruitAttempt"] remoteExecCall ["INCON_ucr_fnc_recruitHandler",_civ];

        		_civ setVariable ["INC_alreadyTried",true];

        	},[],6,true,true,"","((alive _target) && {(_this getVariable ['isUndercover',false])} && {!(_target getVariable ['INC_alreadyTried',false])})",4
        ]] remoteExec ["addAction", 0];

        [_unit, [
        	"<t color='#33FF42'>Try to steal clothes from this unit</t>", {
        		params ["_giver","_reciever"];
        		private ["_gwh","_reciverUniform","_giverUniform","_droppedRecUni"];

        		switch (40 > random 100) do {
        			case true: {
        				_gwh = createVehicle ["GroundWeaponHolder", getPosATL _reciever, [], 0, "CAN_COLLIDE"];
        				_reciverUniform = uniform _reciever;
        				_giverUniform = uniform _giver;
        				_gwh addItemCargoGlobal [_reciverUniform, 1];
        				_droppedRecUni = (((everyContainer _gwh) select 0) select 1);
        				{_droppedRecUni addItemCargoGlobal [_x, 1];} forEach (uniformItems _reciever);
        				{_droppedRecUni addItemCargoGlobal [_x, 1];} forEach (uniformItems _giver);
        				removeUniform _reciever;
        				removeUniform _giver;
        				_reciever forceAddUniform _giverUniform;
        				if (rating _reciever > 1000) then {_reciever addrating -1000};
        				if (20 > (random (rating _reciever / 10))) then {_reciever call INCON_ucr_fnc_compromised};

        				private _civComment = selectRandom ["That's a real dick move.","Fuck you.","I hope you get caught!","You're a horrible human!","What are you playing at?","You've lost my support.","I'll take one for the cause now but not again."];
        				[[_giver, _civComment] remoteExec ["globalChat",0]];
        			};

        			case false: {
        				[[_giver,"runAway"] remoteExecCall ["INCON_ucr_fnc_ucrMain",_giver]];
        				if (rating _reciever > 800) then {_reciever addrating -800};
        				if (30 > (random (rating _reciever / 10))) then {_reciever call INCON_ucr_fnc_compromised};
        				private _civComment = selectRandom ["You can fuck off.","What am I going to wear?","Creep!","Go away!","Is this how you treat your women?","Sounds like a dirty ruse.","So now the truth comes out.","This is my favourite shirt.","You'd like that wouldn't you?"];
        				[[_giver, _civComment] remoteExec ["globalChat",0]];
        			};
        		};

        		_giver setVariable ["INC_alreadyTried",true];

        		},[],6,true,true,"","((_this getVariable ['isUndercover',false]) && {!(_target getVariable ['INC_alreadyTried',false])} && {alive _target} && {uniform _target != ''} && {(currentWeapon _this != '') && {(currentWeapon _this == primaryWeapon _this) || {currentWeapon _this == handgunWeapon _this}}})",4
        ]] remoteExec ["addAction", 0,true];

        if (30 > (random 100)) then {
        	[_unit,"addBackpack"] call INCON_ucr_fnc_gearHandler;
        };

        if (_armedCivPercentage > (random 100)) then {

        	[_unit,"addWeapon"] call INCON_ucr_fnc_gearHandler;
        };

        if (50 > (random 100)) then {
        	[_unit,"addItems"] call INCON_ucr_fnc_gearHandler;
        };
    };

    case "recruitAttempt": {
        private ["_undercoverGroup","_percentage","_civComment"];

        _input params ["_civ","_undercoverUnit"];

        _undercoverGroup = count units group _undercoverUnit;

        _percentage = (linearConversion [0, 40000, (rating _undercoverUnit), 5, 70, true]);

        if (_percentage > 30) then {
            if ((_percentage > (random 100)) && {_undercoverUnit getVariable ["isUndercover", false]}) then {

                if (_undercoverGroup < (5 + (ceil random 5))) then {

                    _civComment = selectRandom ["I've heard about you.","You can count on me.","I admire what you're doing.","You have my support.","Thank you for helping rid us of this scourge.","Thank you for helping our people.","I don't want them to see my face."];
                    [[_civ, _civComment] remoteExec ["globalChat",0]];
                    (group _civ) setGroupOwner (owner _undercoverUnit);
                    [[_civ,_undercoverUnit],"recruitSuccess"] remoteExecCall ["INCON_ucr_fnc_recruitHandler",_undercoverUnit];

                } else {
                    _civComment = selectRandom ["Keep up the good work guys.","You all just keep doing what you're doing.","You don't need me, I'll just hold you guys back.","You'll all be fine without me."];
                    [[_civ, _civComment] remoteExec ["globalChat",0]];
                };

            } else {

                _civComment = selectRandom ["I am just a simple farmer's wife.","I like your style but I've got kids to feed.","Sorry, I'm too drunk.","You get those fuckers.","Get me some more raksi and I'll think about it.","My wife would kill me.","My foot hurts too much but I appreciate what you're doing.","You're a good man but I can't I'm afraid.","Man, I wish I could."];
                [[_civ, _civComment] remoteExec ["globalChat",0]];

            };

        } else {

            if ((_percentage > (random 100)) && {_undercoverUnit getVariable ["isUndercover", false]} && {!(_undercoverUnit getVariable ["INC_isCompromised", false])}) then {

                if (_undercoverGroup < (2 + (random 5))) then {

                    _civComment = selectRandom ["This is for Cyril.","I'll get my fighting hat on.","I'm bored, why not.","I'll join you, but only because they ran over my rabbit.","I should really know better.","I'm going to regret this.","Fuck it, let's go.","My wife is going to kill me for this.","Well it's better than gardening."];
                    [[_civ, _civComment] remoteExec ["globalChat",0]];
                    (group _civ) setGroupOwner (owner _undercoverUnit);
                    [[_civ,_undercoverUnit],"recruitSuccess"] remoteExecCall ["INCON_ucr_fnc_recruitHandler",_undercoverUnit];

                } else {

                    _civComment = selectRandom ["Don't you have enough already?","I haven't heard of you guys before. I'm out.","Prove yourselves and maybe I'll join you next time.","Who are you guys?","I don't like the look of you lot."];
                    [[_civ, _civComment] remoteExec ["globalChat",0]];

                };

            } else {

                _civComment = selectRandom ["You stink.","Have a shower.","I'm good thanks.","My brother likes to do stupid things. Ask him.","While my nails are drying? No Way.","Try my cousin, he's a lunatic.","My piles are more threatening than you.","They will kill us all.","I don't speak Spanish.","There is nothing we can do.","What have you ever done for us?","Who are you?","Why should I join you?","Get out of here foreigner.","I would but I've got this really important thing on.","Prove yourself and I'll join you next time.","Yeah... good luck.","What's the point?","I'll fight them on my own time."];
                [[_civ, _civComment] remoteExec ["globalChat",0]];

            };
        };
    };


	case "recruitSuccess": {

		_input spawn {

			params ["_civ","_groupLead"];

			private ["_unitType","_civPos","_prevGroup","_civFace","_civSpeaker","_civHeadgear","_civName"];

			_civLoadout = getUnitLoadout _civ;

			sleep 0.1;

			_unitType =  (selectRandom (["units",[(faction _groupLead)]] call INCON_ucr_fnc_getConfigInfo));

			sleep 0.2;

			_civPos = getPosWorld _civ;
			_prevGroup = group _civ;
			_civFace = face _civ;
			_civSpeaker = speaker _civ;
			_civHeadgear = selectRandom ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
			_civName = name _civ;
			deleteVehicle _civ;

			_skill = (0.4 + (random 0.55));

			_recruitedCiv = (group _groupLead) createUnit [_unitType,[0,0,0],[],0,""];
			_recruitedCiv setVariable ["noChanges",true,true];
			_recruitedCiv setVariable ["isUndercover", true, true];

			_recruitedCiv setPosWorld _civPos;
			_recruitedCiv setUnitAbility _skill;

			_recruitedCiv setUnitLoadout _civLoadout;

            _recruitedCiv setVariable ["ace_medical_medicClass",1,true];
            _recruitedCiv setVariable ["ACE_isEOD",1,true];
            _recruitedCiv setVariable ["ACE_IsEngineer",1,true];

			if ((count units _prevGroup) == 0) then {
				deleteGroup _prevGroup;
			};

			[_recruitedCiv,_civLoadout,_civHeadgear,_civFace,_civName,_civSpeaker,_groupLead] spawn {
				params ["_recruitedCiv","_civLoadout","_civHeadgear","_civFace","_civName","_civSpeaker","_groupLead"];

				sleep 0.1;

				[_recruitedCiv, _civFace] remoteExec ["setFace", 0];
				[_recruitedCiv, _civName] remoteExec ["setName", 0];
				[_recruitedCiv, _civSpeaker] remoteExec ["setSpeaker", 0];

				_recruitedCiv setUnitLoadout _civLoadout;

				sleep 0.3;

				_recruitedCiv remoteExec ["removeAllActions",0];
				removeHeadgear _recruitedCiv;

				_recruitedCiv setUnitLoadout _civLoadout;

				sleep 0.1;

				_recruitedCiv addHeadgear _civHeadgear;

				_recruitedCiv setUnitLoadout _civLoadout;

				sleep 1;

				[[_recruitedCiv,_groupLead],"addConcealActions"] call INCON_ucr_fnc_ucrMain;
				[[_recruitedCiv],"INC_undercover\Scripts\initUCR.sqf"] remoteExec ["execVM",_groupLead];

				_recruitedCiv setCombatMode "GREEN";
			};
		};
		_return = _recruitedCiv;
	};
};
