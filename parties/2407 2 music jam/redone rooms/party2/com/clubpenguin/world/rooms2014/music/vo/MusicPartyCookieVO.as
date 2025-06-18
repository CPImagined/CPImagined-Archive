//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function MusicPartyCookieVO (cookieId) {
            super(cookieId);
        }
        function getCookieHandlerName() {
            return(MUSIC_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(MUSIC_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function setMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (MUSIC_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.music.party.MusicPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function traceSetError(propertyName, value) {
        }
        static var MUSIC_COOKIE_HANDLER_NAME = "musicparty";
        static var MUSIC_RECEIVE_COMMAND_NAME = "partycookie";
    }
