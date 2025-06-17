//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.game.net.event.NetClientEvent extends com.clubpenguin.lib.event.Event
    {
        var __netMessage, __eventDispatcher, __eventType, __eventData;
        function NetClientEvent (_arg_4, _arg_3, _arg_6, _arg_5) {
            super(_arg_4, _arg_3, _arg_5);
            __netMessage = _arg_6;
        }
        function clone() {
            var _local_2;
            _local_2 = createEvent();
            return(_local_2);
        }
        function createEvent() {
            return(new com.clubpenguin.game.net.event.NetClientEvent(__eventDispatcher, __eventType, __netMessage, __eventData));
        }
        function get message() {
            return(__netMessage);
        }
        static var NET_REQUEST = "netClientRequest";
        static var NET_RECEIVE = "netClientReceive";
        static var REQ_GAME_CONNECT = "ncRequestGameConnect";
        static var REC_GAME_CONNECT = "ncReceiveGameConnect";
        static var REQ_GAME_JOIN = "ncRequestGameJoin";
        static var REC_GAME_JOIN = "ncReceiveGameJoin";
        static var REQ_GAME_LEAVE = "ncRequestGameLeave";
        static var REC_GAME_LEAVE = "ncReceiveGameLeave";
        static var REQ_GAME_PLAYERS = "ncRequestGamePlayers";
        static var REC_GAME_PLAYERS = "ncReceiveGamePlayers";
        static var REQ_GAME_START = "ncRequestGameStart";
        static var REC_GAME_START = "ncReceiveGameStart";
        static var REQ_GAME_ABORT = "ncRequestGameAbort";
        static var REC_GAME_ABORT = "ncReceiveGameAbort";
        static var REQ_GAME_ACTION = "ncRequestGameAction";
        static var REC_GAME_ACTION = "ncReceiveGameAction";
        static var REQ_GAME_OVER = "ncRequestGameOver";
        static var REC_GAME_OVER = "ncReceiveGameOver";
        static var REQ_GAME_ERROR = "ncRequestGameError";
        static var REC_GAME_ERROR = "ncReceiveGameError";
        static var REC_STAMP_INFORMATION = "ncStampInfo";
    }
