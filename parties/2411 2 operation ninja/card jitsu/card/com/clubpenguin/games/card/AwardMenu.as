//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.AwardMenu
    {
        var movie, gameEngine, _beltID;
        function AwardMenu ($parent, $movie) {
            movie = $movie;
            gameEngine = $parent;
            hideSpeechBubble();
            hideMenuOptions();
            hideAnimation();
            movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_WAIT);
        }
        function get beltID() {
            return(_beltID);
        }
        function set beltID(id) {
            _beltID = id;
            //return(beltID);
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
                case MENU_BELT_AWARD : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_congratulations"));
                    hideMenuOptions();
                    hideAnimation();
                    break;
                case MENU_BELT_EARNED : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showAnimation(ANIM_AWARD_BELT);
                    var _local_2;
                    var _local_3;
                    switch (_beltID) {
                        case BELT_WHITE : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_white");
                            _local_3 = 16777215 /* 0xFFFFFF */;
                            break;
                        case BELT_YELLOW : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_yellow");
                            _local_3 = 16776960 /* 0xFFFF00 */;
                            break;
                        case BELT_ORANGE : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_orange");
                            _local_3 = 16737792 /* 0xFF6600 */;
                            break;
                        case BELT_GREEN : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_green");
                            _local_3 = 3394560 /* 0x33CC00 */;
                            break;
                        case BELT_BLUE : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_blue");
                            _local_3 = 13260;
                            break;
                        case BELT_RED : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_red");
                            _local_3 = 13369344 /* 0xCC0000 */;
                            break;
                        case BELT_PURPLE : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_purple");
                            _local_3 = 6684927 /* 0x6600FF */;
                            break;
                        case BELT_BROWN : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_brown");
                            _local_3 = 6697728 /* 0x663300 */;
                            break;
                        case BELT_BLACK : 
                            _local_2 = com.clubpenguin.util.LocaleText.getText("belt_colour_black");
                            _local_3 = 4473924 /* 0x444444 */;
                            break;
                        default : 
                            com.clubpenguin.util.Debug.log("Unknow Belt ID: " + _beltID, "ERROR");
                            break;
                    }
                    gameEngine.dLearningManager.earnedBelt(_beltID);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getTextReplaced("help_award_belt_earned", [_local_2]));
                    var _local_4 = new Color(movie[MOVIE_HOW_TO_PLAY_ANIM].fadeInAnim.belt.colour);
                    _local_4.setRGB(_local_3);
                    break;
                case MENU_FINAL_AWARD : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_defeat_sensei_intro"));
                    hideMenuOptions();
                    hideAnimation();
                    break;
                case MENU_FINAL_WELLDONE : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_defeat_sensei_kowtows"));
                    break;
                case MENU_FINAL_OUTFIT : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_defeat_sensei_gift"));
                    showAnimation(ANIM_AWARD_MASK);
                    break;
                case MENU_FINAL_ROOM : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_defeat_sensei_final"));
                    showAnimation(ANIM_AWARD_HIDEOUT);
                    break;
				case MENU_SHOES_EARNED : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_shoes_earned"));
                    showAnimation("shoes");
                    break;
				case MENU_SUIT_EARNED : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_suit_earned"));
                    showAnimation("suit");
                    break;
				case MENU_MASK_EARNED : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_mask_earned"));
                    showAnimation("shmask");
                    break;
				case MENU_HELMET_EARNED : 
                    movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_helmet_earned"));
                    showAnimation("helmet");
                    break;
				case MENU_SHADOW_FINAL :
					movie[MOVIE_SENSEI_DUDE].gotoAndStop(ANIM_FRAME_POINT);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("help_award_shadow_final"));
                    showAnimation("shadow");
                default : 
                    com.clubpenguin.util.Debug.log("Unknow Menu ID: " + currentMenu, "ERROR");
                    break;
            }
        }
        function handleClick($buttonID) {
            switch (currentMenu) {
                case MENU_BELT_AWARD : 
                    loadMenu(MENU_BELT_EARNED);
                    break;
                case MENU_BELT_EARNED : 
                    gameEngine.leaveGame();
                    break;
                case MENU_FINAL_AWARD : 
                    loadMenu(MENU_FINAL_WELLDONE);
                    break;
                case MENU_FINAL_WELLDONE : 
                    loadMenu(MENU_FINAL_OUTFIT);
                    break;
                case MENU_FINAL_OUTFIT : 
                    loadMenu(MENU_FINAL_ROOM);
                    break;
                case MENU_FINAL_ROOM : 
                    gameEngine.leaveGame();
                    break;
				case MENU_SHOES_EARNED : 
                    gameEngine.leaveGame();
                    break;
				case MENU_SUIT_EARNED : 
                    gameEngine.leaveGame();
                    break;
				case MENU_MASK_EARNED : 
                    gameEngine.leaveGame();
                    break;
				case MENU_HELMET_EARNED : 
                    loadMenu(MENU_SHADOW_FINAL);
                    break;
				case MENU_SHADOW_FINAL : 
                    gameEngine.leaveGame();
                    break;
                default : 
                    com.clubpenguin.util.Debug.log("Unknow Menu ID: " + currentMenu, "ERROR");
                    break;
            }
        }
        function showSpeechBubble($text) {
            trace("show speech: " + $text);
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
            var _local_4 = 27;
            var _local_5 = 42.6;
            var _local_6 = 3.5;
            movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_BACKGROUND]._height = (($menuOptions.length * _local_4) + (($menuOptions.length - 1) * _local_6)) + _local_5;
            var _local_2 = 0;
            while ((_local_2++) < 5) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + _local_2]._visible = false;
            }
            _local_2 = 0;
            while (_local_2 < $menuOptions.length) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local_2 + 1)].label.text = $menuOptions[_local_2];
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local_2 + 1)]._visible = true;
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
        static var MENU_NONE = -100;
        static var MENU_CHOOSE_MODE = 0;
        static var MENU_BELT_AWARD = 300;
        static var MENU_BELT_EARNED = 301;
        static var MENU_FINAL_AWARD = 400;
        static var MENU_FINAL_WELLDONE = 401;
        static var MENU_FINAL_OUTFIT = 402;
        static var MENU_FINAL_ROOM = 403;
		static var MENU_SHOES_EARNED = 500;
		static var MENU_SUIT_EARNED = 501;
		static var MENU_MASK_EARNED = 502;
		static var MENU_HELMET_EARNED = 503;
		static var MENU_SHADOW_FINAL = 504;
        static var BELT_WHITE = 1;
        static var BELT_YELLOW = 2;
        static var BELT_ORANGE = 3;
        static var BELT_GREEN = 4;
        static var BELT_BLUE = 5;
        static var BELT_RED = 6;
        static var BELT_PURPLE = 7;
        static var BELT_BROWN = 8;
        static var BELT_BLACK = 9;
        static var BELTS = [undefined, BELT_WHITE, BELT_YELLOW, BELT_ORANGE, BELT_GREEN, BELT_BLUE, BELT_RED, BELT_PURPLE, BELT_BROWN, BELT_BLACK];
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
        static var ANIM_AWARD_BELT = "belt";
        static var ANIM_AWARD_MASK = "mask";
        static var ANIM_AWARD_HIDEOUT = "hideout";
        var menuData = new Array();
        var currentMenu = MENU_NONE;
        var talking = false;
    }
