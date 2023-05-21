/* ----------------------------------------------------------------------------
Function: gie_discord_activity_fnc_send

Description:
    Send activity to Discord

Parameters:
    _obj - Hashmap containing all fields informations [HashMap]


Returns:

Examples:
    (begin example)
    (end)
Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params ["_obj"];
[
    "Activity", // CfgDiscordEmbedWebhooks
    "",
    "AAN News",
    "https://cdn.discordapp.com/avatars/510077934934032386/e9ddd75a8ee13a8a64c7ac9d57773861.webp",
    false, // tts
    [ // Maximum 10 embeds per message
        [
            "",
            "",
            "https://discord.com/invite/E5fMr3z3kF",
            "B71C1C", // color RGB
            true,     // use timestamp
            "https://cdn.discordapp.com/avatars/510077934934032386/e9ddd75a8ee13a8a64c7ac9d57773861.webp",
            "https://cdn.discordapp.com/avatars/510077934934032386/e9ddd75a8ee13a8a64c7ac9d57773861.webp",
            [
                "Informations locales",
                "https://static.wikia.nocookie.net/armedassault/images/d/d5/Arma3-company-aannews.png/revision/latest?cb=20180829012524",
                "https://static.wikia.nocookie.net/armedassault/images/d/d5/Arma3-company-aannews.png/revision/latest?cb=20180829012524"
            ],
            [
                format ["Informations factices du serveur %1 ne relevant pas d'informations réelles. toute ressemblance avec des faits réels ou ayant existé est purement fortuite", serverName],
                "https://cdn.discordapp.com/avatars/510077934934032386/e9ddd75a8ee13a8a64c7ac9d57773861.webp"
            ],
            (_obj get "contents") apply {
                private _fieldInfo = _x;
                [
                    _fieldInfo get "title",
                    _fieldInfo get "content",
                    _fieldInfo get "inline"
                ]
            }
            // [ // Maximum 25 fields per embed
            //     [
            //         "field title",
            //         "field content",
            //         true  // inline
            //     ],
            //     [ /* another field */ ],
            //     [ /* another field */ ],
            //     [ /* another field */ ],
            //     [ /* another field */ ]
            // ]
        ]
    ]
] call (missionNamespace getVariable ["DiscordEmbedBuilder_fnc_buildSqf", {}]);