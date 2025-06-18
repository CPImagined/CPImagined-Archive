//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower, _updateTotalCoinsDelegate;
        var _jsonObject;
        function TemplatePartyCookieVO (cookieId) {
            super(cookieId);
            trace("TemplatePartyCookieVO - cookieId : " + cookieId);
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
                return([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
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
        function sendCoinsEarned(coins) {
            trace("PARTY COOKIE --  earnCoinsInHolidayRooms !!!!!!!!!!!!!!!!!!!!! - coins : " + coins);
            _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + DECEMBER_PARTY_COINS_EARNED, [coins], "str", _global.getCurrentShell().getCurrentServerRoomId());
            if (!_updateTotalCoinsDelegate) {
                _updateTotalCoinsDelegate = com.clubpenguin.util.Delegate.create(this, updatedCoinsTotal);
                _airtower.addListener(DECEMBER_PARTY_COINS_EARNED, _updateTotalCoinsDelegate);
            }
        }
        function updatedCoinsTotal(data) {
            trace("PARTY COOKIE --  updatedCoinsTotal !!!!!!!!!!!!!!!!!!!!! - player total coins : " + data[1]);
            _airtower.removeListener(DECEMBER_PARTY_COINS_EARNED, _updateTotalCoinsDelegate);
            _updateTotalCoinsDelegate = null;
            var _local_2 = Number(data[1]);
            _global.getCurrentShell().setMyPlayerTotalCoins(_local_2);
        }
        function sendRequestCFCGlobalTotal() {
            _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + CFC_GLOBAL_TOTAL, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendCFCDonation(coinsDonated) {
            _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + CFC_STATION_DONATE, [coinsDonated], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendRequestPartyCookie() {
            trace("PARTY COOKIE --  sendRequestPartyCookie !!!!!!!!!!!!!!!!!!!!! - _airtower : " + _airtower);
            _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + TEMPLATE_RECEIVE_COMMAND_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < msgViewedArray.length)) {
                trace("PARTY VO - sendMessageViewed : " + messageIndex);
                _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendMessageViewed", messageIndex);
            }
        }
        function sendQCMessageViewed(messageIndex) {
            if ((messageIndex >= 0) && (messageIndex < questCommMsgArray.length)) {
                trace("PARTY VO - sendQCMessageViewed : " + messageIndex);
                _airtower.send(_airtower.PLAY_EXT, (TEMPLATE_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
            } else {
                traceSetError("sendQCMessageViewed", messageIndex);
            }
        }
        function sendTaskComplete(taskIndex) {
            if ((taskIndex >= 0) && (taskIndex < questTaskArray.length)) {
                trace("PARTY VO - sendTaskComplete : " + taskIndex);
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
            while (_local_2 < QUEST_LENGTH) {
                trace((("PARTY VO - getNextAvailableTask [" + _local_2) + "] : ") + questTaskArray[_local_2]);
                if (questTaskArray[_local_2] == 0) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(undefined);
        }
        function traceSetError(propertyName, value) {
            trace((("TemplatedPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var TEMPLATE_COOKIE_HANDLER_NAME = "party";
        static var TEMPLATE_RECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
        static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
        static var QUEST_TASK_COMPLETE = "qtaskcomplete";
        static var DECEMBER_PARTY_COINS_EARNED = "qtupdate";
        static var QUEST_LENGTH = 4;
        static var CFC_GLOBAL_TOTAL = "cfcglobaltotal";
        static var CFC_STATION_DONATE = "cfcstationdonate";
    }
