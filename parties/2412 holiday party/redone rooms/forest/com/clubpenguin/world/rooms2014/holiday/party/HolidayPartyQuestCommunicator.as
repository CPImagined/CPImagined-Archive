//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyQuestCommunicator
    {
        static var _party, _shell, _airtower, _interface, _engine, _questCommunicatorTimeout, _genericRoomHintTimeout;
        function HolidayPartyQuestCommunicator () {
        }
        static function init() {
            if (_initialized) {
                return(undefined);
            }
            _party.pebug("\n\nHolidayPartyQuestCommunicator init");
            _initialized = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty().HolidayParty;
            _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
        }
        static function sendCommunicatorMessage(messageToken, expressionID, duration) {
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID, duration:duration});
        }
        static function sendDismissCommunicator() {
            _shell.sendDataToAS3("questcommunicatordismiss", {message:undefined});
        }
        static function clearTimeouts() {
            if ((_questCommunicatorTimeout == undefined) && (_genericRoomHintTimeout == undefined)) {
                return(undefined);
            }
            clearTimeout(_questCommunicatorTimeout);
            clearTimeout(_genericRoomHintTimeout);
            _questCommunicatorTimeout = undefined;
            _genericRoomHintTimeout = undefined;
        }
        static function clean() {
            clearTimeouts();
            sendDismissCommunicator();
        }
        static function displayDecorateTreeQCMessage() {
            if (_party.partyCookie.hasPlayerViewedQCMessage(_party.CONSTANTS.QC_DECORATE_TREE_MESSAGE_NUMBER)) {
                return(undefined);
            }
            _party.pebug("HolidayPartyQuestCommunicator displaySampleQuestCommunicatorMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DECORATE_TREE, MERRY_WALRUS_EXPRESSION_1);
            _party.partyCookie.setQCMessageViewed(_party.CONSTANTS.QC_DECORATE_TREE_MESSAGE_NUMBER);
            _party.sendQuestCommunicatorBI(0, "Decorate tree");
        }
        static function displayBellsQCMessage() {
            if (_party.partyCookie.hasPlayerViewedQCMessage(_party.CONSTANTS.QC_BELLS_MESSAGE_NUMBER)) {
                return(undefined);
            }
            _party.pebug("HolidayPartyQuestCommunicator displaySampleQuestCommunicatorMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BELLS, MERRY_WALRUS_EXPRESSION_2);
            _party.partyCookie.setQCMessageViewed(_party.CONSTANTS.QC_BELLS_MESSAGE_NUMBER);
            _party.sendQuestCommunicatorBI(0, "Plaza bells");
        }
        static function displayFoodFightQCMessage() {
            if (_party.partyCookie.hasPlayerViewedQCMessage(_party.CONSTANTS.QC_FOOD_FIGHT_MESSAGE_NUMBER)) {
                return(undefined);
            }
            _party.pebug("HolidayPartyQuestCommunicator displaySampleQuestCommunicatorMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FOOD_FIGHT, MERRY_WALRUS_EXPRESSION_1);
            _party.partyCookie.setQCMessageViewed(_party.CONSTANTS.QC_FOOD_FIGHT_MESSAGE_NUMBER);
            _party.sendQuestCommunicatorBI(0, "Food fight");
        }
        static function displayCoinsForChangeQCMessage(index) {
            _party.pebug("HolidayPartyQuestCommunicator displaySampleQuestCommunicatorMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_COINS_FOR_CHANGE, MERRY_WALRUS_EXPRESSION_1);
            displayCollectRewardQCMessage();
            _party.sendQuestCommunicatorBI(index, "Task complete");
        }
        static function displayCollectRewardQCMessage() {
            _party.pebug("HolidayPartyQuestCommunicator displaySampleQuestCommunicatorMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_COLLECT_REWARD, MERRY_WALRUS_EXPRESSION_2);
            _party.sendQuestCommunicatorBI(0, "Collect your reward");
        }
        static var _this = com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyQuestCommunicator;
        static var _initialized = false;
        static var SECOND = 1000;
        static var MERRY_WALRUS_EXPRESSION_1 = 0;
        static var MERRY_WALRUS_EXPRESSION_2 = 1;
    }
