//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.ClientProxy extends com.clubpenguin.games.card.BaseObject
    {
        var gameEngine, roomId, dispatchEvent;
        function ClientProxy (gameEngineRef) {
            super();
            gameEngine = gameEngineRef;
            roomId = SHELL.getCurrentServerRoomId();
            addAirtowerListeners();
            mx.events.EventDispatcher.initialize(this);
        }
        function sendGetGameMessage(mode) {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_GET_GAME, [mode], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendJoinGameMessage() {
            var _local_2;
            if (_local_2 == undefined) {
                AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomId);
            } else {
                AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_GAME, [_local_2], SERVER_SIDE_MESSAGE_TYPE, roomId);
            }
        }
        function sendUpdateGameMessage() {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_UPDATE_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendGameMoveDealMessage(instr, num) {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_GAME_MOVE, [instr, num], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendGameMovePickMessage(instr, id) {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_GAME_MOVE, [instr, id], SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function sendLeaveGameMessage() {
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_LEAVE_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function handleGetGameMessage(resObj) {
            dispatchEvent({target:this, type:MESSAGE_GET_GAME, maxPlayers:resObj[1], numPlayers:resObj[2]});
        }
        function handleJoinGameMessage(resObj) {
            dispatchEvent({target:this, type:MESSAGE_JOIN_GAME, seatID:Number(resObj[1]), nickname:resObj[2], color:resObj[3], rank:resObj[4]});
        }
        function handleUpdateGameMessage(resObj) {
            resObj.shift();
            dispatchEvent({target:this, type:MESSAGE_UPDATE_GAME, players:resObj});
        }
        function handleStartGameMessage(resObj) {
            resObj.shift();
            dispatchEvent({target:this, type:MESSAGE_START_GAME, data:resObj});
        }
        function handleGameMoveMessage(resObj) {
            resObj.shift();
            dispatchEvent({target:this, type:MESSAGE_GAME_MOVE, instr:resObj.shift(), data:resObj});
        }
        function handleCloseGameMessage(resObj) {
            dispatchEvent({target:this, type:MESSAGE_CLOSE_GAME, nickname:resObj[1]});
        }
        function handleLeaveGameMessage(resObj) {
            dispatchEvent({target:this, type:MESSAGE_LEAVE_GAME, seatID:resObj[1]});
        }
        function handleGameOverMessage(resObj) {
            resObj.shift();
            dispatchEvent({target:this, type:MESSAGE_GAME_OVER, coins:resObj.shift(), winseat:resObj.shift(), ids:resObj});
        }
        function handleGameAwardMessage(resObj) {
            resObj.shift();
            dispatchEvent({target:this, type:MESSAGE_GAME_AWARD, rank:resObj.shift()});
        }
        function handleStampInfo(resObj) {
            resObj.shift();
            resObj.pop();
            dispatchEvent({target:this, type:MESSAGE_STAMP_INFO, stampInfo:resObj});
        }
        function addAirtowerListeners() {
            AIRTOWER.addListener(MESSAGE_GET_GAME, handleGetGameMessage, this);
            AIRTOWER.addListener(MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
            AIRTOWER.addListener(MESSAGE_LEAVE_GAME, handleLeaveGameMessage, this);
            AIRTOWER.addListener(MESSAGE_UPDATE_GAME, handleUpdateGameMessage, this);
            AIRTOWER.addListener(MESSAGE_START_GAME, handleStartGameMessage, this);
            AIRTOWER.addListener(MESSAGE_CLOSE_GAME, handleCloseGameMessage, this);
            AIRTOWER.addListener(MESSAGE_GAME_MOVE, handleGameMoveMessage, this);
            AIRTOWER.addListener(MESSAGE_GAME_OVER, handleGameOverMessage, this);
            AIRTOWER.addListener(MESSAGE_GAME_AWARD, handleGameAwardMessage, this);
            AIRTOWER.addListener(MESSAGE_STAMP_INFO, handleStampInfo, this);
        }
        function removeAirtowerListeners() {
            AIRTOWER.removeListener(MESSAGE_GET_GAME, handleGetGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_LEAVE_GAME, handleLeaveGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_UPDATE_GAME, handleUpdateGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_START_GAME, handleStartGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_CLOSE_GAME, handleCloseGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_GAME_MOVE, handleGameMoveMessage, this);
            AIRTOWER.removeListener(MESSAGE_GAME_OVER, handleGameOverMessage, this);
            AIRTOWER.removeListener(MESSAGE_GAME_AWARD, handleGameAwardMessage, this);
            AIRTOWER.removeListener(MESSAGE_STAMP_INFO, handleStampInfo, this);
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.card";
        static var CLASS_NAME = "ClientProxy";
        static var MESSAGE_GET_GAME = "gz";
        static var MESSAGE_JOIN_GAME = "jz";
        static var MESSAGE_UPDATE_GAME = "uz";
        static var MESSAGE_START_GAME = "sz";
        static var MESSAGE_GAME_MOVE = "zm";
        static var MESSAGE_CLOSE_GAME = "cz";
        static var MESSAGE_LEAVE_GAME = "lz";
        static var MESSAGE_GAME_OVER = "czo";
        static var MESSAGE_GAME_AWARD = "cza";
        static var MESSAGE_STAMP_INFO = "cjsi";
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
        static var AIRTOWER = _global.getCurrentAirtower();
        static var INTERFACE = _global.getCurrentInterface();
        static var ENGINE = _global.getCurrentEngine();
        static var SHELL = _global.getCurrentShell();
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
    }
