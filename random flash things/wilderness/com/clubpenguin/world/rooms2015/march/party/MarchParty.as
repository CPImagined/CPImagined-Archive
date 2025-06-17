class com.clubpenguin.world.rooms2015.march.party.MarchParty
{
    static var _shell, _airtower, _interface, _engine, _party, _partycookieUpdateHandlerDelegate, __get__partyCookie, CLASS_NAME, _questTaskVOs, currentPuffleSelection, _closeUIHandlerDelegate, _taskItemIndex, __get__isActive, __get__partyIconVisible;
    function MarchParty()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty: Entering");
    } // End of the function
    static function init()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty - INIT");
        com.clubpenguin.party.BaseParty.CLASS_NAME = com.clubpenguin.world.rooms2015.march.party.MarchParty._this.CLASS_NAME;
        com.clubpenguin.party.BaseParty.__set__CURRENT_PARTY(com.clubpenguin.world.rooms2015.march.party.MarchParty._this);
        com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
        com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._this, com.clubpenguin.world.rooms2015.march.party.MarchParty.partycookieUpdateHandler);
        com.clubpenguin.world.rooms2015.march.party.MarchParty._airtower.addListener("partycookie", com.clubpenguin.world.rooms2015.march.party.MarchParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().sendRequestPartyCookie();
        com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.init();
    } // End of the function
    static function partycookieUpdateHandler()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("*** MarchParty.partycookieUpdateHandler()", com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
        com.clubpenguin.world.rooms2015.march.party.MarchParty._airtower.removeListener("partycookie", com.clubpenguin.world.rooms2015.march.party.MarchParty._partycookieUpdateHandlerDelegate);
        com.clubpenguin.party.BaseParty.partyIconState();
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.init();
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.queuePromptToExploreWilds();
        com.clubpenguin.world.rooms2015.march.party.MarchParty._engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
        com.clubpenguin.world.rooms2015.march.party.MarchParty._engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
    } // End of the function
    static function configurePartySettings()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("*** MarchParty.configurePartySettings()", com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
        var _loc4 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.PARTY_SERVICE.pufflePartyRewards;
        if (_loc4 == undefined)
        {
            return;
        } // end if
        _questTaskVOs = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc1 = new com.clubpenguin.world.rooms2015.march.vo.PartyQuestTaskVO();
            var _loc2 = _loc4[_loc3];
            _loc1.questItemIndex = _loc2.questItemIndex;
            _loc1.unlockDay = _loc2.unlockDay;
            _loc1.puffleIds = _loc2.puffleIds;
            _loc1.memberItemId = _loc2.memberItemId;
            _loc1.nonMemberItemId = _loc2.nonmemberItemId;
            com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs.push(_loc1);
        } // end of for
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("*** MarchParty.configurePartySettings() - _questTaskVOs.length : " + com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs, com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("*** MarchParty.configurePartySettings() - _questTaskVOs[0] : " + com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs[0], com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
    } // End of the function
    static function getQuestVOByQuestID(questIndex)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs.length; ++_loc1)
        {
            var _loc2 = com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs[_loc1];
            if (questIndex == _loc2.questItemIndex)
            {
                return (com.clubpenguin.world.rooms2015.march.party.MarchParty._questTaskVOs[_loc1]);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function get partyCookie()
    {
        //return ((com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO)(com.clubpenguin.party.BaseParty.serverCookie()));
    } // End of the function
    static function get isActive()
    {
        return (com.clubpenguin.world.rooms2015.march.party.MarchParty._isActive);
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
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.checkForFirstTimeLogin() - playerObj : " + playerObj);
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.checkForFirstTimeLogin() - _shell.getMyPlayerId() : " + com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.getMyPlayerId());
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.getRoomObject().room_id == 112)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.checkForFirstTimeLogin() - SHOW THE LOGIN PROMPT");
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.checkForFirstTimeLogin() - partyCookie.msgViewedArray : " + com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__msgViewedArray());
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.LOGIN_MESSAGE_INDEX] == 0)
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.showContent(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.LOGIN_PROMPT_PATH);
        } // end if
    } // End of the function
    static function get partyIconVisible()
    {
        trace ("MarchParty.partyIconVisible() - DISPLAY ICON : " + com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.LOGIN_MESSAGE_INDEX]);
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.LOGIN_MESSAGE_INDEX] == 1)
        {
            return (true);
        } // end if
        return;
    } // End of the function
    static function activateFirstTimeUserPartyFunctionality()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.clearTimeouts();
    } // End of the function
    static function partyIconClickHandler()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.showQuestCommunicatorMessage(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.QC_2_BACKPACK, 5);
    } // End of the function
    static function showQuestCommunicatorMessage(token, artFrameNum, messageIndex)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.displayQCMessage(token, artFrameNum, messageIndex);
    } // End of the function
    static function displayCharacterDialogue(index)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.showContent(com.clubpenguin.world.rooms2015.march.party.MarchParty.getDialoguePath(index));
    } // End of the function
    static function getDialoguePath(dialogueIndex)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MARCH PARTY GET DIALOGUE PATH -- dialogueIndex : " + dialogueIndex);
        var _loc1 = "";
        switch (dialogueIndex)
        {
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.GET_FISHING_ROD_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.CONGRATS_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.CONGRATS_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISH_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISH_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISHING_ROD_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISHING_ROD_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.MARCH_COMIC_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.MARCH_COMIC_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.CHEESE_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.CHEESE_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.ROCK_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.ROCK_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SANDWICH_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SANDWICH_PROMPT_PATH;
                break;
            } 
            case com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.COFFEE_REACTION_MESSAGE_INDEX:
            {
                _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.COFFEE_PROMPT_PATH;
                break;
            } 
        } // End of switch
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MARCH PARTY GET DIALOGUE PATH -- promptString : " + _loc1);
        return (_loc1);
    } // End of the function
    static function showGetFishingRodDialoguePopup()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX] == 0)
        {
            setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._this, com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue), 1000, com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.GET_FISHING_ROD_MESSAGE_INDEX);
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchParty.startFishingRodPromptTimer();
    } // End of the function
    static function showAwardItemUI(puffleTaskIndex)
    {
        currentPuffleSelection = puffleTaskIndex;
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.areBothItemsInInventory(puffleTaskIndex))
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.showContent(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.AWARDS_COLLECTION_UI);
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.checkPuffleTasksCompleted() == true && puffleTaskIndex != com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_TASK_INDEX)
        {
            _closeUIHandlerDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._this, com.clubpenguin.world.rooms2015.march.party.MarchParty.onUIClose);
            com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.addListener(com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.CONTENT_CLOSED, com.clubpenguin.world.rooms2015.march.party.MarchParty._closeUIHandlerDelegate);
        } // end if
    } // End of the function
    static function onUIClose()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.onUIClose !!!!!!!!!!!!!!!!");
        com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.removeListener(com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.CONTENT_CLOSED, com.clubpenguin.world.rooms2015.march.party.MarchParty._closeUIHandlerDelegate);
        com.clubpenguin.world.rooms2015.march.party.MarchParty.showGetFishingRodDialoguePopup();
    } // End of the function
    static function setTaskItemComplete(taskNumber)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.setTaskItemComplete() - taskNumber : " + taskNumber, com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
        com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().sendTaskComplete(taskNumber);
        if (taskNumber == com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_TASK_INDEX)
        {
            setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._party, com.clubpenguin.world.rooms2015.march.party.MarchParty.displayQuestCompletedPopups), 2500);
        }
        else
        {
            setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._party, com.clubpenguin.world.rooms2015.march.party.MarchParty.showAwardItemUI), 2500, taskNumber);
        } // end else if
        com.clubpenguin.world.rooms2015.march.party.MarchParty.sendTaskCompleteBI(taskNumber);
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.checkPuffleTasksCompleted())
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty.sendTaskCompleteBI(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.ALL_BERRIES_ON_TABLE_BI_INDEX);
        } // end if
    } // End of the function
    static function checkPuffleTasksCompleted()
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__questItems().length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2015.march.party.MarchParty.__get__partyCookie().__get__questItems()[_loc1] == 0)
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function getCurrentTaskItemIndex()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty._taskItemIndex >= 0)
        {
            return (com.clubpenguin.world.rooms2015.march.party.MarchParty._taskItemIndex);
        }
        else
        {
            return (-1);
        } // end else if
    } // End of the function
    static function areBothItemsInInventory(taskID)
    {
        var _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.getQuestVOByQuestID(taskID);
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.isItemInMyInventory(_loc1.nonMemberItemId) && com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.isItemInMyInventory(_loc1.memberItemId))
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function startFishingRodPromptTimer()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.queuePromptToGetFishingRod();
    } // End of the function
    static function collectTaskItem(itemType)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.pickUpItem() - taskItemIndex : " + com.clubpenguin.world.rooms2015.march.party.MarchParty._taskItemIndex);
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.QUEST_ITEMS_IDS.length; ++_loc1)
        {
            if (itemType == com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.QUEST_ITEMS_IDS[_loc1])
            {
                _taskItemIndex = _loc1;
                break;
            } // end if
        } // end of for
        com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.PARTY_ICON.icon_collected.gotoAndStop(itemType);
        if (itemType == "fishingrod")
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.setMessageAsViewed(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.QC_24_GET_FISHING_ROD_NUM);
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_fishingrod");
        }
        else if (itemType == "fish")
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_fish");
        }
        else if (com.clubpenguin.world.rooms2015.march.party.MarchParty.isBerry(itemType))
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playRandomSound("pickup_berry", 1, 2);
        }
        else
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartySounds.playPartySound("pickup_joke_item1");
        } // end else if
    } // End of the function
    static function isBerry(targetString)
    {
        var _loc1 = ["redBerry", "yellowBerry", "whiteBerry", "greenBerry", "oBerry"];
        return (_loc1.toString().indexOf(targetString) > -1);
    } // End of the function
    static function itemPlacedOnStump()
    {
        _taskItemIndex = -1;
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.itemPlacedOnStump() - _taskItemIndex : " + com.clubpenguin.world.rooms2015.march.party.MarchParty._taskItemIndex);
        com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.PARTY_ICON.icon_collected.gotoAndStop("none");
    } // End of the function
    static function displayQuestCompletedPopups()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.displayQuestCompletedPopups() -- sasquatchDialoguePopupNum : " + com.clubpenguin.world.rooms2015.march.party.MarchParty.sasquatchDialoguePopupNum, com.clubpenguin.world.rooms2015.march.party.MarchParty.CLASS_NAME + "()");
        switch (com.clubpenguin.world.rooms2015.march.party.MarchParty.sasquatchDialoguePopupNum)
        {
            case 0:
            {
                com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_MESSAGE_INDEX);
                break;
            } 
            case 1:
            {
                com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISH_REACTION_MESSAGE_INDEX);
                break;
            } 
            case 2:
            {
                com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISHING_ROD_REACTION_MESSAGE_INDEX);
                break;
            } 
            case 3:
            {
                com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.MARCH_COMIC_INDEX);
                break;
            } 
            case 4:
            {
                com.clubpenguin.world.rooms2015.march.party.MarchParty.displayCharacterDialogue(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.CONGRATS_MESSAGE_INDEX);
                break;
            } 
            case 5:
            {
                setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchParty._party, com.clubpenguin.world.rooms2015.march.party.MarchParty.showAwardItemUI), 500, com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.SASQUATCH_TASK_INDEX);
                sasquatchDialoguePopupNum = 0;
                break;
            } 
        } // End of switch
        sasquatchDialoguePopupNum = ++com.clubpenguin.world.rooms2015.march.party.MarchParty.sasquatchDialoguePopupNum;
    } // End of the function
    static function setSasquatchDialogueNum()
    {
        sasquatchDialoguePopupNum = 0;
    } // End of the function
    static function showPuffleAdoption(puffleID)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.showPuffleAdoption() - puffleID : " + puffleID);
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.puffleManager.myPuffles.length >= com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.MAX_PUFFLES)
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.$e("HolidayParty -> Max Puffles Reached", {error_code: com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.MAX_PUFFLE_LIMIT});
            return;
        } // end if
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty._shell.isMyPlayerMember())
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType: puffleID}, true);
        }
        else
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty._interface.showContent(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        } // end else if
    } // End of the function
    static function transformPuffle(puffleID)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchParty.pebug("MarchParty.transformPuffle() - puffleID : " + puffleID);
    } // End of the function
    static function sendTaskCompleteBI(taskID)
    {
        var _loc2 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.TASKID_TO_TASKNAME[taskID];
        var _loc1 = com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.TASKID_TO_MOBILE_ID[taskID];
        com.clubpenguin.party.BaseParty.sendTaskCompleteBI(_loc1, _loc2);
    } // End of the function
    static var CONSTANTS = com.clubpenguin.world.rooms2015.march.party.MarchPartyConstants;
    static var _this = com.clubpenguin.world.rooms2015.march.party.MarchParty;
    static var _isActive = false;
    static var sasquatchDialoguePopupNum = 0;
} // End of Class
