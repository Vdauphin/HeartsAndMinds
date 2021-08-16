
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_place_key_down

Description:
    https://community.bistudio.com/wiki/DIK_KeyCodes

Parameters:
    _display - [Display]
    _key - [Number]
    _shift - [Boolean]
    _ctrl - [Boolean]
    _alt - [Boolean]
    _keyPressed - [Boolean]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_place_key_down;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_display", displayNull, [displayNull]],
    ["_key", 16, [0]],
    ["_shift", false, [false]],
    ["_ctrl", false, [false]],
    ["_alt", false, [false]],
    ["_keyPressed", false, [false]]
];

private _turbo = if (_shift) then {1} else {0};

//height [+] (Key 16: Q)
if (_key isEqualTo 16) then {
    //check for max height
    if !(btc_log_placing_h > btc_log_placing_max_h) then {
        //increase height
        btc_log_placing_h = btc_log_placing_h + 0.1 + _turbo/2;
        //placing
        btc_log_placing_obj attachTo [player, [0, btc_log_placing_d, btc_log_placing_h]];
    };
    //set var
    _keyPressed = true;
};
//height [-] (Key 44: Z*) (*German keyboard: Y)
if (_key isEqualTo 44) then {
    //check for min height
    if !(btc_log_placing_h < - 2) then {
        //decrease heigth
        btc_log_placing_h = btc_log_placing_h - 0.1 - _turbo/2;
        //placing
        btc_log_placing_obj attachTo [player, [0, btc_log_placing_d, btc_log_placing_h]];
    };
    //set var
    _keyPressed = true;
};
//yaw [+] (Key 45: X)
if (_key isEqualTo 45) then {
    //rotating clockwise
    btc_log_placing_dir = btc_log_placing_dir + 0.5 + _turbo;
    //set var
    _keyPressed = true;
};
//yaw [-] (Key 46: C)
if (_key isEqualTo 46) then {
    //rotating counterclockwise
    btc_log_placing_dir = btc_log_placing_dir - 0.5 - _turbo;
    //set var
    _keyPressed = true;
};
//roll [+] (Key 33: F)
if (_key isEqualTo 33) then {
    //tilting clockwise
    btc_log_rotating_dir = btc_log_rotating_dir + 0.5 + _turbo;
    //set var
    _keyPressed = true;
};
//roll [-] (Key 19: R)
if (_key isEqualTo 19) then {
    //tilting counterclockwise
    btc_log_rotating_dir = btc_log_rotating_dir - 0.5 - _turbo;
    //set var
    _keyPressed = true;
};

//set object position (rotation and tilting)
if (_keyPressed) then {
    btc_log_placing_obj setVectorDirAndUp [
         [
             (sin btc_log_placing_dir) * (cos btc_log_ptich_dir),
            (cos btc_log_placing_dir) * (cos btc_log_ptich_dir),
            (sin btc_log_ptich_dir)
         ],
         [
                 [
                     sin btc_log_rotating_dir,
                    -sin btc_log_ptich_dir,
                    cos btc_log_rotating_dir * cos btc_log_ptich_dir
                ],
         -btc_log_placing_dir
         ] call BIS_fnc_rotateVector2D
    ];
};

_keyPressed
