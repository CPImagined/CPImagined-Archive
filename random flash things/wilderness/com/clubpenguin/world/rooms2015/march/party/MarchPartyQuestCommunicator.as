class com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator
{
    static var _party, _shell, _airtower, _interface, _engine, _questCommunicatorTimeout, _genericRoomHintTimeout, _questExploreTimeout, _questGetFishingRodTimeout;
    function MarchPartyQuestCommunicator()
    {
    } // End of the function
    static function init()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._initialized)
        {
            return;
        } // end if
        _initialized = true;
        _party = _global.getCurrentParty().MarchParty;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("\n\nMarchPartyQuestCommunicator init");
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled: false, hideLoadingDialog: true});
    } // End of the function
    static function sendCommunicatorMessage(messageToken, expressionID, duration)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("sendCommunicatorMessage messageToken" + messageToken + " expression " + expressionID);
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._shell.sendDataToAS3("questcommunicator", {message: messageToken, expression: expressionID, duration: duration});
    } // End of the function
    static function sendDismissCommunicator()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator.sendCommunicatorMessage() questcommunicatordismiss");
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._shell.sendDataToAS3("questcommunicatordismiss", {message: undefined});
    } // End of the function
    static function clearTimeouts()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questCommunicatorTimeout == undefined && com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._genericRoomHintTimeout == undefined)
        {
            return;
        } // end if
        clearTimeout(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questCommunicatorTimeout);
        clearTimeout(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._genericRoomHintTimeout);
        clearTimeout(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questExploreTimeout);
        clearTimeout(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questGetFishingRodTimeout);
        _questCommunicatorTimeout = undefined;
        _genericRoomHintTimeout = undefined;
        _questExploreTimeout = undefined;
        _questGetFishingRodTimeout = undefined;
    } // End of the function
    static function clean()
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.clearTimeouts();
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.sendDismissCommunicator();
    } // End of the function
    static function queuePromptToExploreWilds()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.partyCookie.qcMsgViewedArray[com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM] == 1 || com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.hasPickedUpAFoodItem || com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questExploreTimeout)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator queuePromptToExploreWilds()");
        _questExploreTimeout = setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._this, com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.displayPromptEploreWilds), 420 * com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.SECOND);
    } // End of the function
    static function displayPromptEploreWilds()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.partyCookie.qcMsgViewedArray[com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM] == 1 || com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.hasPickedUpAFoodItem)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator displayPromptEploreWilds()");
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.sendCommunicatorMessage(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_8_DEEPER_INTO_WOODS, 3);
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.setMessageAsViewed(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM);
    } // End of the function
    static function queuePromptToGetFishingRod()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.partyCookie.qcMsgViewedArray[com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM] == 1 || com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._questGetFishingRodTimeout)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator queuePromptToGetFishingRod()");
        _questGetFishingRodTimeout = setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._this, com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.displayPromptToGetFishingRod), 300 * com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.SECOND);
    } // End of the function
    static function displayPromptToGetFishingRod()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.partyCookie.qcMsgViewedArray[com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM] == 1)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator displayPromptToGetFishingRod()");
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.sendCommunicatorMessage(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_24_GET_FISHING_ROD, 3);
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.setMessageAsViewed(com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM);
    } // End of the function
    static function displayQCMessage(token, artFrameNum, messageIndex)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.sendCommunicatorMessage(token, artFrameNum);
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator displayQCMessage() - token : " + token + " / artFrameNum : " + artFrameNum + " / messageIndex : " + messageIndex);
        if (messageIndex >= 0)
        {
            com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator.setMessageAsViewed(messageIndex);
        } // end if
    } // End of the function
    static function setMessageAsViewed(messageIndex)
    {
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.pebug("MarchPartyQuestCommunicator setMessageAsViewed() - messageIndex : " + messageIndex);
        if (messageIndex == undefined)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator._party.partyCookie.setQCMessageViewed(messageIndex);
    } // End of the function
    static var _this = com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator;
    static var _initialized = false;
    static var SECOND = 1000;
    static var EXPRESSION_CHARACTER_1 = 0;
} // End of Class
