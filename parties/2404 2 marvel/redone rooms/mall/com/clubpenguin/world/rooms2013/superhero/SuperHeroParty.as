//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.SuperHeroParty
    {
        static var _instance;
        var _shell, _airtower, _interface, _engine, _serverCookieService, _serverCookie, _heroPrizeCollectedReceivedDelegate, _villainPrizeCollectedReceivedDelegate, _robotHitReceivedDelegate, handlePowerSnowballThrownDelegate, opcodeJournal, __get__robotCollection, stompDanceCounter;
        function SuperHeroParty () {
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.superhero.SuperHeroParty();
            }
            return(_instance);
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _heroPrizeCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onHeroPrizeCollectedReceived);
            _villainPrizeCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onVillainPrizeCollectedReceived);
            _robotHitReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onRobotHitReceived);
            handlePowerSnowballThrownDelegate = com.clubpenguin.util.Delegate.create(this, updatePlayerGlovePower);
            _interface.showContent(LOGIN_SCREEN);
            opcodeJournal = new com.clubpenguin.world.rooms2013.superhero.OpcodeJournal();
        }
        static function launchCatalog() {
            _global.getCurrentInterface().showContent(PARTY_CATALOGUE);
        }
        function get getSuperHeroCookieVO() {
            return(com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO(_serverCookie));
        }
        function sendSomething(something) {
            var _local_1 = something;
        }
        function get glovePower() {
            return(((_serverCookie == null) ? 0 : (_serverCookie.glovePower)));
        }
        function set glovePower(num) {
            if (_serverCookie != null) {
                _serverCookie.glovePower = num;
            }
            //return(glovePower);
        }
        function get totalSnowballPoints() {
            return(((_serverCookie == null) ? 0 : (_serverCookie.totalSnowballPoints)));
        }
        function set totalSnowballPoints(num) {
            if (_serverCookie != null) {
                _serverCookie.totalSnowballPoints = num;
            }
            //return(totalSnowballPoints);
        }
        function get heroPrize() {
            if (_serverCookie == null) {
                return(0);
            }
            if (_shell.isItemInMyInventory(HERO_PRIZE_ITEM_ID)) {
                return(2);
            }
            if (_serverCookie.totalSnowballPoints >= HEROPRIZETHRESHOLD) {
                return(1);
            }
            return(0);
        }
        function isPowerGloveEquipped(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            return(isItemAPowerGlove(_local_2));
        }
        function isStaticPowerGloveEquipped(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            if ((((((_local_2 == LASER_POWERGLOVE_ID) || (_local_2 == TELEKINETIC_POWERGLOVE_ID)) || (_local_2 == TORNADO_POWERGLOVE_ID)) || (_local_2 == TELEPORT_POWERGLOVE_ID)) || (_local_2 == SONIC_POWERGLOVE_ID)) || (_local_2 == STOMP_POWERGLOVE_ID)) {
                return(true);
            } else {
                return(false);
            }
        }
        function isStompPowerGloveEquipped(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            if (_local_2 == STOMP_POWERGLOVE_ID) {
                return(true);
            } else {
                return(false);
            }
        }
        function isItemAPowerGlove(itemID) {
            var _local_1 = 5240;
            while (_local_1 <= 5247) {
                if (itemID == _local_1) {
                    return(true);
                }
                _local_1++;
            }
            if (itemID == FIXING_POWERGLOVE_ID) {
                return(true);
            }
            return(false);
        }
        function collectHeroItem() {
            _shell.sendBuyInventory(HERO_PRIZE_ITEM_ID);
        }
        function sendClaimHeroPrize() {
            _airtower.send(_airtower.PLAY_EXT, "shp#" + HERO_PRIZE_COLLECTED_RESPONSE_NAME, [], "str", _shell.getCurrentServerRoomId());
            _airtower.addListener(HERO_PRIZE_COLLECTED_RESPONSE_NAME, _heroPrizeCollectedReceivedDelegate, this);
        }
        function onHeroPrizeCollectedReceived(data) {
            _airtower.removeListener(HERO_PRIZE_COLLECTED_RESPONSE_NAME, _heroPrizeCollectedReceivedDelegate);
            var _local_2 = Number(data[1]);
            var _local_5 = _shell.getInventoryObjectById(_local_2);
            var _local_4 = _shell.getMyInventoryArray();
            if ((_local_2 > 0) && (!_shell.isItemInMyInventory(_local_2))) {
                _local_4.push(_local_5);
                showItemCollectedPrompt(_local_2);
            }
            var _local_3 = Number(data[2]);
            _shell.setMyPlayerTotalCoins(_local_3);
        }
        function handlePowerSnowballThrown() {
            _airtower.addListener(POWER_SNOWBALL_RESPONSE_NAME, handlePowerSnowballThrownDelegate, this);
        }
        function updatePlayerGlovePower(data) {
            _airtower.removeListener(POWER_SNOWBALL_RESPONSE_NAME, handlePowerSnowballThrownDelegate);
            _serverCookie.glovePower = Number(data[1]);
            _interface.updateHeroPowerMeter();
        }
        function get villainPrize() {
            if (numRobotTypesCollected == NUM_ROBOT_TYPES) {
                return(1);
            }
            return(0);
        }
        function get robotPower() {
            return((((_serverCookie == null) || (!isRobotEquipped(_shell.getMyPlayerId()))) ? 0 : (_serverCookie.robotPower)));
        }
        function set robotPower(num) {
            if (_serverCookie != null) {
                _serverCookie.robotPower = num;
            }
            //return(robotPower);
        }
        function isRobotEquipped(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            return(isItemARobot(_local_2));
        }
        function isItemARobot(itemID) {
            var _local_1 = 5300;
            while (_local_1 <= 5331) {
                if (itemID == _local_1) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        function get numRobotTypesCollected() {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_4 = 0;
            var _local_3 = _serverCookie.robotTypesCollected;
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_local_3[_local_2] == true) {
                    _local_4++;
                }
                _local_2++;
            }
            return(_local_4);
        }
        function get robotTypesCollected() {
            return(((_serverCookie == null) ? (new Array(false, false, false, false, false, false, false, false)) : (_serverCookie.robotTypesCollected)));
        }
        function set robotTypesCollected(value) {
            if (_serverCookie == null) {
                _serverCookie.robotTypesCollected = value;
            }
            //return(robotTypesCollected);
        }
        function get robotInventory() {
            var _local_3 = new Array();
            if (_serverCookie == null) {
                var _local_2 = 0;
                while (_local_2 < com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.TOTAL_NUM_ROBOTS) {
                    _local_3.push(0);
                    _local_2++;
                }
            } else {
                _local_3 = _serverCookie.robotInventory;
            }
            return(_local_3);
        }
        function getSelectedRobotCollection(robotType) {
            var _local_3 = new Array();
            if (_serverCookie == null) {
                var _local_2 = 0;
                while (_local_2 < com.clubpenguin.world.rooms2013.superhero.vo.SuperHeroCookieVO.TOTAL_NUM_ROBOTS) {
                    _local_3.push(0);
                    _local_2++;
                }
            } else {
                _local_3 = _serverCookie.robotInventory;
            }
            var _local_5 = new Array();
            var _local_4 = 4;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                _local_5.push(_local_3[_local_2 + ((robotType - 1) * _local_4)]);
                _local_2++;
            }
            return(_local_5);
        }
        function set robotCollection(value) {
            if (_serverCookie != null) {
                _serverCookie.robotCollection = value;
            }
            //return(__get__robotCollection());
        }
        function collectVillainItem() {
            _shell.sendBuyInventory(VILLAIN_PRIZE_ITEM_ID);
        }
        function sendClaimVillainPrize() {
            _airtower.send(_airtower.PLAY_EXT, "shp#" + VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME, [], "str", _shell.getCurrentServerRoomId());
            _airtower.addListener(VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME, _villainPrizeCollectedReceivedDelegate, this);
        }
        function onVillainPrizeCollectedReceived(data) {
            _airtower.removeListener(VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME, _villainPrizeCollectedReceivedDelegate);
            var _local_2 = Number(data[1]);
            var _local_5 = _shell.getInventoryObjectById(_local_2);
            var _local_4 = _shell.getMyInventoryArray();
            if ((_local_2 > 0) && (!_shell.isItemInMyInventory(_local_2))) {
                _local_4.push(_local_5);
                showItemCollectedPrompt(_local_2);
            }
            var _local_3 = Number(data[2]);
            _shell.setMyPlayerTotalCoins(_local_3);
        }
        function showItemCollectedPrompt(itemID) {
            var _local_4 = _shell.getInventoryObjectById(itemID);
            var _local_3 = _shell.getLocalizedString("buy_inventory_done");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%name%", _local_4.name, _local_3);
            _global.getCurrentInterface().showPrompt("ok", _local_3);
        }
        function handleRobotSnowballHit(snowball_player_id, hit_player_id, frame) {
            var _local_2 = _engine.getPlayerMovieClip(hit_player_id);
            _local_2.hand_mc.gotoAndStop(frame);
            if (_local_2.hand_mc.robot._currentframe > 1) {
                _local_2.hand_mc.robot.gotoAndPlay(1);
            }
            if (_shell.isMyPlayer(hit_player_id)) {
                _airtower.addListener(ROBOT_HIT_RESPONSE_NAME, _robotHitReceivedDelegate, this);
                sendRobotHit(snowball_player_id);
            }
        }
        function handleMyRobotHit(player_id) {
            _robotHitReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onRobotHitReceived, player_id);
            _airtower.addListener(ROBOT_HIT_RESPONSE_NAME, _robotHitReceivedDelegate, this);
            sendRobotHit(player_id);
        }
        function sendRobotHit(player_id) {
            _airtower.send(_airtower.PLAY_EXT, "shp#" + ROBOT_HIT_RESPONSE_NAME, [player_id], "str", _shell.getCurrentServerRoomId());
        }
        function onRobotHitReceived(data) {
            _airtower.removeListener(ROBOT_HIT_RESPONSE_NAME, _robotHitReceivedDelegate);
            if (data == null) {
                return(undefined);
            }
            updateRobotHealth(Number(data[1]));
        }
        function updateRobotHealth(robotPower) {
            _serverCookie.robotPower = robotPower;
            if (Number(_serverCookie.robotPower) == 0) {
                handleDestroyRobot();
            } else {
                _interface.updateRobotMeter();
            }
        }
        function handleDestroyRobot() {
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId()).hand_mc;
            _local_2.gotoAndStop(ROBOT_DEATH_FRAME);
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackRobotDeathAnimation, _local_2);
        }
        function trackRobotDeathAnimation(robotMC) {
            if (robotMC.robot._currentframe == robotMC.robot._totalframes) {
                _shell.sendUpdatePlayerHand(0);
                delete robotMC.onEnterFrame;
            }
        }
        function playSpecialStompAnimation(player_id) {
            var _local_2 = _engine.getPlayerMovieClip(player_id);
            var _local_3 = _local_2.attachMovie("StompEffect", "stompEffect", _local_2.art_mc.getDepth() - 5);
        }
        function trackDanceAnimation(player_id) {
            if (stompDanceCounter == 10) {
                var _local_2 = _engine.getPlayerMovieClip(player_id);
                _engine.updatePlayerFrame(player_id, 1, false);
                stompDanceCounter = 0;
                delete _local_2.art_mc.onEnterFrame;
                return(undefined);
            }
            stompDanceCounter++;
        }
        function fetchRobotSnowballOrigin(player_id) {
            var _local_3 = _shell.getPlayerObjectById(player_id);
            var _local_2 = _local_3.hand;
            if ((_local_2 >= 5300) && (_local_2 <= 5303)) {
                return(17);
            } else if ((_local_2 >= 5304) && (_local_2 <= 5307)) {
                return(16);
            } else if ((_local_2 >= 5308) && (_local_2 <= 5311)) {
                return(18);
            } else if ((_local_2 >= 5312) && (_local_2 <= 5315)) {
                return(20);
            } else if ((_local_2 >= 5316) && (_local_2 <= 5319)) {
                return(16);
            } else if ((_local_2 >= 5320) && (_local_2 <= 5323)) {
                return(17);
            } else if ((_local_2 >= 5324) && (_local_2 <= 5327)) {
                return(21);
            } else if ((_local_2 >= 5328) && (_local_2 <= 5331)) {
                return(26);
            } else {
                return(14);
            }
        }
        static var PARTY_COOKIE_ID = "20130424";
        static var UNAVAILABLE = 0;
        static var AVAILABLE = 1;
        static var COLLECTED = 2;
        static var NUM_POWER_GLOVES = 9;
        static var HEROPRIZETHRESHOLD = 50000;
        static var MAXSNOWBALLPOWER = 100;
        static var MAXROBOTPOWER = 40;
        static var NUM_ROBOT_TYPES = 8;
        static var HERO_PRIZE_ITEM_ID = 4841;
        static var VILLAIN_PRIZE_ITEM_ID = 4842;
        static var CRYSTALSHARDS_POWERGLOVE_ID = 5243;
        static var SLIME_POWERGLOVE_ID = 5245;
        static var LASER_POWERGLOVE_ID = 5241;
        static var TELEKINETIC_POWERGLOVE_ID = 5244;
        static var TORNADO_POWERGLOVE_ID = 5246;
        static var TELEPORT_POWERGLOVE_ID = 5240;
        static var SONIC_POWERGLOVE_ID = 5247;
        static var STOMP_POWERGLOVE_ID = 5242;
        static var FIXING_POWERGLOVE_ID = 5249;
        static var FREE_MONEY_BAG = 5153;
        static var MUGSHOT = 9143;
        static var REMOTE_CONTROLLER = 5248;
        static var PARTY_DAY = 0;
        static var SUPERHERO_UI = "w.p2013.superhero.superheroui";
        static var VILLAIN_UI = "w.p2013.superhero.villainui";
        static var LOGIN_SCREEN = "w.p2013.superhero.loginprompt";
        static var ROBOT_HIT_FRAME = 31;
        static var ROBOT_DEATH_FRAME = 32;
        static var HERO_PRIZE_COLLECTED_RESPONSE_NAME = "shphp";
        static var VILLAIN_PRIZE_COLLECTED_RESPONSE_NAME = "shpvp";
        static var ROBOT_HIT_RESPONSE_NAME = "shprh";
        static var PARTY_CATALOGUE = "w.party.catalogue.party1";
        static var POWER_SNOWBALL_RESPONSE_NAME = "shpgp";
        static var SUPER_HERO_HANDLER_NAME = "shp";
        static var OOPS_POWERGLOVE = "oops_party3";
        static var OOPS_ROBOT = "oops_party2";
        static var OOPS_PARTY_CATALOG = "oops_party1_catalog";
    }
