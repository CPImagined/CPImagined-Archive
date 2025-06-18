//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.sensei.MenuSystem
    {
        var movie, gameEngine, dlearning;
        function MenuSystem ($parent, $movie) {
            movie = $movie;
            gameEngine = $parent;
            dlearning = new com.disney.dlearning.games.cardjitsu.DLearning(SHELL.getMyPlayerId());
            hideSpeechBubble();
            hideMenuOptions();
            hideAnimation();
            movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
            var _local_2 = SHELL.isItemInMyInventory(821);
            if (!_local_2) {
                loadMenu(MENU_HOW_TO_PLAY_WELCOME);
            } else {
                loadMenu(MENU_CHOOSE_MODE);
            }
        }
        function loadMenu($menuID) {
            if ($menuID == undefined) {
                currentMenu++;
            } else {
                currentMenu = $menuID;
            }
            switch (currentMenu) {
                case MENU_NONE : 
                    break;
                case MENU_CHOOSE_MODE : 
                case MENU_CHOOSE_MODE_COMPETITION : 
                case MENU_CHOOSE_MODE_SENSEI : 
                case MENU_CHOOSE_MODE_INSTRUCTIONS : 
                    if (currentMenu == MENU_CHOOSE_MODE) {
                        movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                        hideSpeechBubble();
                    } else {
                        movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                        if (currentMenu == MENU_CHOOSE_MODE_COMPETITION) {
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_description_competition"));
                        } else if (currentMenu == MENU_CHOOSE_MODE_SENSEI) {
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_description_sensei"));
                        } else if (currentMenu == MENU_CHOOSE_MODE_INSTRUCTIONS) {
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_description_instructions"));
                        }
                    }
                    hideAnimation();
                    var _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("menu_title_competition"));
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("menu_title_sensei"));
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("menu_title_instructions"));
                    showMenuOptions(_local_2);
                    break;
                case MENU_HOW_TO_PLAY_WELCOME : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_welcome"));
                    hideMenuOptions();
                    hideAnimation();
                    break;
                case MENU_HOW_TO_PLAY_BEGIN : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_tobegin"));
                    showAnimation(ANIM_TUTORIAL_THESECARDS);
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_WHAT_DO_I_DO : 
                    if (!SHELL.isItemInMyInventory(821)) {
                        SHELL.sendBuyInventory(821);
                    }
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                    showAnimation(ANIM_TUTORIAL_THESECARDS_FADE);
                    _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_whatdoido"));
                    showMenuOptions(_local_2);
                    break;
                case MENU_HOW_TO_PLAY_COMPETE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_TUTORIAL_COMPETE);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_improve"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_READY : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    hideAnimation();
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_areyouready"));
                    break;
                case MENU_HOW_TO_PLAY_READY_QUESTION : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                    _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_yes"));
                    _local_2.push((com.clubpenguin.util.LocaleText.getText("help_response_no") + " ") + com.clubpenguin.util.LocaleText.getText("help_response_play"));
                    showMenuOptions(_local_2);
                    break;
                case MENU_HOW_TO_PLAY_CARD : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_TUTORIAL_PICKCARD);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_pickacard"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_WATER : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_WATER);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_water"));
                    break;
                case MENU_HOW_TO_PLAY_SNOW : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_SNOW);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_snow"));
                    break;
                case MENU_HOW_TO_PLAY_FIRE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_FIRE);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_fire"));
                    break;
                case MENU_HOW_TO_PLAY_TIE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_TIE);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_tie"));
                    break;
                case MENU_HOW_TO_PLAY_HOW_TO_WIN : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                    hideAnimation();
                    hideSpeechBubble();
                    _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_howtowin"));
                    _local_2.push((com.clubpenguin.util.LocaleText.getText("help_response_cantwait") + " ") + com.clubpenguin.util.LocaleText.getText("help_response_play"));
                    showMenuOptions(_local_2);
                    break;
                case MENU_HOW_TO_PLAY_TWO_WAYS : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_howtowin"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_SAME_TYPE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_TUTORIAL_WINSAME);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_winsame"));
                    break;
                case MENU_HOW_TO_PLAY_DIFFERENT_TYPE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_WINDIFFERENT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_windifferent"));
                    break;
                case MENU_HOW_TO_PLAY_INGAME_HELP : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_TUTORIAL_INGAMEHELP);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_ingamehelp"));
                    break;
                case MENU_HOW_TO_PLAY_HOW_TO_NINJA : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                    hideAnimation();
                    hideSpeechBubble();
                    _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_becomeninja"));
                    _local_2.push((com.clubpenguin.util.LocaleText.getText("help_response_cantwait") + " ") + com.clubpenguin.util.LocaleText.getText("help_response_play"));
                    showMenuOptions(_local_2);
                    break;
                case MENU_HOW_TO_PLAY_JOKE_ANSWER : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_LAUGH);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_joking"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_EXPERIENCE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_gainexp"));
                    break;
                case MENU_HOW_TO_PLAY_BELT : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_TUTORIAL_BELT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_belts"));
                    break;
                case MENU_HOW_TO_PLAY_DEFEAT_ME : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_BLACKBELT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_fightme"));
                    break;
                case MENU_HOW_TO_PLAY_BECOME_NINJA : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showAnimation(ANIM_TUTORIAL_NINJA);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_firsttime_ninja"));
                    break;
                case MENU_HOW_TO_PLAY_MENU_OPTIONS : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
                    hideSpeechBubble();
                    hideAnimation();
                    _local_2 = new Array();
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_countmein"));
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_tellmeagain"));
                    _local_2.push(com.clubpenguin.util.LocaleText.getText("help_response_havetogo"));
                    showMenuOptions(_local_2);
                    break;
                default : 
                    com.clubpenguin.util.Debug.log("unknown menu id entered: " + currentMenu, "ERROR");
                    break;
            }
        }
        function handleMouseOver($buttonID) {
            switch (currentMenu) {
                case MENU_CHOOSE_MODE : 
                case MENU_CHOOSE_MODE_COMPETITION : 
                case MENU_CHOOSE_MODE_SENSEI : 
                case MENU_CHOOSE_MODE_INSTRUCTIONS : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_CHOOSE_MODE_COMPETITION);
                            break;
                        case 2 : 
                            loadMenu(MENU_CHOOSE_MODE_SENSEI);
                            break;
                        case 3 : 
                            loadMenu(MENU_CHOOSE_MODE_INSTRUCTIONS);
                            break;
                        case undefined : 
                            loadMenu(MENU_CHOOSE_MODE);
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
            }
        }
        function handleClick($buttonID) {
            switch (currentMenu) {
                case MENU_CHOOSE_MODE : 
                case MENU_CHOOSE_MODE_COMPETITION : 
                case MENU_CHOOSE_MODE_SENSEI : 
                case MENU_CHOOSE_MODE_INSTRUCTIONS : 
                    switch ($buttonID) {
                        case 1 : 
                            gameEngine.pauseMenu(MENU_CHOOSE_MODE);
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:2});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.dLearningManager.setMode(2);
                            gameEngine.dLearningManager.startGame();
                            gameEngine.sendJoinMatchMaking();
                            break;
                        case 2 : 
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:3});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.dLearningManager.setMode(3);
                            gameEngine.dLearningManager.startGame();
                            gameEngine.sendJoinSensei();
                            break;
                        case 3 : 
                            loadMenu(MENU_HOW_TO_PLAY_CARD);
                            dlearning.readInstructions();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_HOW_TO_PLAY_WELCOME : 
                    loadMenu(MENU_HOW_TO_PLAY_BEGIN);
                    break;
                case MENU_HOW_TO_PLAY_BEGIN : 
                    loadMenu(MENU_HOW_TO_PLAY_WHAT_DO_I_DO);
                    break;
                case MENU_HOW_TO_PLAY_WHAT_DO_I_DO : 
                    if ($buttonID == 1) {
                        loadMenu(MENU_HOW_TO_PLAY_COMPETE);
                    }
                    break;
                case MENU_HOW_TO_PLAY_COMPETE : 
                    loadMenu(MENU_HOW_TO_PLAY_READY);
                    break;
                case MENU_HOW_TO_PLAY_READY : 
                    loadMenu(MENU_HOW_TO_PLAY_READY_QUESTION);
                    break;
                case MENU_HOW_TO_PLAY_READY_QUESTION : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_HOW_TO_PLAY_CARD);
                            break;
                        case 2 : 
                            gameEngine.pauseMenu(currentMenu);
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:2});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.sendJoinMatchMaking();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_HOW_TO_PLAY_CARD : 
                    loadMenu(MENU_HOW_TO_PLAY_WATER);
                    break;
                case MENU_HOW_TO_PLAY_WATER : 
                    loadMenu(MENU_HOW_TO_PLAY_SNOW);
                    break;
                case MENU_HOW_TO_PLAY_SNOW : 
                    loadMenu(MENU_HOW_TO_PLAY_FIRE);
                    break;
                case MENU_HOW_TO_PLAY_FIRE : 
                    loadMenu(MENU_HOW_TO_PLAY_TIE);
                    break;
                case MENU_HOW_TO_PLAY_TIE : 
                    loadMenu(MENU_HOW_TO_PLAY_HOW_TO_WIN);
                    break;
                case MENU_HOW_TO_PLAY_HOW_TO_WIN : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_HOW_TO_PLAY_TWO_WAYS);
                            break;
                        case 2 : 
                            gameEngine.pauseMenu(currentMenu);
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:2});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.sendJoinMatchMaking();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_HOW_TO_PLAY_TWO_WAYS : 
                    loadMenu(MENU_HOW_TO_PLAY_SAME_TYPE);
                    break;
                case MENU_HOW_TO_PLAY_SAME_TYPE : 
                    loadMenu(MENU_HOW_TO_PLAY_DIFFERENT_TYPE);
                    break;
                case MENU_HOW_TO_PLAY_DIFFERENT_TYPE : 
                    loadMenu(MENU_HOW_TO_PLAY_INGAME_HELP);
                    break;
                case MENU_HOW_TO_PLAY_INGAME_HELP : 
                    loadMenu(MENU_HOW_TO_PLAY_HOW_TO_NINJA);
                    break;
                case MENU_HOW_TO_PLAY_HOW_TO_NINJA : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_HOW_TO_PLAY_JOKE_ANSWER);
                            break;
                        case 2 : 
                            gameEngine.pauseMenu(currentMenu);
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:2});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.sendJoinMatchMaking();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_HOW_TO_PLAY_JOKE_ANSWER : 
                    loadMenu(MENU_HOW_TO_PLAY_EXPERIENCE);
                    break;
                case MENU_HOW_TO_PLAY_EXPERIENCE : 
                    loadMenu(MENU_HOW_TO_PLAY_BELT);
                    break;
                case MENU_HOW_TO_PLAY_BELT : 
                    loadMenu(MENU_HOW_TO_PLAY_DEFEAT_ME);
                    break;
                case MENU_HOW_TO_PLAY_DEFEAT_ME : 
                    loadMenu(MENU_HOW_TO_PLAY_BECOME_NINJA);
                    break;
                case MENU_HOW_TO_PLAY_BECOME_NINJA : 
                    loadMenu(MENU_HOW_TO_PLAY_MENU_OPTIONS);
                    break;
                case MENU_HOW_TO_PLAY_MENU_OPTIONS : 
                    switch ($buttonID) {
                        case 1 : 
                            gameEngine.pauseMenu(currentMenu);
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {mode:2});
                            SHELL.addCookie(SHELL.GAME_COOKIE, "game_ninja", {room:"dojo"});
                            gameEngine.sendJoinMatchMaking();
                            break;
                        case 2 : 
                            loadMenu(MENU_HOW_TO_PLAY_BEGIN);
                            break;
                        case 3 : 
                            gameEngine.closeGame();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
            }
        }
        function showSpeechBubble($text) {
            movie.speech.message.text = $text;
            updateSpeechBubble();
            movie[MOVIE_SPEECH_BUBBLE]._visible = true;
        }
        function hideSpeechBubble() {
            movie[MOVIE_SPEECH_BUBBLE]._visible = false;
        }
        function updateSpeechBubble() {
            var _local_5 = 80;
            var _local_3 = 24;
            var _local_6 = _local_3 / 2;
            var _local_4 = 5;
            var _local_2 = 1;
            while (_local_2 <= _local_4) {
                if (movie[MOVIE_SPEECH_BUBBLE].message.textHeight < ((_local_2 * _local_3) + _local_6)) {
                    movie[MOVIE_SPEECH_BUBBLE].bubble._height = _local_5 + (_local_2 * _local_3);
                    break;
                }
                _local_2++;
            }
        }
        function showMenuOptions($menuOptions) {
            var _local_5 = 27;
            var _local_6 = 42.6;
            var _local_7 = 3.5;
            movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_BACKGROUND]._height = (($menuOptions.length * _local_5) + (($menuOptions.length - 1) * _local_7)) + _local_6;
            var _local_2 = 0;
            while ((_local_2++) < 5) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + _local_2]._visible = false;
            }
            _local_2 = 0;
            while (_local_2 < $menuOptions.length) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local_2 + 1)].label.text = $menuOptions[_local_2];
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local_2 + 1)]._visible = true;
                var _local_3 = movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local_2 + 1)];
                if ($menuOptions[_local_2] == com.clubpenguin.util.LocaleText.getText("menu_title_competition")) {
                    attachMenuIcon(_local_3, "beltIcon");
                } else if ($menuOptions[_local_2] == com.clubpenguin.util.LocaleText.getText("menu_title_sensei")) {
                    attachMenuIcon(_local_3, "senseiIcon");
                } else if ($menuOptions[_local_2] == com.clubpenguin.util.LocaleText.getText("menu_title_instructions")) {
                    attachMenuIcon(_local_3, "InstructionsIcon");
                } else {
                    _local_3.icon.removeMovieClip();
                    _local_3.label._x = 0;
                }
                _local_2++;
            }
            movie[MOVIE_OPTIONS_MENU]._visible = true;
            talking = false;
        }
        function hideMenuOptions() {
            movie[MOVIE_OPTIONS_MENU]._visible = false;
            talking = true;
        }
        function showAnimation($animName) {
            movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
            movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop($animName);
        }
        function hideAnimation() {
            movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
        }
        function isTalking() {
            return(talking);
        }
        function attachMenuIcon($mc, $icon) {
            $mc.attachMovie($icon, "icon", 1);
            $mc.icon._y = 3;
            $mc.icon._xscale = ($mc.icon._yscale = 25);
            $mc.label._x = 28;
        }
        static var MENU_NONE = -100;
        static var MENU_CHOOSE_MODE = 0;
        static var MENU_CHOOSE_MODE_COMPETITION = 1;
        static var MENU_CHOOSE_MODE_SENSEI = 2;
        static var MENU_CHOOSE_MODE_INSTRUCTIONS = 3;
        static var MENU_HOW_TO_PLAY_WELCOME = 100;
        static var MENU_HOW_TO_PLAY_BEGIN = 101;
        static var MENU_HOW_TO_PLAY_WHAT_DO_I_DO = 102;
        static var MENU_HOW_TO_PLAY_COMPETE = 103;
        static var MENU_HOW_TO_PLAY_READY = 104;
        static var MENU_HOW_TO_PLAY_READY_QUESTION = 105;
        static var MENU_HOW_TO_PLAY_CARD = 106;
        static var MENU_HOW_TO_PLAY_WATER = 107;
        static var MENU_HOW_TO_PLAY_SNOW = 108;
        static var MENU_HOW_TO_PLAY_FIRE = 109;
        static var MENU_HOW_TO_PLAY_TIE = 110;
        static var MENU_HOW_TO_PLAY_HOW_TO_WIN = 111;
        static var MENU_HOW_TO_PLAY_TWO_WAYS = 112;
        static var MENU_HOW_TO_PLAY_SAME_TYPE = 113;
        static var MENU_HOW_TO_PLAY_DIFFERENT_TYPE = 114;
        static var MENU_HOW_TO_PLAY_INGAME_HELP = 115;
        static var MENU_HOW_TO_PLAY_HOW_TO_NINJA = 116;
        static var MENU_HOW_TO_PLAY_JOKE_ANSWER = 117;
        static var MENU_HOW_TO_PLAY_EXPERIENCE = 118;
        static var MENU_HOW_TO_PLAY_BELT = 119;
        static var MENU_HOW_TO_PLAY_DEFEAT_ME = 120;
        static var MENU_HOW_TO_PLAY_BECOME_NINJA = 121;
        static var MENU_HOW_TO_PLAY_MENU_OPTIONS = 122;
        static var MOVIE_SENSEI_DUDE = "sensei";
        static var MOVIE_SPEECH_BUBBLE = "speech";
        static var MOVIE_OPTIONS_MENU = "options";
        static var MOVIE_OPTIONS_BACKGROUND = "background";
        static var MOVIE_OPTIONS_ITEM = "item";
        static var MOVIE_HOW_TO_PLAY_ANIM = "howtoplay";
        static var ANIM_FRAME_TALK = "talk";
        static var ANIM_FRAME_WAIT = "wait";
        static var ANIM_FRAME_POINT = "point";
        static var ANIM_FRAME_LAUGH = "laugh";
        static var ANIM_TUTORIAL_THESECARDS = "theseCards";
        static var ANIM_TUTORIAL_THESECARDS_FADE = "theseCardsFade";
        static var ANIM_TUTORIAL_COMPETE = "compete";
        static var ANIM_TUTORIAL_PICKCARD = "pickCard";
        static var ANIM_TUTORIAL_WATER = "water";
        static var ANIM_TUTORIAL_SNOW = "snow";
        static var ANIM_TUTORIAL_FIRE = "fire";
        static var ANIM_TUTORIAL_TIE = "tie";
        static var ANIM_TUTORIAL_WINSAME = "winSame";
        static var ANIM_TUTORIAL_WINDIFFERENT = "winDifferent";
        static var ANIM_TUTORIAL_INGAMEHELP = "inGameHelp";
        static var ANIM_TUTORIAL_BELT = "belts";
        static var ANIM_TUTORIAL_BLACKBELT = "blackBelt";
        static var ANIM_TUTORIAL_NINJA = "ninja";
        static var ENGINE = _global.getCurrentEngine();
        static var SHELL = _global.getCurrentShell();
        var menuData = new Array();
        var currentMenu = MENU_NONE;
        var talking = false;
    }
