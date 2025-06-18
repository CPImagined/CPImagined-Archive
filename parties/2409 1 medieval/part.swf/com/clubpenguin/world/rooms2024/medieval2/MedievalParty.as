class com.clubpenguin.world.rooms2024.medieval.MedievalParty extends com.clubpenguin.party.template.TemplatedParty {
    static var _shell, _airtower, _interface, _engine, _party, _this, CLASS_NAME, CONSTANTS, _serverCookieService, _serverCookie, _purchaseItemThrottler, _joinRoomDelegate, _interfaceOverrides, _engineOverrides;
    function MedievalParty() {
		CONSTANTS = com.clubpenguin.world.rooms2024.medieval.MedievalPartyConstants;
		_this = com.clubpenguin.world.rooms2024.medieval.MedievalParty;
		CLASS_NAME = "MedievalParty";
	}
	function init() {
		super.init();
	}
	static function startRoomDelegate() {
		if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
			_joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, checkForLoginDialogue);
		};
		trace("room delegate");
	}
	static function checkForLoginDialogue(_arg_1) {
        if ((_shell.getMyPlayerId() != _arg_1.player_id)) {
            return (undefined);
        }
		if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
			_interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
		};
    }
}