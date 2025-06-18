//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator
    {
        static var _shell, _airtower, _interface, _engine, _party, _fightCrabsTimeout, _duelPlayersTimeout;
        function PiratePartyQuestCommunicator () {
        }
        static function init() {
            if (_initialized) {
                return(undefined);
            }
            _initialized = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty().PirateParty;
            _party.pebug("\n\\iratePartyQuestCommunicator init");
            _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
            checkDisplayHelpFightCrabsMessage();
            checkDisplayDuelPlayersMessage();
        }
        static function sendCommunicatorMessage(messageToken, expressionID, duration) {
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID, duration:duration});
        }
        static function sendDismissCommunicator() {
            _shell.sendDataToAS3("questcommunicatordismiss", {message:undefined});
        }
        static function clearTimeouts() {
            clearFightCrabsTimeout();
            clearDuelPlayersTimeout();
        }
        static function clean() {
            clearTimeouts();
            sendDismissCommunicator();
        }
        static function displayLoseAttackMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC3) displayLoseAttackMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_LOSE_ATTACK_MESSAGE, EXPRESSION_ROCKHOPPER_2);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_LOSE_ATTACK_MESSAGE_NUMBER);
        }
        static function displayWinAttackMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC4) displayWinAttackMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_WIN_ATTACK_MESSAGE, EXPRESSION_ROCKHOPPER_1);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_WIN_ATTACK_MESSAGE_NUMBER);
        }
        static function displayTieAttackMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC5) displayTieAttackMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_TIE_ATTACK_MESSAGE, EXPRESSION_ROCKHOPPER_2);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_TIE_ATTACK_MESSAGE_NUMBER);
        }
        static function displayNewSwordMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC7) displayNewSwordMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_NEW_SWORD_MESSAGE, EXPRESSION_ROCKHOPPER_1);
            com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_NEW_SWORD_MESSAGE_NUMBER);
        }
        static function displayLastSwordMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC17) displayLastSwordMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_UNLOCK_LAST_SWORD_MESSAGE, EXPRESSION_ROCKHOPPER_1);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_UNLOCK_LAST_SWORD_MESSAGE_NUMBER);
        }
        static function displayDefeatThirdCrabMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC8) displayDefeatThirdCrabMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DEFEAT_CRAB_MESSAGE, EXPRESSION_ROCKHOPPER_1);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_DEFEAT_CRAB_MESSAGE_NUMBER);
        }
        static function checkDisplayHelpFightCrabsMessage() {
            if ((_party.partyCookie.numTasksCompleted < _party.partyCookie.questItems.length) && (_shell.getRoomObject().room_id != com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.CRAB_BATTLE_ROOM_ID)) {
                _party.pebug("PiratePartyQuestCommunicator (QC10) checkDisplayHelpFightCrabsMessage()");
                _fightCrabsTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayHelpFightCrabsMessage), 120 * SECOND);
            }
        }
        static function displayHelpFightCrabsMessage() {
            if (_shell.getRoomObject().room_id != com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.CRAB_BATTLE_ROOM_ID) {
                return(undefined);
            }
            _party.pebug("PiratePartyQuestCommunicator (QC10) displayHelpFightCrabsMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_MORE_CRABS_MESSAGE, EXPRESSION_ROCKHOPPER_3);
            clearFightCrabsTimeout();
        }
        static function clearFightCrabsTimeout() {
            _party.pebug("-------- PiratePartyQuestCommunicator clearFightCrabsTimeout--------" + _fightCrabsTimeout);
            if (_fightCrabsTimeout == undefined) {
                return(undefined);
            }
            clearTimeout(_fightCrabsTimeout);
            _fightCrabsTimeout = undefined;
        }
        static function checkDisplayDuelPlayersMessage() {
            if ((_party.partyCookie.didCompleteAtLeastOneTask && (_party.partyCookie.points <= 0)) && (!_party.partyCookie.hasPlayerViewedQCMessage(_party.CONSTANTS.QC_DUEL_PLAYERS_MESSAGE_NUMBER))) {
                clearDuelPlayersTimeout();
                _party.pebug("PiratePartyQuestCommunicator (QC10) checkDisplayDuelPlayersMessage()");
                _duelPlayersTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayDuelPlayersMessage), 180 * SECOND);
            }
        }
        static function displayDuelPlayersMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC8) displayDuelPlayersMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DUEL_PLAYERS_MESSAGE, EXPRESSION_ROCKHOPPER_1);
            _party.partyCookie.setQCMessageViewed(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.QC_DUEL_PLAYERS_MESSAGE_NUMBER);
            clearDuelPlayersTimeout();
        }
        static function clearDuelPlayersTimeout() {
            _party.pebug("-------- PiratePartyQuestCommunicator clearDuelPlayersTimeout--------" + _duelPlayersTimeout);
            if (_duelPlayersTimeout == undefined) {
                return(undefined);
            }
            clearTimeout(_duelPlayersTimeout);
            _duelPlayersTimeout = undefined;
        }
        static function displayCongratulationsMessage() {
            _party.pebug("PiratePartyQuestCommunicator (QC8) displayCongratulationsMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_CONGRATULATIONS_MESSAGE, EXPRESSION_ROCKHOPPER_2);
        }
        static var _this = com.clubpenguin.world.rooms2014.pirate.party.PiratePartyQuestCommunicator;
        static var _initialized = false;
        static var SECOND = 1000;
        static var EXPRESSION_ROCKHOPPER_1 = 0;
        static var EXPRESSION_ROCKHOPPER_2 = 1;
        static var EXPRESSION_ROCKHOPPER_3 = 2;
        static var EXPRESSION_ROCKHOPPER_4 = 3;
    }
