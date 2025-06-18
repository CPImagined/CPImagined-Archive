//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.vo.JulyPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower;
        var _jsonObject;
        function JulyPartyCookieVO (cookieId) {
            super(cookieId);
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(JULY_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(PARTY_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(PARTY_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function questCommMsgArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.communicatorMsgArray);
        }
        function get questTaskArray() {
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (JULY_COOKIE_HANDLER_NAME + "#") + JULY_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < msgViewedArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (JULY_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendMessageViewed", messageIndex);
            }
        }
        function sendQCMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < questCommMsgArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (JULY_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendQCMessageViewed", messageIndex);
            }
        }
        function sendTaskComplete(taskIndex) {
            if ((taskIndex >= 0) && (taskIndex < questTaskArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (JULY_COOKIE_HANDLER_NAME + "#") + QUEST_TASK_COMPLETE, [taskIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendTaskComplete", taskIndex);
            }
        }
        function traceSetError(propertyName, value) {
        }
        function toString(arr) {
            var _local_1 = 0;
            while (_local_1 < (arr.length - 1)) {
                _local_1++;
            }
        }
        function isTaskComplete(num) {
            return(((questTaskArray[num] == 1) ? true : false));
        }
        function isQuestComplete() {
            var _local_3 = _global.getCurrentParty().JulyParty.CONSTANTS.QUEST_COMPLETE_INDEX;
            return(((questTaskArray[_local_3] == 1) ? true : false));
        }
        function get nextAvailableTask() {
            var _local_3 = 0;
            var _local_2 = 0;
            while (_local_2 < 5) {
                if (questTaskArray[_local_2] == 0) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        function hasPlayerViewedMessage(messageIndex) {
            return(((msgViewedArray[messageIndex] == 1) ? true : false));
        }
        function hasPlayerViewedQCMessage(messageIndex) {
            return(((questCommMsgArray[messageIndex] == 1) ? true : false));
        }
        static var PARTY_COOKIE_ID = "20150702";
        static var JULY_COOKIE_HANDLER_NAME = "insideout";
        static var PARTY_RECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
        static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
        static var QUEST_TASK_COMPLETE = "qtaskcomplete";
    }
