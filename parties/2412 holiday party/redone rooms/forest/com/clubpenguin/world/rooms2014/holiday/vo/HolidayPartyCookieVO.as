//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.vo.HolidayPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _airtower, _jsonObject, _updateUserCoinsDelegate;
        function HolidayPartyCookieVO (cookieId) {
            super(cookieId);
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
            for (var id in _jsonObject) {
                var value = _jsonObject[id];
            }
            return(_jsonObject.questTaskStatus);
        }
        function get coinsDonated() {
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
            _updateUserCoinsDelegate = com.clubpenguin.util.Delegate.create(this, handleUserCoinsUpdated);
            _airtower.addListener(CFC_STATION_DONATE, _updateUserCoinsDelegate);
        }
        function handleUserCoinsUpdated(data) {
            _airtower.removeListener(CFC_STATION_DONATE, _updateUserCoinsDelegate);
            var totalCoins = Number(data[1]);
            _global.getCurrentShell().setMyPlayerTotalCoins(totalCoins);
        }
        function setQCMessageViewed(messageIndex) {
            var airtower = _global.getCurrentAirtower();
            airtower.send(airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function sendItemCollected(itemIndex) {
            _airtower.send(_airtower.PLAY_EXT, (HOLIDAY_COOKIE_HANDLER_NAME + "#") + COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _global.getCurrentShell().getCurrentServerRoomId());
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.sendTaskCompleteBI(itemIndex);
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.playPartyIconSparkles();
        }
        function get numTasksCompleted() {
            var items = 0;
            var i = 0;
            while (i < (_jsonObject.questTaskStatus.length - 1)) {
                if (_jsonObject.questTaskStatus[i] == 1) {
                    items++;
                }
                i++;
            }
            return(items);
        }
        function get didCompleteAtLeastOneTask() {
            var i = 1;
            while (i < (_jsonObject.questTaskStatus.length - 1)) {
                if (_jsonObject.questTaskStatus[i] == 1) {
                    return(true);
                }
                i++;
            }
            return(false);
        }
        function get isQuestComplete() {
            var i = 0;
            while (i < _jsonObject.questTaskStatus.length) {
                if (_jsonObject.questTaskStatus[i] == 0) {
                    return(false);
                }
                i++;
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
