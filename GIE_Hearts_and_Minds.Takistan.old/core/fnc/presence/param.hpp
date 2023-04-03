richAssets[] = {
	"20221212142215_1",
	"20221212142224_1",
	"20221212142249_1",
	"20221212142258_1",
	"20221212142436_1",
	"20221212142446_1",
	"20221212142456_1",
	"20221212142700_1",
	"20221212175720_1",
	"20221212175822_1",
	"20221212180103_1",
	"20221212180117_1",
	"20221212180135_1"
};

class CfgDiscordRichPresence {
    applicationID = "510077934934032386";             // Provided by discord
    defaultDetails = "[G.I.E] Hearts & Minds";            // Upper text
    defaultState = "[G.I.E] Hearts & Minds";              // Lower text
    defaultLargeImageKey = __EVAL(call compile "selectRandom (getMissionConfigValue [""richAssets"", []])");      // Large image
    defaultLargeImageText = "myImg1 hover";     // Large image hover text
    defaultSmallImageKey = __EVAL(call compile "selectRandom (getMissionConfigValue [""richAssets"", []])");      // Small image
    defaultSmallImageText = "myImg2 hover";     // Small image hover text
    defaultButtons[] = {};		  // Button texts and urls
    useTimeElapsed = 1;             // Show time elapsed since the player connected (1 - true, 0 - false)
};
