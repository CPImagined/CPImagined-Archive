class com.clubpenguin.world.rooms2025.time.TimePartyQuestCom {
    static var _party,
    _shell,
    _airtower,
    _interface,
    _engine,
    _questCommunicatorTimeout;
    function TimePartyQuestCom() {}
    static function init() {
        if (_initialized) {
            return (undefined);
        }
        _initialized = true;
        _party = _global.getCurrentParty().CURRENT_PARTY;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        pebug("\n\nTimePartyQuestCom init");
        pebug("CURRENT PARTY : " + _party);
        _shell.sendOpenAS3Module("quest_communicator", null, {
            modalBackgroundEnabled: false,
            hideLoadingDialog: true
        });
    }
    static function sendCommunicatorMessage(_arg_4, _arg_5, _arg_1) {
		if(_arg_1 == undefined) {
			_arg_1 = (SECOND * 8);
		};
        pebug((("sendCommunicatorMessage messageToken" + _arg_4) + " expression ") + _arg_5);
        _shell.sendDataToAS3("questcommunicator", {
            message: _arg_4,
            expression: _arg_5,
            duration: _arg_1
        });
    }
    static function sendDismissCommunicator() {
        pebug("TimePartyQuestCom.sendCommunicatorMessage() questcommunicatordismiss");
        _shell.sendDataToAS3("questcommunicatordismiss", {
            message: undefined
        });
    }
    static function clearTimeouts() {
        if (_questCommunicatorTimeout == undefined) {
            return (undefined);
        }
        clearTimeout(_questCommunicatorTimeout);
        _questCommunicatorTimeout = undefined;
    }
    static function clean() {
        clearTimeouts();
        sendDismissCommunicator();
    }
	static function pebug(message) {
		flash.external.ExternalInterface.call('console.log', message);
	}
	static var _this = com.clubpenguin.world.rooms2025.time.TimePartyQuestCom
    static var _initialized = false;
    static var SECOND = 1000;
    static var EXPRESSION_CHARACTER_1 = 0;
}