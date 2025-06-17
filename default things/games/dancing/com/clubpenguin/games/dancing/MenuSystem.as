
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.MenuSystem
    {
        var movie, gameEngine, keyPressTest;
        function MenuSystem ($parent, $movie) {
            movie = $movie;
            gameEngine = $parent;
            movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_LOADING]._visible = false;
            loadMenu(MENU_WELCOME_INTRO);
        }
        function getCurrentMenu() {
            return(currentMenu);
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
                case MENU_START_SONG : 
                case MENU_START_MULTIPLAYER_SONG : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WALK_OFF);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_WELCOME_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WALK_ON);
                    movie[MOVIE_HOST_COMPERE].nextMenu = MENU_WELCOME;
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_WELCOME : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    switch (gameEngine.allSongsLoaded()) {
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK : 
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_intro"));
                            break;
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR : 
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs_error"));
                            break;
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS : 
                            showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs"));
                            break;
                    }
                    hideMenuOptions();
                    break;
                case MENU_WELCOME_OPTIONS : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    var _local6 = com.clubpenguin.util.LocaleText.getText("menu_welcome_item_multiplayer");
                    if (com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK) {
                        _local6 = "         " + _local6;
                        movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                        movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_MEMBERS_ONLY_ICON);
                    }
                    var _local3 = new Array();
                    _local3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_singleplayer"));
                    _local3.push(_local6);
                    _local3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_howtoplay"));
                    _local3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_quit"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_choice"));
                    showMenuOptions(_local3);
                    break;
                case MENU_SINGLEPLAYER_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble((com.clubpenguin.util.LocaleText.getText("menu_singleplayer_intro") + newline) + gameEngine.getRandomTipText(true));
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_SINGLEPLAYER_SONG : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_song_choice"));
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_PREGAME_CHOOSE_SONG);
                    break;
                case MENU_SINGLEPLAYER_DIFFICULTY : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    var _local2 = new Array();
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_back"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
                    showMenuOptions(_local2);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_SECRET_DIFFICULTY);
                    break;
                case MENU_SINGLEPLAYER_DIFFICULTY_SECRET : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    _local2 = new Array();
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_confirm_secret"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_change"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice_secret"));
                    showMenuOptions(_local2);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_SINGLEPLAYER_PREGAME : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_pregame"));
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_SINGLEPLAYER_POSTGAME_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WALK_ON);
                    movie[MOVIE_HOST_COMPERE].nextMenu = MENU_SINGLEPLAYER_COINSWON;
                    gameEngine.playApplause();
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_SINGLEPLAYER_COINSWON : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(gameEngine.getJudgesOpinion());
                    hideMenuOptions();
                    break;
                case MENU_SINGLEPLAYER_POSTGAME : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    var _local4 = new Array();
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_playagain"));
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_newsong"));
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
                    showMenuOptions(_local4);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_SINGLEPLAYER_POSTGAME_STATS : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(gameEngine.getPostGameStatsSpeechBubble());
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_POSTGAME_STATS);
                    break;
                case MENU_HOW_TO_PLAY_INTRO_WALK : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_ON);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_TALK);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_intro"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_TIMING_ANIM : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_HOWTOPLAY_HITNOTE);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_TIMING : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_timing"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLE_ANIM : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_HOWTOPLAY_TWOATONCE);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLE : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiple"));
                    hideMenuOptions();
                    keyPressTest = [false, false];
                    break;
                case MENU_HOW_TO_PLAY_HOLD_ANIM : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_HOWTOPLAY_HOLDNOTE);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_HOLD : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_hold"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER_ANIM : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_HOWTOPLAY_COMBO);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiplier"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM : 
                case MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM : 
                case MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO : 
                    movie[MOVIE_HOW_TO_PLAY_ANIM].animation.play();
                    break;
                case MENU_HOW_TO_PLAY_OUTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_TALK);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_outro"));
                    hideMenuOptions();
                    break;
                case MENU_HOW_TO_PLAY_OUTRO_WALK : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_HELP_OFF);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_MULTIPLAYER_CONNECTING : 
                case MENU_MULTIPLAYER_JOINING : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                    hideSpeechBubble();
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_MULTIPLAYER_PRE_QUEUE : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(gameEngine.getJoinGameSpeechBubble());
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_MULTIPLAYER_JOIN_GAME : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(gameEngine.getWaitingSpeechBubble());
                    var _local7 = new Array();
                    var _local5 = com.clubpenguin.util.LocaleText.getText("menu_difficulty_change");
                    _local5 = _local5.substring(0, _local5.length - 1);
                    _local7.push((_local5 + " ") + gameEngine.getCurrentDifficulty());
                    _local7.push(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_response_mainmenu"));
                    showMenuOptions(_local7);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_MULTIPLAYER_SERVERFULL : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_serverfull"));
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_MULTIPLAYER_DIFFICULTY : 
                case MENU_MULTIPLAYER_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    _local2 = new Array();
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
                    _local2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_expert"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
                    showMenuOptions(_local2);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    break;
                case MENU_MULTIPLAYER_POSTGAME_INTRO : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WALK_ON);
                    movie[MOVIE_HOST_COMPERE].nextMenu = MENU_MULTIPLAYER_COINSWON;
                    hideSpeechBubble();
                    hideMenuOptions();
                    break;
                case MENU_MULTIPLAYER_COINSWON : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(gameEngine.getMultiplayerCoinsWon());
                    hideMenuOptions();
                    gameEngine.setMultiplayerScoreVisibility(false);
                    gameEngine.hideDancer();
                    break;
                case MENU_MULTIPLAYER_POSTGAME : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_WAIT);
                    movie[MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                    _local4 = new Array();
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_joinqueue"));
                    _local4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
                    showMenuOptions(_local4);
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                    gameEngine.setMultiplayerScoreVisibility(false);
                    break;
                case MENU_MULTIPLAYER_POSTGAME_STATS : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(gameEngine.getPostGameStatsSpeechBubble());
                    hideMenuOptions();
                    movie[MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(ANIM_FRAME_POSTGAME_STATS);
                    gameEngine.setMultiplayerScoreVisibility(true);
                    break;
                case ERROR_CODE_ROOM_FULL : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("error_message_room_full"));
                    hideMenuOptions();
                    break;
                case ERROR_CODE_MULTIPLE_CONNECTIONS : 
                    movie[MOVIE_HOST_COMPERE].gotoAndStop(ANIM_FRAME_TALK);
                    showSpeechBubble(com.clubpenguin.util.LocaleText.getText("error_message_multiple_connections"));
                    hideMenuOptions();
                    break;
                default : 
                    debugTrace("unknown menu id entered: " + currentMenu, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    break;
            }
        }
        function handleClick($buttonID) {
            var _local5 = _global.getCurrentShell();
            var _local4 = _global.getCurrentInterface();
            switch (currentMenu) {
                case MENU_WELCOME_INTRO : 
                    loadMenu(MENU_WELCOME);
                    break;
                case MENU_WELCOME : 
                    switch (gameEngine.allSongsLoaded()) {
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK : 
                            loadMenu(MENU_WELCOME_OPTIONS);
                            break;
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR : 
                            gameEngine.destroy();
                            break;
                        case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS : 
                            break;
                    }
                    break;
                case MENU_WELCOME_OPTIONS : 
                    _global.dls_dance._seenInstructions = false;
                    switch ($buttonID) {
                        case 1 : 
                            _global.dls_dance.setGameType(false);
                            loadMenu(MENU_SINGLEPLAYER_INTRO);
                            break;
                        case 2 : 
                            if ((!com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK) || (gameEngine.isMember())) {
                                _global.dls_dance.setGameType(true);
                                loadMenu(MENU_MULTIPLAYER_INTRO);
                            } else {
                                _local4.showWindow(OOPS_SCREEN_ID_MULTIPLAYER);
                            }
                            break;
                        case 3 : 
                            loadMenu(MENU_HOW_TO_PLAY_INTRO_WALK);
                            break;
                        case 4 : 
                            gameEngine.destroy();
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_SINGLEPLAYER_INTRO : 
                    loadMenu(MENU_SINGLEPLAYER_SONG);
                    break;
                case MENU_SINGLEPLAYER_SONG : 
                    if ($buttonID == 1) {
                        if (((gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FOUR) || (gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FIVE)) || (gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_SIX)) {
                            if ((!com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK) || (gameEngine.isMember())) {
                                loadMenu(MENU_SINGLEPLAYER_DIFFICULTY);
                            } else {
                                _local4.showWindow(OOPS_SCREEN_ID_SONGS);
                            }
                        } else {
                            loadMenu(MENU_SINGLEPLAYER_DIFFICULTY);
                        }
                    }
                    break;
                case MENU_SINGLEPLAYER_DIFFICULTY : 
                    switch ($buttonID) {
                        case 1 : 
                            _global.dls_dance.setSongLevel(0);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                            break;
                        case 2 : 
                            _global.dls_dance.setSongLevel(1);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                            break;
                        case 3 : 
                            _global.dls_dance.setSongLevel(2);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                            break;
                        case 4 : 
                            loadMenu(MENU_WELCOME_OPTIONS);
                            return(undefined);
                        case 5 : 
                            loadMenu(MENU_SINGLEPLAYER_DIFFICULTY_SECRET);
                            return(undefined);
                        default : 
                            return(undefined);
                    }
                    loadMenu(MENU_SINGLEPLAYER_PREGAME);
                    break;
                case MENU_SINGLEPLAYER_DIFFICULTY_SECRET : 
                    switch ($buttonID) {
                        case 1 : 
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                            loadMenu(MENU_SINGLEPLAYER_PREGAME);
                            return(undefined);
                        case 2 : 
                            loadMenu(MENU_SINGLEPLAYER_DIFFICULTY);
                            return(undefined);
                    }
                    break;
                case MENU_SINGLEPLAYER_PREGAME : 
                    loadMenu(MENU_START_SONG);
                    break;
                case MENU_SINGLEPLAYER_COINSWON : 
                    loadMenu(MENU_SINGLEPLAYER_POSTGAME);
                    gameEngine.hideDancer();
                    break;
                case MENU_SINGLEPLAYER_POSTGAME : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_SINGLEPLAYER_POSTGAME_STATS);
                            break;
                        case 2 : 
                            loadMenu(MENU_SINGLEPLAYER_DIFFICULTY);
                            break;
                        case 3 : 
                            loadMenu(MENU_SINGLEPLAYER_SONG);
                            break;
                        case 4 : 
                            loadMenu(MENU_WELCOME_OPTIONS);
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_SINGLEPLAYER_POSTGAME_STATS : 
                    if ($buttonID == 1) {
                        _global.dls_dance.startDancingStats();
                        loadMenu(MENU_SINGLEPLAYER_POSTGAME);
                    }
                    break;
                case MENU_HOW_TO_PLAY_INTRO : 
                case MENU_HOW_TO_PLAY_OUTRO : 
                    _global.dls_dance.startDancingHelp();
                    loadMenu(currentMenu + 1);
                    break;
                case MENU_HOW_TO_PLAY_TIMING_KEYPRESS : 
                    if ($buttonID == 40) {
                        loadMenu(MENU_HOW_TO_PLAY_MULTIPLE_ANIM);
                    }
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS : 
                    if ($buttonID == 37) {
                        keyPressTest[0] = true;
                        if (keyPressTest[1]) {
                            loadMenu(MENU_HOW_TO_PLAY_HOLD_ANIM);
                            break;
                        }
                    }
                    if ($buttonID == 39) {
                        keyPressTest[1] = true;
                        if (keyPressTest[0]) {
                            loadMenu(MENU_HOW_TO_PLAY_HOLD_ANIM);
                            break;
                        }
                    } else {
                        break;
                        if ($buttonID == 40) {
                            loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_ANIM);
                        }
                        break;
                        if ($buttonID == 40) {
                            loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM);
                        }
                        break;
                        if ($buttonID == 37) {
                            loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM);
                        }
                        break;
                        if ($buttonID == 39) {
                            loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO);
                        }
                        break;
                        switch ($buttonID) {
                            case 1 : 
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                                break;
                            case 2 : 
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                                break;
                            case 3 : 
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                                break;
                            case 4 : 
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                                break;
                            default : 
                                return(undefined);
                        }
                        gameEngine.joinMultiplayerServer();
                        gameEngine.setMultiplayerDifficulty();
                        loadMenu(MENU_MULTIPLAYER_CONNECTING);
                        break;
                        if ($buttonID == undefined) {
                            return(undefined);
                        }
                        break;
                        switch ($buttonID) {
                            case 1 : 
                                loadMenu(MENU_MULTIPLAYER_DIFFICULTY);
                                break;
                            case 2 : 
                                gameEngine.leaveMultiplayerServer();
                                loadMenu(MENU_WELCOME_OPTIONS);
                                break;
                            default : 
                                return(undefined);
                        }
                        break;
                        gameEngine.leaveMultiplayerServer();
                        loadMenu(MENU_WELCOME_OPTIONS);
                        break;
                        switch ($buttonID) {
                            case 1 : 
                                _global.dls_dance.setSongLevel(0);
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                                break;
                            case 2 : 
                                _global.dls_dance.setSongLevel(1);
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                                break;
                            case 3 : 
                                _global.dls_dance.setSongLevel(2);
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                                break;
                            case 4 : 
                                _global.dls_dance.setSongLevel(3);
                                gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                                break;
                            default : 
                                return(undefined);
                        }
                        if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING) {
                            loadMenu(MENU_MULTIPLAYER_JOIN_GAME);
                        } else if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                            loadMenu(MENU_MULTIPLAYER_SERVERFULL);
                        } else {
                            loadMenu(MENU_MULTIPLAYER_JOINING);
                        }
                        break;
                        loadMenu(MENU_MULTIPLAYER_POSTGAME);
                        break;
                        switch ($buttonID) {
                            case 1 : 
                                loadMenu(MENU_MULTIPLAYER_POSTGAME_STATS);
                                break;
                            case 2 : 
                                gameEngine.rejoinMultiplayerServer();
                                loadMenu(MENU_MULTIPLAYER_CONNECTING);
                                break;
                            case 3 : 
                                gameEngine.leaveMultiplayerServer();
                                loadMenu(MENU_WELCOME_OPTIONS);
                                break;
                            default : 
                                return(undefined);
                        }
                        break;
                        if ($buttonID == 1) {
                            _global.dls_dance.startDancingStats();
                            loadMenu(MENU_MULTIPLAYER_POSTGAME);
                        }
                        break;
                        loadMenu(MENU_WELCOME_OPTIONS);
                        break;
                    }
                case MENU_HOW_TO_PLAY_HOLD_KEYPRESS : 
                    if ($buttonID == 40) {
                        loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_ANIM);
                    }
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER_DOWN : 
                    if ($buttonID == 40) {
                        loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM);
                    }
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER_LEFT : 
                    if ($buttonID == 37) {
                        loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM);
                    }
                    break;
                case MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT : 
                    if ($buttonID == 39) {
                        loadMenu(MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO);
                    }
                    break;
                case MENU_MULTIPLAYER_INTRO : 
                    switch ($buttonID) {
                        case 1 : 
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                            break;
                        case 2 : 
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                            break;
                        case 3 : 
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                            break;
                        case 4 : 
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                            break;
                        default : 
                            return(undefined);
                    }
                    gameEngine.joinMultiplayerServer();
                    gameEngine.setMultiplayerDifficulty();
                    loadMenu(MENU_MULTIPLAYER_CONNECTING);
                    break;
                case MENU_MULTIPLAYER_PRE_QUEUE : 
                    if ($buttonID == undefined) {
                        return(undefined);
                    }
                    break;
                case MENU_MULTIPLAYER_JOIN_GAME : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_MULTIPLAYER_DIFFICULTY);
                            break;
                        case 2 : 
                            gameEngine.leaveMultiplayerServer();
                            loadMenu(MENU_WELCOME_OPTIONS);
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_MULTIPLAYER_SERVERFULL : 
                    gameEngine.leaveMultiplayerServer();
                    loadMenu(MENU_WELCOME_OPTIONS);
                    break;
                case MENU_MULTIPLAYER_DIFFICULTY : 
                    switch ($buttonID) {
                        case 1 : 
                            _global.dls_dance.setSongLevel(0);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                            break;
                        case 2 : 
                            _global.dls_dance.setSongLevel(1);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                            break;
                        case 3 : 
                            _global.dls_dance.setSongLevel(2);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                            break;
                        case 4 : 
                            _global.dls_dance.setSongLevel(3);
                            gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                            break;
                        default : 
                            return(undefined);
                    }
                    if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING) {
                        loadMenu(MENU_MULTIPLAYER_JOIN_GAME);
                    } else if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                        loadMenu(MENU_MULTIPLAYER_SERVERFULL);
                    } else {
                        loadMenu(MENU_MULTIPLAYER_JOINING);
                    }
                    break;
                case MENU_MULTIPLAYER_COINSWON : 
                    loadMenu(MENU_MULTIPLAYER_POSTGAME);
                    break;
                case MENU_MULTIPLAYER_POSTGAME : 
                    switch ($buttonID) {
                        case 1 : 
                            loadMenu(MENU_MULTIPLAYER_POSTGAME_STATS);
                            break;
                        case 2 : 
                            gameEngine.rejoinMultiplayerServer();
                            loadMenu(MENU_MULTIPLAYER_CONNECTING);
                            break;
                        case 3 : 
                            gameEngine.leaveMultiplayerServer();
                            loadMenu(MENU_WELCOME_OPTIONS);
                            break;
                        default : 
                            return(undefined);
                    }
                    break;
                case MENU_MULTIPLAYER_POSTGAME_STATS : 
                    if ($buttonID == 1) {
                        _global.dls_dance.startDancingStats();
                        loadMenu(MENU_MULTIPLAYER_POSTGAME);
                    }
                    break;
                case ERROR_CODE_ROOM_FULL : 
                case ERROR_CODE_MULTIPLE_CONNECTIONS : 
                    loadMenu(MENU_WELCOME_OPTIONS);
                    break;
            }
        }
        function showSpeechBubble($text) {
            movie.speech.message.text = $text;
            updateSpeechBubble();
            movie[MOVIE_SPEECH_BUBBLE]._visible = true;
            if ((currentMenu >= MENU_HOW_TO_PLAY_INTRO_WALK) && (currentMenu <= MENU_HOW_TO_PLAY_OUTRO_WALK)) {
                movie[MOVIE_SPEECH_BUBBLE]._x = SPEECH_HELPANIM_XPOSITION;
            } else {
                movie[MOVIE_SPEECH_BUBBLE]._x = SPEECH_NORMAL_XPOSITION;
            }
        }
        function hideSpeechBubble() {
            movie[MOVIE_SPEECH_BUBBLE]._visible = false;
        }
        function updateSpeechBubble() {
            var _local5 = 80;
            var _local3 = 24;
            var _local6 = _local3 / 2;
            var _local4 = 5;
            var _local2 = 1;
            while (_local2 <= _local4) {
                if (movie[MOVIE_SPEECH_BUBBLE].message.textHeight < ((_local2 * _local3) + _local6)) {
                    movie[MOVIE_SPEECH_BUBBLE].bubble._height = _local5 + (_local2 * _local3);
                    break;
                }
                _local2++;
            }
        }
        function showMenuOptions($menuOptions) {
            var _local4 = 27;
            var _local5 = 14;
            var _local6 = 3.5;
            movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_BACKGROUND]._height = (($menuOptions.length * _local4) + (($menuOptions.length - 1) * _local6)) + _local5;
            var _local2 = 0;
            while ((_local2++) < 5) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + _local2]._visible = false;
            }
            _local2 = 0;
            while (_local2 < $menuOptions.length) {
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local2 + 1)].label.text = $menuOptions[_local2];
                movie[MOVIE_OPTIONS_MENU][MOVIE_OPTIONS_ITEM + (_local2 + 1)]._visible = true;
                _local2++;
            }
            movie[MOVIE_OPTIONS_MENU]._visible = true;
            talking = false;
        }
        function hideMenuOptions() {
            movie[MOVIE_OPTIONS_MENU]._visible = false;
            talking = true;
        }
        function isTalking() {
            return(talking);
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(MenuSystem) " + message, priority);
            }
        }
        static var OOPS_SCREEN_ID_MULTIPLAYER = "oops_game_dance";
        static var OOPS_SCREEN_ID_SONGS = "oops_game_dance_songs";
        static var MENU_START_MULTIPLAYER_SONG = -300;
        static var MENU_START_SONG = -200;
        static var MENU_NONE = -100;
        static var MENU_WELCOME_INTRO = 100;
        static var MENU_WELCOME = 101;
        static var MENU_WELCOME_OPTIONS = 102;
        static var MENU_SINGLEPLAYER_INTRO = 103;
        static var MENU_SINGLEPLAYER_SONG = 104;
        static var MENU_SINGLEPLAYER_DIFFICULTY = 105;
        static var MENU_SINGLEPLAYER_PREGAME = 106;
        static var MENU_SINGLEPLAYER_POSTGAME_INTRO = 107;
        static var MENU_SINGLEPLAYER_COINSWON = 108;
        static var MENU_SINGLEPLAYER_POSTGAME = 109;
        static var MENU_SINGLEPLAYER_POSTGAME_STATS = 110;
        static var MENU_SINGLEPLAYER_DIFFICULTY_SECRET = 111;
        static var MENU_HOW_TO_PLAY_INTRO_WALK = 200;
        static var MENU_HOW_TO_PLAY_INTRO = 201;
        static var MENU_HOW_TO_PLAY_TIMING_ANIM = 202;
        static var MENU_HOW_TO_PLAY_TIMING = 203;
        static var MENU_HOW_TO_PLAY_TIMING_KEYPRESS = 204;
        static var MENU_HOW_TO_PLAY_MULTIPLE_ANIM = 205;
        static var MENU_HOW_TO_PLAY_MULTIPLE = 206;
        static var MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS = 207;
        static var MENU_HOW_TO_PLAY_HOLD_ANIM = 208;
        static var MENU_HOW_TO_PLAY_HOLD = 209;
        static var MENU_HOW_TO_PLAY_HOLD_KEYPRESS = 210;
        static var MENU_HOW_TO_PLAY_HOLD_OUTRO = 211;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_ANIM = 212;
        static var MENU_HOW_TO_PLAY_MULTIPLIER = 213;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_DOWN = 214;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM = 215;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT = 216;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM = 217;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT = 218;
        static var MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO = 219;
        static var MENU_HOW_TO_PLAY_OUTRO = 220;
        static var MENU_HOW_TO_PLAY_OUTRO_WALK = 221;
        static var MENU_MULTIPLAYER_CONNECTING = 300;
        static var MENU_MULTIPLAYER_PRE_QUEUE = 301;
        static var MENU_MULTIPLAYER_JOINING = 302;
        static var MENU_MULTIPLAYER_JOIN_GAME = 303;
        static var MENU_MULTIPLAYER_SERVERFULL = 304;
        static var MENU_MULTIPLAYER_DIFFICULTY = 305;
        static var MENU_MULTIPLAYER_POSTGAME_INTRO = 306;
        static var MENU_MULTIPLAYER_COINSWON = 307;
        static var MENU_MULTIPLAYER_POSTGAME = 308;
        static var MENU_MULTIPLAYER_POSTGAME_STATS = 309;
        static var MENU_MULTIPLAYER_INTRO = 310;
        static var ERROR_CODE_ROOM_FULL = 401;
        static var ERROR_CODE_MULTIPLE_CONNECTIONS = 402;
        static var MOVIE_HOST_COMPERE = "host";
        static var MOVIE_SPEECH_BUBBLE = "speech";
        static var MOVIE_OPTIONS_MENU = "options";
        static var MOVIE_OPTIONS_BACKGROUND = "background";
        static var MOVIE_OPTIONS_ITEM = "item";
        static var MOVIE_OPTIONS_LOADING = "loading";
        static var MOVIE_HOW_TO_PLAY_ANIM = "howtoplay";
        static var ANIM_FRAME_WALK_ON = "enter";
        static var ANIM_FRAME_TALK = "talk";
        static var ANIM_FRAME_WAIT = "wait";
        static var ANIM_FRAME_WALK_OFF = "exit";
        static var ANIM_FRAME_HELP_ON = "help_on";
        static var ANIM_FRAME_HELP_OFF = "help_off";
        static var ANIM_FRAME_HELP_TALK = "help_talk";
        static var ANIM_FRAME_HELP_WAIT = "help_wait";
        static var ANIM_FRAME_HOWTOPLAY_HITNOTE = "howtoplay_hitnote";
        static var ANIM_FRAME_HOWTOPLAY_TWOATONCE = "howtoplay_twoatonce";
        static var ANIM_FRAME_HOWTOPLAY_HOLDNOTE = "howtoplay_holdnote";
        static var ANIM_FRAME_HOWTOPLAY_COMBO = "howtoplay_combo";
        static var ANIM_FRAME_SECRET_DIFFICULTY = "secret_difficulty";
        static var ANIM_FRAME_POSTGAME_STATS = "postgame_stats";
        static var ANIM_FRAME_PREGAME_CHOOSE_SONG = "pregame_song";
        static var ANIM_FRAME_MEMBERS_ONLY_ICON = "members_only";
        static var SPEECH_NORMAL_XPOSITION = 72.5;
        static var SPEECH_HELPANIM_XPOSITION = 180;
        var menuData = new Array();
        var currentMenu = MENU_NONE;
        var talking = false;
    }
