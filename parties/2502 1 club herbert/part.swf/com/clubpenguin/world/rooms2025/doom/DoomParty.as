
//Created by Action Script Viewer - http://www.buraks.com/asv
class com.clubpenguin.world.rooms2025.doom.DoomParty {
    static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, _joinRoomDelegate, _interfaceOverrides, _engineOverrides, _snowballCoolDownExpirationDate;
    function DoomParty() {}
    static function init() {
        pebug("TEMPLATED PARTY - INIT");
        com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
        com.clubpenguin.party.BaseParty.CURRENT_PARTY = (_this);
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        initPartyAvatars();
        _serverCookieService = _shell.getServerCookieService();
		setServerCookie();
        _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
        _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
        _purchaseItemThrottler.delayBetweenEvents = (2000);
        com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
		startRoomDelegate();
        engineOverrides.init();
        interfaceOverrides.init();
        activateInterfaceOverrides();
        activateEngineOverrides();
        _airtower.addListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
        _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(_this, onRoomInitialized));
		_shell.addListener(_shell.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(_this, handleUpdatePlayer));
    }
	static function setServerCookie() {
		_serverCookie = new com.clubpenguin.world.rooms2025.doom.vo.DoomPartyCookieVO(PARTY_COOKIE_ID);
	}
	static function startRoomDelegate() {
		if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, checkForLoginDialogue);
        };
		trace("room delegate");
	}
    static function get partyCookie() {
        return (com.clubpenguin.world.rooms2025.doom.vo.DoomPartyCookieVO(_serverCookie));
    }
	static function get isActive() {
        return (_isActive);
    }
    static function handleUpdatePartySettings(_arg_2) {
        questCom.init();
    }
	static function onRoomInitialized() {
        trace("TEMPLATED PARTY - ROOM INIT");
		if (!getMessageViewed(11)) {
			_interface.PARTY_ICON._visible = false;
		};
    }
    static function pebug(_arg_2, _arg_1) {
        com.clubpenguin.party.BaseParty.pebug(_arg_2, _arg_1);
    }
    static function checkForLoginDialogue(_arg_1) {
        if ((_shell.getMyPlayerId() != _arg_1.player_id)) {
            return (undefined);
        }
        if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
            _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
		};
    }
    static function checkForFirstTimeLogin(_arg_1) {
        //_interface.doThemedPartyUITest();
        if ((_shell.getMyPlayerId() != _arg_1.player_id)) {
            return (undefined);
        }
        if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
            _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
        }
		handleUpdatePlayer(_arg_1)
    }
	static function getMessageViewed(number) {
		return (partyCookie[CONSTANTS.MESSAGE_KEY][number] == 1);
	}
	static function setMessageViewed(number) {
		_airtower.send(_airtower.PLAY_EXT, (CONSTANTS.TEMPLATED_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [number], "str", _shell.getCurrentServerRoomId());
	}
	static function getMessageViewedQC(number) {
		return (partyCookie[CONSTANTS.QC_MESSAGE_KEY][number] == 1);
	}
	static function setMessageViewedQC(number) {
		_airtower.send(_airtower.PLAY_EXT, (CONSTANTS.TEMPLATED_COOKIE_HANDLER_NAME + "#") + CONSTANTS.QC_MESSAGE_VIEWED_COMMAND, [number], "str", _shell.getCurrentServerRoomId());
	}
	static function getTaskComplete(number) {
		return (partyCookie[CONSTANTS.TASK_KEY][number] == 1);
	}
	static function setTaskComplete(number) {
		_airtower.send(_airtower.PLAY_EXT, (CONSTANTS.TEMPLATED_COOKIE_HANDLER_NAME + "#") + CONSTANTS.TASK_COMMAND, [number], "str", _shell.getCurrentServerRoomId());
	}
    static function showPartyCatalogue() {
        _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
    }
    static function get interfaceOverrides() {
        if (_interfaceOverrides == null) {
            _interfaceOverrides = new com.clubpenguin.world.rooms2025.doom.DoomParty_InterfaceOverrides();
        }
        return (_interfaceOverrides);
    }
    static function get engineOverrides() {
        if (_engineOverrides == null) {
            _engineOverrides = new com.clubpenguin.world.rooms2025.doom.DoomParty_EngineOverrides();
        }
        return (_engineOverrides);
    }
    static function get partyIconVisible() {
        if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 1) {
            return (true);
        }
        return (false);
    }
    static function get iglooFurnitureItems() {
        return (CONSTANTS.IGLOO_FURNITURE_ITEMS);
    }
    static function get questCom() {
        return com.clubpenguin.world.rooms2025.doom.DoomPartyQuestCom;
    }
    static function openQuestUI() {
        _interface.showContent(CONSTANTS.QUEST_UI_PATH);
    }
    static function showIglooList() {
        _interface.showContent(CONSTANTS.IGLOO_LIST_PATH);
    }
    static function showPartyMap() {
        pebug("SHOW PARTY MAP!!!!!");
        _interface.showContent(CONSTANTS.PARTY_MAP);
    }
    static function showIglooPrompt() {
        _interface.showContent(CONSTANTS.IGLOO_PROMPT_PATH);
    }
    static function sendMessageViewed(_arg_1) {
        _airtower.send(_airtower.PLAY_EXT, (CONSTANTS.TEMPLATED_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [_arg_1], "str", _shell.getCurrentServerRoomId());
    }
	static function sendQCMessage(message, expression, duration) {
		questCom.sendCommunicatorMessage(message, expression, duration);
	}
	static function get snowballCoolDownExpirationDate() {
        return(((_snowballCoolDownExpirationDate == undefined) ? (_shell.getPenguinStandardTime().getTime()) : (_snowballCoolDownExpirationDate)));
    }
    static function startSnowballCoolDown() {
        _snowballCoolDownExpirationDate = _shell.getPenguinStandardTime().getTime() + CONSTANTS.SNOWBALL_COOLDOWN;
    }
    static function get isSnowballEnabled() {
        if (snowballCoolDownExpirationDate <= _shell.getPenguinStandardTime().getTime()) {
            return(true);
        }
        return(false);
    }
    static function activateInterfaceOverrides() {
        _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showCrosshair);
        //_interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
    }
    static function activateEngineOverrides() {
        pebug("Activate engine overrides");
        //_engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
    }
    static function initPartyAvatars() {
		//trace("no party avatars yippee");
		 var _local_2 = _engine.avatarManager.model;
            var _local_3 = _local_2.createAvatarFromTemplate(0);
			// ghost
            var _local_1;
			var _local_4 = _global.com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE;
			var BALL_GHOST = new _global.com.clubpenguin.engine.projectiles.SnowballEnum("ballghostcanister", _global.com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
            _local_1 = _local_3.clone();
            _local_1.snowball = new _global.com.clubpenguin.engine.projectiles.vo.SnowballVO(BALL_GHOST, -100, 20);
			_local_2.setAvatarTemplate(9, _local_1);
			// herbert
			_local_1 = _local_1.clone();
			_local_1.snowball = new _global.com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, 20);
			_local_2.setAvatarTemplate(8, _local_1);
    }
	static function activateSnowballManagerOverride() {
        _engine.snowballManager = new com.clubpenguin.world.rooms2025.doom.DoomPartySnowballManager(_shell, _engine, _interface);
    }
    static function deactivateSnowballManagerOverride() {
        _engine.snowballManager = new com.clubpenguin.engine.projectiles.SnowballManager(_shell, _engine, _interface);
    }
	static function handleUpdatePlayer(event) {
		if (!getMessageViewed(11)) {
			_interface.PARTY_ICON._visible = false;
		};
		if (_shell.getMyPlayerId() == event.player_id) {
			var __reg2 = _shell.getPlayerObjectById(event.player_id);
			// ghost
			if (__reg2.body == 93044 && __reg2.avatar_id == 0) {
				_engine.avatarManager.transformationManager.sendTransformPlayer(9);
			} else if (__reg2.body != 93044 && __reg2.avatar_id == 9) {
				_engine.avatarManager.transformationManager.sendTransformPlayer(0);
			// herbert
			} else if (__reg2.body == 4744 && __reg2.avatar_id == 0) {
				_engine.avatarManager.transformationManager.sendTransformPlayer(8);
			} else if (__reg2.body != 4744 && __reg2.avatar_id == 8) {
				_engine.avatarManager.transformationManager.sendTransformPlayer(0);
			};
		};
	}

    static var CONSTANTS = com.clubpenguin.world.rooms2025.doom.DoomPartyConstants;
    static var CLASS_NAME = "DoomParty";
    static var PARTY_COOKIE_ID = CONSTANTS.PARTY_COOKIE_ID;
    static var _this = com.clubpenguin.world.rooms2025.doom.DoomParty;
    static var _isActive = false;
}
