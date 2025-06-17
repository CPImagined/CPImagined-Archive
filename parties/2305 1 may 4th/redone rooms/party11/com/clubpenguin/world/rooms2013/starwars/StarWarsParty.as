//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.StarWarsParty
    {
        static var _instance;
        var _shell, _airtower, _interface, _engine, _serverCookieService, _serverCookie, miniGameProgressDelegate, partyCookieReceivedDelegate, _opcodeJournal, _joinRoomDelegate;
        function StarWarsParty () {
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.starwars.StarWarsParty();
            }
            return(_instance);
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO(PARTY_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            miniGameProgressDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePlayerCoins);
            partyCookieReceivedDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePartyCookie);
            _opcodeJournal = new com.clubpenguin.world.rooms2013.starwars.OpcodeJournal();
        }
        function getOpcodeJournal() {
            return(_opcodeJournal);
        }
        function get getStarWarsPartyCookieVO() {
            return(com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO(_serverCookie));
        }
        static function launchCatalogue() {
            _global.getCurrentInterface().showContent(PARTY_CATALOGUE_PATH);
        }
        static function isPlayerABattleAvatar(player_id) {
            var _local_2 = _global.getCurrentShell().getPlayerObjectById(player_id).avatar_id;
            return(((_local_2 == com.clubpenguin.engine.avatar.AvatarConfig.JEDI_BROWN_ID) || (_local_2 == com.clubpenguin.engine.avatar.AvatarConfig.JEDI_BLACK_ID)) || (_local_2 == com.clubpenguin.engine.avatar.AvatarConfig.VADER_ID));
        }
        static function getLightSaberOuterColor(lightSaberItemId) {
            switch (lightSaberItemId) {
                case BLUE_LIGHT_SABER_ID : 
                    return(12447989);
                case GREEN_LIGHT_SABER_ID : 
                    return(10746775);
                case RED_LIGHT_SABER_ID : 
                    return(16763080);
            }
            return(170);
        }
        static function getLightSaberInnerColor(lightSaberItemId) {
            switch (lightSaberItemId) {
                case BLUE_LIGHT_SABER_ID : 
                    return(11329508);
                case GREEN_LIGHT_SABER_ID : 
                    return(8702842);
                case RED_LIGHT_SABER_ID : 
                    return(16711680);
            }
            return(170);
        }
        static function isLightSaberEquipped(player_id) {
            var _local_2 = _global.getCurrentShell().getPlayerObjectById(player_id).hand;
            return(((_local_2 == BLUE_LIGHT_SABER_ID) || (_local_2 == GREEN_LIGHT_SABER_ID)) || (_local_2 == RED_LIGHT_SABER_ID));
        }
        static function isDarthVaderEquipped(playerId) {
            var _local_2 = _global.getCurrentShell().getPlayerObjectById(playerId);
            return((_local_2.head == DARTH_VADER_HELMET_ID) || (_local_2.body == DARTH_VADER_COSTUME_ID));
        }
        static function isBlackJediEquipped(playerId) {
            var _local_2 = _global.getCurrentShell().getPlayerObjectById(playerId);
            return((_local_2.body == BATTLE_PRIZE_6_ID) || (_local_2.neck == BATTLE_PRIZE_7_ID));
        }
        function get jediPoints() {
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.jediPoints);
        }
        function get numBattlesWon() {
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.numBattlesWon);
        }
        function get falconAccessedThroughPartyInterface() {
            return(_falconAccessedThroughPartyInterface);
        }
        function set falconAccessedThroughPartyInterface(value) {
            _falconAccessedThroughPartyInterface = value;
            //return(falconAccessedThroughPartyInterface);
        }
        function get spokeToSoloCadence() {
            return(_spokeToSoloCadence);
        }
        function set spokeToSoloCadence(value) {
            _spokeToSoloCadence = value;
            //return(spokeToSoloCadence);
        }
        function get tatooineClicked() {
            if (instance.soloRoomVisited && (instance.tatooineWelcomeViewed)) {
                return(true);
            }
            return(_tatooineClicked);
        }
        function set tatooineClicked(value) {
            _tatooineClicked = value;
            //return(tatooineClicked);
        }
        function isStormTrooperCostumeEquipped(playerID) {
            var _local_3 = _shell.getPlayerObjectById(playerID);
            var _local_2 = _local_3.body;
            if (_local_2 == STORMTROOPER_COSTUME) {
                return(true);
            } else {
                return(false);
            }
        }
        function checkForCharacterDialogue(location) {
            switch (location) {
                case "Tatooine" : 
                    if (!instance.tatooineWelcomeViewed) {
                        _interface.showContent(CHARACTER_DIALOGUE_TATOOINE_WELCOME);
                    }
                    break;
                case "BlasterGame" : 
                    if (!instance.tatooineCongratulationsViewed) {
                        _interface.showContent(CHARACTER_DIALOGUE_TATOOINE_CONGRATULATIONS);
                    } else {
                        _interface.closeContent();
                    }
                    break;
                case "DeathStar" : 
                    if (!instance.deathStarWelcomeViewed) {
                        _interface.showContent(CHARACTER_DIALOGUE_DEATHSTAR_WELCOME);
                    }
                    break;
                case "IceJam" : 
                    if (instance.icejamLevel == 6) {
                        _interface.showContent(CHARACTER_DIALOGUE_DEATHSTAR_CONGRATULATIONS);
                    } else {
                        _interface.closeContent();
                    }
                    break;
                case "Yavin" : 
                    if (!instance.yavinWelcomeViewed) {
                        _interface.showContent(CHARACTER_DIALOGUE_YAVIN_WELCOME);
                    }
                    break;
                case "XWingGame" : 
                    if ((instance.xwingLevel > 3) && (!instance.yavinCongratulationsViewed)) {
                        _interface.showContent(CHARACTER_DIALOGUE_YAVIN_CONGRATULATIONS);
                    } else {
                        _interface.closeContent();
                    }
                    break;
            }
        }
        function sendDialogueViewed(token) {
            var _local_2 = -1;
            switch (token) {
                case CINEMATIC_PATH : 
                    _local_2 = 0;
                    break;
                case CHARACTER_DIALOGUE_SOLOROOM : 
                    _local_2 = 1;
                    break;
                case CHARACTER_DIALOGUE_TATOOINE_WELCOME : 
                    _local_2 = 2;
                    break;
                case CHARACTER_DIALOGUE_TATOOINE_CONGRATULATIONS : 
                    _local_2 = 3;
                    break;
                case CHARACTER_DIALOGUE_DEATHSTAR_WELCOME : 
                    _local_2 = 4;
                    break;
                case CHARACTER_DIALOGUE_DEATHSTAR_CONGRATULATIONS : 
                    _local_2 = 5;
                    break;
                case CHARACTER_DIALOGUE_YAVIN_WELCOME : 
                    _local_2 = 6;
                    break;
                case CHARACTER_DIALOGUE_YAVIN_CONGRATULATIONS : 
                    _local_2 = 7;
                    break;
            }
            if (_local_2 == -1) {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO.STARWARS_COOKIE_HANDLER_NAME + "#") + DIALOGUE_VIEWED_COMMAND_NAME, [_local_2], "str", _shell.getCurrentServerRoomId());
        }
        function checkForFirstTimePartyLogin() {
            if (!cinematicViewed) {
                var _local_3 = {source:_global.getCurrentShell().getPath(CINEMATIC_PATH), autoPlay:true};
                _interface.showContent("videoPlayer", null, undefined, _local_3, true);
            }
        }
        function get cinematicViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.cinematicViewed);
        }
        function set cinematicViewed(value) {
            _serverCookie.cinematicViewed = value;
            //return(cinematicViewed);
        }
        function get soloRoomVisited() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.soloRoomVisited);
        }
        function set soloRoomVisited(value) {
            _serverCookie.soloRoomVisited = value;
            //return(soloRoomVisited);
        }
        function get tatooineWelcomeViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.tatooineWelcomeViewed);
        }
        function set tatooineWelcomeViewed(value) {
            _serverCookie.tatooineWelcomeViewed = value;
            //return(tatooineWelcomeViewed);
        }
        function get tatooineCongratulationsViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.tatooineCongratulationsViewed);
        }
        function set tatooineCongratulationsViewed(value) {
            _serverCookie.tatooineCongratulationsViewed = value;
            //return(tatooineCongratulationsViewed);
        }
        function get blasterGameLevel() {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_2 = Number(_serverCookie.blasterGameLevel) + 1;
            return(_local_2);
        }
        function set blasterGameLevel(value) {
            _serverCookie.blasterGameLevel = value;
            //return(blasterGameLevel);
        }
        function isPlayerOnTatooine(roomID) {
            var _local_2 = 0;
            while (_local_2 < TATOOINE_ROOMS.length) {
                if (roomID == _shell.getRoomCrumbsByName(TATOOINE_ROOMS[_local_2]).room_id) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function get isWeek2Available() {
            return(((PARTY_WEEK >= 2) ? true : false));
        }
        function get deathStarWelcomeViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.deathStarWelcomeViewed);
        }
        function set deathStarWelcomeViewed(value) {
            _serverCookie.deathStarWelcomeViewed = value;
            //return(deathStarWelcomeViewed);
        }
        function get deathStarCongratulationsViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.deathStarCongratulationsViewed);
        }
        function set deathStarCongratulationsViewed(value) {
            _serverCookie.deathStarCongratulationsViewed = value;
            //return(deathStarCongratulationsViewed);
        }
        function get icejamLevel() {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_2 = Number(_serverCookie.icejamLevel) + 1;
            return(_local_2);
        }
        function set icejamLevel(value) {
            _serverCookie.icejamLevel = value;
            //return(icejamLevel);
        }
        function isPlayerOnDeathStar(roomID) {
            var _local_2 = 0;
            while (_local_2 < DEATHSTAR_ROOMS.length) {
                if (roomID == _shell.getRoomCrumbsByName(DEATHSTAR_ROOMS[_local_2]).room_id) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function sendIceJamGameComplete(isLevelCompleted, level) {
            instance.sendUpdateMiniGameProgress(ICEJAM_GAME, level, isLevelCompleted, 0, isLevelCompleted);
            var _local_2 = "null";
            if (isLevelCompleted) {
                switch (level) {
                    case 1 : 
                        _local_2 = "Level_One_Complete";
                        break;
                    case 2 : 
                        _local_2 = "Level_Two_Complete";
                        break;
                    case 3 : 
                        _local_2 = "Level_Three_Complete";
                        break;
                    case 4 : 
                        _local_2 = "Level_Four_Complete";
                        break;
                    case 5 : 
                        _local_2 = "Level_Five_Complete";
                        break;
                }
            } else {
                _engine.setActiveGameParams(null);
            }
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_local_2, "Deathstar_Game");
        }
        function launchIcejamGame(level) {
            var _local_2 = {currentLevel:level, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, instance.sendIceJamGameComplete, level)};
            instance.sendUpdateMiniGameProgress(ICEJAM_GAME, 0, false, 0, false);
            _global.getCurrentEngine().setActiveGameParams(_local_2);
            _global.getCurrentEngine().sendJoinGame(ICEJAM_GAME, false, _local_2);
        }
        function get isWeek3Available() {
            return(((PARTY_WEEK == 3) ? true : false));
        }
        function get yavinWelcomeViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.yavinWelcomeViewed);
        }
        function get xwingLevel() {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_2 = Number(_serverCookie.xwingLevel) + 1;
            return(_local_2);
        }
        function get yavinCongratulationsViewed() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.yavinCongratulationsViewed);
        }
        function isPlayerOnYavin(roomID) {
            var _local_2 = 0;
            while (_local_2 < YAVIN_ROOMS.length) {
                if (roomID == _shell.getRoomCrumbsByName(YAVIN_ROOMS[_local_2]).room_id) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function setDeathStarState(mc) {
            var _local_1;
            if (instance.yavinCongratulationsViewed && (instance.xwingLevel > 3)) {
                _local_1 = "destroyed";
            } else {
                _local_1 = "active";
            }
            mc.gotoAndStop(_local_1);
        }
        function sendUpdateMiniGameProgress(minigame, level, completed, coins, addCoinListener) {
            if ((minigame != ICEJAM_GAME) && (_engine.getActiveGameParams().currentLevel != undefined)) {
                _engine.setActiveGameParams(null);
            }
            var _local_2 = 0;
            if (minigame == BLASTER_GAME) {
                _local_2 = BLASTER_GAME_ID;
                if ((_serverCookie.blasterGameLevel == 0) && (level == 1)) {
                    _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.starwars.OpcodeJournal.COMPLETE_BLASTER_LEVEL_1);
                }
            } else if (minigame == ICEJAM_GAME) {
                _local_2 = ICEJAM_GAME_ID;
            } else if (minigame == XWING_GAME) {
                _local_2 = XWING_GAME_ID;
                if ((_serverCookie.xwingLevel == 0) && (level == 1)) {
                    _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.starwars.OpcodeJournal.COMPLETE_XWING_LEVEL_1);
                }
            } else {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO.STARWARS_COOKIE_HANDLER_NAME + "#") + UPDATE_MINIGAME_PROGRESS_COMMAND_NAME, [_local_2, level, completed, coins], "str", _shell.getCurrentServerRoomId());
            if (addCoinListener) {
                _airtower.addListener(UPDATE_MINIGAME_PROGRESS_COMMAND_NAME, miniGameProgressDelegate, this);
                _airtower.addListener(PARTY_COOKIE_RESPONSE_NAME, partyCookieReceivedDelegate, this);
            }
        }
        function handleUpdatePlayerCoins(data) {
            _airtower.removeListener(UPDATE_MINIGAME_PROGRESS_COMMAND_NAME, miniGameProgressDelegate);
            var _local_2 = data[1];
            _shell.setMyPlayerTotalCoins(_local_2);
        }
        function handleUpdatePartyCookie(data) {
            _airtower.removeListener(PARTY_COOKIE_RESPONSE_NAME, partyCookieReceivedDelegate);
            if (_engine.getActiveGameParams().currentLevel != undefined) {
                _interface.showContent(ICEJAM_GAME_UI);
            }
        }
        function sendJoinPlanet(planet) {
            var _local_2 = 0;
            switch (planet) {
                case TATOOINE_NAME : 
                    _local_2 = 1;
                    break;
                case DEATHSTAR_NAME : 
                    _local_2 = 2;
                    break;
                case YAVIN_NAME : 
                    _local_2 = 3;
                    break;
            }
            if (_local_2 <= 0) {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO.STARWARS_COOKIE_HANDLER_NAME + "#") + JOIN_PLANET_COMMAND_NAME, [_local_2], "str", _shell.getCurrentServerRoomId());
        }
        function playSound(ui, soundId) {
            var _local_1 = new Sound(ui);
            _local_1.attachSound(soundId);
            _local_1.start();
        }
        function waitForPlayerLoadComplete(param) {
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom, param);
            _engine.penguinTransformComplete.add(_joinRoomDelegate);
        }
        function handleJoinRoom(playerObj, param) {
            if (playerObj.player_id == _shell.getMyPlayerId()) {
                instance.checkForCharacterDialogue(param);
            }
            _engine.penguinTransformComplete.remove(_joinRoomDelegate);
            _joinRoomDelegate = null;
        }
        static var PARTY_COOKIE_ID = "20130724";
        static var PARTY_INTERFACE_PATH = "w.p2013.starwars.partyinterface";
        static var PARTY_CATALOGUE_PATH = "w.party.clothing.catalogue1";
        static var OOPS_PARTY_CATALOG = "oops_party1_catalog";
        static var OOPS_JEDI_EXPERIENCE = "oops_party2";
        static var OOPS_GAME_REWARDS = "oops_party3";
        static var JEDI_ATTACK_WIDGET_PATH = "w.p0713.starwars.jedi.attackWidget";
        static var PARTY_COOKIE_RESPONSE_NAME = "swpc";
        static var MAX_JEDI_POINTS = 700;
        static var JEDI_WINS_THRESHOLD = 25;
        static var PARTY_WEEK = 1;
        static var BATTLE_PRIZE_1_ID = 5336;
        static var BATTLE_PRIZE_2_ID = 1641;
        static var BATTLE_PRIZE_3_ID = 4892;
        static var BATTLE_PRIZE_4_ID = 3169;
        static var BATTLE_PRIZE_5_ID = 5335;
        static var BATTLE_PRIZE_6_ID = 4895;
        static var BATTLE_PRIZE_7_ID = 3170;
        static var DARTH_VADER_HELMET_ID = 1637;
        static var DARTH_VADER_COSTUME_ID = 4888;
        static var OBIWAN_CLOAK_ID = 3172;
        static var DARTH_VADER_LIGHT_SABER_ID = 5337;
        static var REBEL_PIN = 7158;
        static var REBEL_HELMET = 1643;
        static var REBEL_COSTUME = 4894;
        static var REBEL_BOOTS = 6179;
        static var DEATHSTAR_PLANS = 9205;
        static var STORMTROOPER_COSTUME = 4891;
        static var BLUE_LIGHT_SABER_ID = 5336;
        static var GREEN_LIGHT_SABER_ID = 5335;
        static var RED_LIGHT_SABER_ID = 5337;
        static var DIALOGUE_VIEWED_COMMAND_NAME = "swv";
        static var UPDATE_MINIGAME_PROGRESS_COMMAND_NAME = "swmgp";
        static var JOIN_PLANET_COMMAND_NAME = "swjp";
        static var TATOOINE_NAME = "Tatooine";
        static var CINEMATIC_FLV_NAME = "water_path_video_flv";
        static var CINEMATIC_PATH = "w.p2013.starwars.cinematic";
        static var CHARACTER_DIALOGUE_SOLOROOM = "w.p2013.starwars.dialogue_soloroom";
        static var CHARACTER_DIALOGUE_TATOOINE_WELCOME = "w.p2013.starwars.dialogue_tatooine_1";
        static var CHARACTER_DIALOGUE_TATOOINE_CONGRATULATIONS = "w.p2013.starwars.dialogue_tatooine_2";
        static var BLASTER_GAME_UI = "w.p2013.starwars.blastergameui";
        static var BLASTER_GAME = "shooter";
        static var BLASTER_GAME_ID = 0;
        static var TATOOINE_MAP_PATH = "w.p2013.starwars.tatooinemap";
        static var TATOOINE_ROOMS = ["party2", "party3", "party4", "party5", "party6", "party7"];
        static var DEATHSTAR_NAME = "DeathStar";
        static var WEEK_2_LAUNCH_DATE = 1375228800000;
        static var CHARACTER_DIALOGUE_DEATHSTAR_WELCOME = "w.p2013.starwars.dialogue_deathstar_1";
        static var CHARACTER_DIALOGUE_DEATHSTAR_CONGRATULATIONS = "w.p2013.starwars.dialogue_deathstar_2";
        static var ICEJAM_GAME_UI = "w.p2013.starwars.icejamui";
        static var ICEJAM_GAME = "icejam";
        static var ICEJAM_GAME_ID = 1;
        static var DEATHSTAR_MAP_PATH = "w.p2013.starwars.deathstarmap";
        static var DEATHSTAR_ROOMS = ["party8", "party9", "party10", "party11", "party12", "party13", "party14", "party15"];
        static var YAVIN_NAME = "Yavin";
        static var WEEK_3_LAUNCH_DATE = 1375833600000;
        static var CHARACTER_DIALOGUE_YAVIN_WELCOME = "w.p2013.starwars.dialogue_yavin_1";
        static var CHARACTER_DIALOGUE_YAVIN_CONGRATULATIONS = "w.p2013.starwars.dialogue_yavin_2";
        static var XWING_GAME_UI = "w.p2013.starwars.xwinggameui";
        static var XWING_GAME = "xwing";
        static var XWING_GAME_ID = 2;
        static var YAVIN_MAP_PATH = "w.p2013.starwars.yavinmap";
        static var YAVIN_ROOMS = ["party16", "party17"];
        static var MEDAL_ITEM_ID = 3171;
        var _falconAccessedThroughPartyInterface = false;
        var _spokeToSoloCadence = false;
        var _tatooineClicked = false;
    }
