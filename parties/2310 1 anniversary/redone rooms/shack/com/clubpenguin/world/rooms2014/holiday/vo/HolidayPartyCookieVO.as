//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.vo.HolidayPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _airtower, _jsonObject;
        function HolidayPartyCookieVO (cookieId) {
            super(cookieId);
            trace("HolidayPartyCookieVO()");
            _airtower = _global.getCurrentAirtower();
        }
        function getCookieHandlerName() {
            return(HOLIDAY_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return("ERROR-NO-COOKIE-SEND-COMMAND");
        }
        function getReceiveCommandName() {
            return(HOLIDAY_RECEIVE_COMMAND_NAME);
        }
        function get msgViewedArray() {
            if (_jsonObject.msgViewedArray == undefined) {
                return([0, 0]);
            }
            return(_jsonObject.msgViewedArray);
        }
        function get qcMsgViewedArray() {
            if (_jsonObject.qcMsgViewedArray == undefined) {
                return([0, 0, 0]);
            }
            return(_jsonObject.qcMsgViewedArray);
        }
        function get questItems() {
            trace("HolidayPartyCookieVO.questItems _jsonObject.questItems: " + _jsonObject.questTaskStatus);
            trace("HolidayPartyCookieVO.questItems _jsonObjects: " + _jsonObject);
            for (var _local_3 in _jsonObject) {
                var _local_2 = _jsonObject[_local_3];
                trace((("HolidayPartyCookieVO json property : " + _local_3) + " = ") + _local_2);
            }
            return(_jsonObject.questTaskStatus);
        }
        function get coinsDonated() {
            trace("HolidayPartyCookieVO.coinsDonated _jsonObject.coinsDonated: " + _jsonObject.coinsDonated);
            trace("HolidayPartyCookieVO.coinsDonated _jsonObjects: " + _jsonObject);
            return(999);
        }
        function sendRequestCFCGlobalTotal() {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + CFC_GLOBAL_TOTAL, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + HOLIDAY_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setMessageViewed(messageIndex) {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendCFCDonation(coinsDonated) {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + CFC_STATION_DONATE, [coinsDonated], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function setQCMessageViewed(messageIndex) {
            var _local_2 = _global.getCurrentAirtower();
            _local_2.send(_local_2.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendItemCollected(itemIndex) {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _global.getCurrentShell().getCurrentServerRoomId());
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.sendTaskCompleteBI(itemIndex);
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.playPartyIconSparkles();
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
        function crystalQuestTaskStatusIndexForRoom(roomId) {
            if (roomId == ROOM_ID_DOCK) {
                return(3);
            } else if (roomId == ROOM_ID_PLAZA) {
                return(4);
            } else if (roomId == ROOM_ID_SHACK) {
                return(5);
            } else if (roomId == ROOM_ID_BEACH) {
                return(6);
            } else if (roomId == ROOM_ID_TOWN) {
                return(7);
            } else if (roomId == ROOM_ID_FOREST) {
                return(8);
            } else {
                return(-1);
            }
        }
        function hasPlayerViewedMessage(messageIndex) {
            return(msgViewedArray[messageIndex] == 1);
        }
        function hasPlayerViewedQCMessage(messageIndex) {
            return(qcMsgViewedArray[messageIndex] == 1);
        }
        function traceSetError(propertyName, value) {
            trace((("HolidayPartyCookieVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var HOLIDAY_COOKIE_HANDLER_NAME = "xmas2014";
        static var HOLIDAY_RECEIVE_COMMAND_NAME = "partycookie";
        static var MESSAGE_VIEWED_COMMAND = "msgviewed";
        static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
        static var COLLECT_QUEST_ITEM_COMMAND = "qtaskcomplete";
        static var CFC_GLOBAL_TOTAL = "cfcglobaltotal";
        static var CFC_STATION_DONATE = "cfcstationdonate";
        static var ROOM_ID_DOCK = 800;
        static var ROOM_ID_PLAZA = 300;
        static var ROOM_ID_SHACK = 807;
        static var ROOM_ID_BEACH = 400;
        static var ROOM_ID_TOWN = 100;
        static var ROOM_ID_FOREST = 809;
    }
