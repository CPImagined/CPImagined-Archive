//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty
    {
        static var _instance, CONCERT_DURATION_IN_MILLISECONDS;
        var _shell, _airtower, _interface, _engine, _party, _serverCookie, opcodeJournal, _concertHandlerDelegate, countdownSignal, _onInventoryBoughtDelegate, _engineOverrides, _isPlayerMascot, _currentRoom, _millisecondsTillStart, _timeBetweenConcertsInMilliSeconds;
        function TeenBeachParty () {
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty();
            }
            return(_instance);
        }
        function init() {
            trace("TEEN BEACH PARTY - INIT");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            var _local_3 = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.teenbeach.vo.TeenBeachPartyCookieVO(PARTY_COOKIE_ID);
            _local_3.registerCookieVO(_serverCookie.getID(), _serverCookie);
            opcodeJournal = new com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal();
            CONCERT_DURATION_IN_MILLISECONDS = CONCERT_DURATION_IN_SECONDS * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS;
            _concertHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handleConcertDetails);
            _airtower.addListener(CONCERT_COMMAND_NAME, _concertHandlerDelegate);
            countdownSignal = new org.osflash.signals.Signal();
            _onInventoryBoughtDelegate = com.clubpenguin.util.Delegate.create(this, onInventoryBought);
            _shell.addListener(_shell.BUY_INVENTORY, _onInventoryBoughtDelegate, this);
            _engineOverrides = new com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty_EngineOverrides();
            _engineOverrides.init();
            _isPlayerMascot = _shell.isPlayerMascotById(_shell.getMyPlayerId());
        }
        function onInventoryBought(event) {
            if (event.success && (event.item_id == MASCOT_GIVE_AWAY_ID)) {
                opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal.COLLECT_MASCOT_BACKGROUND);
            }
        }
        function checkShowFirstTimeLogin() {
            return(!_serverCookie.isLoginScreenViewed);
        }
        function setLoginScreenShown() {
            _serverCookie.isLoginScreenViewed = true;
            _serverCookie.sendToServer();
        }
        function checkHasVisitedSurfRoom() {
            return(_serverCookie.hasVisitedSurfRoom);
        }
        function setSurfRoomVisited() {
            _serverCookie.hasVisitedSurfRoom = true;
            _serverCookie.sendToServer();
        }
        function checkAllItemsCollected() {
            for (var _local_2 in roomItemID) {
                if (!_shell.isItemInMyInventory(roomItemID[_local_2])) {
                    return(false);
                }
            }
            return(true);
        }
        function showCatalogue() {
            _global.getCurrentInterface().showContent(PARTY_CATALOGUE_PATH);
        }
        function set currentRoom(room) {
            _currentRoom = room;
            //return(currentRoom);
        }
        function get currentRoom() {
            return(_currentRoom);
        }
        function isRoomItemAvailable(room) {
            var _local_3 = roomUnlockOrder.slice(0, PARTY_DAY + 1);
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_local_3[_local_2] == room) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function getRoomNameForDay(dayIndex) {
            return(roomUnlockOrder[dayIndex]);
        }
        function getRoomItemForDay(dayIndex) {
            return(roomItemID[getRoomNameForDay(dayIndex)]);
        }
        function configureItemHut(room, mc) {
            var _local_1 = instance.isRoomItemAvailable(room);
            if (_local_1) {
                mc.gotoAndStop(HUT_UNLOCKED);
            } else {
                mc.gotoAndStop(HUT_LOCKED);
            }
        }
        function collectPartyItem(room) {
            var _local_2 = _global.getCurrentShell();
            if (instance.isPenguinOnWaterslide(_local_2.getMyPlayerId())) {
                return(undefined);
            }
            var _local_4 = roomItemID[room];
            instance.currentRoom = room;
            _global.getCurrentInterface().showContent(SCAVENGER_PICKUP_PROMPT_PATH);
        }
        function isInValidSurfingState(mc, f) {
            var _local_2 = _shell.getRoomObject();
            if (((((_party.PARTY_ID == _party.PARTY_ID_2013_TEENBEACH) && (_local_2.room_id == SURF_ROOM_ID)) && (f >= PENGUIN_FIRST_WADDLE_FRAME)) && (f <= PENGUIN_LAST_WADDLE_FRAME)) && (!mc.art_mc.hitTest(_engine.getRoomMovieClip().triggers_mc.boatTrigger_mc))) {
                return(true);
            }
            return(false);
        }
        function isInValidHighwayState(mc, f) {
            var _local_2 = _shell.getRoomObject();
            if (((_party.PARTY_ID == _party.PARTY_ID_2013_TEENBEACH) && (_local_2.room_id == HIGHWAY_ROOM_ID)) && (f <= PENGUIN_LAST_WADDLE_FRAME)) {
                return(true);
            }
            return(false);
        }
        function hasVehicleItemEquipped(player_id) {
            return(isItemVehicle(player_id));
        }
        function isItemVehicle(player_id) {
            var _local_4 = _shell.getPlayerObjectById(player_id);
            var _local_3 = _local_4.body;
            var _local_2 = 0;
            while (_local_2 < VEHICLE_BODY_ITEM_IDS.length) {
                if (_local_3 == VEHICLE_BODY_ITEM_IDS[_local_2]) {
                    return(true);
                }
                _local_2++;
            }
            _local_3 = _local_4.hand;
            _local_2 = 0;
            while (_local_2 < VEHICLE_HAND_ITEM_IDS.length) {
                if (_local_3 == VEHICLE_HAND_ITEM_IDS[_local_2]) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function addPenguinToWaterslide(player_id) {
            instance.penguinsCurrentlyOnWaterslide[player_id] = player_id;
        }
        function removePenguinFromWaterslide(player_id) {
            instance.penguinsCurrentlyOnWaterslide[player_id] = null;
        }
        function isPenguinOnWaterslide(player_id) {
            if ((instance.penguinsCurrentlyOnWaterslide[player_id] != undefined) && (instance.penguinsCurrentlyOnWaterslide[player_id] == player_id)) {
                return(true);
            }
            return(false);
        }
        function sendPenguinOnWaterslide(slideID) {
            _airtower.send(_airtower.PLAY_EXT, (TEENBEACH_COOKIE_HANDLER_NAME + "#") + WATERSLIDE_COMMAND_NAME, [slideID], "str", _shell.getCurrentServerRoomId());
        }
        function requestConcertTime() {
            _airtower.send(_airtower.PLAY_EXT, (TEENBEACH_COOKIE_HANDLER_NAME + "#") + CONCERT_COMMAND_NAME, [0], "str", _shell.getCurrentServerRoomId());
        }
        function setSecondsSinceLastConcertStarted(secondsSinceLastConcertStarted) {
            _millisecondsTillStart = _timeBetweenConcertsInMilliSeconds - (secondsSinceLastConcertStarted * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS);
            trace((CLASS_NAME + ":_millisecondsTillStart:") + _millisecondsTillStart);
        }
        function set millisecondsTillStart(millisecondsTillStart) {
            _millisecondsTillStart = millisecondsTillStart;
            //return(this.millisecondsTillStart);
        }
        function get millisecondsTillStart() {
            return(_millisecondsTillStart);
        }
        function isConcertTimeSet() {
            return(_millisecondsTillStart != undefined);
        }
        function setTimeBetweenConcertsInMilliSeconds(timeBetweenConcertsInMilliSeconds) {
            _timeBetweenConcertsInMilliSeconds = timeBetweenConcertsInMilliSeconds;
        }
        function get timeBetweenConcertsInMilliSeconds() {
            return(_timeBetweenConcertsInMilliSeconds);
        }
        function resetConcertStartTime() {
            _millisecondsTillStart = _timeBetweenConcertsInMilliSeconds;
        }
        function collectMacAndBradyGiveAway() {
            if (!hasMacAndBradyGiveAway()) {
                _global.getCurrentInterface().buyInventory(MAC_AND_BRADY_GIVEAWAY_ITEM_ID);
            }
        }
        function hasMacAndBradyGiveAway() {
            return(_shell.isItemInMyInventory(MAC_AND_BRADY_GIVEAWAY_ITEM_ID));
        }
        function handleConcertDetails(data) {
            var _local_2 = Number(data[1]);
            var _local_3 = Number(data[2]);
            setTimeBetweenConcertsInMilliSeconds(_local_3 * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS);
            setSecondsSinceLastConcertStarted(_local_2);
            data = null;
            countdownSignal.dispatch();
        }
        function updateCountdownDisplay(concertCountdownTimer, tensDigitMC, onesDigitMC) {
            var _local_5 = _millisecondsTillStart / com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS;
            var _local_3;
            var _local_2;
            if ((_timeBetweenConcertsInMilliSeconds - _millisecondsTillStart) <= CONCERT_DURATION_IN_MILLISECONDS) {
                _local_2 = 0;
                _local_3 = 0;
            } else {
                _local_3 = Math.floor((_local_5 / 60) / 10);
                _local_2 = Math.floor((_local_5 / 60) % 10) + 1;
                if (10 == _local_2) {
                    _local_2 = 0;
                    _local_3++;
                }
            }
            if (concertCountdownTimer.tensDigit != _local_3) {
                tensDigitMC.gotoAndPlay("n_" + _local_3);
                concertCountdownTimer.tensDigit = _local_3;
            }
            if (concertCountdownTimer.onesDigit != _local_2) {
                onesDigitMC.gotoAndPlay("n_" + _local_2);
                concertCountdownTimer.onesDigit = _local_2;
            }
        }
        function isAMascotInBigMommasBackStageRoom(player) {
            if (_shell.isPlayerMascotById(player.player_id) && (_shell.getRoomObject().room_id == BACKSTAGE_ROOM_ID)) {
                return(true);
            }
            return(false);
        }
        function get engineOverrides() {
            if (_engineOverrides == null) {
                _engineOverrides = new com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty_EngineOverrides();
                _engineOverrides.init();
            }
            return(_engineOverrides);
        }
        function get isPlayerMascot() {
            if (_isPlayerMascot == undefined) {
                return(false);
            }
            return(_isPlayerMascot);
        }
        function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        function activateTeenBeachPlayerOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _party.TeenBeachParty.instance.engineOverrides.updatePlayerFrame);
        }
        function deactivateTeenBeachPlayerOverrides() {
            _engine.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _party.TeenBeachParty.instance.engineOverrides.defaultUpdatePlayerFrame);
        }
        function activateTeenBeachBackStageSettings() {
            _engine.checkIsValidPosition = com.clubpenguin.util.Delegate.create(this, _party.TeenBeachParty.instance.engineOverrides.checkIsValidPosition);
        }
        function deactivateTeenBeachBackStageSettings() {
            _engine.checkIsValidPosition = com.clubpenguin.util.Delegate.create(this, _party.TeenBeachParty.instance.engineOverrides.defaultCheckIsValidPosition);
        }
        static var CLASS_NAME = "TeenBeachParty";
        static var PARTY_COOKIE_ID = "20130801";
        static var AB_TEST_NAME = "TeenBeachItems";
        static var AB_TEST_CATALOGUE_VERSION = "CatalogID";
        static var TEENBEACH_COOKIE_HANDLER_NAME = "tnbch";
        static var WATERSLIDE_COMMAND_NAME = "tnbchslide";
        static var CONCERT_COMMAND_NAME = "tnbchshow";
        static var PARTY_INTERFACE_PATH = "w.p2013.teenBeach.partyInterface";
        static var SCAVENGER_PICKUP_PROMPT_PATH = "w.p2013.teenBeach.scavengerPickupPrompt";
        static var OOPS_PARTY_CATALOG = "oops_party2";
        static var OOPS_BACKSTAGE = "oops_party1";
        static var PARTY_CATALOGUE_PATH = "w.party.clothing.catalogue1";
        static var PARTY_DAY = 1;
        var roomUnlockOrder = ["dock", "forts", "party3", "rink", "beach", "cove", "forest"];
        static var roomItemID = {dock:5350, forts:1672, party3:5352, rink:5353, beach:3175, cove:5354, forest:5351};
        static var MASCOT_GIVE_AWAY_ID = 9211;
        static var BACKSTAGE_ROOM_ID = 852;
        static var BACKSTAGE_BACKGROUND_ITEM_ID = 9210;
        static var HUT_LOCKED = 1;
        static var HUT_UNLOCKED = 2;
        static var PENGUIN_FACING_RIGHT_FRAME = 7;
        static var PENGUIN_FIRST_WADDLE_FRAME = 9;
        static var PENGUIN_LAST_WADDLE_FRAME = 16;
        static var PENGUIN_WADDLE_FRAME = 15;
        static var PENGUIN_SIT_FRONT_CENTER = 17;
        static var PENGUIN_SIT_FRONT_LEFT = 18;
        static var PENGUIN_SIT_LEFT = 19;
        static var PENGUIN_SIT_BACK_LEFT = 20;
        static var PENGUIN_SIT_BACK_CENTER = 21;
        static var PENGUIN_SIT_BACK_RIGHT = 22;
        static var PENGUIN_SIT_RIGHT = 23;
        static var PENGUIN_SIT_FRONT_RIGHT = 24;
        static var SURF_ROOM_ID = 853;
        static var HIGHWAY_ROOM_ID = 854;
        static var VEHICLE_BODY_ITEM_IDS = new Array(4414, 4415, 14437, 4421, 4518, 4715, 4794, 4759, 4760, 4905, 14570, 4906);
        static var VEHICLE_HAND_ITEM_IDS = new Array(5344, 5346, 5345);
        var penguinsCurrentlyOnWaterslide = new Array();
        static var MAC_AND_BRADY_GIVEAWAY_ITEM_ID = 9211;
        static var CONCERT_DURATION_IN_SECONDS = 80;
    }
