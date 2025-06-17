
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.GameEngine extends com.clubpenguin.games.generic.GenericGameEngine
    {
        static var instance, SHELL;
        var gameFilename, isMember, musicPlayer, keyListener, timeOnScreenMillis, animationEngine, movie, noteManager, netClient, menuSystem, isPlayingGame, isDancing, statsNoteBreakdown, soundData, cheerSound, startTimeMillis, currentTimeMillis, elapsedTimeMillis, keyPresses, multiplayerScores;
        function GameEngine ($movieClip, $gameFilename) {
            super($movieClip);
            if (instance != undefined) {
                debugTrace("there is already an active instance of GameEngine. overwriting it!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            }
            SHELL = _global.getCurrentShell();
            instance = this;
            gameFilename = $gameFilename;
            qualityFrameTicks = 0;
            qualityFrameTicksLast = 0;
            setInterval(this, "updateQualityMode", 1000);
        }
        function init() {
            debugTrace("init function started");
            _global.dls_dance.startDancingContest();
            loadedSongs = 3;
            if (MEMBER_ONLY_CHECK && (isMember())) {
                loadedSongs = 0;
            }
            musicPlayer = new Array();
            var _local5 = gameFilename.split("/");
            var _local4 = "";
            var _local3 = 0;
            while (_local3 < (_local5.length - 1)) {
                _local4 = _local4 + (_local5[_local3] + "/");
                _local3++;
            }
            debugTrace(("game root directory is '" + _local4) + "'");
            loadSong(_local4 + SONG_ONE_DATA, SONG_ONE);
            loadSong(_local4 + SONG_TWO_DATA, SONG_TWO);
            loadSong(_local4 + SONG_THREE_DATA, SONG_THREE);
            if (MEMBER_ONLY_CHECK && (isMember())) {
                loadSong(_local4 + SONG_FOUR_DATA, SONG_FOUR);
                loadSong(_local4 + SONG_FIVE_DATA, SONG_FIVE);
                loadSong(_local4 + SONG_SIX_DATA, SONG_SIX);
            }
            initApplause();
            keyListener = new Object();
            keyListener.onKeyDown = com.clubpenguin.util.Delegate.create(this, handleKeyDown);
            keyListener.onKeyUp = com.clubpenguin.util.Delegate.create(this, handleKeyUp);
            Key.addListener(keyListener);
            timeOnScreenMillis = new Array();
            timeOnScreenMillis[DIFFICULTY_EASY] = 4000;
            timeOnScreenMillis[DIFFICULTY_MEDIUM] = 2500;
            timeOnScreenMillis[DIFFICULTY_HARD] = 1750;
            timeOnScreenMillis[DIFFICULTY_EXPERT] = 1500;
            animationEngine = new com.clubpenguin.games.dancing.AnimationEngine(this, movie);
            noteManager = new com.clubpenguin.games.dancing.NoteManager(movie[com.clubpenguin.games.dancing.AnimationEngine.ARROWS_MOVIECLIP]);
            netClient = new com.clubpenguin.games.dancing.DanceNetClient(this);
            menuSystem = new com.clubpenguin.games.dancing.MenuSystem(this, movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP]);
            currentDifficulty = DIFFICULTY_MEDIUM;
            isPlayingGame = false;
            isDancing = false;
        }
        function destroy() {
            _global.dls_dance.stopDancingContest();
            leaveMultiplayerServer();
            Key.removeListener(keyListener);
            keyListener = undefined;
            var _local5 = _global.getCurrentEngine();
            _local5.sendGameOver(totalScore);
            var _local4 = ((((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            var _local3 = Math.round((statsNotesHit / _local4) * 1000) / 10;
            _global.dls_dance.sendLearnerScore(Math.round(_local3), true);
            _global.dls_dance.sendGameScore(currentScore, Math.round(_local3), true);
            totalScore = 0;
        }
        function loadSong($songLocation, $songID) {
            var _local2 = new Object();
            var _local3 = new MovieClipLoader();
            musicPlayer[$songID] = movie.createEmptyMovieClip("songData" + $songID, movie.getNextHighestDepth());
            _local2.onLoadInit = com.clubpenguin.util.Delegate.create(this, handleSongLoadComplete);
            _local2.onLoadError = com.clubpenguin.util.Delegate.create(this, handleSongLoadError);
            _local3.addListener(_local2);
            _local3.loadClip($songLocation, musicPlayer[$songID]);
        }
        function handleSongLoadComplete() {
            if (loadedSongs < 0) {
                return(undefined);
            }
            loadedSongs++;
            if (allSongsLoaded() == SONG_LOAD_OK) {
                if (getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO) {
                    menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
                }
            }
        }
        function handleSongLoadError() {
            loadedSongs = -1;
            if (getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO) {
                menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
            }
        }
        function handleSoundComplete() {
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                endSong();
            }
        }
        function allSongsLoaded() {
            if (loadedSongs < 0) {
                return(SONG_LOAD_ERROR);
            }
            if (loadedSongs >= TOTAL_SONGS) {
                return(SONG_LOAD_OK);
            }
            return(SONG_LOAD_IN_PROGRESS);
        }
        function initApplause() {
            soundData = movie.createEmptyMovieClip("soundData", 100);
            cheerSound = new Sound(soundData);
            cheerSound.attachSound("applause");
            cheerSound.setVolume(33);
        }
        function playApplause() {
            cheerSound.start();
        }
        function setDifficulty($difficulty) {
            currentDifficulty = $difficulty;
            if (netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                setMultiplayerDifficulty();
            }
        }
        function setSong($song) {
            currentSong = $song;
            _global.dls_dance.setSong($song);
        }
        function startTimer() {
            startTimeMillis = getTimer();
            currentTimeMillis = startTimeMillis;
            elapsedTimeMillis = 0;
        }
        function startSong() {
            _global.dls_dance.startSong();
            if ((netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) && (netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)) {
                debugTrace("startSong called when in an unknown net state: " + netClient.currentState);
                return(undefined);
            }
            if (isPlayingGame) {
                debugTrace("startSong called when song already started!");
                return(undefined);
            }
            noteManager.destroy();
            var _local5;
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                var _local3 = com.clubpenguin.games.dancing.data.SongData.getSongData(currentSong, currentDifficulty);
                noteManager.init(_local3[0], _local3[1], _local3[2], timeOnScreenMillis[currentDifficulty]);
                _local5 = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(currentSong) / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
            } else {
                noteManager.init(netClient.songData[0], netClient.songData[1], netClient.songData[2], timeOnScreenMillis[currentDifficulty]);
                _local5 = netClient.millisPerBar / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
            }
            keyPresses = new Array();
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME) {
                netClient.keyPressIDs = new Array();
            }
            animationEngine.startSong(_local5);
            startTimer();
            var _local6 = netClient.millisPerBar;
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                _local6 = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(currentSong);
            }
            var _local4 = _local6 / 4;
            if (currentSong == SONG_SIX) {
                startTimeMillis = startTimeMillis + (_local4 / 24);
            } else if (currentSong == SONG_FOUR) {
                startTimeMillis = startTimeMillis + (_local4 / 16);
            } else if (currentSong == SONG_FIVE) {
                startTimeMillis = startTimeMillis + (_local4 / 16);
            }
            currentRating = MAX_RATING / 2;
            consecutiveNotes = 0;
            currentMultiplier = 1;
            currentScore = 0;
            statsLongestChain = 0;
            statsNotesHit = 0;
            statsNoteBreakdown = [0, 0, 0, 0, 0, 0];
            statsTotalNotes = _local3[0].length;
            if (SHELL == undefined) {
                SHELL = _global.getCurrentShell();
            }
            SHELL.stopMusic();
            musicPlayer[currentSong].playSound();
            handleScoreUpdate(Number.MAX_VALUE);
            isPlayingGame = true;
            isDancing = true;
        }
        function endSong() {
            debugTrace("song ends");
            totalScore = totalScore + getCoinsWon(currentScore);
            if (SHELL == undefined) {
                SHELL = _global.getCurrentShell();
            }
            SHELL.startMusicById(MUSIC_ID_NIGHTCLUB);
            playApplause();
            animationEngine.endSong();
            noteManager.hide();
            musicPlayer.stopSequence("music");
            var _local3;
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED) {
                _local3 = com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_INTRO;
            } else {
                _local3 = com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_INTRO;
            }
            menuSystem.loadMenu(_local3);
            isPlayingGame = false;
        }
        function update() {
            debugTrace("update function started", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            currentTimeMillis = getTimer();
            elapsedTimeMillis = currentTimeMillis - startTimeMillis;
            debugTrace("elapsed time = " + elapsedTimeMillis, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            qualityFrameTicks++;
            if (isDancing) {
                if (isPlayingGame) {
                    var _local3 = noteManager.update(elapsedTimeMillis);
                    if (_local3.length > 0) {
                        debugTrace(_local3.length + " notes missed", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                        var _local2 = 0;
                        while (_local2 < _local3.length) {
                            handleScoreUpdate(com.clubpenguin.games.dancing.Note.RESULT_MISS);
                            _local2++;
                        }
                    }
                    if (elapsedTimeMillis > com.clubpenguin.games.dancing.data.SongData.getSongLengthMillis(currentSong)) {
                        endSong();
                    }
                }
                var _local4 = Math.floor(currentRating / (MAX_RATING / 3));
                animationEngine.updateDancer(_local4);
                animationEngine.updateBackground();
                if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME) {
                    netClient.updateKeyPresses(keyPresses);
                }
            } else {
                updateMenus();
            }
            animationEngine.updateDancefloor();
            animationEngine.updateHUD();
        }
        function updateMenus() {
            if ((menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME) || (menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE)) {
                startTimeMillis = currentTimeMillis;
                netClient.timeToNextSong = netClient.timeToNextSong - elapsedTimeMillis;
                loadMenu(menuSystem.getCurrentMenu());
            }
            if ((menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY) || (menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME)) {
                if ((netClient.timeToNextSong <= 0) && (menuSystem.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG)) {
                    loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
                }
            }
        }
        function handleScoreUpdate($noteResult) {
            var _local3 = false;
            var _local2 = 0;
            switch ($noteResult) {
                case com.clubpenguin.games.dancing.Note.RESULT_PERFECT : 
                    _local2 = 10;
                    currentRating = currentRating + 1;
                    consecutiveNotes++;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GREAT : 
                    _local2 = 5;
                    currentRating = currentRating + 1;
                    consecutiveNotes++;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GOOD : 
                    _local2 = 2;
                    consecutiveNotes++;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_ALMOST : 
                    if (consecutiveNotes > 50) {
                        _local3 = true;
                    }
                    _local2 = 1;
                    currentRating = currentRating - 2;
                    consecutiveNotes = 0;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_MISS : 
                    if (consecutiveNotes > 50) {
                        _local3 = true;
                    }
                    _local2 = 0;
                    currentRating = currentRating - 5;
                    consecutiveNotes = 0;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_BOO : 
                    if (consecutiveNotes > 50) {
                        _local3 = true;
                    }
                    _local2 = 0;
                    currentRating = currentRating - 5;
                    consecutiveNotes = 0;
                    break;
                default : 
                    debugTrace(("incorrect note result " + $noteResult) + " in handleScoreUpdate", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                    return(undefined);
            }
            statsNoteBreakdown[$noteResult]++;
            if (consecutiveNotes > statsLongestChain) {
                statsLongestChain = consecutiveNotes;
            }
            if (consecutiveNotes > 0) {
                statsNotesHit++;
            }
            if (currentRating >= MAX_RATING) {
                currentRating = MAX_RATING - 1;
            }
            if (currentRating < 0) {
                currentRating = 0;
            }
            debugTrace((("current rating updated to " + currentRating) + ", absolute rating is ") + Math.floor(currentRating / (MAX_RATING / 3)), com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            switch (Math.floor(consecutiveNotes / MULTIPLIER_LIMIT)) {
                case 0 : 
                    currentMultiplier = 1;
                    break;
                case 1 : 
                    currentMultiplier = 2;
                    break;
                case 2 : 
                    currentMultiplier = 3;
                    break;
                case 3 : 
                    currentMultiplier = 4;
                    break;
                case 4 : 
                    currentMultiplier = 5;
                    break;
                case 5 : 
                    currentMultiplier = 6;
                    break;
                case 6 : 
                    currentMultiplier = 8;
                    break;
                case 7 : 
                    currentMultiplier = 10;
                    break;
                default : 
                    currentMultiplier = 10;
                    break;
            }
            _local2 = _local2 * currentMultiplier;
            if (currentDifficulty == DIFFICULTY_EXPERT) {
                _local2 = _local2 * 2;
            }
            currentScore = currentScore + _local2;
            var _local5 = Math.floor(currentRating / (MAX_RATING / 3));
            animationEngine.updateNoteCombo($noteResult, consecutiveNotes, _local3, currentScore, _local5);
        }
        function handleKeyDown() {
            if (isPlayingGame) {
                var _local4;
                var _local3 = com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN;
                var _local2;
				if ((Key.getCode() == 37 || Key.getCode() == 68) && (!KEY_PRESSED_LEFT)) { 
					_local2 = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
					KEY_PRESSED_LEFT = true;
				}
				if ((Key.getCode() == 39 || Key.getCode() == 75) && (!KEY_PRESSED_RIGHT)) { 
					_local2 = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
					KEY_PRESSED_RIGHT = true;
				}
				if ((Key.getCode() == 38 || Key.getCode() == 70) && (!KEY_PRESSED_UP)) { 
					_local2 = com.clubpenguin.games.dancing.Note.TYPE_UP;
					KEY_PRESSED_UP = true;
				}
				if ((Key.getCode() == 40 || Key.getCode() == 74) && (!KEY_PRESSED_DOWN)) { 
					_local2 = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
					KEY_PRESSED_DOWN = true;
				}
                debugTrace("keyDown event, noteType = " + _local2);
                _local4 = noteManager.getClosestValidNote(_local2, elapsedTimeMillis);
                _local3 = noteManager.handleNotePress(_local2, elapsedTimeMillis, _local4);
                if (_local3 != com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN) {
                    debugTrace((("note was pressed at " + elapsedTimeMillis) + ", the result is ") + _local3, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                    var _local6 = keyPresses.push(_local4);
                    if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME) {
                        netClient.keyPressIDs.push(_local6 - 1);
                    }
                    handleScoreUpdate(_local3);
                }
            } else {
                switch (menuSystem.getCurrentMenu()) {
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_KEYPRESS : 
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS : 
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_KEYPRESS : 
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_DOWN : 
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT : 
                    case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT : 
                        var _local5 = Key.getCode();
                        switch (_local5) {
                            case 37 : 
                                menuSystem.handleClick(37);
                                break;
                            case 39 : 
                                menuSystem.handleClick(39);
                                break;
                            case 38 : 
                                menuSystem.handleClick(38);
                                break;
                            case 40 : 
                                menuSystem.handleClick(40);
                                break;
							case 68: 
                                menuSystem.handleClick(37);
                                break;
                            case 75: 
                                menuSystem.handleClick(39);
                                break;
                            case 70: 
                                menuSystem.handleClick(38);
                                break;
                            case 74: 
                                menuSystem.handleClick(40);
                                break;
                        }
                        break;
                }
            }
        }
        function handleKeyUp() {
            if (isPlayingGame) {
                var _local4;
                if ((Key.getCode() == 37 || Key.getCode() == 68) && (KEY_PRESSED_LEFT)) {
                    _local4 = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
                    KEY_PRESSED_LEFT = false;
                }
                if ((Key.getCode() == 39 || Key.getCode() == 75) && (KEY_PRESSED_RIGHT)) {
                    _local4 = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
                    KEY_PRESSED_RIGHT = false;
                }
                if ((Key.getCode() == 38 || Key.getCode() == 70) && (KEY_PRESSED_UP)) {
                    _local4 = com.clubpenguin.games.dancing.Note.TYPE_UP;
                    KEY_PRESSED_UP = false;
                }
                if ((Key.getCode() == 40 || Key.getCode() == 74) && (KEY_PRESSED_DOWN)) {
                    _local4 = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
                    KEY_PRESSED_DOWN = false;
                }
                debugTrace("keyUp event, noteType = " + _local4);
                if (_local4 != undefined) {
                    var _local2 = keyPresses.length - 1;
                    while (_local2 > 0) {
                        if (keyPresses[_local2].noteType == _local4) {
                            var _local3 = false;
                            if (keyPresses[_local2].autoReleased) {
                                _local3 = true;
                                keyPresses[_local2].autoReleased = false;
                            }
                            if ((keyPresses[_local2].getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED) && (keyPresses[_local2].noteDuration > 0)) {
                                _local3 = true;
                            }
                            if (_local3) {
                                keyPresses[_local2].handleNoteReleaseEvent(elapsedTimeMillis);
                                handleHoldBonus(keyPresses[_local2].noteType, keyPresses[_local2].getNotePressResult(), keyPresses[_local2].getNoteHoldLength());
                                debugTrace((("note was released at " + elapsedTimeMillis) + " with length ") + keyPresses[_local2].getNoteHoldLength(), com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                                break;
                            }
                        }
                        _local2--;
                    }
                }
            }
        }
        function handleHoldBonus($noteType, $noteResult, $noteLength) {
            if ($noteLength <= 0) {
                return(undefined);
            }
            var _local2 = 0;
            switch ($noteResult) {
                case com.clubpenguin.games.dancing.Note.RESULT_PERFECT : 
                    _local2 = 10;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GREAT : 
                    _local2 = 5;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GOOD : 
                    _local2 = 2;
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_ALMOST : 
                    _local2 = 1;
                    break;
                default : 
                    return(undefined);
            }
            _local2 = _local2 * currentMultiplier;
            _local2 = _local2 * ($noteLength / 500);
            _local2 = Math.round(_local2);
            if (currentDifficulty == DIFFICULTY_EXPERT) {
                _local2 = _local2 * 2;
            }
            if (_local2 > 0) {
                currentScore = currentScore + _local2;
                animationEngine.updateNoteBonus($noteType, _local2, currentScore);
            }
        }
        function getPostGameStatsSpeechBubble() {
            var _local2 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating") + newline;
            var _local3 = ((((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            var _local4 = (Math.round((statsNotesHit / _local3) * 1000) / 10) + "%";
            _local2 = _local2 + (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame_score", [currentScore]) + newline);
            _local2 = _local2 + (com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_note_percent", [_local4]) + newline);
            _local2 = _local2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_biggest_combo", [statsLongestChain + ""]);
            return(_local2);
        }
        function getNoteHitPercentage() {
            var _local2 = ((((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            var _local3 = Math.round((statsNotesHit / _local2) * 1000) / 10;
            return(_local3);
        }
        function getPostGameStatsBreakdown() {
            var _local5 = ((((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            var _local4 = Math.round((statsNotesHit / _local5) * 1000) / 10;
            var _local2 = new Array();
            _local2[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] = (com.clubpenguin.util.LocaleText.getText("game_note_perfect") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT];
            _local2[com.clubpenguin.games.dancing.Note.RESULT_GREAT] = (com.clubpenguin.util.LocaleText.getText("game_note_great") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT];
            _local2[com.clubpenguin.games.dancing.Note.RESULT_GOOD] = (com.clubpenguin.util.LocaleText.getText("game_note_good") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD];
            _local2[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] = (com.clubpenguin.util.LocaleText.getText("game_note_almost") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST];
            _local2[com.clubpenguin.games.dancing.Note.RESULT_BOO] = (com.clubpenguin.util.LocaleText.getText("game_note_boo") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO];
            _local2[com.clubpenguin.games.dancing.Note.RESULT_MISS] = (com.clubpenguin.util.LocaleText.getText("game_note_miss") + ": ") + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            if (_local4 < 50) {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_D") + newline;
            } else if (_local4 < 75) {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_C") + newline;
            } else if (_local4 < 100) {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_B") + newline;
            } else if (statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] == statsTotalNotes) {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AAA") + newline;
            } else if ((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) == statsTotalNotes) {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AA") + newline;
            } else {
                _local2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_A") + newline;
            }
            for (var _local3 in _local2) {
                _local2[_local3] = _local2[_local3].toUpperCase();
            }
            return(_local2);
        }
        function getCoinsWon($totalScore) {
            var _local2 = currentScore;
            if ($totalScore != undefined) {
                _local2 = $totalScore;
            }
            var _local3 = 0;
            if (_local2 <= 10000) {
                _local3 = Math.round(_local2 / 25);
            } else {
                _local3 = 400 + Math.round((_local2 - 10000) / 100);
            }
            return(_local3);
        }
        function getJudgesOpinion() {
            var _local3 = "";
            var _local4 = "";
            var _local6 = ((((statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO]) + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
            var _local5 = Math.round((statsNotesHit / _local6) * 1000) / 10;
            _global.dls_dance.sendLearnerScore(Math.round(_local5), false);
            _global.dls_dance.sendGameScore(currentScore, Math.round(_local5), false);
            if (_local5 < 66) {
                _local3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_bad");
            } else if (_local5 < 85) {
                _local3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_OK");
            } else if (_local5 < 95) {
                _local3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_great");
                if ((currentDifficulty != DIFFICULTY_EXPERT) && (currentDifficulty != DIFFICULTY_HARD)) {
                    _local4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
                }
            } else {
                _local3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_awesome");
                if (currentDifficulty == DIFFICULTY_HARD) {
                    _local4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_hard");
                } else if (currentDifficulty == DIFFICULTY_EXPERT) {
                    _local4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_expert");
                } else {
                    _local4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
                }
            }
            _local3 = _local3 + ((" " + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_coinswon", [getCoinsWon()])) + _local4);
            return(_local3);
        }
        function handleButtonClick($menuOption) {
            menuSystem.handleClick($menuOption);
        }
        function loadMenu($menu) {
            menuSystem.loadMenu($menu);
        }
        function getCurrentMenu() {
            return(menuSystem.getCurrentMenu());
        }
        function updateQualityMode() {
            if ((!isPlayingGame) || (!AUTO_QUALITY_MODE)) {
                return(undefined);
            }
            var _local4 = qualityFrameTicks - qualityFrameTicksLast;
            var _local3 = _local4;
            var _local2 = 1;
            while (_local2 < averageFPS.length) {
                averageFPS[_local2] = averageFPS[_local2 - 1];
                _local3 = _local3 + averageFPS[_local2];
                _local2++;
            }
            averageFPS[0] = _local4;
            _local3 = _local3 / averageFPS.length;
            debugTrace((("fps: " + _local4) + ", average: ") + _local3);
            if (_local3 < LOW_FPS_LIMIT) {
                setQualityMode(com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM);
                movie.qualityBtn.gotoAndStop("fadeIn");
            }
            qualityFrameTicksLast = qualityFrameTicks;
        }
        function setQualityMode($quality) {
            animationEngine.setQualityMode($quality);
        }
        function getQualityMode() {
            return(animationEngine.getQualityMode());
        }
        function hideDancer() {
            animationEngine.hideDancer();
        }
        function handleSongSelect($direction) {
            if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_LEFT) {
                currentSong--;
                if (currentSong < 0) {
                    currentSong = TOTAL_SONGS - 1;
                }
            } else if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_RIGHT) {
                currentSong++;
                if (currentSong >= TOTAL_SONGS) {
                    currentSong = 0;
                }
            }
            setSong(currentSong);
            animationEngine.handleSongSelect($direction);
        }
        function getCurrentDifficulty() {
            switch (currentDifficulty) {
                case DIFFICULTY_EASY : 
                    return(com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_easy"));
                case DIFFICULTY_MEDIUM : 
                    return(com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_medium"));
                case DIFFICULTY_HARD : 
                    return(com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_hard"));
                case DIFFICULTY_EXPERT : 
                    return(com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_expert"));
            }
        }
        function getRandomTipText($random) {
            var _local2 = ["menu_tip_multiplier", "menu_tip_longnotes", "menu_tip_dances", "menu_tip_lights", "menu_tip_multiplier_light", "menu_tip_practice", "menu_tip_expert_mode", "menu_tip_note_combos"];
            if ($random || (randomTip == undefined)) {
                randomTip = Math.floor(Math.random() * _local2.length);
            }
            return(com.clubpenguin.util.LocaleText.getText(_local2[randomTip]));
        }
        function joinMultiplayerServer() {
            netClient.init(this);
            netClient.sendGetGameMessage();
        }
        function rejoinMultiplayerServer() {
            netClient.sendGetGameAgainMessage();
        }
        function joinMultiplayerGame() {
            netClient.sendJoinGameMessage();
            setMultiplayerDifficulty();
        }
        function setMultiplayerDifficulty() {
            netClient.sendDifficultyLevelMessage(currentDifficulty);
        }
        function leaveMultiplayerServer() {
            netClient.sendAbortGameMessage();
            netClient.destroy();
        }
        function getNetClientState() {
            return(netClient.currentState);
        }
        function getTimeToNextSong() {
            return(netClient.timeToNextSong);
        }
        function updateMultiplayerScores(playerScores) {
            if (playerScores != null) {
                multiplayerScores = playerScores;
            }
            animationEngine.updateMultiplayerScores(playerScores);
        }
        function setMultiplayerScoreVisibility($visible) {
            animationEngine.setMultiplayerScoreVisibility($visible);
        }
        function getJoinGameSpeechBubble() {
            var _local2 = "";
            var _local3 = formatTimeApproximate(netClient.timeToNextSong);
            _local2 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_inprogress") + " ";
            _local2 = _local2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_progress", [_local3]);
            return(_local2);
        }
        function getWaitingSpeechBubble() {
            var _local2 = "";
            var _local3 = Math.round(netClient.timeToNextSong / 1000);
            var _local4 = formatTimeApproximate(netClient.timeToNextSong);
            var _local5 = Math.round(_local3 / 10);
            if ((_local3 < 32) || ((_local5 % 2) == 0)) {
                _local2 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_joingame") + " ";
                _local2 = _local2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting", [netClient.songName, _local4]);
                randomTip = undefined;
            } else {
                _local2 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting", [netClient.songName, _local4]);
                _local2 = _local2 + (" " + getRandomTipText(false));
            }
            return(_local2);
        }
        function getMultiplayerCoinsWon() {
            var _local6;
            var _local7;
            var _local4;
            if (multiplayerScores != null) {
                if (SHELL == undefined) {
                    SHELL = _global.getCurrentShell();
                }
                var _local3 = SHELL.getMyPlayerNickname();
                if (multiplayerScores[0].name == _local3) {
                    _local7 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_postgame_you");
                    _local4 = "";
                } else {
                    _local7 = multiplayerScores[0].name;
                    for (var _local5 in multiplayerScores) {
                        if (multiplayerScores[_local5].name == _local3) {
                            _local4 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame_score", [multiplayerScores[_local5].score]);
                            break;
                        }
                    }
                }
                _local6 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame", [_local7, multiplayerScores[0].score]);
                _local6 = _local6 + (" " + _local4);
            } else {
                _local6 = getJudgesOpinion();
            }
            return(_local6);
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(GameEngine) " + message, priority);
            }
        }
        function formatTime($timeInSeconds) {
            var _local1 = "";
            var _local3 = Math.floor($timeInSeconds / 60);
            var _local2 = $timeInSeconds % 60;
            _local1 = ((_local2 < 10) ? ("0" + _local2) : (_local2));
            if (_local3 > 0) {
                _local1 = (_local3 + ":") + _local1;
            }
            return(_local1);
        }
        function formatTimeApproximate($timeInMillis) {
            var _local5 = 5000;
            var _local3 = 30000;
            var _local2 = 60000;
            var _local4 = 2 * _local2;
            if ($timeInMillis <= _local5) {
                return(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_waiting_now"));
            } else if ($timeInMillis >= (_local4 + _local3)) {
                return(com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["2\u00BD"]));
            } else if ($timeInMillis >= _local4) {
                return(com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["2"]));
            } else if ($timeInMillis >= (_local2 + _local3)) {
                return(com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["1\u00BD"]));
            } else if ($timeInMillis >= _local2) {
                return(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_waiting_one_minute"));
            } else {
                var _local6 = Math.round($timeInMillis / 1000);
                return(com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_secs", [_local6]));
            }
        }
        static var MEMBER_ONLY_CHECK = true;
        static var DIFFICULTY_EASY = 0;
        static var DIFFICULTY_MEDIUM = 1;
        static var DIFFICULTY_HARD = 2;
        static var DIFFICULTY_EXPERT = 3;
        static var SPECIAL_NONE = 0;
        static var SPECIAL_RIVERDANCE = 1;
        static var SPECIAL_WORM = 2;
        static var SPECIAL_BREAKDANCE = 3;
        static var SPECIAL_PUFFLESPIN = 4;
        static var SONG_ONE = 0;
        static var SONG_TWO = 1;
        static var SONG_THREE = 2;
        static var SONG_FOUR = 3;
        static var SONG_FIVE = 4;
        static var SONG_SIX = 5;
        static var SONG_ONE_DATA = "songs/songData1.swf";
        static var SONG_TWO_DATA = "songs/songData2.swf";
        static var SONG_THREE_DATA = "songs/songData3.swf";
        static var SONG_FOUR_DATA = "songs/songData4.swf";
        static var SONG_FIVE_DATA = "songs/songData5.swf";
        static var SONG_SIX_DATA = "songs/songData6.swf";
        static var TOTAL_SONGS = 6;
        static var SONG_LOAD_OK = 0;
        static var SONG_LOAD_ERROR = 1;
        static var SONG_LOAD_IN_PROGRESS = 2;
        static var ERROR_CODE_ROOM_FULL = 210;
        static var ERROR_CODE_MULTIPLE_CONNECTIONS = 120;
        static var KEY_PRESSED_LEFT = false;
        static var KEY_PRESSED_RIGHT = false;
        static var KEY_PRESSED_UP = false;
        static var KEY_PRESSED_DOWN = false;
        static var LOW_FPS_LIMIT = 8;
        static var MULTIPLIER_LIMIT = 10;
        static var MAX_RATING = 30;
        static var AUTO_QUALITY_MODE = true;
        static var MUSIC_ID_NIGHTCLUB = 5;
        static var MUSIC_ID_LOUNGE = 6;
        var currentRating = 0;
        var consecutiveNotes = 0;
        var currentMultiplier = 1;
        var currentScore = 0;
        var totalScore = 0;
        var qualityFrameTicks = 0;
        var qualityFrameTicksLast = 0;
        var averageFPS = [com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS];
        var statsLongestChain = 0;
        var statsNotesHit = 0;
        var statsTotalNotes = 0;
        var currentSong = 1;
        var currentDifficulty = 1;
        var randomTip = 1;
        var loadedSongs = 0;
        var hasPurplePuffle = false;
    }
