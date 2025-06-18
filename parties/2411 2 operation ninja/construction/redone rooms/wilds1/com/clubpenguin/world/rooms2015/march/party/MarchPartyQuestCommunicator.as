//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator
    {
        static var _party, _shell, _airtower, _interface, _engine, _questCommunicatorTimeout, _genericRoomHintTimeout, _questExploreTimeout, _questGetFishingRodTimeout;
        function MarchPartyQuestCommunicator () {
        }
        static function init() {
            if (_initialized) {
                return(undefined);
            }
            _initialized = true;
            _party = _global.getCurrentParty().MarchParty;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party.pebug("\n\nMarchPartyQuestCommunicator init");
            _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
        }
        static function sendCommunicatorMessage(messageToken, expressionID, duration) {
            _party.pebug((("sendCommunicatorMessage messageToken" + messageToken) + " expression ") + expressionID);
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID, duration:duration});
        }
        static function sendDismissCommunicator() {
            _party.pebug("MarchPartyQuestCommunicator.sendCommunicatorMessage() questcommunicatordismiss");
            _shell.sendDataToAS3("questcommunicatordismiss", {message:undefined});
        }
        static function clearTimeouts() {
            if ((_questCommunicatorTimeout == undefined) && (_genericRoomHintTimeout == undefined)) {
                return(undefined);
            }
            clearTimeout(_questCommunicatorTimeout);
            clearTimeout(_genericRoomHintTimeout);
            clearTimeout(_questExploreTimeout);
            clearTimeout(_questGetFishingRodTimeout);
            _questCommunicatorTimeout = undefined;
            _genericRoomHintTimeout = undefined;
            _questExploreTimeout = undefined;
            _questGetFishingRodTimeout = undefined;
        }
        static function clean() {
            clearTimeouts();
            sendDismissCommunicator();
        }
        static function queuePromptToExploreWilds() {
            if (((_party.partyCookie.qcMsgViewedArray[_party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM] == 1) || (_party.hasPickedUpAFoodItem)) || (_questExploreTimeout)) {
                return(undefined);
            }
            _party.pebug("MarchPartyQuestCommunicator queuePromptToExploreWilds()");
            _questExploreTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayPromptEploreWilds), 420 * SECOND);
        }
        static function displayPromptEploreWilds() {
            if ((_party.partyCookie.qcMsgViewedArray[_party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM] == 1) || (_party.hasPickedUpAFoodItem)) {
                return(undefined);
            }
            _party.pebug("MarchPartyQuestCommunicator displayPromptEploreWilds()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_8_DEEPER_INTO_WOODS, 3);
            setMessageAsViewed(_party.CONSTANTS.QC_8_DEEPER_INTO_WOODS_NUM);
        }
        static function queuePromptToGetFishingRod() {
            if ((_party.partyCookie.qcMsgViewedArray[_party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM] == 1) || (_questGetFishingRodTimeout)) {
                return(undefined);
            }
            _party.pebug("MarchPartyQuestCommunicator queuePromptToGetFishingRod()");
            _questGetFishingRodTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayPromptToGetFishingRod), 300 * SECOND);
        }
        static function displayPromptToGetFishingRod() {
            if (_party.partyCookie.qcMsgViewedArray[_party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM] == 1) {
                return(undefined);
            }
            _party.pebug("MarchPartyQuestCommunicator displayPromptToGetFishingRod()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_24_GET_FISHING_ROD, 3);
            setMessageAsViewed(_party.CONSTANTS.QC_24_GET_FISHING_ROD_NUM);
        }
        static function displayQCMessage(token, artFrameNum, messageIndex) {
            sendCommunicatorMessage(token, artFrameNum);
            _party.pebug((((("MarchPartyQuestCommunicator displayQCMessage() - token : " + token) + " / artFrameNum : ") + artFrameNum) + " / messageIndex : ") + messageIndex);
            if (messageIndex >= 0) {
                setMessageAsViewed(messageIndex);
            }
        }
        static function setMessageAsViewed(messageIndex) {
            _party.pebug("MarchPartyQuestCommunicator setMessageAsViewed() - messageIndex : " + messageIndex);
            if (messageIndex == undefined) {
                return(undefined);
            }
            _party.partyCookie.setQCMessageViewed(messageIndex);
        }
        static var _this = com.clubpenguin.world.rooms2015.march.party.MarchPartyQuestCommunicator;
        static var _initialized = false;
        static var SECOND = 1000;
        static var EXPRESSION_CHARACTER_1 = 0;
    }
