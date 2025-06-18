//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function PiratePartyCookieVO (cookieId) {
            super(cookieId);
            trace("PiratePartyCookieVO()");
        }
        function getCookieHandlerName() {
            return(PIRATE_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(PIRATE_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0, 0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function get qcMsgViewedArray() {
            if (_jsonObject.qcMsgViewedArray == undefined) {
                return([0, 0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.qcMsgViewedArray);
        }
        function setMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (PIRATE_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.pirate.party.PiratePartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setQCMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (PIRATE_COOKIE_HANDLER_NAME + "#") + com.clubpenguin.world.rooms2014.pirate.party.PiratePartyConstants.QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function hasPlayerViewedMessage(messageIndex) {
            return(msgViewedArray[messageIndex] == 1);
        }
        function hasPlayerViewedQCMessage(messageIndex) {
            return(qcMsgViewedArray[messageIndex] == 1);
        }
        function get questItems() {
            for (var _local_3 in _jsonObject) {
                var _local_2 = _jsonObject[_local_3];
            }
            if (_jsonObject.questTaskStatus == undefined) {
                return([0, 0, 0, 0, 0, 0, 0]);
            }
            return(_jsonObject.questTaskStatus);
        }
        function get points() {
            if ((_jsonObject.points == undefined) || (_jsonObject.points < 0)) {
                return(0);
            }
            return(_jsonObject.points);
        }
        function get coinRewards() {
            if ((questItems == undefined) || (questItems.length == 0)) {
                return([0, 0, 0, 0]);
            }
            trace("PiratePartyCookieVO questItems : " + questItems);
            trace("PiratePartyCookieVO _global.getCurrentParty().PirateParty.CONSTANTS.NUMBER_OF_TASKS : " + _global.getCurrentParty().PirateParty.CONSTANTS.NUMBER_OF_TASKS);
            var _local_3 = questItems;
            return(new Array(_local_3[7], _local_3[8], _local_3[9], _local_3[10]));
        }
        function get didCompleteAtLeastOneTask() {
            var _local_3 = 0;
            while (_local_3 < _global.getCurrentParty().PirateParty.CONSTANTS.NUMBER_OF_TASKS) {
                if (_jsonObject.questTaskStatus[_local_3] == 1) {
                    return(true);
                }
                _local_3++;
            }
            return(false);
        }
        function get numTasksCompleted() {
            var _local_4 = 0;
            var _local_3 = 0;
            while (_local_3 < _global.getCurrentParty().PirateParty.CONSTANTS.NUMBER_OF_TASKS) {
                if (_jsonObject.questTaskStatus[_local_3] == 1) {
                    _local_4++;
                }
                _local_3++;
            }
            return(_local_4);
        }
        function traceSetError(propertyName, value) {
            trace((("PiratePartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var PIRATE_COOKIE_HANDLER_NAME = "pirate";
        static var PIRATE_RECEIVE_COMMAND_NAME = "partycookie";
    }
