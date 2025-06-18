//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.vo.HalloweenPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function HalloweenPartyCookieVO (cookieId) {
            super(cookieId);
            trace("HalloweenPartyCookieVO()");
        }
        function getCookieHandlerName() {
            return(HALLOWEEN_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(HALLOWEEN_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function get hasPlayerVisitedFloor12() {
            return(((_jsonObject.visitedFloor12 == undefined) ? false : (_jsonObject.visitedFloor12 == 1)));
        }
        function setMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (HALLOWEEN_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function get questItems() {
            trace("HalloweenPartyCookieVO.questItems _jsonObject.questItems: " + _jsonObject.questTaskStatus);
            trace("HalloweenPartyCookieVO.questItems _jsonObjects: " + _jsonObject);
            for (var _local_3 in _jsonObject) {
                var _local_2 = _jsonObject[_local_3];
                trace((("SchoolPartyCookieVO json property : " + _local_3) + " = ") + _local_2);
            }
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        function traceSetError(propertyName, value) {
            trace((("HalloweenPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        function get numItemsCollected() {
            var _local_3 = 0;
            var _local_2 = 0;
            while (_local_2 < (_jsonObject.questTaskStatus.length - 1)) {
                if (_jsonObject.questTaskStatus[_local_2] == 1) {
                    _local_3++;
                }
                _local_2++;
            }
            return(_local_3);
        }
        function get didCompleteAtLeastOneTask() {
            var _local_2 = 1;
            while (_local_2 < (_jsonObject.questTaskStatus.length - 1)) {
                if (_jsonObject.questTaskStatus[_local_2] == 1) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function areItemsCollected() {
            var _local_2 = 0;
            while (_local_2 < (_jsonObject.questTaskStatus.length - 1)) {
                if (_jsonObject.questTaskStatus[_local_2] == 0) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function get isQuestComplete() {
            var _local_2 = 0;
            while (_local_2 < _jsonObject.questTaskStatus.length) {
                if (_jsonObject.questTaskStatus[_local_2] == 0) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        static var HALLOWEEN_COOKIE_HANDLER_NAME = "halloween";
        static var HALLOWEEN_RECEIVE_COMMAND_NAME = "partycookie";
    }
