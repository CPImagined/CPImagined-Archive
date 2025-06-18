//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function FrozenPartyCookieVO (_arg_2) {
            super(_arg_2);
        }
        function getCookieHandlerName() {
            return(FROZEN_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(FROZEN_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function setMessageViewed(_arg_3) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (FROZEN_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.frozen.party.FrozenPartyConstants.MESSAGE_VIEWED_COMMAND, [_arg_3], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function get snowflakes() {
            return(_jsonObject.snowflakes);
        }
        function getSnowflakesForRoom(_arg_4) {
            var _local_2 = getSnowflakesStartIndexForRoom(_arg_4);
            var _local_3 = _local_2 + 3;
            return(snowflakes.slice(_local_2, _local_3));
        }
        function getSnowflakesStartIndexForRoom(_arg_2) {
            var _local_1 = parseInt(_arg_2.toString());
            switch (_local_1) {
                case ROOM_ID_BEACH : 
                    return(0);
                case ROOM_ID_DOCK : 
                    return(3);
                case ROOM_ID_TOWN : 
                    return(6);
                case ROOM_ID_FORTS : 
                    return(9);
                case ROOM_ID_PLAZA : 
                    return(12);
                case ROOM_ID_FOREST : 
                    return(15);
                case ROOM_ID_COVE : 
                    return(18);
            }
            return(-1);
        }
        function get freezingPowers() {
            if (_jsonObject.freezingPowers == undefined) {
                return(0);
            }
            return(_jsonObject.freezingPowers);
        }
        function traceSetError(_arg_2, _arg_1) {
        }
        static var FROZEN_COOKIE_HANDLER_NAME = "frozen";
        static var FROZEN_RECEIVE_COMMAND_NAME = "partycookie";
        static var NUM_FLAKES = 21;
        static var ROOM_ID_BEACH = 400;
        static var ROOM_ID_DOCK = 800;
        static var ROOM_ID_TOWN = 100;
        static var ROOM_ID_FORTS = 801;
        static var ROOM_ID_PLAZA = 300;
        static var ROOM_ID_FOREST = 809;
        static var ROOM_ID_COVE = 810;
    }
