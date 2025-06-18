//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.party.MayParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _boatController, _currentController, _partycookieUpdateHandlerDelegate, _interfaceOverrides, _engineOverrides, _shellOverrides, _puffleIDBeingWalked, selectedRideObject, _joinRoomDelegate, _snowballCoolDownExpirationDate;
        function MayParty () {
        }
        static function init() {
            pebug("MAY PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            com.clubpenguin.party.BaseParty.addListenerForPartySettings(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _boatController = new com.clubpenguin.world.rooms2013.epfparty.boat.BoatController();
            _currentController = new com.clubpenguin.world.rooms2013.epfparty.boat.CurrentController();
            initPartyAvatars();
            engineOverrides.init();
            shellOverrides.init();
            activateInterfaceOverrides();
            _partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(_this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", _partycookieUpdateHandlerDelegate);
            partyCookie.sendRequestPartyCookie();
        }
        static function partycookieUpdateHandler() {
            pebug("*** MarchParty.partycookieUpdateHandler()", CLASS_NAME + "()");
            pebug("*** MarchParty.partycookieUpdateHandler() - partyCookie : " + partyCookie, CLASS_NAME + "()");
            com.clubpenguin.party.BaseParty.partyIconState();
            _airtower.removeListener("partycookie", _partycookieUpdateHandlerDelegate);
            _engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
            _engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get tickets() {
            return(partyCookie.tickets);
        }
        static function get canSpinToday() {
            return(partyCookie.spinDayIndex < CONSTANTS.PARTY_DAY);
        }
        static function get isActive() {
            return(_isActive);
        }
        static function get isWeek2() {
            return(((CONSTANTS.PARTY_DAY < 7) ? false : true));
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId, volume) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
        }
        static function checkForFirstTimeLogin(playerObj) {
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            trace("CHECK FOR FIRST TIME LOGIN!!!!!! - partyCookie.msgViewedArray : " + partyCookie.msgViewedArray);
            if (partyCookie.msgViewedArray[0] == 0) {
                pebug("Show login prompt");
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showPartyCatalogue() {
            _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_PUFFLES_MESSAGE);
        }
        static function showRideOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_RIDE_MESSAGE);
        }
        static function launchMidwayGame(gameName) {
            _engine.sendJoinGame(gameName, true);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2015.may.party.MayParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2015.may.party.MayParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get shellOverrides() {
            if (_shellOverrides == null) {
                _shellOverrides = new com.clubpenguin.world.rooms2015.may.party.MayParty_ShellOverrides();
            }
            return(_shellOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function get isFairRoom() {
            var _local_1 = _shell.getRoomObject().room_id;
            pebug("What is the roomID " + _local_1);
            if (((_local_1 != undefined) && (_local_1 >= 851)) && (_local_1 <= 860)) {
                return(true);
            }
            return(false);
        }
        static function set puffleIDBeingWalked(id) {
            _puffleIDBeingWalked = id;
            //return(puffleIDBeingWalked);
        }
        static function get puffleIDBeingWalked() {
            return(_puffleIDBeingWalked);
        }
        static function showTicketsEarnedIcon() {
            var _local_1 = _shell.getMyPlayerObject();
            _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.TICKETS_EARNED_ICON, _local_1);
        }
        static function checkEntry(roomName, x, y) {
            pebug("MayParty.checkEntry _shell " + _shell);
            if (_shell == undefined) {
                _shell = _global.getCurrentShell();
            }
            if (!_shell.isMyPlayerMember()) {
                showRideOopsMessage();
            } else {
                _shell.sendJoinRoom(roomName, x, y);
            }
        }
        static function setRideSelected(room, x, y) {
            pebug((("setRideselected x " + x) + " y") + y);
            selectedRideObject = {name:room, xPos:x, yPos:y};
        }
        static function unequipCurrentPuffle() {
            puffleIDBeingWalked = (_shell.getMyPlayerObject().attachedPuffle.id);
            if (puffleIDBeingWalked != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 0], "str", _shell.getCurrentServerRoomId());
            }
            addListenerForRewalkingPuffle();
        }
        static function reequipCurrentPuffle() {
            if (puffleIDBeingWalked != undefined) {
                trace("there is a puffle to start walking again");
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffleIDBeingWalked, 1], "str", _shell.getCurrentServerRoomId());
                puffleIDBeingWalked = (null);
                _engine.penguinTransformComplete.remove(_joinRoomDelegate);
            }
        }
        static function addListenerForRewalkingPuffle() {
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, handleJoinRoom);
            _engine.penguinTransformComplete.add(_joinRoomDelegate);
        }
        static function handleJoinRoom(playerObj) {
            trace("handleJoinRoom");
            if (_shell.getMyPlayerId() != playerObj.player_id) {
                return(undefined);
            }
            reequipCurrentPuffle();
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _shell.getCurrentServerRoomId());
        }
        static function sendPenguinOnConveyorBelt(slideIndex) {
            _airtower.send(_airtower.PLAY_EXT, "u#" + CONSTANTS.SLIDE_COMMAND_NAME, [slideIndex], "str", _shell.getCurrentServerRoomId());
        }
        static function sendTicketsEarned(tickets) {
            showTicketsEarnedIcon();
            var _local_2 = _shell.getRoomObject().room_id;
            var _local_1;
            if (_local_2 == CONSTANTS.EIGHTBIT_ROOM_ID) {
                _local_1 = "8_bit";
            }
            if (_local_2 == CONSTANTS.SHOOTING_RANGE_ROOM_ID) {
                _local_1 = "Shooting_Range";
            }
            if (_local_2 == CONSTANTS.MAROONED_LAGOON_ROOM_ID) {
                _local_1 = "Marooned_Lagoon";
            }
            if (_local_2 == CONSTANTS.BUMPER_BOATS_ROOM_ID) {
                _local_1 = "Bumper_Boats";
            }
            if (_local_1 != undefined) {
                sendBITicketsEarned(_local_1, tickets);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.TICKETS_EARNED_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendStartMidwayGame() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.START_MIDWAY_GAME_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendEndMidwayGame(tickets) {
            var _local_2 = _shell.getCurrentServerRoomId();
            var _local_1;
            if (_local_2 == 91) {
                _local_1 = "Soaker";
            }
            if (_local_2 == 92) {
                _local_1 = "Balloon";
            }
            if (_local_2 == 93) {
                _local_1 = "Lunar_Launch";
            }
            if (_local_2 == 94) {
                _local_1 = "Feed_A_Puffle";
            }
            if (_local_2 == 95) {
                _local_1 = "Memory";
            }
            if (_local_2 == 96) {
                _local_1 = "Paddle";
            }
            if (_local_2 == 97) {
                _local_1 = "Shuffle";
            }
            if (_local_1 != undefined) {
                sendBITicketsEarned(_local_1, tickets);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.END_MIDWAY_GAME_COMMAND_NAME, [tickets], "str", _shell.getCurrentServerRoomId());
        }
        static function sendPurchaseItem(itemID, itemMC, itemType) {
            pebug((("sendPurchaseItem itemID : " + itemID) + " / itemType : ") + itemType, "MayParty");
            var _local_4 = _global.getCurrentShell().getInventoryObjectById(itemID);
            var _local_2 = _local_4.cost;
            var _local_5 = _local_4.name;
            var _local_6 = String(itemID) + "_Clothing";
            pebug((("sendPurchaseItem itemName : " + _local_5) + " / itemCost : ") + _local_2, "MayParty");
            if (itemType == CONSTANTS.PUFFLE_ITEM_TAG) {
                pebug((("PUFFLE ITEM!!!!!!! - itemType : " + itemType) + " / itemCost : ") + _local_2, "MayParty");
                _local_2 = CONSTANTS.MEMBER_PUFFLE_REWARD_COST;
                _local_6 = String(itemID) + "_PuffleItem";
                var _local_8 = _shell.getPuffleHatCollection();
                var _local_9 = _local_8.getPuffleHatVO(Number(itemID));
                _interface.setActiveShopItemName(_local_9.label);
                _interface.showBuyPuffleCareItemSuccessPrompt = true;
            }
            if ((tickets - _local_2) < 0) {
                itemMC._parent._parent._parent._parent.not_enough_tickets_mc.gotoAndStop("not_enough_tickets");
                playSound(itemMC, "sfx_error");
            } else {
                _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.USE_TICKETS, [itemID], "str", _shell.getCurrentServerRoomId());
                playSound(itemMC._parent._parent, "sfx_item_purchase");
                com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned("fair_ticket", -_local_2, _local_6, _local_5, tickets - _local_2);
            }
        }
        static function initPartyAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_1 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_1.isSpriteTransformed = true;
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _local_1.hasCustomPlayerCard = true;
            _local_1.canRevertToDefault = true;
            _local_1.attachItems = false;
            _local_1.hasColorVersions = false;
            _local_1.isMemberOnly = true;
            _local_1.spritePath = CONSTANTS.COYOTE_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_COYOTE, _local_1);
            var _local_5 = _local_1.clone();
            _local_5.spritePath = CONSTANTS.CRAB_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_CRAB, _local_5);
            var _local_4 = _local_1.clone();
            _local_4.spritePath = CONSTANTS.DRAGON_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_DRAGON, _local_4);
            var _local_3 = _local_1.clone();
            _local_3.spritePath = CONSTANTS.ROBO_TRANSFORMATION_TOKEN;
            _local_2.setAvatarTemplate(CONSTANTS.TRANSFORMATION_ID_ROBO, _local_3);
        }
        static function sendTransformation(id) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2015.may.vo.MayPartyCookieVO.MAY_COOKIE_HANDLER_NAME + "#") + CONSTANTS.SET_PLAYER_TRANSFORM, [id], "str", _shell.getCurrentServerRoomId());
            trace((("id : " + id) + " / slice : ") + String(id).substr(3, 3));
            trace("transformation name : " + CONSTANTS.TRANSOFORMATION_BI_NAMES[String(id).substr(3, 3)]);
            sendTransformBI(CONSTANTS.TRANSOFORMATION_BI_NAMES[String(id).substr(3, 3)]);
            _interface.closeContent();
        }
        static function get localPlayerAvatarID() {
            return(_shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO.avatar_id);
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
        static function activateShellOverrides() {
            pebug("Activate shell overrides");
            _shell.AIRTOWER.removeListener(_shell.AIRTOWER.BUY_INVENTORY, _shell.handleBuyInventory);
            _shell.handleBuyInventory = com.clubpenguin.util.Delegate.create(_shell, shellOverrides.handleBuyInventory);
            _shell.AIRTOWER.addListener(_shell.AIRTOWER.BUY_INVENTORY, _shell.handleBuyInventory);
        }
        static function deactivateShellOverrides() {
            pebug("Deactivate shell overrides");
            _shell.AIRTOWER.removeListener(_shell.AIRTOWER.BUY_INVENTORY, _shell.handleBuyInventory);
            _shell.handleBuyInventory = shellOverrides.defaultHandleBuyInventory;
            _shell.AIRTOWER.addListener(_shell.AIRTOWER.BUY_INVENTORY, _shell.handleBuyInventory);
        }
        static function activateInterfaceOverrides() {
            pebug("Activate interface overrides");
            _interface.showCrosshair = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showCrosshair);
            _interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
            _interface.updateAvatarCard = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.updateAvatarCard);
            _interface.revertAvatar = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.revertAvatar);
        }
        static function activateSnowballManagerOverride() {
            _engine.snowballManager = new com.clubpenguin.world.rooms2015.may.party.MayPartySnowballManager(_shell, _engine, _interface);
        }
        static function deactivateSnowballManagerOverride() {
            _engine.snowballManager = new com.clubpenguin.engine.projectiles.SnowballManager(_shell, _engine, _interface);
        }
        static function activateBoatEngineOverrides() {
            pebug("Activate engine overrides");
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
        }
        static function deactivateBoatEngineOverrides() {
            pebug("Deactivate engine overrides");
            _engine.updatePlayerFrame = engineOverrides.defaultUpdatePlayerFrame;
        }
        static function sendTransformBI(transformName) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(transformName, "avatar_transform");
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + transformName, "start");
        }
        static function sendUnTransformBI() {
            var _local_1 = CONSTANTS.TRANSOFORMATION_BI_NAMES[String(localPlayerAvatarID).substr(3, 3)];
            trace("localPlayerAvatarID : " + localPlayerAvatarID);
            trace("MayParty.sendUnTransformBI() - transformation name : " + _local_1);
            com.clubpenguin.util.TrackerAS2.getInstance().trackStepTimingEvent("avatar_transform_" + _local_1, "end");
        }
        static function sendBIRideRoom(roomName) {
            pebug("send bi tracking for ride room");
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(roomName, "ride_room");
        }
        static function sendBITicketsEarned(activity, tickets) {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("tickets_earned=" + tickets, "ticket_payout_" + activity);
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2015.may.party.MayPartyConstants;
        static var CLASS_NAME = "MayParty";
        static var PARTY_COOKIE_ID = "20150501";
        static var _this = com.clubpenguin.world.rooms2015.may.party.MayParty;
        static var _isActive = false;
    }
