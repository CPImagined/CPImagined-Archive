
//Created by Action Script Viewer - http://www.buraks.com/asv
class com.clubpenguin.world.rooms2025.waddleon.WaddleOnParty {
    static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, _joinRoomDelegate, _prehistoricDinoHitCheck, _interfaceOverrides, _engineOverrides;
    function WaddleOnParty() {}
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
		com.clubpenguin.world.rooms2025.waddleon.DinoSounds.init();
		_engine.snowballManager = new com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartySnowballManager(_shell, _engine, _interface);
    }
	static function setServerCookie() {
		_serverCookie = new com.clubpenguin.world.rooms2025.waddleon.vo.WaddleOnPartyCookieVO(PARTY_COOKIE_ID);
	}
	static function startRoomDelegate() {
		if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, checkForLoginDialogue);
        };
		trace("room delegate");
	}
    static function get partyCookie() {
        return (com.clubpenguin.world.rooms2025.waddleon.vo.WaddleOnPartyCookieVO(_serverCookie));
    }
	static function get isActive() {
        return (_isActive);
    }
    static function handleUpdatePartySettings(_arg_2) {
        questCom.init();
    }
	static function onRoomInitialized() {
		_prehistoricDinoHitCheck = new com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyDinoHitCheck();
        _shell.addListener(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, com.clubpenguin.util.Delegate.create(_prehistoricDinoHitCheck, _prehistoricDinoHitCheck.hitCheck));
        trace("TEMPLATED PARTY - ROOM INIT");
    }
	static function isDinosaur(_arg_2) {
        var _local_1 = _shell.getPlayerObjectById(_arg_2);
        return (isDinosaurByAvatarId(_local_1.avatarVO.avatar_id));
    }
    static function isDinosaurByAvatarId(_arg_1) {
        if ((_arg_1 >= 400) && (_arg_1 < 420)) {
            return (true);
        }
        return (false);
    }
	static function isTrex(avatarId) {
        return((((avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_PINK) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_RED)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_TURQUOISE)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_YELLOW));
    }
    static function isTriceratops(avatarId) {
        return((((avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_BROWN) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_PURPLE)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_TURQUOISE)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_YELLOW));
    }
    static function isPteranodon(avatarId) {
        return((((avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_BLUE) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_GREEN)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_ORANGE)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_PINK));
    }
    static function isStegosuarus(avatarId) {
        return((((avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_BLUE) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_GREEN)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_PURPLE)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_YELLOW));
    }
    static function isRaptor(avatarId) {
        return((((avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_BLACK) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_GREEN)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_PINK)) || (avatarId == com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_RED));
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
            _interfaceOverrides = new com.clubpenguin.world.rooms2025.waddleon.WaddleOnParty_InterfaceOverrides();
        }
        return (_interfaceOverrides);
    }
    static function get engineOverrides() {
        if (_engineOverrides == null) {
            _engineOverrides = new com.clubpenguin.world.rooms2025.waddleon.WaddleOnParty_EngineOverrides();
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
        return com.clubpenguin.world.rooms2025.waddleon.WaddleOnPartyQuestCom;
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
    static function activateInterfaceOverrides() {
        pebug("Activate interface overrides");
        //_interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
    }
    static function activateEngineOverrides() {
        pebug("Activate engine overrides");
        //_engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
    }
    static function initPartyAvatars() {
		initDinoAvatars();
		var _local_2 = _engine.avatarManager.model;
		var _local_3 = _local_2.createAvatarFromTemplate(0);
		_local_3.isSpriteTransformed = true;
		_local_3.defaultTransitionEffect = _global.com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
		_local_3.defaultRevertEffect = _global.com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
		_local_3.hasCustomPlayerCard = true;
		_local_3.canRevertToDefault = true;
		_local_3.attachItems = false;
		var _local_1;
		_local_1 = _local_3.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.blue";
		_local_2.setAvatarTemplate(1000, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.red";
		_local_2.setAvatarTemplate(1001, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.pink";
		_local_2.setAvatarTemplate(1002, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.black";
		_local_2.setAvatarTemplate(1003, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.green";
		_local_2.setAvatarTemplate(1004, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.purple";
		_local_2.setAvatarTemplate(1005, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.yellow";
		_local_2.setAvatarTemplate(1006, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.white";
		_local_2.setAvatarTemplate(1007, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.orange";
		_local_2.setAvatarTemplate(1008, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.brown";
		_local_2.setAvatarTemplate(1009, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.gold";
		_local_2.setAvatarTemplate(1010, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.rainbow";
		_local_2.setAvatarTemplate(1011, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.dogBlue";
		_local_2.setAvatarTemplate(1012, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.p2016.puffleparty.avatarSprite.catOrange";
		_local_2.setAvatarTemplate(1013, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.avatarSprite.robo";
		_local_2.setAvatarTemplate(3000, _local_1);
		_local_1 = _local_1.clone();
		_local_1.spritePath = "w.avatarSprite.crab";
		_local_2.setAvatarTemplate(3001, _local_1);
    }
	static function initDinoAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_3 = _local_2.createAvatarFromTemplate(0);
            _local_3.isSpriteTransformed = true;
            _local_3.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_LARGE;
            _local_3.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_LARGE;
            _local_3.hasCustomPlayerCard = true;
            _local_3.canRevertToDefault = true;
            _local_3.attachItems = false;
            var _local_1;
            var _local_4 = com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL;
            _local_1 = _local_3.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexPink";
            _local_1.speechBubbleOffsetY = -80;
            _local_1.nicknameOffsetY = 0;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.TREX_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexRed";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_RED, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexTurquoise";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_TURQUOISE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TREX_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsBrown";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.TRICERATOPS_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_BROWN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsPurple";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_PURPLE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsTurquoise";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_TURQUOISE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_TRICERATOPS_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusBlue";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.STEGOSAURUS_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_BLUE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusPurple";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_PURPLE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonBlue";
            _local_1.speechBubbleOffsetY = -35;
            _local_1.nicknameOffsetY = 0;
            _local_1.attributes.spriteScale = 85;
            _local_1.attributes.ignoresBlockLayer = true;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.PTERANODON_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_BLUE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonlOrange";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_ORANGE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonlPink";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_PTERANODON_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporBlack";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
			_local_1.attributes.ignoresBlockLayer = false;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.RAPTOR_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_BLACK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporPink";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporRed";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.AVATAR_RAPTOR_RED, _local_1);
        }
    static var CONSTANTS = com.clubpenguin.world.rooms2025.waddleon.WaddleOnPartyConstants;
    static var CLASS_NAME = "WaddleOnParty";
    static var PARTY_COOKIE_ID = CONSTANTS.PARTY_COOKIE_ID;
    static var _this = com.clubpenguin.world.rooms2025.waddleon.WaddleOnParty;
    static var _isActive = false;
}
