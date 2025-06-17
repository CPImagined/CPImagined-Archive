//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.MedievalParty
    {
        static var _instance;
        var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, opcodeJournal, _purchaseItemThrottler, _joinRoomDelegate, _interfaceOverrides, _engineOverrides, _ingredientJustCollected, _onIngredientCollectedDelegate, _pagesLogged, _buyItemDelegate;
        function MedievalParty () {
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.medieval.MedievalParty();
            }
            return(_instance);
        }
        function get isActive() {
            trace("HSF get isActive = " + _isActive);
            return(_isActive);
        }
        function init() {
            trace("MEDIEVAL PARTY - INIT");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            opcodeJournal = new com.clubpenguin.world.rooms2013.medieval.OpcodeJournal();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
            activateMedievalInterfaceOverrides();
            activateMedievalEngineOverrides();
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, checkForGaryReminderPrompt);
            _engine.penguinTransformComplete.add(_joinRoomDelegate);
            _global.com.clubpenguin.engine.avatar.AvatarConfig.initPartyAvatars();
            _airtower.addListener(PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
        }
        function handleUpdatePartySettings(data) {
            var _local_2 = com.clubpenguin.util.JSONParser.parse(data[1]);
            POTION_RECIPES = _local_2.recipes;
            PARTY_DAY = _local_2.unlockDayIndex;
            POTIONS_PER_GAME = _local_2.potionsPerGame;
            COINS_PER_GAME = _local_2.coinsPerGame;
            MAX_POTIONS = _local_2.maxPotions;
            MAX_PENGUIN_SPEED = _local_2.maxSpeed;
            _airtower.removeListener(PARTY_SETTINGS_RESPONSE_NAME, handleUpdatePartySettings);
            trace("0918_medieval: handleUpdatePartySettings 1.Party Day: " + PARTY_DAY);
            trace("0918_medieval: handleUpdatePartySettings 2.Potions Per game: " + POTIONS_PER_GAME);
            trace("0918_medieval: handleUpdatePartySettings 3.Coins Per game: " + COINS_PER_GAME);
            trace("0918_medieval: handleUpdatePartySettings 4.Max Potions: " + MAX_POTIONS);
            trace("0918_medieval: handleUpdatePartySettings 5.Recipes: " + POTION_RECIPES);
        }
        function checkForGaryReminderPrompt(playerObj) {
            if (playerObj.player_id != _shell.getMyPlayerId()) {
                return(undefined);
            }
            if ((((_shell.getRoomObject().room_id != 112) && (instance.messageIndex > 0)) && (instance.messageIndex < 10)) && (instance.messageIndex <= PARTY_DAY)) {
                _interface.showContent(CHARACTER_DIALOGUE_PATH_REMINDER);
                _joinRoomDelegate = null;
            }
        }
        function showPartyCatalogue() {
            trace("show");
            _interface.showContent(PARTY_CATALOGUE);
        }
        function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2013.medieval.MedievalParty_InterfaceOverrides();
                _interfaceOverrides.init();
            }
            return(_interfaceOverrides);
        }
        function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2013.medieval.MedievalParty_EngineOverrides();
                _engineOverrides.init();
            }
            return(_engineOverrides);
        }
        function get ingredientJustCollected() {
            return(_ingredientJustCollected);
        }
        function set ingredientJustCollected(ingredient) {
            _ingredientJustCollected = ingredient;
            //return(ingredientJustCollected);
        }
        function isStaticPenguinRequired(playerId) {
            if (instance.isMagicWandEquipped(playerId)) {
                return(true);
            }
            return(false);
        }
        function isMagicWandEquipped(playerId) {
            var _local_3 = _shell.getPlayerObjectById(playerId);
            var _local_2 = _local_3.hand;
            if (_local_2 == MAGIC_WAND_ITEM_ID) {
                return(true);
            }
            return(false);
        }
        function get messageIndex() {
            trace("is the server cookie null ? " + _serverCookie);
            return(((_serverCookie == null) ? 0 : (_serverCookie.msgIndex)));
        }
        function set messageIndex(index) {
            if (_serverCookie != null) {
                _serverCookie.msgIndex = index;
            }
            //return(messageIndex);
        }
        function get ingredients() {
            return(((_serverCookie == null) ? (new Array(0, 0, 0, 0, 0)) : (_serverCookie.ingredients)));
        }
        function set ingredients(list) {
            if (_serverCookie != null) {
                _serverCookie.ingredients = list;
            }
            //return(ingredients);
        }
        function get potionsMade() {
            return(((_serverCookie == null) ? (new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) : (_serverCookie.potionsMade)));
        }
        function set potionsMade(list) {
            if (_serverCookie != null) {
                _serverCookie.potionsMade = list;
            }
            //return(potionsMade);
        }
        function get hasPlayerMadeAnyPotions() {
            var _local_2 = instance.potionsMade;
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if (_local_2[_local_1] == 1) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        function get inventory() {
            return(((_serverCookie == null) ? (new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)) : (_serverCookie.inventory)));
        }
        function set inventory(list) {
            if (_serverCookie != null) {
                _serverCookie.inventory = list;
            }
            //return(inventory);
        }
        function get goldenBerryDialogueViewed() {
            return(((_serverCookie == null) ? false : (_serverCookie.golden)));
        }
        function set goldenBerryDialogueViewed(viewed) {
            if (_serverCookie != null) {
                _serverCookie.golden = viewed;
            }
            //return(goldenBerryDialogueViewed);
        }
        function handleIngredientCollected(data, ingredient, callback) {
            _airtower.removeListener(com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_RECEIVE_COMMAND_NAME, _onIngredientCollectedDelegate);
            _engine.getRoomMovieClip().room.deactivateIngredient();
            openSpellbook(ingredient);
        }
        function openSpellbook(ingredient) {
            ingredientJustCollected = (ingredient);
            _interface.showContent(SPELLBOOK_PATH);
        }
        function hasPlayerCollectedIngredient(id) {
            if (instance.ingredients[id] == COLLECTED) {
                return(true);
            }
            return(false);
        }
        function get hasPlayerCollectedAllIngredients() {
            var _local_3 = [DRAGONSCALE_ITEM_ID, OGRE_SNOT_ITEM_ID, MAGIC_BERRY_ITEM_ID, HORSESHOE_ITEM_ID, FAIRY_DUST_ITEM_ID];
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (!hasPlayerCollectedIngredient(_local_3[_local_2])) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function hasPotionBeenMade(num) {
            if (instance.potionsMade[num - 1] == COLLECTED) {
                return(true);
            }
            return(false);
        }
        function get hasAllPotionsBeenMade() {
            var _local_2 = instance.potionsMade;
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if (_local_2[_local_1] == 0) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        function getInventoryForThisPotion(potion) {
            var _local_1 = instance.inventory;
            return(_local_1[potion]);
        }
        function launchPotionGame(_potionNumber) {
            _engine.sendJoinGame(POTION_GAME_PATH, false, {gameStartParams:{isAS3:true, ingredients:POTION_RECIPES[_potionNumber - 1].ingredientIds, potion:_potionNumber, member:_shell.isMyPlayerMember()}});
        }
        function hasAllIngredients(potionNumber) {
            var _local_2 = POTION_RECIPES[potionNumber - 1].ingredientIds;
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if ((!instance.hasPlayerCollectedIngredient(_local_2[_local_1])) && (_local_2[_local_1] != GOLD_BERRY_ITEM_ID)) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        function get spellbookPagesLogged() {
            return(_pagesLogged);
        }
        function setUpSpellbookLoggedPages(totalPages) {
            _pagesLogged = new Array();
            var _local_2 = 0;
            while (_local_2 < totalPages) {
                _pagesLogged.push(0);
                _local_2++;
            }
        }
        function sendBILogForSpellbookPage(page) {
            if (_pagesLogged[page - 1] == 0) {
                com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("quest_spell_book_view", "page_" + (page - 1));
                _pagesLogged[page - 1] = 1;
            }
        }
        function configurePurchaseableItem(itemMC, itemID, member, prompt) {
            if (_shell.isItemInMyInventory(itemID)) {
                itemMC.nextFrame();
            } else {
                itemMC.buy_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem, itemMC, itemID, member, prompt);
            }
        }
        function checkPurchaseOfItem(itemMC, itemID, member, prompt) {
            instance.playSound(itemMC, "sfx_item");
            if (member) {
                if (_shell.isMyPlayerMember()) {
                    buyItem(itemID, itemMC, prompt);
                } else {
                    opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.OOPS_PARTY_ITEMS);
                    _interface.showContent(OOPS_CATALOGUE_MESSAGE);
                }
            } else {
                buyItem(itemID, itemMC, prompt);
            }
        }
        function buyItem(itemID, itemMC, prompt) {
            _buyItemDelegate = null;
            if (itemID == POTION_REWARD_1) {
                opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.COLLECT_WIZARD_HAT);
            }
            if (prompt) {
                _interface.buyInventory(itemID);
            } else {
                _shell.sendBuyInventory(itemID);
            }
            if (!prompt) {
                _buyItemDelegate = com.clubpenguin.util.Delegate.create(this, onInventoryBought, itemMC, itemID);
                _shell.addListener(_shell.BUY_INVENTORY, _buyItemDelegate, this);
            }
        }
        function onInventoryBought(event, itemMC, itemID) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyItemDelegate);
            if (event.success) {
                itemMC.nextFrame();
            }
        }
        function showMedievalIcon() {
            trace("show medieval icon");
            _interface.PARTY_ICON._visible = true;
            _interface.PARTY_ICON.gotoAndStop("idle");
            _interface.PARTY_ICON.icon_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, instance.openSpellbook);
        }
        function hideMedievalIcon() {
            _interface.PARTY_ICON._visible = false;
            delete _interface.PARTY_ICON.icon_Btn.onRelease;
        }
        function medievalPartyIconState() {
            _interface.PARTY_ICON.gotoAndStop("idle");
            trace("MedievalParty.instance.messageIndex " + instance.messageIndex);
            if (instance.messageIndex > 0) {
                showMedievalIcon();
            } else {
                hideMedievalIcon();
            }
        }
        function sendReminderMessageViewed(message) {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_COOKIE_HANDLER_NAME + "#") + REMINDER_MESSAGE_COMMAND_NAME, [message], "str", _shell.getCurrentServerRoomId());
        }
        function sendCollectIngredient(ingredient, ingredientMC, roomCallback) {
            _onIngredientCollectedDelegate = null;
            _onIngredientCollectedDelegate = com.clubpenguin.util.Delegate.create(this, handleIngredientCollected, ingredient, roomCallback);
            _airtower.addListener(com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_RECEIVE_COMMAND_NAME, _onIngredientCollectedDelegate, this);
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_COOKIE_HANDLER_NAME + "#") + COLLECT_INGREDIENT_COMMAND_NAME, [ingredient], "str", _shell.getCurrentServerRoomId());
        }
        function sendConsumePotion(potionIndex) {
            var _local_3 = _shell.getPlayerObjectById(_shell.getMyPlayerId()).avatarVO;
            var _local_2 = _local_3.avatar_id;
            var _local_5 = _local_3.attributes.spriteScale;
            var _local_6 = _local_3.attributes.spriteSpeed;
            var _local_7 = _local_3.attributes.isInvisible;
            var _local_8 = _local_3.attributes.isFloating;
            switch (potionIndex) {
                case 1 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.UNICORN_PUFFLE_WHITE_ID) {
                        return(undefined);
                    }
                    opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.WHITE_PUFFLE_UNICORN_TRANSFORMATION);
                    break;
                case 2 : 
                    if (_local_5 > 100) {
                        return(undefined);
                    }
                    break;
                case 3 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DRAGON_PUFFLE_GREEN_ID) {
                        return(undefined);
                    }
                    break;
                case 4 : 
                    if (_local_7) {
                        return(undefined);
                    }
                    opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.INVISIBLE_TRANSFORMATION);
                    break;
                case 5 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.UNICORN_PUFFLE_BLACK_ID) {
                        return(undefined);
                    }
                    break;
                case 6 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.FAIRY_ID) {
                        return(undefined);
                    }
                    break;
                case 7 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DRAGON_PUFFLE_BLUE_ID) {
                        return(undefined);
                    }
                    break;
                case 8 : 
                    if (_local_8) {
                        return(undefined);
                    }
                    break;
                case 9 : 
                    if (_local_6 >= MAX_PENGUIN_SPEED) {
                        return(undefined);
                    }
                    break;
                case 10 : 
                    if (_local_2 == com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DRAGON_ID) {
                        return(undefined);
                    }
                    opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.MEGADRAGON_TRANSFORMATION);
                    break;
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("medieval_transform", transformationNames[potionIndex]);
            if ((potionIndex >= 0) && (potionIndex <= TOTAL_NUM_POTIONS)) {
                _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_COOKIE_HANDLER_NAME + "#") + CONSUME_POTION_COMMAND_NAME, [potionIndex], "str", _shell.getCurrentServerRoomId());
            }
        }
        function sendConsumeAntidotePotion() {
            sendConsumePotion(0);
        }
        function sendPotionMade(potionIndex) {
            if (!instance.hasPlayerMadeAnyPotions) {
                opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.medieval.OpcodeJournal.POTION_FIRST_PLAY);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_COOKIE_HANDLER_NAME + "#") + POTION_MADE_COMMAND_NAME, [potionIndex], "str", _shell.getCurrentServerRoomId());
        }
        function sendPenguinOnWaterslide() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO.MEDIEVAL_COOKIE_HANDLER_NAME + "#") + FAIRY_SLIDE_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        function activateMedievalInterfaceOverrides() {
            _interface.showPartyIcon = com.clubpenguin.util.Delegate.create(this, _party.MedievalParty.instance.interfaceOverrides.showPartyIcon);
            _interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(this, _party.MedievalParty.instance.interfaceOverrides.onPartyIconLoad);
        }
        function activateMedievalEngineOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _party.MedievalParty.instance.engineOverrides.updatePlayerFrame);
        }
        function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        static var PARTY_COOKIE_ID = "20130901";
        static var PARTY_SETTINGS_RESPONSE_NAME = "mdvls";
        static var REMINDER_MESSAGE_COMMAND_NAME = "mdvlv";
        static var COLLECT_INGREDIENT_COMMAND_NAME = "mdvli";
        static var CONSUME_POTION_COMMAND_NAME = "mdvlc";
        static var POTION_MADE_COMMAND_NAME = "mdvlm";
        static var FAIRY_SLIDE_COMMAND_NAME = "mdvlsld";
        var _isActive = false;
        static var SOLO_ROOM_ID = 435;
        static var SPELLBOOK_PATH = "w.p2013.medieval.spellbook";
        static var POTION_GAME_PATH = "potion";
        static var PARTY_CATALOGUE = "w.party.catalogue.party1";
        static var OOPS_CATALOGUE_MESSAGE = "oops_party2";
        static var OOPS_MEMBER_MESSAGE = "oops_party1";
        static var OOPS_MEMBER_CLOTHING_MESSAGE = "oops_party2";
        static var CHARACTER_DIALOGUE_PATH_SOLOROOM = "w.p2013.medieval.dialogue.soloroom";
        static var CHARACTER_DIALOGUE_PATH_REMINDER = "w.p2013.medieval.dialogue.reminder";
        static var CHARACTER_DIALOGUE_PATH_GAME_SUCCESS = "w.p2013.medieval.dialogue.gamesuccess";
        static var CHARACTER_DIALOGUE_PATH_GAME_FAIL = "w.p2013.medieval.dialogue.gamefail";
        static var CHARACTER_DIALOGUE_PATH_FINAL_INGREDIENT = "w.p2013.medieval.dialogue.finalingredient";
        static var CHARACTER_DIALOGUE_SOLOROOM_1 = "w.party.dialogue.soloroom.1";
        static var CHARACTER_DIALOGUE_SOLOROOM_2 = "w.party.dialogue.soloroom.2";
        static var CHARACTER_DIALOGUE_REMINDER_1 = "w.party.dialogue.reminder.1";
        static var CHARACTER_DIALOGUE_REMINDER_2 = "w.party.dialogue.reminder.2";
        static var CHARACTER_DIALOGUE_REMINDER_3 = "w.party.dialogue.reminder.3";
        static var CHARACTER_DIALOGUE_GAME_FAIL_MEMBER = "w.party.dialogue.gamefail.member";
        static var CHARACTER_DIALOGUE_GAME_FAIL_NONMEMBER = "w.party.dialogue.gamefail.nonmember";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_MEMBER = "w.party.dialogue.gamesuccess.member";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_NONMEMBER = "w.party.dialogue.gamesuccess.nonmember";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_FAST = "w.party.dialogue.gamesuccess.fast";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_INVISIBLE = "w.party.dialogue.gamesuccess.invisible";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_BLUEDRAGON = "w.party.dialogue.gamesuccess.bluepuffledragon";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_GREENDRAGON = "w.party.dialogue.gamesuccess.greenpuffledragon";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_OGRE = "w.party.dialogue.gamesuccess.ogre";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_FLOAT = "w.party.dialogue.gamesuccess.float";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_FAIRY = "w.party.dialogue.gamesuccess.fairy";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_BLACKUNICORN = "w.party.dialogue.gamesuccess.blackunicornpufle";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_WHITEUNICORN = "w.party.dialogue.gamesuccess.whiteunicornpuffle";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_MEGADRAGON_MEMBER = "w.party.dialogue.gamesuccess.megadragon.member";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_MEGADRAGON_NONMEMBER = "w.party.dialogue.gamesuccess.megadragon.nonmember";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_POTION_ENDING = "w.party.dialogue.gamesuccess.potionending";
        static var CHARACTER_DIALOGUE_GAME_SUCCESS_CONGRATULATORY_WORD = "w.party.dialogue.gamesuccess.congratulatory.";
        static var NUM_CONGRATULATORY_WORDS = 6;
        static var CHARACTER_DIALOGUE_GAME_FINAL_INGREDIENT = "w.party.dialogue.finalingredient";
        static var CHARACTER_DIALOGUE_OK = "w.p2013.medieval.dialogue.ok";
        static var PARTY_DAY = 0;
        static var AVAILABLE = 0;
        static var COLLECTED = 1;
        static var DRAGONSCALE_ITEM_ID = 0;
        static var OGRE_SNOT_ITEM_ID = 1;
        static var MAGIC_BERRY_ITEM_ID = 2;
        static var HORSESHOE_ITEM_ID = 3;
        static var FAIRY_DUST_ITEM_ID = 4;
        static var GOLD_BERRY_ITEM_ID = 5;
        static var MAGIC_WAND_ITEM_ID = 5362;
        static var POTION_REWARD_1 = 1698;
        static var POTION_REWARD_2 = 4952;
        static var POTION_REWARD_3 = 5362;
        static var POTION_RECIPES = [{ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}, {ingredients:[0]}];
        static var TOTAL_NUM_POTIONS = 11;
        static var GOLD_BERRY_MESSAGE_INDEX = 11;
        static var POTIONS_PER_GAME = 5;
        static var COINS_PER_GAME = 50;
        static var MAX_POTIONS = 99;
        static var MAX_PENGUIN_SPEED = 200;
        static var PUFFLE_WHITE_UNICORN_POTION_ID = 1;
        static var OGRE_POTION_ID = 2;
        static var GREEN_PUFFLE_DRAGON_POTION_ID = 3;
        static var INVISIBLE_POTION_ID = 4;
        static var BLACK_PUFFLE_UNICORN_POTION_ID = 5;
        static var FAIRY_POTION_ID = 6;
        static var BLUE_PUFFLE_DRAGON_POTION_ID = 7;
        static var FLOAT_POTION_ID = 8;
        static var FAST_POTION_ID = 9;
        static var MEGA_DRAGON_POTION_ID = 10;
        static var CHICKEN_POTION_ID = 11;
        static var transformationNames = ["revert_to_penguin", "white_puffle_unicorn", "ogre_size", "green_puffle_dragon", "invisible_penguin", "black_puffle_unicorn", "fairy", "blue_puffle_dragon", "floating_penguin", "fast_penguin", "megadragon"];
    }
