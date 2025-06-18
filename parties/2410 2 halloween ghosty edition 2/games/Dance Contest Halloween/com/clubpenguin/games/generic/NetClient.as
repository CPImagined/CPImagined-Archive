
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.generic.NetClient
    {
        var SHELL, AIRTOWER, roomID;
        function NetClient () {
        }
        function init() {
            SHELL = _global.getCurrentShell();
            AIRTOWER = _global.getCurrentAirtower();
            AIRTOWER.addListener(MESSAGE_GET_GAME, handleGetGameMessage, this);
            AIRTOWER.addListener(MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
            AIRTOWER.addListener(MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
            AIRTOWER.addListener(MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
            AIRTOWER.addListener(MESSAGE_START_GAME, handleStartGameMessage, this);
            AIRTOWER.addListener(MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
            AIRTOWER.addListener(MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
            AIRTOWER.addListener(MESSAGE_GAME_OVER, handleGameOverMessage, this);
            AIRTOWER.addListener(MESSAGE_ERROR, handleErrorMessage, this);
            roomID = SHELL.getCurrentServerRoomId();
        }
        function destroy() {
            AIRTOWER.removeListener(MESSAGE_GET_GAME, handleGetGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_START_GAME, handleStartGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
            AIRTOWER.removeListener(MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
            AIRTOWER.removeListener(MESSAGE_GAME_OVER, handleGameOverMessage, this);
            AIRTOWER.removeListener(MESSAGE_ERROR, handleErrorMessage, this);
        }
        function sendGetGameMessage() {
            debugTrace("sendGetGameMessage");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_GET_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendJoinGameMessage() {
            debugTrace("sendJoinGameMessage");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_JOIN_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendLeaveGameMessage() {
            debugTrace("sendLeaveGameMessage");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_LEAVE_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendAbortGameMessage() {
            debugTrace("sendAbortGameMessage");
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_ABORT_GAME, "", SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function sendPlayerActionMessage(messageData) {
            debugTrace("sendPlayerActionMessage - messageData is...");
            for (var _local3 in messageData) {
                debugTrace((("messageData[" + _local3) + "] = ") + messageData[_local3]);
            }
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_PLAYER_ACTION, messageData, SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        function handleGetGameMessage(resObj) {
            debugTrace("handleGetGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleJoinGameMessage(resObj) {
            debugTrace("handleJoinGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleStartGameMessage(resObj) {
            debugTrace("handleStartGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleUpdateGameMessage(resObj) {
            debugTrace("handleUpdateGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handlePlayerActionMessage(resObj) {
            debugTrace("handlePlayerActionMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleCloseGameMessage(resObj) {
            debugTrace("handleCloseGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleAbortGameMessage(resObj) {
            debugTrace("handleAbortGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleGameOverMessage(resObj) {
            debugTrace("handleGameOverMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        function handleErrorMessage(resObj) {
            debugTrace("handleErrorMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(NetClient) " + message, priority);
            }
        }
        static var MESSAGE_GET_GAME = "gz";
        static var MESSAGE_JOIN_GAME = "jz";
        static var MESSAGE_LEAVE_GAME = "lz";
        static var MESSAGE_PLAYER_ACTION = "zm";
        static var MESSAGE_START_GAME = "sz";
        static var MESSAGE_UPDATE_PLAYERLIST = "uz";
        static var MESSAGE_ABORT_GAME = "cz";
        static var MESSAGE_GAME_OVER = "zo";
        static var MESSAGE_ERROR = "ez";
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
    }
