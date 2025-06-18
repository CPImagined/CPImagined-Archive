class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyQuestCom{
    static var _party,
    _shell,
    _airtower,
    _interface,
    _engine,
    _questCommunicatorTimeout,
    _newContestPromptTimeout;
    function PrehistoricPartyQuestCom() {}
    static function init() {
        if (_initialized) {
            return (undefined);
        }
        _initialized = true;
        _party = _global.getCurrentParty().PrehistoricParty;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        pebug("\n\nPrehistoricPartyQuestCom init");
        pebug("CURRENT PARTY : " + _party);
        _shell.sendOpenAS3Module("quest_communicator", null, {
            modalBackgroundEnabled: false,
            hideLoadingDialog: true
        });
    }
    static function sendCommunicatorMessage(_arg_4, _arg_5, _arg_1) {
        pebug((("sendCommunicatorMessage messageToken" + _arg_4) + " expression ") + _arg_5);
        _shell.sendDataToAS3("questcommunicator", {
            message: _arg_4,
            expression: _arg_5,
            duration: _arg_1
        });
    }
    static function sendDismissCommunicator() {
        pebug("PrehistoricPartyQuestCom.sendCommunicatorMessage() questcommunicatordismiss");
        _shell.sendDataToAS3("questcommunicatordismiss", {
            message: undefined
        });
    }
    static function clearTimeouts() {
        if (_questCommunicatorTimeout == undefined) {
            return (undefined);
        }
        clearTimeout(_questCommunicatorTimeout);
        clearTimeout(_newContestPromptTimeout);
        _questCommunicatorTimeout = undefined;
        _newContestPromptTimeout = undefined;
    }
    static function clean() {
        clearTimeouts();
        sendDismissCommunicator();
    }
	static function showGaryQCMessage(string) {
		sendCommunicatorMessage(string, 1, 5000);
	}
	static function showGaruggQCMessage(string) {
		sendCommunicatorMessage(string, 2, 5000);
		
	}
	static function pebug(message) {
		flash.external.ExternalInterface.call('console.log', message);
	}
    static var _this =com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyQuestCom;
    static var _initialized = false;
    static var SECOND = 1000;
    static var EXPRESSION_CHARACTER_1 = 0;
}
