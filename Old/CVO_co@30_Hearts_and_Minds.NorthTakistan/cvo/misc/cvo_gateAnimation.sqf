/*
###############################
Open/Close Gate via Trigger + Animation for Gate Guard 
###############################

Debug:

[player, cvo_gate_guard_1, cvo_base_gate_1, [6287.46,7129.08,0.0220032] ] execVM "cvo\misc\cvo_gateAnimation.sqf";



// on deactivation
cvo_base_gate_1 animateSource ["Door_1_sound_source", 0];


// on activation

[(selectRandom thisList), cvo_gate_guard_1, cvo_base_gate_1, [6287.46,7129.08,0.0220032] ] spawn cvo_gateAnimation.sqf

*/

params ["_arrivalOBJ","_guardOBJ", "_gateOBJ", "_guardPos"];

private _idleArray = [
"Acts_Ambient_Rifle_Drop",
"Acts_Ambient_Stretching",
"Acts_Ambient_Shoelaces",
"Acts_Ambient_Picking_Up",
"Acts_Ambient_Relax_1",
"Acts_Ambient_Relax_2",
"Acts_Ambient_Relax_3",
"Acts_Ambient_Relax_4", 
"Acts_Dance_02",
"Acts_Dance_01",
"Acts_Rifle_Operations_Checking_Chamber",
"Acts_Rifle_Operations_Barrel"
];

private _idleArraySelect = [];
_idleArraySelect pushBack selectRandom _idleArray;
_idleArraySelect pushBack selectRandom _idleArray;
_idleArraySelect pushBack selectRandom _idleArray;

_dir = _guardOBJ getDir _arrivalOBJ;
_dirGate = _guardOBJ getDir _gateOBJ;

_guardOBJ setPos _guardPos;

// Guard looking at player
_guardOBJ lookAt _arrivalOBJ;
sleep 2;
//_guardOBJ setDir _dir;

_guardOBJ switchMove "Acts_PercMstpSlowWrflDnon_handup2c";
_guardOBJ playMoveNow "Acts_PercMstpSlowWrflDnon_handup2c";
sleep 3;

// Turning Guard to the gate
_guardOBJ lookAt _gateOBJ;
sleep 2;
//_guardOBJ setDir _dirGate;


_guardOBJ playMove "acts_miller_knockout";
sleep 2.5;
_gateOBJ animateSource ["Door_1_sound_source", 1];
cvo_base_gate_1_isOpen = true;
sleep 0.7;


_guardOBJ switchMove "AidlPercMstpSlowWrflDnon_AI";
_guardOBJ playMoveNow "AidlPercMstpSlowWrflDnon_AI";
sleep 0.1;


_guardOBJ lookAt _arrivalOBJ;
sleep 1;
_guardOBJ setDir _dir;

_guardOBJ switchMove 	"Acts_NavigatingChopper_In";
_guardOBJ playMoveNow 	"Acts_NavigatingChopper_In";
while {sleep 1.8; cvo_base_gate_1_isOpen} do {
	_guardOBJ playMove 		"Acts_NavigatingChopper_Loop";
};
_guardOBJ playMoveNow 	"Acts_NavigatingChopper_Out";

sleep 4;

{  _guardOBJ playMove _x; sleep 20; } forEach _idleArraySelect;

sleep 20;
_guardOBJ switchMove "AidlPercMstpSlowWrflDnon_AI";
_guardOBJ playMoveNow "AidlPercMstpSlowWrflDnon_AI";


