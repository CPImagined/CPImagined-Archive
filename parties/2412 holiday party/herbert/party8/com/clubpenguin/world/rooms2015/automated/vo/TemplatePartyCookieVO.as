//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower;
        var _jsonObject;
        function TemplatePartyCookieVO (cookieId) {
            super(cookieId);
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(TEMPLATE_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(TEMPLATE_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function get questCommMsgArray() {
            if (_jsonObject.communicatorMsgArray == undefined) {
                return([0, 0, 0, 0, 0]);
            }
            return(_jsonObject.communicatorMsgArray);
        }
        function get questTaskArray() {
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + TEMPLATE_RECEIVE_COMMAND_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < msgViewedArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendMessageViewed", messageIndex);
            }
        }
        function sendQCMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < questCommMsgArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendQCMessageViewed", messageIndex);
            }
        }
        function sendTaskComplete(taskIndex) {
            if ((taskIndex >= 0) && (taskIndex < questTaskArray.length)) {
                _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + QUEST_TASK_COMPLETE, [taskIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendTaskComplete", taskIndex);
            }
        }
        function hasPlayerViewedMessage(messageIndex) {
            return(((msgViewedArray[messageIndex] == 1) ? true : false));
        }
        function hasPlayerViewedQCMessage(messageIndex) {
            return(((questCommMsgArray[messageIndex] == 1) ? true : false));
        }
        function hasPlayerCompletedTask(taskIndex) {
            return(((questTaskArray[taskIndex] == 1) ? true : false));
        }
        function getNextAvailableTask() {
            var _local_2 = 0;
            while (_local_2 < questTaskArray.length) {
                if (questTaskArray[_local_2] == 0) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(undefined);
        }
        function traceSetError(propertyName, value) {
        }
        static var TEMPLATE_COOKIE_HANDLER_NAME = "party";
        static var TEMPLATE_RECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
        static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
        static var QUEST_TASK_COMPLETE = "qtaskcomplete";
    }
