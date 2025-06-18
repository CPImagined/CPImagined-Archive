//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.treasure.net.DinoHuntClient
    {
        var gameEngine, smartFox, playerData, netData, SHELL, roomID, AIRTOWER, gameOverDelay;
        function DinoHuntClient (gameEngineReference) {
            gameEngine = gameEngineReference;
            smartFox = _root.smartfox;
            playerData = _root.myPlayer;
            netData = _root.myTable;
            SHELL = _global.getCurrentShell();
            roomID = SHELL.getCurrentServerRoomId();
        }
        function init() {
            AIRTOWER = _global.getCurrentAirtower();
            AIRTOWER.addListener("jz", handleJoinGameMessage, this);
            AIRTOWER.addListener("uz", handleUpdateGameMessage, this);
            AIRTOWER.addListener("sz", handleStartGameMessage, this);
            AIRTOWER.addListener("cz", handleCloseGameMessage, this);
            AIRTOWER.addListener("zm", handlePlayerDigMessage, this);
            AIRTOWER.addListener("dzo", handleGameOverMessage, this);
        }
        function destroy() {
            AIRTOWER.removeListener("jz", handleJoinGameMessage, this);
            AIRTOWER.removeListener("uz", handleUpdateGameMessage, this);
            AIRTOWER.removeListener("sz", handleStartGameMessage, this);
            AIRTOWER.removeListener("cz", handleCloseGameMessage, this);
            AIRTOWER.removeListener("zm", handlePlayerDigMessage, this);
            AIRTOWER.removeListener("dzo", handleGameOverMessage, this);
        }
        function sendJoinGameMessage(seatID) {
            debugTrace("sendJoinGameMessage - seatID:" + seatID);
            if (seatID == undefined) {
                AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
            } else {
                AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_GAME, [seatID], SERVER_SIDE_MESSAGE_TYPE, roomID);
            }
        }
        function sendDigMessage(buttonName, buttonDir, buttonNum) {
            debugTrace((((("sendDigMessage - buttonName:" + buttonName) + ", buttonDir:") + buttonDir) + ", buttonNum:") + buttonNum);
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_PLAYER_DIG, [buttonName, buttonDir, buttonNum], SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendLeaveMessage() {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_LEAVE_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendAbortGame() {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_ABORT_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function handleJoinGameMessage(resObj) {
            debugTrace("handleJoinGameMessage");
            debugTrace("smartRoomID: " + resObj[0]);
            debugTrace("seatID: " + resObj[1]);
            var _local_3 = parseInt(resObj[1]);
            gameEngine.updatePlayerSeatID(_local_3);
        }
        function handleStartGameMessage(resObj) {
            debugTrace("handleStartGameMessage");
            debugTrace("smartRoomID: " + resObj[0]);
            debugTrace("player1Name: " + resObj[1]);
            debugTrace("player2Name: " + resObj[2]);
            debugTrace("MAP_WIDTH: " + resObj[3]);
            debugTrace("MAP_HEIGHT: " + resObj[4]);
            debugTrace("COIN_NUM_HIDDEN: " + resObj[5]);
            debugTrace("GEM_NUM_HIDDEN: " + resObj[6]);
            debugTrace("NUM_TURNS: " + resObj[7]);
            debugTrace("GEM_VALUE: " + resObj[8]);
            debugTrace("COIN_VALUE: " + resObj[9]);
            debugTrace("gemLocations: " + resObj[10]);
            debugTrace("treasureMap: " + resObj[11]);
            var _local_3 = new Object();
            _local_3.player1Name = resObj[1];
            _local_3.player2Name = resObj[2];
            _local_3.MAP_WIDTH = parseInt(resObj[3]);
            _local_3.MAP_HEIGHT = parseInt(resObj[4]);
            _local_3.COIN_NUM_HIDDEN = parseInt(resObj[5]);
            _local_3.GEM_NUM_HIDDEN = parseInt(resObj[6]);
            _local_3.NUM_TURNS = parseInt(resObj[7]);
            _local_3.GEM_VALUE = parseInt(resObj[8]);
            _local_3.COIN_VALUE = parseInt(resObj[9]);
            _local_3.gemLocations = resObj[10];
            _local_3.treasureMap = resObj[11];
            gameEngine.initMultiplayer(_local_3);
        }
        function handleUpdateGameMessage(resObj) {
            debugTrace("handleUpdateGameMessage");
            debugTrace("smartRoomID: " + resObj[0]);
            debugTrace("seatID: " + resObj[1]);
            debugTrace("nickname: " + resObj[2]);
            var _local_3 = parseInt(resObj[1]);
            var _local_4 = resObj[2];
            gameEngine.updatePlayerNames(_local_3, _local_4);
        }
        function handlePlayerDigMessage(resObj) {
            debugTrace("handlePlayerDigMessage");
            debugTrace("smartRoomID: " + resObj[0]);
            debugTrace("buttonName: " + resObj[1]);
            debugTrace("buttonDir: " + resObj[2]);
            debugTrace("buttonNum: " + resObj[3]);
            var _local_5 = resObj[1];
            var _local_3 = resObj[2];
            var _local_4 = parseInt(resObj[3]);
            gameEngine.onDigButtonClick(_local_5, _local_3, _local_4);
        }
        function handleCloseGameMessage(resObj) {
            debugTrace("handleCloseGameMessage");
            gameEngine.showGameOver();
        }
        function handleGameOverMessage(resObj) {
            debugTrace("handleGameOverMessage");
            debugTrace("smartRoomID: " + resObj[0]);
            debugTrace("totalCoinsFound: " + resObj[1]);
            debugTrace("totalGemsFound: " + resObj[2]);
            debugTrace("totalScore: " + resObj[3]);
            var _local_3 = parseInt(resObj[1]);
            var _local_5 = parseInt(resObj[2]);
            var _local_4 = parseInt(resObj[3]);
            clearInterval(gameOverDelay);
            gameOverDelay = setInterval(gameEngine, "showGameOver", 3000);
        }
        function debugTrace(msg) {
            if (DEBUG) {
            }
        }
        static var DEBUG = true;
        static var MESSAGE_JOIN_GAME = "jz";
        static var MESSAGE_LEAVE_GAME = "lnbhg";
        static var MESSAGE_PLAYER_DIG = "zm";
        static var MESSAGE_START_GAME = "sz";
        static var MESSAGE_UPDATE_PLAYERLIST = "uz";
        static var MESSAGE_ABORT_GAME = "cz";
        static var MESSAGE_GAME_OVER = "dzo";
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
    }
