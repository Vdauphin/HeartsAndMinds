// ##########################
// Debug Viewer

if (!isNil "cvo_ss_debug" && {cvo_ss_debug isEqualTo true}) then {cvo_ss_debug = false} else {
	[] spawn {
		diag_log ("[CVO] [SandStorm] (DebugHint) - Init");
		cvo_ss_debug = true;
		
		while {sleep 1; cvo_ss_running} do {
			if (!cvo_ss_debug) exitWith {};
			hintSilent (format ["### CVO SANDSTORM DEBUG ###\nTime left: %4s / %5s\nIntensity: %8\nCurrent Phase: %6\nFogParams:\nValue: %1\nDecay: %2\nFogBase: %3", fogParams#0, fogParams#1, fogParams#2,cvo_ss_remaining, cvo_ss_duration, cvo_ss_phase, cvo_ss_remaining, cvo_ss_intensity]);
		};
		cvo_ss_debug = false;
		diag_log ("[CVO] [SandStorm] (DebugHint) - End");
	};
};