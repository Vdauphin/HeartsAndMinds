private [ "_vehmarkers", "_markedveh", "_cfg", "_vehtomark", "_marker" ];

_vehmarkers = [];
_markedveh = []; 
_cfg = configFile >> "cfgVehicles";
_vehtomark = [];

_vehtomark = [
// EDEN - CONFIG - VEHICLES TO BE MARKED
"fza_ah64d_b2e", 
"RHS_MELB_AH6M", 
"RHS_CH_47F", 
"rhsusf_stryker_m1127_m2_wd", 
"rhsusf_stryker_m1132_m2_wd", 
"rhsusf_m1151_m2_v2_usarmy_wd", 
"rhsusf_m1151_mk19_v2_usarmy_wd", 
"rhsusf_M1220_M153_M2_usarmy_wd", 
"rhsusf_m1240a1_m2crows_usarmy_wd", 
"RHS_M2A3_BUSKI_wd", 
"RHS_M6_wd", 
"rhsusf_M977A4_BKIT_M2_usarmy_wd", 
"RHS_MELB_MH6M", 
"rhsusf_mkvsoc", 
"rhsgref_hidf_rhib", 
"B_SDV_01_F", 
"RHS_UH1Y_UNARMED"
];


// Misc variables
markers_reset = [99999,99999,0];

while { true } do {

    _markedveh = [];
    {
        if (alive _x && (typeof _x) in _vehtomark && (_x distance2d btc_gear_object) > 500 && (count (crew _x)) == 0) then {
            _markedveh pushback _x;
        };
    } foreach vehicles;

    if ( count _markedveh != count _vehmarkers ) then {
        { deleteMarkerLocal _x; } foreach _vehmarkers;
        _vehmarkers = [];

        {
            _marker = createMarkerLocal [ format [ "markedveh%1" ,_x], markers_reset ];
            _marker setMarkerColorLocal "ColorKhaki";
            _marker setMarkerTypeLocal "mil_dot";
            _marker setMarkerSizeLocal [ 0.75, 0.75 ];
            _vehmarkers pushback _marker;
        } foreach _markedveh;
    };

    {
        _marker = _vehmarkers select (_markedveh find _x);
        _marker setMarkerPosLocal getpos _x;
        _marker setMarkerTextLocal  (getText (_cfg >> typeOf _x >> "displayName"));

    } foreach _markedveh;

    sleep 15;
};