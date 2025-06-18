
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.DanceNetClient extends com.clubpenguin.games.generic.NetClient
    {
        var currentState, timeToNextSong, songName, gameEngine, AIRTOWER, netSendTimeMillis, keyPressIDs, sendPlayerActionMessage, songData, millisPerBar, roomID;
        function DanceNetClient () {
            super();
            currentState = STATE_DISCONNECTED;
            timeToNextSong = 0;
            songName = "undefined";
        }
        function init($gameEngine) {
            super.init();
            gameEngine = $gameEngine;
            AIRTOWER.addListener(MESSAGE_FINISH_GAME, handleEndGameMessage, this);
        }
        function destroy() {
            super.destroy();
            currentState = STATE_DISCONNECTED;
            AIRTOWER.removeListener(MESSAGE_FINISH_GAME, handleEndGameMessage, this);
        }
        function updateKeyPresses($keyPresses) {
            var _local8 = gameEngine.elapsedTimeMillis;
            if (_local8 > (netSendTimeMillis + NET_SEND_INTERVAL)) {
                netSendTimeMillis = netSendTimeMillis + NET_SEND_INTERVAL;
                var _local5 = new Array();
                var _local4 = new Array();
                _local4.push(gameEngine.currentScore);
                for (var _local7 in keyPressIDs) {
                    var _local2 = $keyPresses[keyPressIDs[_local7]];
                    if ((_local2.noteDuration == 0) || (_local2.releaseTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)) {
                        var _local3 = (((((_local2.noteType + ",") + _local2.pressTime) + ",") + _local2.releaseTime) + ",") + _local2.getNotePressResult();
                        _local4.push(_local3);
                    } else {
                        _local5.push(keyPressIDs[_local7]);
                    }
                }
                keyPressIDs = _local5;
                sendPlayerActionMessage(_local4);
            }
        }
        function handleGetGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleGetGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("estimatedTime: " + resObj[1]);
            com.clubpenguin.games.generic.NetClient.debugTrace("nextSong: " + com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]));
            com.clubpenguin.games.generic.NetClient.debugTrace("timeToNextSong: " + resObj[3]);
            timeToNextSong = parseInt(resObj[1]) + parseInt(resObj[3]);
            songName = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]);
            currentState = STATE_ATTEMPT_TO_JOIN;
            gameEngine.setSong(parseInt(resObj[3]));
            gameEngine.startTimer();
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE);
        }
        function handleJoinGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleJoinGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("success: " + resObj[1]);
            com.clubpenguin.games.generic.NetClient.debugTrace("songName: " + com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]));
            com.clubpenguin.games.generic.NetClient.debugTrace("timeToNextSong: " + resObj[3]);
            var _local3 = resObj[1] == "true";
            songName = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]);
            timeToNextSong = parseInt(resObj[3]);
            if (_local3) {
                currentState = STATE_QUEUEING;
                gameEngine.setSong(parseInt(resObj[2]));
                gameEngine.startTimer();
                gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME);
            } else {
                currentState = STATE_DISCONNECTED;
                gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL);
            }
        }
        function handleStartGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleStartGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("noteTimes: " + resObj[1]);
            com.clubpenguin.games.generic.NetClient.debugTrace("noteTypes: " + resObj[2]);
            com.clubpenguin.games.generic.NetClient.debugTrace("noteLengths: " + resObj[3]);
            com.clubpenguin.games.generic.NetClient.debugTrace("millisPerBar: " + resObj[4]);
            var _local4 = resObj[1].split(",");
            var _local2 = resObj[2].split(",");
            var _local5 = resObj[3].split(",");
            songData = [[], [], []];
            for (var _local6 in _local2) {
                songData[0][_local6] = parseInt(_local2[_local6]);
                songData[1][_local6] = parseInt(_local4[_local6]);
                songData[2][_local6] = parseInt(_local5[_local6]);
            }
            millisPerBar = parseInt(resObj[4]);
            netSendTimeMillis = 0;
            currentState = STATE_IN_GAME;
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
            gameEngine.startSong();
        }
        function handleEndGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleEndGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            handlePlayerActionMessage(resObj);
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
            gameEngine.endSong();
        }
        function handleUpdateGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("handleUpdateGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handlePlayerActionMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handlePlayerActionMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("playerScores: " + resObj[1]);
            var _local4 = resObj[1].split(",");
            var _local5 = new Array();
            for (var _local6 in _local4) {
                var _local2 = _local4[_local6].split("|");
                com.clubpenguin.games.generic.NetClient.debugTrace((("smartID[" + _local6) + "]: ") + _local2[0]);
                com.clubpenguin.games.generic.NetClient.debugTrace((("name[" + _local6) + "]: ") + _local2[1]);
                com.clubpenguin.games.generic.NetClient.debugTrace((("score[" + _local6) + "]: ") + _local2[2]);
                com.clubpenguin.games.generic.NetClient.debugTrace((("rating[" + _local6) + "]: ") + _local2[3]);
                com.clubpenguin.games.generic.NetClient.debugTrace((("noteStreak[" + _local6) + "]: ") + _local2[4]);
                var _local3 = new Object();
                _local3.smartID = parseInt(_local2[0]);
                _local3.name = _local2[1];
                _local3.score = parseInt(_local2[2]);
                _local3.rating = parseInt(_local2[3]);
                _local3.streak = parseInt(_local2[4]);
                if ((_local3.name != undefined) && (_local3.name != "undefined")) {
                    _local5.push(_local3);
                }
            }
            _local5.sortOn("score", Array.DESCENDING | Array.NUMERIC);
            if (_local5.length > 0) {
                gameEngine.updateMultiplayerScores(_local5);
            }
        }
        function handleErrorMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleErrorMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("errorCode: " + resObj[1]);
            var _local2 = parseInt(resObj[1]);
            if (_local2 == com.clubpenguin.games.dancing.GameEngine.ERROR_CODE_ROOM_FULL) {
                gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_ROOM_FULL);
            } else if (_local2 == com.clubpenguin.games.dancing.GameEngine.ERROR_CODE_MULTIPLE_CONNECTIONS) {
                gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_MULTIPLE_CONNECTIONS);
            }
        }
        function handleCloseGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("handleCloseGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleAbortGameMessage(resObj) {
            com.clubpenguin.games.generic.NetClient.debugTrace("handleAbortGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function sendDifficultyLevelMessage($difficulty) {
            com.clubpenguin.games.generic.NetClient.debugTrace("sendDifficultyLevelMessage - difficulty is " + $difficulty);
            AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, MESSAGE_CHANGE_DIFFICULTY, [$difficulty], com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendGetGameAgainMessage() {
            com.clubpenguin.games.generic.NetClient.debugTrace("sendGetGameAgainMessage");
            AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, MESSAGE_GET_GAME_AGAIN, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        static var MESSAGE_CHANGE_DIFFICULTY = "zd";
        static var MESSAGE_FINISH_GAME = "zf";
        static var MESSAGE_GET_GAME_AGAIN = "zr";
        static var NET_SEND_INTERVAL = 3000;
        static var STATE_DISCONNECTED = 0;
        static var STATE_ATTEMPT_TO_JOIN = 1;
        static var STATE_QUEUEING = 2;
        static var STATE_IN_GAME = 3;
    }
