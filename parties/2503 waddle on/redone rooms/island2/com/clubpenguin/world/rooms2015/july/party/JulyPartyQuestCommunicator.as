//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyPartyQuestCommunicator
    {
        static var _party, _shell, _airtower, _interface, _engine, _questCommunicatorTimeout;
        function JulyPartyQuestCommunicator () {
        }
        static function init() {
            if (_initialized) {
                return(undefined);
            }
            _initialized = true;
            _party = _global.getCurrentParty().JulyParty;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party.pebug("\n\nJulyPartyQuestCommunicator init");
            _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
        }
        static function sendCommunicatorMessage(messageToken, expressionID, duration) {
            _party.pebug((("sendCommunicatorMessage messageToken" + messageToken) + " expression ") + expressionID);
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID, duration:duration});
        }
        static function sendDismissCommunicator() {
            _party.pebug("JulyPartyQuestCommunicator.sendCommunicatorMessage() questcommunicatordismiss");
            _shell.sendDataToAS3("questcommunicatordismiss", {message:undefined});
        }
        static function clearTimeouts() {
            if (_questCommunicatorTimeout == undefined) {
                return(undefined);
            }
            clearTimeout(_questCommunicatorTimeout);
            _questCommunicatorTimeout = undefined;
        }
        static function clean() {
            clearTimeouts();
            sendDismissCommunicator();
        }
        static function displayQCMessage(index) {
            var _local_1 = index + 1;
            sendCommunicatorMessage(getToken(index), _local_1);
            _party.pebug((("JulyPartyQuestCommunicator displayQCMessage() - token : " + getToken(index)) + " / frameNum : ") + _local_1);
        }
        static function getToken(num) {
            switch (num) {
                case 0 : 
                    return(com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.QC_1_MESSAGE_JOY);
                    break;
                case 1 : 
                    return(com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.QC_2_MESSAGE_SADNESS);
                    break;
                case 2 : 
                    return(com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.QC_3_MESSAGE_ANGER);
                    break;
                case 3 : 
                    return(com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.QC_4_MESSAGE_DISGUST);
                    break;
                case 4 : 
                    return(com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.QC_5_MESSAGE_FEAR);
                    break;
            }
        }
        static var _this = com.clubpenguin.world.rooms2015.july.party.JulyPartyQuestCommunicator;
        static var _initialized = false;
        static var SECOND = 1000;
        static var EXPRESSION_CHARACTER_1 = 0;
    }
