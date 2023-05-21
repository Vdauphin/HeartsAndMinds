
/* ----------------------------------------------------------------------------
Function: btc_tag_fnc_eh

Description:
    Store texture for city de_activation, check if player try to remove a tag or store player tag to database.

Parameters:
    _tag - Tag. [Object]
    _texture - Texture of the tag. [String]
    _object - Object where the tag is draw. [Object]
    _unit - Unit tagging. [Object]

Returns:

Examples:

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_tag", "_texture", "_object", "_unit"];

if (_unit in values btc_city_all) then {
    _tag setVariable ["btc_texture", _texture]; //Store texture for city de_activation
    _tag setVariable ["btc_city", _unit];
    btc_tags_server pushBack _tag;
} else {
    if (isNull _tag) then {
        _object setVariable ["btc_tag_vehicle", _texture, 2];
    };
    if (_texture isEqualTo "#(rgb,8,8,3)color(0,0,0,0)") then { //Check if player want to remove a tag
        private _tags = (allSimpleObjects btc_type_blacklist) inAreaArray [getPosWorld _tag, 3, 3];
        if (count _tags > 1) then {
            _tags = _tags apply {[_x distance _tag, _x]};
            _tags sort true;
            private _tagToRemove = _tags select 1 select 1;
            if (_tagToRemove in btc_tags_server) then {
                [
                    [btc_rep_bonus_removeTagLetter, btc_rep_bonus_removeTag] select (_tagToRemove isKindOf "Graffiti_base_F"),
                    _unit
                ] call btc_rep_fnc_change;
            };
            deleteVehicle _tagToRemove;
        };
        deleteVehicle _tag;
    } else { //Store tag for database
        btc_tags_player pushBack [_tag, _texture, _object];
    };
};
