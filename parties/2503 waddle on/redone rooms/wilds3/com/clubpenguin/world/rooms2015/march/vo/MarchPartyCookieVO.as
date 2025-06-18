//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        static var _airtower;
        var _jsonObject;
        function MarchPartyCookieVO (cookieId) {
            super(cookieId);
            trace("MarchPartyCookieVO()");
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(MARCH_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(MARCH_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function get qcMsgViewedArray() {
            if (_jsonObject.qcMessageArray == undefined) {
                return([0, 0, 0]);
            }
            return(_jsonObject.qcMessageArray);
        }
        function get questItems() {
            for (var _local_3 in _jsonObject) {
                var _local_2 = _jsonObject[_local_3];
            }
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (MARCH_COOKIE_HANDLER_NAME + "#") + MARCH_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setMessageViewed(messageIndex) {
            _airtower.send(_airtower.PLAY_EXT, (MARCH_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setQCMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (MARCH_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        static function sendItemCollected(itemIndex) {
            _airtower.send(_airtower.PLAY_EXT, (MARCH_COOKIE_HANDLER_NAME + "#") + COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendTaskComplete(id) {
            _airtower.send(_airtower.PLAY_EXT, (MARCH_COOKIE_HANDLER_NAME + "#") + QUEST_TASK_COMPLETE, [id], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function get numTasksCompleted() {
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
        function traceSetError(propertyName, value) {
            trace((("MarchPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var MARCH_COOKIE_HANDLER_NAME = "puffle2015";
        static var MARCH_RECEIVE_COMMAND_NAME = "partycookie";
        static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
        static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
        static var COLLECT_QUEST_ITEM_COMMAND = "collectquestitem";
        static var QUEST_TASK_COMPLETE = "qtaskcomplete";
    }
