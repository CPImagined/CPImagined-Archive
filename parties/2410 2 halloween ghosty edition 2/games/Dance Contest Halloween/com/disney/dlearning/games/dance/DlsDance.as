﻿
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.disney.dlearning.games.dance.DlsDance
    {
        var _isMultiplayer, _currentSong, _currentSongLevel;
        function DlsDance (learnerID) {
            com.disney.dlearning.managers.DLSManager.init(learnerID, "dc.k.api.dlsnetwork.com");
        }
        function startDancingContest(level, isMultiPlayer, mulitplayerId) {
            _isMultiplayer = isMultiPlayer;
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("start", __CP_Dance_Contest, callbackFunc, null);
        }
        function stopDancingContest() {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __CP_Dance_Contest, callbackFunc, null);
        }
        function startDancingHelp() {
            if (!_seenInstructions) {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Instructions, callbackFunc, null);
                _seenInstructions = true;
            }
        }
        function stopDancingHelp() {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Instructions, callbackFunc, null);
        }
        function startDancingStats() {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Stats_Page, callbackFunc, null);
        }
        function stopDancingStats() {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Stats_Page, callbackFunc, null);
        }
        function selectSong(songName) {
        }
        function setSong($song) {
            _currentSong = $song;
        }
        function selectCurrentSong() {
            switch (_currentSong) {
                case 0 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Penguin_Band_Boogie, callbackFunc, null);
                    break;
                case 1 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __The_Generic_Way, callbackFunc, null);
                    break;
                case 2 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Epic_Win, callbackFunc, null);
                    break;
                case 3 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Lets_Bounce, callbackFunc, null);
                    break;
                case 4 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Go_West, callbackFunc, null);
                    break;
                case 5 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Patricks_Jig, callbackFunc, null);
                    break;
            }
            _sentScore = false;
        }
        function setSongLevel(level) {
            _currentSongLevel = level;
            if (!_setDifficulty) {
                if (_currentSongLevel == 0) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Easy, callbackFunc, null);
                } else if (_currentSongLevel == 1) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Medium, callbackFunc, null);
                } else {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Hard, callbackFunc, null);
                }
                _setDifficulty = true;
            }
        }
        function setGameType(isMultiplayer) {
            _isMultiplayer = isMultiplayer;
            if (_isMultiplayer) {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Mulitplayer, callbackFunc, null);
            } else {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Solo, callbackFunc, null);
            }
        }
        function startSong() {
            _newSong = true;
            switch (_currentSong) {
                case 0 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Penguin_Band_Boogie, callbackFunc, null);
                    break;
                case 1 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __The_Generic_Way, callbackFunc, null);
                    break;
                case 2 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Epic_Win, callbackFunc, null);
                    break;
                case 3 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Lets_Bounce, callbackFunc, null);
                    break;
                case 4 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Go_West, callbackFunc, null);
                    break;
                case 5 : 
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", __Patricks_Jig, callbackFunc, null);
                    break;
            }
            _sentScore = false;
        }
        function stopSong() {
            if (_currentSongLevel == 0) {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Easy, callbackFunc, null);
            } else if (_currentSongLevel == 1) {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Medium, callbackFunc, null);
            } else {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Hard, callbackFunc, null);
            }
            if (_isMultiplayer) {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Mulitplayer, callbackFunc, null);
            } else {
                com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __Solo, callbackFunc, null);
            }
        }
        function sendLearnerScore($score, quit) {
            if (quit == null) {
                quit = false;
            }
            if (_newSong && (!_sentScore)) {
                if (_currentSongLevel == 0) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("learnerscore", __Easy, callbackFunc, $score);
                } else if (_currentSongLevel == 1) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("learnerscore", __Medium, callbackFunc, $score);
                } else {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("learnerscore", __Hard, callbackFunc, $score);
                }
            }
        }
        function sendGameScore($score, $percentage, quit) {
            if (quit == null) {
                quit = false;
            }
            if (_newSong && (!_sentScore)) {
                _newSong = false;
                if (quit) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("gamescore", __CP_Dance_Contest, callbackFunc, $score, "quit");
                } else if ($percentage < 66) {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("gamescore", __CP_Dance_Contest, callbackFunc, $score, "lose");
                } else {
                    com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("gamescore", __CP_Dance_Contest, callbackFunc, $score, "win");
                }
                _sentScore = true;
                _setDifficulty = false;
            }
        }
        function callbackFunc(obj) {
        }
        var __CP_Dance_Contest = "E1A8ABD8-26E5-829F-90B7-0F6B0EBDEE73";
        var __Solo = "70EBCB8B-84AC-D544-DFE1-1ED6E1B5ED5F";
        var __Mulitplayer = "06813335-3B5F-F129-B22D-D5B1DD333408";
        var __Easy = "975B3922-7DC7-42B7-F33C-3CDFDBCB89D2";
        var __Medium = "FF551922-3702-D4B4-F016-0F77ADBA30AE";
        var __Hard = "E7DFBF0D-96D8-1458-020C-F426C7183C44";
        var __Stats_Page = "BEF82E6B-EBB9-D1C1-6A3C-3C9AA83B62D2";
        var __Penguin_Band_Boogie = "06E55025-C098-3C27-CEAB-D753C318A12B";
        var __Patricks_Jig = "80051490-3D8F-BB3C-6B77-82C432D99BC2";
        var __Go_West = "6F2EB430-76E0-1CCA-5AA0-341930E8D33E";
        var __Instructions = "F3E98AB5-9C24-3F20-653C-0FBA58D6ACC5";
        var __Lets_Bounce = "DF238BF5-8A99-B737-DFC4-88B3BD8DE9A4";
        var __Epic_Win = "DD1C3EA9-EEC9-B8C3-3A2A-1B0E4B2B274A";
        var __The_Generic_Way = "46CCAFC2-B822-AB2B-5CF9-C6337514CE0D";
        var dls = com.disney.dlearning.managers.DLSManager;
        var _newSong = false;
        var _sentScore = false;
        var _setDifficulty = false;
        var _seenInstructions = false;
    }
