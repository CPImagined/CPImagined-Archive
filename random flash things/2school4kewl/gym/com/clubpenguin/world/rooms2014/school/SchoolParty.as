class com.clubpenguin.world.rooms2014.school.SchoolParty
{
    static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, _quest, __get__partyCookie, _handleCollectIglooItemDelegate, __get__isActive, __get__partyIconVisible;
    function SchoolParty()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty.pebug("SCHOOL PARTY - INIT");
        com.clubpenguin.party.BaseParty.CLASS_NAME = com.clubpenguin.world.rooms2014.school.SchoolParty._this.CLASS_NAME;
        com.clubpenguin.party.BaseParty.__set__CURRENT_PARTY(com.clubpenguin.world.rooms2014.school.SchoolParty._this);
        com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
        com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        trace ("SchoolParty.init");
        _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.school.SchoolParty._this, com.clubpenguin.world.rooms2014.school.SchoolParty.partycookieUpdateHandler);
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.addListener("partycookie", com.clubpenguin.world.rooms2014.school.SchoolParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.world.rooms2014.school.SchoolParty.sendRequestPartyCookie();
    } // End of the function
    static function partycookieUpdateHandler()
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.removeListener("partycookie", com.clubpenguin.world.rooms2014.school.SchoolParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.world.rooms2014.school.SchoolParty.pebug("partycookieUpdateHandler update icon state ");
        com.clubpenguin.party.BaseParty.partyIconState();
    } // End of the function
    static function sendCommunicatorMessage(messageToken, expressionID)
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._shell.sendDataToAS3("questcommunicator", {message: messageToken, expression: expressionID});
    } // End of the function
    static function configurePartySettings()
    {
        trace ("SchoolParty.configurePartySettings: Entering");
        var _loc4 = com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.PARTY_SERVICE.questSettingList;
        if (_loc4 == undefined)
        {
            return;
        } // end if
        _quest = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc1 = new com.clubpenguin.world.rooms2014.school.vo.SchoolQuestRoomVO();
            var _loc2 = _loc4[_loc3];
            _loc1.roomId = _loc2.roomId;
            _loc1.snowflakeIds = _loc2.questItemIds;
            _loc1.memberItemId = _loc2.memberItemId;
            _loc1.nonMemberItemId = _loc2.nonmemberItemId;
            _loc1.createItemVOs();
            com.clubpenguin.world.rooms2014.school.SchoolParty._quest.push(_loc1);
        } // end of for
        trace ("SchoolParty.configurePartySettings quests: " + com.clubpenguin.world.rooms2014.school.SchoolParty._quest.length);
    } // End of the function
    static function get partyCookie()
    {
        //return ((com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO)(com.clubpenguin.party.BaseParty.serverCookie()));
    } // End of the function
    static function get isActive()
    {
        return (com.clubpenguin.world.rooms2014.school.SchoolParty._isActive);
    } // End of the function
    static function pebug(msg, prefix)
    {
        com.clubpenguin.party.BaseParty.pebug(msg, prefix);
    } // End of the function
    static function playSound(ui, soundId, volume)
    {
        com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        if (com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getRoomObject().room_id == 112)
        {
            return;
        } // end if
        if (com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty._interface.showContent(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_PROMPT_PATH);
        } // end if
    } // End of the function
    static function get partyIconVisible()
    {
        if (com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_MESSAGE_NUMBER] == 1)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function getScavengerIdsByRoomId(roomId)
    {
        trace ("SchoolParty.getScavengerIdsByRoomId: " + roomId);
        for (var _loc2 = 0; _loc2 < com.clubpenguin.world.rooms2014.school.SchoolParty._quest.length; ++_loc2)
        {
            var _loc1 = com.clubpenguin.world.rooms2014.school.SchoolParty._quest[_loc2];
            trace ("SchoolParty.getScavengerIdsByRoomId quest room: " + _loc1.roomId);
            if (roomId == _loc1.roomId)
            {
                return (_loc1.snowflakeIds);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getQuestDataForRoom(roomId)
    {
        var _loc1 = com.clubpenguin.world.rooms2014.school.SchoolParty.getScavengerIdsByRoomId(roomId)[0];
        var _loc2 = _loc1 + 3;
        //return (com.clubpenguin.world.rooms2014.school.SchoolParty.partyCookie().__get__snowflakes().slice(_loc1, _loc2));
    } // End of the function
    static function getRoomVOByRoomID(roomID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.school.SchoolParty._quest.length; ++_loc1)
        {
            var _loc2 = com.clubpenguin.world.rooms2014.school.SchoolParty._quest[_loc1];
            if (roomID == _loc2.roomId)
            {
                return (com.clubpenguin.world.rooms2014.school.SchoolParty._quest[_loc1]);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function setHuntItemCollectedForRoomAtIndex(roomId, offset)
    {
        var _loc4 = com.clubpenguin.world.rooms2014.school.SchoolParty.getScavengerIdsByRoomId(roomId);
        var _loc2 = _loc4[0];
        var _loc6 = _loc2 + offset;
        com.clubpenguin.world.rooms2014.school.SchoolParty.sendItemCollected(_loc6);
        if (com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_MESSAGE_NUMBER] == 0)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty._interface.showContent(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_PROMPT_PATH);
        }
        else if (com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.HUNT_COMPLETE_MESSAGE_NUMBER] == 0 && com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().areItemsCollected())
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty._interface.showContent(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.LOGIN_PROMPT_PATH);
        } // end else if
        var _loc3 = true;
        for (var _loc1 = 0; _loc1 < _loc4.length; ++_loc1)
        {
            if (_loc1 != offset && com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().__get__snowflakes()[_loc2 + _loc1] != 1)
            {
                _loc3 = false;
            } // end if
        } // end of for
        if (_loc3)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty.sendTaskCompleteBI(com.clubpenguin.world.rooms2014.school.SchoolParty.getTaskIDForRoomID(roomId) + 1);
        } // end if
    } // End of the function
    static function getTaskIDForRoomID(roomID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.ROOMID_TO_TASKID.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.ROOMID_TO_TASKID[_loc1] == roomID)
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function playPartyIconSparkles()
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._interface.PARTY_ICON._visible = true;
        if (com.clubpenguin.world.rooms2014.school.SchoolParty._interface.PARTY_ICON.collectedSparkles._currentframe == 1)
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty._interface.PARTY_ICON.collectedSparkles.gotoAndStop(2);
        } // end if
        com.clubpenguin.world.rooms2014.school.SchoolParty.showRookieCharacterDialogue();
    } // End of the function
    static function showRookieCharacterDialogue()
    {
        if (com.clubpenguin.world.rooms2014.school.SchoolParty.__get__partyCookie().areItemsCollected())
        {
            com.clubpenguin.world.rooms2014.school.SchoolParty._interface.showContent(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.HUNTCOMPLETE_PROMPT_PATH);
        } // end if
    } // End of the function
    static function collectIglooItem(collectionButton)
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty.sendCollectIglooItem();
        com.clubpenguin.world.rooms2014.school.SchoolParty.handleCollectIglooItem(null, collectionButton);
    } // End of the function
    static function handleCollectIglooItem(data, collectButton)
    {
        trace ("SchoolParty.handleCollectIglooItem");
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.removeListener(com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, com.clubpenguin.world.rooms2014.school.SchoolParty._handleCollectIglooItemDelegate);
        collectButton.gotoAndStop(2);
    } // End of the function
    static function sendMessageViewed(message)
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.send(com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendCollectIglooItem()
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.send(com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.COLLECT_IGLOO_ITEM_COMMAND, [0], "str", com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendRequestPartyCookie()
    {
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.send(com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#partycookie", [0], "str", com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendItemCollected(itemIndex)
    {
        trace ("SchoolParty.sendItemCollected index: " + itemIndex);
        com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.send(com.clubpenguin.world.rooms2014.school.SchoolParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.school.SchoolParty.CONSTANTS.COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", com.clubpenguin.world.rooms2014.school.SchoolParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendGoThereBI(room)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(room, "quest_go_there");
    } // End of the function
    static function sendOpenQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_open");
    } // End of the function
    static function sendScrollQuestBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_ui_end");
    } // End of the function
    static function sendTaskCompleteBI(taskID)
    {
        var _loc2 = "TODO: get taskname";
        var _loc1 = {message: _loc2};
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(taskID.toString(), "quest_task", _loc1);
    } // End of the function
    static function sendClassroomSnowballBI(snowballType, numberThrown)
    {
        var _loc1 = {message: numberThrown};
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(snowballType, "sept_snowball", _loc1);
    } // End of the function
    static function sendGymSnowballBI(numberThrown)
    {
        trace ("SchoolParty.sendGymSnowballBI: " + numberThrown);
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(numberThrown.toString(), "sept_dodge_ball");
    } // End of the function
    static function sendSkateTrickBI(trickName, count)
    {
        trace ("SchoolParty.sendSkateTrickBI: " + trickName + " " + count);
        var _loc1 = {message: count};
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(trickName, "skatepark", _loc1);
    } // End of the function
    static var CONSTANTS = com.clubpenguin.world.rooms2014.school.SchoolPartyConstants;
    static var CLASS_NAME = "SchoolParty";
    static var PARTY_COOKIE_ID = "20140901";
    static var _this = com.clubpenguin.world.rooms2014.school.SchoolParty;
    static var _isActive = false;
} // End of Class
