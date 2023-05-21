
/* ----------------------------------------------------------------------------
Function: gie_db_fnc_exportDatabase

Description:
    Export database to UI

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] spawn gie_db_fnc_exportDatabase;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

gie_database_export_datas = nil;
[] remoteExecCall ["gie_db_fnc_exportDatabase_s", 2];
waitUntil {!(isNil "gie_database_export_datas")};

hint composeText [
	"Copier le contenu",
	lineBreak,
	"Coller le contenu dans un fichier"
];
private _ctrl = findDisplay 46 createDisplay "RscDisplayEmpty" ctrlCreate ["RscEditMultiReadOnly", -1];
_ctrl ctrlSetBackgroundColor [1,1,1,0.5];
private _ctrlWidth = 0.5 * safeZoneW; // 50% of screen width
private _ctrlHeight = 0.3 * safeZoneH; // 30% of screen height
_ctrl ctrlSetPositionW _ctrlWidth;
_ctrl ctrlSetPositionH _ctrlHeight;
_ctrl ctrlSetPositionX ((safeZoneW - _ctrlWidth) / 2 + safeZoneX); // center it horizontally
_ctrl ctrlSetPositionY ((safeZoneH - _ctrlHeight) / 2 + safeZoneY);
_ctrl ctrlSetText gie_database_export_datas;
_ctrl ctrlSetTextSelection [0, count gie_database_export_datas]; // Select the whole text
_ctrl ctrlCommit 0;
