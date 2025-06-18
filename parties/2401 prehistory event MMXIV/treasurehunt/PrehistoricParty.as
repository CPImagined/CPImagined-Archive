//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, _joinRoomDelegate, _puffleWalkCheckDelegate, _prehistoricDinoHitCheck, eggTypeFoundInGame, _garugCongratsMessageDelegate, _interfaceOverrides, _engineOverrides, handlePuffleHatchingBroadcastReceivedDelegate;
        function PrehistoricParty () {
        }
        static function init() {
            pebug("PREHISTORIC PARTY - INIT");
            com.clubpenguin.party.BaseParty.CLASS_NAME = _this.CLASS_NAME;
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = _this;
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            initPartyAvatars();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
            if (partyCookie[CONSTANTS.MESSAGE_KEY][1] == 0) {
                _joinRoomDelegate = com.clubpenguin.util.Delegate.create(_this, checkForGaruggLogin);
                _engine.penguinTransformComplete.add(_joinRoomDelegate);
            }
            engineOverrides.init();
            interfaceOverrides.init();
            activateInterfaceOverrides();
            activateEngineOverrides();
            _airtower.addListener(CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
            _engine.snowballManager = new com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartySnowballManager(_shell, _engine, _interface);
            _shell.addListener(_shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, onRoomInitialized));
            if (partyCookie[CONSTANTS.MESSAGE_KEY][4] == 0) {
                _puffleWalkCheckDelegate = com.clubpenguin.util.Delegate.create(_this, checkForMyPuffleBeingWalked);
                _shell.addListener(_shell.PUFFLE_WALK, _puffleWalkCheckDelegate);
            }
            com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.init();
        }
        static function onRoomInitialized() {
            _prehistoricDinoHitCheck = new com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyDinoHitCheck();
            _shell.addListener(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, com.clubpenguin.util.Delegate.create(_prehistoricDinoHitCheck, _prehistoricDinoHitCheck.hitCheck));
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO(_serverCookie));
        }
        static function handleUpdatePartySettings(data) {
            var _local_1 = com.clubpenguin.util.JSONParser.parse(data[1]);
            CONSTANTS.PARTY_DAY = _local_1.day;
            CONSTANTS.TREX_REWARD_ITEM = _local_1[CONSTANTS.TRANSFORM_REWARDS_KEY][0];
            CONSTANTS.TRICERATOPS_REWARD_ITEM = _local_1[CONSTANTS.TRANSFORM_REWARDS_KEY][1];
            CONSTANTS.STEGOSAURUS_REWARD_ITEM = _local_1[CONSTANTS.TRANSFORM_REWARDS_KEY][2];
            CONSTANTS.PTERANODON_REWARD_ITEM = _local_1[CONSTANTS.TRANSFORM_REWARDS_KEY][3];
            CONSTANTS.RAPTORS_REWARD_ITEM = _local_1[CONSTANTS.TRANSFORM_REWARDS_KEY][4];
            CONSTANTS.PUFFLE_TRICERATOPS_BLUE_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][0];
            CONSTANTS.PUFFLE_TREX_GREY_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][1];
            CONSTANTS.PUFFLE_STEGO_PINK_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][2];
            CONSTANTS.PUFFLE_TRICERATOPS_RED_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][3];
            CONSTANTS.PUFFLE_TREX_PURPLE_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][4];
            CONSTANTS.PUFFLE_STEGO_YELLOW_ITEM = _local_1[CONSTANTS.DINO_PUFFLE_REWARDS_KEY][5];
        }
        static function get isActive() {
            return(_isActive);
        }
        static function pebug(msg, prefix) {
            com.clubpenguin.party.BaseParty.pebug(msg, prefix);
        }
        static function playSound(ui, soundId) {
            com.clubpenguin.party.BaseParty.playSound(ui, soundId);
        }
        static function checkForGaruggLogin(playerObj) {
            _interface.doThemedPartyUITest();
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (_this.isPrehistoricRoom && (partyCookie[CONSTANTS.MESSAGE_KEY][1] == 0)) {
                _interface.showContent(CONSTANTS.GARUG_LOGIN_PROMPT_PATH);
            }
            if (eggTypeFoundInGame != undefined) {
                checkForGarugGameDialogue(eggTypeFoundInGame);
                eggTypeFoundInGame = undefined;
            }
        }
        static function checkForFirstTimeLogin(playerObj) {
            _interface.doThemedPartyUITest();
            if ((_shell.getMyPlayerId() != playerObj.player_id) || (_shell.getRoomObject().room_id == 112)) {
                return(undefined);
            }
            if (partyCookie[CONSTANTS.MESSAGE_KEY][0] == 0) {
                _interface.showContent(CONSTANTS.GARY_LOGIN_PROMPT_PATH);
            }
            if (_this.isPrehistoricRoom && (partyCookie[CONSTANTS.MESSAGE_KEY][1] == 0)) {
                _interface.showContent(CONSTANTS.GARUG_LOGIN_PROMPT_PATH);
            }
            if (eggTypeFoundInGame != undefined) {
                checkForGarugGameDialogue(eggTypeFoundInGame);
                eggTypeFoundInGame = undefined;
            }
        }
        static function checkForMyPuffleBeingWalked(event) {
            _garugCongratsMessageDelegate = com.clubpenguin.util.Delegate.create(_this, checkForGarugCongratsMessage, event.id);
            _shell.addListener(_shell.UPDATE_PLAYER, _garugCongratsMessageDelegate);
        }
        static function checkForGarugCongratsMessage(event, puffleId) {
            _shell.removeListener(_shell.UPDATE_PLAYER, _garugCongratsMessageDelegate);
            _shell.removeListener(_shell.PUFFLE_WALK, _puffleWalkCheckDelegate);
            if (_shell.getMyPlayerId() != event.player_id) {
                return(undefined);
            }
            var _local_1 = _shell.getPlayerObjectById(_shell.getMyPlayerId());
            if (puffleId != _local_1.attachedPuffle.id) {
                return(undefined);
            }
            if (partyCookie[CONSTANTS.MESSAGE_KEY][4] == 0) {
                _interface.showContent(CONSTANTS.GARUG_CONGRATULATIONS_PATH);
            }
        }
        static function showPartyCatalogue() {
            _global.getCurrentInterface().showContent(CONSTANTS.PARTY_CATALOGUE);
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_PUFFLES_MESSAGE);
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty_EngineOverrides();
            }
            return(_engineOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie[CONSTANTS.MESSAGE_KEY][1] == 1) {
                return(true);
            }
            return(false);
        }
        static function get iglooFurnitureItems() {
            return([CONSTANTS.DINO_DIG_FURNITURE_ITEM]);
        }
        static function get isPrehistoricRoom() {
            var _local_1 = _shell.getRoomObject().room_id;
            pebug("What is the roomID " + _local_1);
            if (((_local_1 != undefined) && (_local_1 >= 852)) && (_local_1 <= 867)) {
                return(true);
            }
            return(false);
        }
        static function hasPlayerCollectedAllTransforms(type) {
            var _local_1 = partyCookie[CONSTANTS.TRANSFORM_COLLECTION_KEY];
            switch (type) {
                case CONSTANTS.TREX : 
                    return(((((_local_1[0] && (_local_1[1])) && (_local_1[2])) && (_local_1[3])) ? true : false));
                    break;
                case CONSTANTS.TRICERATOPS : 
                    return(((((_local_1[4] && (_local_1[5])) && (_local_1[6])) && (_local_1[7])) ? true : false));
                    break;
                case CONSTANTS.PTERANODON : 
                    return(((((_local_1[8] && (_local_1[9])) && (_local_1[10])) && (_local_1[11])) ? true : false));
                    break;
                case CONSTANTS.STEGOSAURUS : 
                    return(((((_local_1[12] && (_local_1[13])) && (_local_1[14])) && (_local_1[15])) ? true : false));
                    break;
                case CONSTANTS.RAPTORS : 
                    return(((((_local_1[16] && (_local_1[17])) && (_local_1[18])) && (_local_1[19])) ? true : false));
                    break;
                default : 
                    break;
            }
        }
        static function specificDinoPuffleObject(puffleNum) {
            var _local_1 = 0;
            while (partyCookie.puff.length) {
                if (puffleNum == partyCookie[CONSTANTS.DINO_PUFFLE_COLLECTION_KEY][_local_1].id) {
                    return(partyCookie[CONSTANTS.DINO_PUFFLE_COLLECTION_KEY][_local_1]);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getStateOfDinoPuffle(itemID) {
            var _local_1 = 0;
            while (_local_1 < CONSTANTS.DINO_PUFFLE_EGG_IDS.length) {
                if (itemID == CONSTANTS.DINO_PUFFLE_EGG_IDS[_local_1]) {
                    return(partyCookie[CONSTANTS.DINO_PUFFLE_COLLECTION_KEY][_local_1][CONSTANTS.DINO_PUFFLE_STATE_KEY]);
                }
                _local_1++;
            }
            return(-1);
        }
        static function openQuestUI() {
            _interface.showContent(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.QUEST_UI_PATH);
        }
        static function showDinoDigIglooList() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("dino_dig_igloo_list", "view");
            _interface.showContent(CONSTANTS.IGLOO_LIST_PATH);
        }
        static function showPrehistoricMap() {
            _interface.showContent(CONSTANTS.PREHISTORIC_MAP);
        }
        static function showPuffleHatchingInstructions() {
            _interface.showContent(CONSTANTS.DINO_PUFFLE_INSTRUCTIONS);
        }
        static function showIglooPrompt() {
            _interface.showContent(CONSTANTS.IGLOO_PROMPT_PATH);
        }
        static function sendEquipPuffleEgg(puffleId) {
            pebug("sendEquipPuffleEgg " + puffleId, CLASS_NAME);
            if (!_shell.isMyPlayerMember()) {
                showMemberContentOopsMessage();
                return(undefined);
            }
            _shell.sendUpdatePlayerHand(CONSTANTS.DINO_PUFFLE_EGG_IDS[puffleId]);
        }
        static function isDinoPuffleEggEquipped(player_id) {
            var _local_2 = _shell.getPlayerObjectById(player_id);
            var _local_1 = _local_2.hand;
            return(isDinoPuffleEgg(_local_1));
        }
        static function isDinoPuffleEgg(itemId) {
            return(true);
            var _local_1 = 0;
            while (_local_1 < com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.DINO_PUFFLE_EGG_IDS.length) {
                if (itemId == com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.DINO_PUFFLE_EGG_IDS[_local_1]) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function sendWalkDinoPuffle(puffleId) {
            if (!_shell.isMyPlayerMember()) {
                showMemberContentOopsMessage();
                return(undefined);
            }
            var _local_1 = _shell.puffleManager.getPuffleModelIdBySubtype(CONSTANTS.DINO_PUFFLE_IDS[puffleId]);
            _shell.puffleManager.sendStartPuffleWalkOutsideIgloo(_local_1);
            _interface.closeContent();
        }
        static function launchDinoDigGame() {
            _engine.sendJoinGame(CONSTANTS.DINO_DIG_GAME_PATH, true);
        }
        static function showDinoDigHint(mc) {
            _interface.showHint(mc, "dinodig_hint");
        }
        static function hideDinoDigHint() {
            _interface.closeHint();
        }
        static function activatePuffleHatchBroadcastReceiver() {
            handlePuffleHatchingBroadcastReceivedDelegate = com.clubpenguin.util.Delegate.create(_this, puffleHatchBroadcastReceived);
            _airtower.addListener(CONSTANTS.DINO_PUFFLE_EGG_HEATED, handlePuffleHatchingBroadcastReceivedDelegate);
        }
        static function deactivatePuffleHatchBroadcastReceiver() {
            _airtower.removeListener(CONSTANTS.DINO_PUFFLE_EGG_HEATED, handlePuffleHatchingBroadcastReceivedDelegate);
        }
        static function puffleHatchBroadcastReceived(data) {
            var _local_2 = data[1];
            var _local_3 = Number(data[2]);
            var _local_1 = _engine.getPlayerMovieClip(_local_2);
            var _local_4 = _shell.getPlayerObjectById(_local_2).hand;
            switch (_local_3) {
                case 1 : 
                    var _local_7 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_local_1.hand_mc.puffle, com.clubpenguin.util.Delegate.create(_this, stopDinoEggAnimating, _local_1.hand_mc.puffle), 15, 37);
                    com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.playPuffleCracking(_local_2, _local_3);
                    break;
                case 2 : 
                    _local_7 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_local_1.hand_mc.puffle, com.clubpenguin.util.Delegate.create(_this, stopDinoEggAnimating, _local_1.hand_mc.puffle), 38, 57);
                    com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.playPuffleCracking(_local_2, _local_3);
                    break;
                case 3 : 
                    _local_1.hand_mc.puffle.dinoEggAnimating = true;
                    var _local_5 = _local_1.hand_mc.puffle._totalframes;
                    _local_7 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_local_1.hand_mc.puffle, com.clubpenguin.util.Delegate.create(_this, showDinoPuffleAdoption, _local_4, _local_2, _local_1.hand_mc.puffle), CONSTANTS.PUFFLE_HATCH_FRAME, _local_1.hand_mc.puffle._totalframes);
                    com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.playPuffleHatching(_local_2, _local_4);
                    break;
                default : 
                    pebug("WRONG STATE! ERROR! State = " + _local_3);
            }
        }
        static function stopDinoEggAnimating(puffleHandMC) {
            pebug("stopDinoEggAnimating()");
            puffleHandMC.dinoEggAnimating = false;
        }
        static function checkForGarugGameDialogue(eggType) {
            switch (eggType) {
                case "puffle" : 
                    if (partyCookie.msg[2] == 0) {
                        _interface.showContent(CONSTANTS.GARUG_DINOPUFFLEGG_FOUND_PATH);
                    }
                    break;
                case "transform" : 
                    if (partyCookie.msg[3] == 0) {
                        _interface.showContent(CONSTANTS.GARUG_TRANSFORMEGG_FOUND_PATH);
                    }
                    break;
            }
        }
        static function showDinoPuffleAdoption(puffleNum, playerID, puffleHandMC) {
            if (playerID == _shell.getMyPlayerId()) {
                pebug("Adopt my new puffle! " + puffleNum);
                puffleHandMC.dinoEggAnimating = false;
                var _local_1;
                switch (puffleNum) {
                    case 5408 : 
                        _local_1 = "1003";
                        break;
                    case 5409 : 
                        _local_1 = "1000";
                        break;
                    case 5410 : 
                        _local_1 = "1005";
                        break;
                    case 5411 : 
                        _local_1 = "1002";
                        break;
                    case 5412 : 
                        _local_1 = "1001";
                        break;
                    case 5413 : 
                        _local_1 = "1004";
                        break;
                }
                _interface.showContent("puffle_adoption", null, null, {puffleAdoptionType:_local_1}, true);
                _shell.sendUpdatePlayerHand(0);
            } else {
                puffleHandMC.dinoEggAnimating = false;
            }
        }
        static function sendMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO.PREHISTORIC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.MESSAGE_VIEWED_COMMAND, [message], "str", _shell.getCurrentServerRoomId());
        }
        static function sendSpawnInPrehistoricRoom() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO.PREHISTORIC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.PREHISTORIC_SPAWN_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendSpawnInCPRoom() {
            _airtower.send(_airtower.PLAY_EXT, "j#" + CONSTANTS.CP_SPAWN_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendDinosaurTransformation(transformNum) {
            pebug("Transform into dinosaur " + transformNum);
            if (transformationAllowed(transformNum)) {
                sendDinosaurTransformBI(transformNum);
                _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO.PREHISTORIC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.DINO_TRANSFORMATION_COMMAND, [transformNum], "str", _shell.getCurrentServerRoomId());
            } else {
                pebug("Transform not allowed");
                _interface.showContent(CONSTANTS.OOPS_MEMBER_TRANSFORM_MESSAGE);
            }
        }
        static function sendDinosaurTransformBI(transformNum) {
            var _local_2;
            var _local_1;
            switch (transformNum) {
                case 400 : 
                    _local_2 = "t-rex";
                    _local_1 = "pink";
                    break;
                case 401 : 
                    _local_2 = "t-rex";
                    _local_1 = "red";
                    break;
                case 402 : 
                    _local_2 = "t-rex";
                    _local_1 = "turquoise";
                    break;
                case 403 : 
                    _local_2 = "t-rex";
                    _local_1 = "yellow";
                    break;
                case 404 : 
                    _local_2 = "triceratops";
                    _local_1 = "brown";
                    break;
                case 405 : 
                    _local_2 = "triceratops";
                    _local_1 = "purple";
                    break;
                case 406 : 
                    _local_2 = "triceratops";
                    _local_1 = "turquoise";
                    break;
                case 407 : 
                    _local_2 = "triceratops";
                    _local_1 = "yellow";
                    break;
                case 408 : 
                    _local_2 = "pteranodon";
                    _local_1 = "blue";
                    break;
                case 409 : 
                    _local_2 = "pteranodon";
                    _local_1 = "green";
                    break;
                case 410 : 
                    _local_2 = "pteranodon";
                    _local_1 = "orange";
                    break;
                case 411 : 
                    _local_2 = "pteranodon";
                    _local_1 = "pink";
                    break;
                case 412 : 
                    _local_2 = "stegosaurus";
                    _local_1 = "blue";
                    break;
                case 413 : 
                    _local_2 = "stegosaurus";
                    _local_1 = "green";
                    break;
                case 414 : 
                    _local_2 = "stegosaurus";
                    _local_1 = "purple";
                    break;
                case 415 : 
                    _local_2 = "stegosaurus";
                    _local_1 = "yellow";
                    break;
                case 416 : 
                    _local_2 = "raptor";
                    _local_1 = "black";
                    break;
                case 417 : 
                    _local_2 = "raptor";
                    _local_1 = "green";
                    break;
                case 418 : 
                    _local_2 = "raptor";
                    _local_1 = "pink";
                    break;
                case 419 : 
                    _local_2 = "raptor";
                    _local_1 = "red";
                    break;
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_2, "dino_transform", {message:_local_1});
        }
        static function transformationAllowed(transformNum) {
            if (_shell.isMyPlayerMember()) {
                return(true);
            }
            var _local_2 = false;
            var _local_1 = _shell.abTestModel.getTestDataByName(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.PREHISTORIC_PARTY_AB_TEST);
            var _local_3 = Number(_local_1[com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AB_TEST_SHARD_ID]);
            if ((_local_1 == undefined) || ((_local_1 != undefined) && (_local_3 == 0))) {
                _local_2 = false;
            } else if ((_local_1 != undefined) && (_local_3 == 1)) {
                if ((((transformNum == com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_BLACK) || (transformNum == com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_GREEN)) || (transformNum == com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_PINK)) || (transformNum == com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_RED)) {
                    pebug("transform is allowed");
                    _local_2 = true;
                }
            } else if ((_local_1 != undefined) && (_local_3 == 2)) {
                _local_2 = true;
            }
            return(_local_2);
        }
        static function sendDinoPuffleEggHeated() {
            pebug("sendDinoPuffleEggHeated()");
            hotSpotPreviouslyRegistered = true;
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.prehistoric.vo.PrehistoricPartyCookieVO.PREHISTORIC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.DINO_PUFFLE_EGG_HEATED, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendDinoDigBI(eggName, type) {
            var _local_1;
            var _local_2;
            var _local_3;
            if (type == "puffle") {
                _local_3 = "dino_puffle_eggs_found";
            } else if (type == "transform") {
                _local_3 = "dino_eggs_found";
            }
            switch (eggName) {
                case "trex_purple" : 
                    _local_1 = "t-rex";
                    _local_2 = "pink";
                    break;
                case "trex_red" : 
                    _local_1 = "t-rex";
                    _local_2 = "red";
                    break;
                case "trex_green" : 
                    _local_1 = "t-rex";
                    _local_2 = "turquoise";
                    break;
                case "trex_yellow" : 
                    _local_1 = "t-rex";
                    _local_2 = "yellow";
                    break;
                case "tri_black" : 
                    _local_1 = "triceratops";
                    _local_2 = "brown";
                    break;
                case "tri_purple" : 
                    _local_1 = "triceratops";
                    _local_2 = "purple";
                    break;
                case "tri_green" : 
                    _local_1 = "triceratops";
                    _local_2 = "turquoise";
                    break;
                case "tri_yellow" : 
                    _local_1 = "triceratops";
                    _local_2 = "yellow";
                    break;
                case "pt_blue" : 
                    _local_1 = "pteranodon";
                    _local_2 = "blue";
                    break;
                case "pt_green" : 
                    _local_1 = "pteranodon";
                    _local_2 = "green";
                    break;
                case "pt_orange" : 
                    _local_1 = "pteranodon";
                    _local_2 = "orange";
                    break;
                case "pt_pink" : 
                    _local_1 = "pteranodon";
                    _local_2 = "pink";
                    break;
                case "st_blue" : 
                    _local_1 = "stegosaurus";
                    _local_2 = "blue";
                    break;
                case "st_green" : 
                    _local_1 = "stegosaurus";
                    _local_2 = "green";
                    break;
                case "st_purple" : 
                    _local_1 = "stegosaurus";
                    _local_2 = "purple";
                    break;
                case "st_yellow" : 
                    _local_1 = "stegosaurus";
                    _local_2 = "yellow";
                    break;
                case "ra_black" : 
                    _local_1 = "raptor";
                    _local_2 = "black";
                    break;
                case "ra_green" : 
                    _local_1 = "raptor";
                    _local_2 = "green";
                    break;
                case "ra_pink" : 
                    _local_1 = "raptor";
                    _local_2 = "pink";
                    break;
                case "ra_red" : 
                    _local_1 = "raptor";
                    _local_2 = "red";
                    break;
                case "puffle_st_pink" : 
                    _local_1 = "pink_stegosaurus";
                    break;
                case "puffle_st_yellow" : 
                    _local_1 = "yellow_stegosaurus";
                    break;
                case "puffle_tri_red" : 
                    _local_1 = "red_triceratops";
                    break;
                case "puffle_tri_blue" : 
                    _local_1 = "blue_triceratops";
                    break;
                case "puffle_trex_black" : 
                    _local_1 = "black_t_rex";
                    break;
                case "puffle_trex_purple" : 
                    _local_1 = "purple_t_rex";
                    break;
                default : 
                    _local_1 = "none";
                    _local_2 = "none";
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_1, _local_3, {message:_local_2});
        }
        static function activateInterfaceOverrides() {
            pebug("Activate interface overrides");
            _interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
            _interface.updateQuestRewardsReady = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.updateQuestRewardsReady);
        }
        static function activateEngineOverrides() {
            pebug("Activate engine overrides");
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(_engine, engineOverrides.updatePlayerFrame);
        }
        static function initPartyAvatars() {
            var _local_2 = _engine.avatarManager.model;
            var _local_3 = _local_2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _local_3.isSpriteTransformed = true;
            _local_3.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_LARGE;
            _local_3.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_LARGE;
            _local_3.hasCustomPlayerCard = true;
            _local_3.canRevertToDefault = true;
            _local_3.revertSoundEffectSymbol = "sfx_dino_revert";
            _local_3.attachItems = false;
            _local_3.isMemberOnly = (transformationAllowed(400) ? true : false);
            var _local_1;
            var _local_4 = com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL;
            _local_1 = _local_3.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexPink";
            _local_1.speechBubbleOffsetY = -80;
            _local_1.nicknameOffsetY = 0;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, CONSTANTS.TREX_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TREX_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexRed";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TREX_RED, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexTurquoise";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TREX_TURQUOISE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.trexYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TREX_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsBrown";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, CONSTANTS.TRICERATOPS_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TRICERATOPS_BROWN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsPurple";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TRICERATOPS_PURPLE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsTurquoise";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TRICERATOPS_TURQUOISE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.triceratopsYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_TRICERATOPS_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusBlue";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, CONSTANTS.STEGOSAURUS_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_BLUE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusPurple";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_PURPLE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.stegosaurusYellow";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_STEGOSAURUS_YELLOW, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonBlue";
            _local_1.speechBubbleOffsetY = -35;
            _local_1.nicknameOffsetY = 0;
            _local_1.attributes.spriteScale = 85;
            _local_1.attributes.ignoresBlockLayer = true;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, CONSTANTS.PTERANODON_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_PTERANODON_BLUE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_PTERANODON_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonlOrange";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_PTERANODON_ORANGE, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.pteranodonlPink";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_PTERANODON_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporBlack";
            _local_1.speechBubbleOffsetY = -30;
            _local_1.nicknameOffsetY = 18;
            _local_1.attributes.spriteScale = 85;
            _local_1.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_4, -100, CONSTANTS.RAPTOR_SNOWBALL_DELAY);
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_BLACK, _local_1);
            _local_1.isMemberOnly = (transformationAllowed(416) ? true : false);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporGreen";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_GREEN, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporPink";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_PINK, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.p2014.prehistoric.avatarSprite.ratporRed";
            _local_1.attributes.spriteScale = 85;
            _local_2.setAvatarTemplate(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants.AVATAR_RAPTOR_RED, _local_1);
        }
        static function isDinosaur(playerId) {
            var _local_1 = _shell.getPlayerObjectById(playerId);
            return(isDinosaurByAvatarId(_local_1.avatarVO.avatar_id));
        }
        static function isDinosaurByAvatarId(avatarId) {
            if ((avatarId >= 400) && (avatarId < 420)) {
                return(true);
            }
            return(false);
        }
        static function isTrex(avatarId) {
            return((((avatarId == CONSTANTS.AVATAR_TREX_PINK) || (avatarId == CONSTANTS.AVATAR_TREX_RED)) || (avatarId == CONSTANTS.AVATAR_TREX_TURQUOISE)) || (avatarId == CONSTANTS.AVATAR_TREX_YELLOW));
        }
        static function isTriceratops(avatarId) {
            return((((avatarId == CONSTANTS.AVATAR_TRICERATOPS_BROWN) || (avatarId == CONSTANTS.AVATAR_TRICERATOPS_PURPLE)) || (avatarId == CONSTANTS.AVATAR_TRICERATOPS_TURQUOISE)) || (avatarId == CONSTANTS.AVATAR_TRICERATOPS_YELLOW));
        }
        static function isPteranodon(avatarId) {
            return((((avatarId == CONSTANTS.AVATAR_PTERANODON_BLUE) || (avatarId == CONSTANTS.AVATAR_PTERANODON_GREEN)) || (avatarId == CONSTANTS.AVATAR_PTERANODON_ORANGE)) || (avatarId == CONSTANTS.AVATAR_PTERANODON_PINK));
        }
        static function isStegosuarus(avatarId) {
            return((((avatarId == CONSTANTS.AVATAR_STEGOSAURUS_BLUE) || (avatarId == CONSTANTS.AVATAR_STEGOSAURUS_GREEN)) || (avatarId == CONSTANTS.AVATAR_STEGOSAURUS_PURPLE)) || (avatarId == CONSTANTS.AVATAR_STEGOSAURUS_YELLOW));
        }
        static function isRaptor(avatarId) {
            return((((avatarId == CONSTANTS.AVATAR_RAPTOR_BLACK) || (avatarId == CONSTANTS.AVATAR_RAPTOR_GREEN)) || (avatarId == CONSTANTS.AVATAR_RAPTOR_PINK)) || (avatarId == CONSTANTS.AVATAR_RAPTOR_RED));
        }
        static function getSnowballDelay(avatarId) {
            if (isTrex(avatarId)) {
                return(CONSTANTS.TREX_SNOWBALL_DELAY);
            } else if (isTriceratops(avatarId)) {
                return(CONSTANTS.TRICERATOPS_SNOWBALL_DELAY);
            } else if (isPteranodon(avatarId)) {
                return(CONSTANTS.PTERANODON_SNOWBALL_DELAY);
            } else if (isStegosuarus(avatarId)) {
                return(CONSTANTS.STEGOSAURUS_SNOWBALL_DELAY);
            } else if (isRaptor(avatarId)) {
                return(CONSTANTS.RAPTOR_SNOWBALL_DELAY);
            } else {
                return(0);
            }
        }
        static function canPlayerStomp(avatarId) {
            if (isDinosaurByAvatarId(avatarId) && (!isPteranodon(avatarId))) {
                return(true);
            }
            return(false);
        }
        static function onPuffleCareStationFeed(playerID) {
            var _local_8 = "w.puffle.sprite.eat";
            var _local_4 = _shell.getPlayerObjectById(playerID).attachedPuffle;
            if (_local_4) {
                var _local_7 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _local_4.id, _shell, _engine, true);
                _local_7.addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(_this, onEatAnimationDone, playerID));
                var _local_6 = _local_4["color"];
                var _local_1 = _local_4.subTypeID;
                var _local_3 = _shell.getPath(_local_8);
                _local_3 = com.clubpenguin.util.StringUtils.replaceString("%color%", _local_6, _local_3);
                _local_3 = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%", (isNaN(_local_1) ? "" : (String(_local_1))), _local_3);
                _local_7.playPuffleAnimation(_local_3);
                var _local_2 = _local_6;
                if (_local_1 == 1000) {
                    _local_2 = "black_t_rex";
                }
                if (_local_1 == 1001) {
                    _local_2 = "purple_t_rex";
                }
                if (_local_1 == 1002) {
                    _local_2 = "red_triceratops";
                }
                if (_local_1 == 1003) {
                    _local_2 = "blue_triceratops";
                }
                if (_local_1 == 1004) {
                    _local_2 = "yellow_stegosaurus";
                }
                if (_local_1 == 1005) {
                    _local_2 = "pink_stegosaurus ";
                }
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("feed", "puffle_station", {message:"station_type=prehistoric_feeding|puffle_color=" + _local_2});
        }
        static function onEatAnimationDone(event) {
            if (_shell.isMyPlayer(event.playerID)) {
                var _local_1 = _shell.getMyPlayerObject().attachedPuffle.id;
                _engine.puffleAvatarController.displayPuffleWidget(_local_1, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_EAT_ITEM_ID);
            }
        }
        static var CONSTANTS = com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyConstants;
        static var hotSpotPreviouslyRegistered = false;
        static var CLASS_NAME = "PrehistoricParty";
        static var PARTY_COOKIE_ID = "20140101";
        static var _this = com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty;
        static var _isActive = false;
        static var dinoEggAnimating = false;
    }
