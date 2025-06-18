//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.HalloweenParty
    {
        static var _instance;
        var _shell, _airtower, _interface, _engine, _party, TrickOrTreating, _serverCookieService, _serverCookie, _purchaseItemThrottler, _joinRoomDelegate, _transformCandyJustCollected, _engineOverrides, _interfaceOverrides;
        function HalloweenParty () {
        }
        function init() {
            trace("HALLOWEEN PARTY - INIT");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            TrickOrTreating = com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating.instance;
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, checkForFirstTimeLogin);
            _engine.penguinTransformComplete.add(_joinRoomDelegate);
            activateHalloweenEngineOverrides();
            activateHalloweenInterfaceOverrides();
            _global.com.clubpenguin.engine.avatar.AvatarConfig.initPartyAvatars();
            _airtower.addListener(PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
        }
        function get partyCookie() {
            return(com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO(_serverCookie));
        }
        function handleUpdatePartySettings(data) {
            var _local_2 = com.clubpenguin.util.JSONParser.parse(data[1]);
            _airtower.removeListener(PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
        }
        function get isActive() {
            return(_isActive);
        }
        function checkForFirstTimeLogin(playerObj) {
            if (((_shell.getMyPlayerId() != playerObj.player_id) || (partyCookie.msg[0])) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            _interface.showContent(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.CHARACTER_DIALOGUE_PATH_LOGIN);
        }
        function showPartyCatalogue() {
            _interface.showContent(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.PARTY_CATALOGUE);
        }
        function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        function hideItems(avatarMC) {
            avatarMC.book_mc._visible = false;
            avatarMC.head_mc._visible = false;
            avatarMC.face_mc._visible = false;
            avatarMC.hand_mc._visible = false;
            avatarMC.neck_mc._visible = false;
            avatarMC.body_mc._visible = false;
            avatarMC.feet_mc._visible = false;
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.halloween.HalloweenParty();
            }
            return(_instance);
        }
        function get transformCandyJustCollected() {
            return(_transformCandyJustCollected);
        }
        function set transformCandyJustCollected(value) {
            _transformCandyJustCollected = value;
            //return(transformCandyJustCollected);
        }
        function currentTransformationName(playerObject) {
            var _local_3 = _shell.getPlayerObjectById(playerObject.player_id).avatar_id;
            var _local_2;
            switch (_local_3) {
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.GREEN_ZOMBIE_ID : 
                    _local_2 = 0;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.PURPLE_ZOMBIE_ID : 
                    _local_2 = 1;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.BLUE_ZOMBIE_ID : 
                    _local_2 = 2;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.VAMPIRE_A_ID : 
                    _local_2 = 3;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.VAMPIRE_B_ID : 
                    _local_2 = 4;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.VAMPIRE_C_ID : 
                    _local_2 = 5;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.BLUE_WEREWOLF_ID : 
                    _local_2 = 6;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.BROWN_WEREWOLF_ID : 
                    _local_2 = 7;
                    break;
                case com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.BLACK_WEREWOLF_ID : 
                    _local_2 = 8;
                    break;
            }
            if (_local_2 == undefined) {
                return(undefined);
            }
            return(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.TRANSFORM_CANDY_MAP[_local_2]);
        }
        function get allTransformCandiesCollected() {
            var _local_2 = 0;
            while (_local_2 < partyCookie.candiesCollected.length) {
                if (partyCookie.candiesCollected[_local_2] == 0) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2013.halloween.HalloweenParty_EngineOverrides();
                _engineOverrides.init();
            }
            return(_engineOverrides);
        }
        function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2013.halloween.HalloweenParty_InterfaceOverrides();
                _interfaceOverrides.init();
            }
            return(_interfaceOverrides);
        }
        function openQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.QUEST_UI_PATH);
        }
        function claimQuestPrize() {
            sendBuyCatalogueItem(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.CANDY_PRIZE_ITEM_ID);
            _interface.closeContent();
        }
        function launchPumpkinMiniGame(id) {
            TrickOrTreating.currentTrickOrTreatPumpkin = id;
            _interface.showContent(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.PUMPKIN_MINI_GAME);
        }
        function showHalloweenIcon() {
            _interface.PARTY_ICON._visible = true;
        }
        function hideHalloweenIcon() {
            _interface.PARTY_ICON._visible = false;
        }
        function halloweenPartyIconState() {
            if (partyCookie.msg[0] == 1) {
                showHalloweenIcon();
            } else {
                hideHalloweenIcon();
            }
        }
        function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + MESSAGE_VIEWED_COMMAND_NAME, [message], "str", _shell.getCurrentServerRoomId());
        }
        function sendUpdateCandyPoints(points, candyIndex) {
            TrickOrTreating.trickOrTreatPumpkinVisited(TrickOrTreating.currentTrickOrTreatPumpkin);
            TrickOrTreating.currentTrickOrTreatPumpkin = null;
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("pumpkin_game", String((points + "_") + com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.TRANSFORM_CANDY_MAP[candyIndex]), {message:_shell.getRoomObject().room_id});
            trace("what is the candy index " + candyIndex);
            var _local_3 = (((candyIndex == undefined) || (candyIndex == -1)) ? ([points]) : ([points, candyIndex]));
            trace("candyResult " + _local_3);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + COMPLETED_PUMPKIN_GAME_COMMAND_NAME, _local_3, "str", _shell.getCurrentServerRoomId());
        }
        function sendBuyCatalogueItem(itemID) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + BUY_CATALOGUE_ITEM_COMMAND_NAME, [itemID], "str", _shell.getCurrentServerRoomId());
        }
        function sendEatTransformCandy(transformCandyId) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("halloween_transform", com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.TRANSFORM_CANDY_MAP[transformCandyId]);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.halloween.vo.HalloweenPartyCookieVO.HALLOWEEN_COOKIE_HANDLER_NAME + "#") + EAT_TRANSFORM_CANDY_COMMAND_NAME, [transformCandyId], "str", _shell.getCurrentServerRoomId());
        }
        function activateHalloweenEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _party.HalloweenParty.instance.engineOverrides.updatePlayerFrame);
        }
        function activateHalloweenInterfaceOverrides() {
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(this, _party.HalloweenParty.instance.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(this, _party.HalloweenParty.instance.interfaceOverrides.onPartyIconLoad);
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants;
        static var PARTY_COOKIE_ID = "20131001";
        static var PARTY_SETTINGS_RESPONSE_NAME = "hweens";
        static var MESSAGE_VIEWED_COMMAND_NAME = "hweenv";
        static var COMPLETED_PUMPKIN_GAME_COMMAND_NAME = "hweenpumpkingame";
        static var BUY_CATALOGUE_ITEM_COMMAND_NAME = "hweenai";
        static var EAT_TRANSFORM_CANDY_COMMAND_NAME = "hweenpt";
        var _isActive = false;
    }
