//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.school.SchoolParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _quest, _handleCollectIglooItemDelegate;
        function SchoolParty () {
        }
        static function init() {
            pebug("SCHOOL PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            trace("SchoolParty.init");
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            sendRequestPartyCookie();
        }
        static function partycookieUpdateHandler() {
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            pebug("partycookieUpdateHandler update icon state ");
            com.clubpenguin.party.BaseParty.partyIconState();
        }
        static function sendCommunicatorMessage(messageToken, expressionID) {
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID});
        }
        static function configurePartySettings() {
            trace("SchoolParty.configurePartySettings: Entering");
            var _local_4 = CONSTANTS.PARTY_SERVICE.questSettingList;
            if (_local_4 == undefined) {
                return(undefined);
            }
            _quest = new Array();
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_1 = new com.clubpenguin.world.rooms2014.school.vo.SchoolQuestRoomVO();
                var _local_2 = _local_4[_local_3];
                _local_1.roomId = _local_2.roomId;
                _local_1.snowflakeIds = _local_2.questItemIds;
                _local_1.memberItemId = _local_2.memberItemId;
                _local_1.nonMemberItemId = _local_2.nonmemberItemId;
                _local_1.createItemVOs();
                _quest.push(_local_1);
                _local_3++;
            }
            trace("SchoolParty.configurePartySettings quests: " + _quest.length);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 1) {
                return(true);
            }
            return(false);
        }
        static function activateFirstTimeUserPartyFunctionality() {
            pebug("activateFirstTimeUserPartyFunctionality");
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            sendRequestPartyCookie();
            _engine.getRoomMovieClip().room.configureRoomElements();
        }
        static function getScavengerIdsByRoomId(roomId) {
            trace("SchoolParty.getScavengerIdsByRoomId: " + roomId);
            var _local_2 = 0;
            while (_local_2 < _quest.length) {
                var _local_1 = _quest[_local_2];
                trace("SchoolParty.getScavengerIdsByRoomId quest room: " + _local_1.roomId);
                if (roomId == _local_1.roomId) {
                    return(_local_1.snowflakeIds);
                }
                _local_2++;
            }
            return(undefined);
        }
        static function getQuestDataForRoom(roomId) {
            var _local_1 = getScavengerIdsByRoomId(roomId)[0];
            var _local_2 = _local_1 + 3;
            return(partyCookie.snowflakes.slice(_local_1, _local_2));
        }
        static function getRoomVOByRoomID(roomID) {
            var _local_1 = 0;
            while (_local_1 < _quest.length) {
                var _local_2 = _quest[_local_1];
                if (roomID == _local_2.roomId) {
                    return(_quest[_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function setHuntItemCollectedForRoomAtIndex(roomId, offset) {
            var _local_4 = getScavengerIdsByRoomId(roomId);
            var _local_2 = _local_4[0];
            var _local_6 = _local_2 + offset;
            sendItemCollected(_local_6);
            if (partyCookie.msgViewedArray[CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            } else if ((partyCookie.msgViewedArray[CONSTANTS.HUNT_COMPLETE_MESSAGE_NUMBER] == 0) && (partyCookie.areItemsCollected())) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
            var _local_3 = true;
            var _local_1 = 0;
            while (_local_1 < _local_4.length) {
                if ((_local_1 != offset) && (partyCookie.snowflakes[_local_2 + _local_1] != 1)) {
                    _local_3 = false;
                }
                _local_1++;
            }
            if (_local_3) {
                sendTaskCompleteBI(getTaskIDForRoomID(roomId) + 1);
            }
        }
        static function getTaskIDForRoomID(roomID) {
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.ROOMID_TO_TASKID.length) {
                if (CONSTANTS.ROOMID_TO_TASKID[_local_1] == roomID) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        static function playPartyIconSparkles() {
            _interface.PARTY_ICON._visible = true;
            if (_interface.PARTY_ICON.collectedSparkles._currentframe == 1) {
                _interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
            }
            showRookieCharacterDialogue();
        }
        static function showRookieCharacterDialogue() {
            if (partyCookie.areItemsCollected() && (partyCookie.msgViewedArray[CONSTANTS.HUNT_COMPLETE_MESSAGE_NUMBER] == 0)) {
                _interface.showContent(CONSTANTS.HUNTCOMPLETE_PROMPT_PATH);
            }
        }
        static function collectIglooItem(collectionButton) {
            sendCollectIglooItem();
            handleCollectIglooItem(null, collectionButton);
        }
        static function handleCollectIglooItem(data, collectButton) {
            trace("SchoolParty.handleCollectIglooItem");
            _airtower.removeListener(CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, _handleCollectIglooItemDelegate);
            collectButton.gotoAndStop(2);
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _shell.getCurrentServerRoomId());
        }
        static function sendCollectIglooItem() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendRequestPartyCookie() {
            _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#partycookie", [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendItemCollected(itemIndex) {
            trace("SchoolParty.sendItemCollected index: " + itemIndex);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#") + CONSTANTS.COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _shell.getCurrentServerRoomId());
        }
        static function sendGoThereBI(room) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(room, "quest_go_there");
        }
        static function sendOpenQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
        }
        static function sendScrollQuestBI() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
        }
        static function sendTaskCompleteBI(taskID) {
            var _local_2 = CONSTANTS.TASKID_TO_TASKNAME[taskID];
            var _local_1 = {message:_local_2};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(taskID.toString(), "quest_task", _local_1);
        }
        static function sendClassroomSnowballBI(snowballType, numberThrown) {
            var _local_1 = {message:numberThrown};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(snowballType, "sept_snowball", _local_1);
        }
        static function sendGymSnowballBI(numberThrown) {
            trace("SchoolParty.sendGymSnowballBI: " + numberThrown);
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(numberThrown.toString(), "sept_dodge_ball");
        }
        static function sendSkateTrickBI(trickName, count) {
            trace((("SchoolParty.sendSkateTrickBI: " + trickName) + " ") + count);
            var _local_1 = {message:count};
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(trickName, "skatepark", _local_1);
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.school.SchoolPartyConstants;
        static var CLASS_NAME = "SchoolParty";
        static var PARTY_COOKIE_ID = "20140901";
        static var _this = com.clubpenguin.world.rooms2014.school.SchoolParty;
        static var _isActive = false;
    }
