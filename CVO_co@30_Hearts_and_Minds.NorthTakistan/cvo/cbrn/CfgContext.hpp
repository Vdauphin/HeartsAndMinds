class CVO_ZEN_CBRN_ContextAction {
	displayName = "CBRN";
	icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa";
	priority = 50;

	condition = "btc_p_chem";

	class CVO_ZEN_CBRN_ContaminateObjects_ContextAction {
		displayName = "Contaminate Objects";
		icon = "";
		priority = 100;

		condition = "(count _objects) > 0";
		statement = "_objects call cvo_cbrn_fnc_contaminateObjects";
	};

	class CVO_ZEN_CBRN_DecontaminateObjects_ContextAction : CVO_ZEN_CBRN_ContaminateObjects_ContextAction {
		displayName = "Decontaminate Objects";
		priority = 99;

		statement = "_objects call cvo_cbrn_fnc_decontaminateObjects";
	};
};
