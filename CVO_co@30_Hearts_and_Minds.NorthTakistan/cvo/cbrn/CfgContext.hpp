class CVO_ZEN_CBRN_ContextAction {
	displayName = "CBRN";
	icon = ""; // danger sign
	priority = 50;

	condition = "btc_p_chem";

	class CVO_ZEN_CBRN_ContaminateObjects_ContextAction {
		displayName = "Contaminate Objects";
		icon = "";
		priority = 100;

		condition = "(count _objects) > 0";
		statement = "_objects call cvo_cbrn_fnc_contaminateObject";
	};

	class CVO_ZEN_CBRN_DecontaminateObjects_ContextAction : CVO_ZEN_CBRN_ContaminateObjects_ContextAction {
		displayName = "Decontaminate Objects";
		priority = 99;

		statement = "_objects call cvo_cbrn_fnc_decontaminateObject";
	};
};
