//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.party.MusicParty
    {
        static var _shell, _airtower, _interface, _engine, _party, _questRewards, _interfaceOverrides;
        function MusicParty () {
        }
        static function init() {
            pebug("MUSIC PARTY - INIT");
            _isActive = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            interfaceOverrides.init();
            activateInterfaceOverrides();
        }
        static function configurePartySettings() {
            _questRewards = new Array();
            CONSTANTS.IGLOO_LIST_ITEM_ID = CONSTANTS.PARTY_SERVICE.partySettings.partyIglooItems[0];
            CONSTANTS.IGLOO_LIST_ITEMS = [new com.clubpenguin.party.items.IglooItem(CONSTANTS.IGLOO_LIST_ITEM_ID)];
            var _local_4 = CONSTANTS.PARTY_SERVICE.musicJamRewards;
            pebug("musicItemList " + _local_4.length);
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_2 = new com.clubpenguin.world.rooms2014.music.vo.MusicPartyRewardVO();
                var _local_1 = _local_4[_local_3];
                _local_2.unlockday = _local_1.unlockDay;
                _local_2.createMemberItemVO(_local_1.memberItemId, ((_local_1.memberItemId == CONSTANTS.PARTY_SERVICE.musicJamPuffleReward) ? "puffle" : "paper"), _shell.getInventoryObjectById(_local_1.memberItemId).cost);
                _local_2.createNonMemberItemVO(_local_1.nonmemberItemId, "paper", _shell.getInventoryObjectById(_local_1.nonmemberItemId).cost);
                _questRewards.push(_local_2);
                _local_3++;
            }
            pebug("_questRewards " + _questRewards);
        }
        static function get partyCookie() {
            return(com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO(com.clubpenguin.party.BaseParty.serverCookie));
        }
        static function get isActive() {
            return(_isActive);
        }
        static function get CONSTANTS() {
            return(com.clubpenguin.party.BaseParty.CONSTANTS);
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
            if (partyCookie.msgViewedArray[0] == 0) {
                _interface.showContent(CONSTANTS.LOGIN_PROMPT_PATH);
            }
        }
        static function showMemberContentOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_PUFFLES_MESSAGE);
        }
        static function showMemberItemOopsMessage() {
            _global.getCurrentInterface().showContent(CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        }
        static function get itemOnIglooList() {
            return(new com.clubpenguin.party.items.IglooItem(CONSTANTS.IGLOO_LIST_ITEM_ID, true, 1800, "Tour Bus Igloo"));
        }
        static function get interfaceOverrides() {
            if (_interfaceOverrides == null) {
                _interfaceOverrides = new com.clubpenguin.world.rooms2014.music.party.MusicParty_InterfaceOverrides();
            }
            return(_interfaceOverrides);
        }
        static function get partyIconVisible() {
            if (partyCookie.msgViewedArray[0] == 1) {
                return(true);
            }
            return(false);
        }
        static function getUnlockDayByArrayIndex(index) {
            return(_questRewards[index].unlockday);
        }
        static function getNonmemberPartyItemByUnlockDay(index) {
            var _local_1 = 0;
            while (_local_1 < _questRewards.length) {
                if (_questRewards[_local_1].unlockday == index) {
                    return(_questRewards[_local_1].nonMemberItemVO);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getMemberPartyItemByUnlockDay(index) {
            var _local_1 = 0;
            while (_local_1 < _questRewards.length) {
                pebug("index " + index);
                pebug("_questRewards[i].unlockday " + _questRewards[_local_1].unlockday);
                if (_questRewards[_local_1].unlockday == index) {
                    return(_questRewards[_local_1].memberItemVO);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getPerformerNameByID(index) {
            var _local_2 = CONSTANTS.PARTY_SERVICE.concertList;
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if (_local_2[_local_1].id == index) {
                    return(_local_2[_local_1].name);
                }
                _local_1++;
            }
            return(undefined);
        }
        static function getIsValidConcertId(id) {
            var _local_2 = CONSTANTS.PARTY_SERVICE.concertList;
            var _local_1 = 0;
            while (_local_1 < _local_2.length) {
                if (_local_2[_local_1].id == id) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function launchMusicGame() {
            pebug("MusicParty.launchMusicGame");
            var _local_1 = _shell.getLocalizedString("soundstudio_prompt");
            _interface.closePrompt();
            _interface.showPrompt("game", _local_1, undefined, com.clubpenguin.util.Delegate.create(_this, clickJoinGamePrompt));
            sendLaunchMusicGameBI();
        }
        static function clickJoinGamePrompt() {
            _shell.sendJoinRoom("soundroom", 312, 308);
        }
        static function activateInterfaceOverrides() {
            _interface.showMapIcon = com.clubpenguin.util.Delegate.create(_interface, interfaceOverrides.showMapIcon);
        }
        static function sendGetConcertCountdown() {
            _airtower.send(_airtower.PLAY_EXT, (com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO.MUSIC_COOKIE_HANDLER_NAME + "#") + CONSTANTS.GET_CONCERT_COUNTDOWN, [0], "str", _shell.getCurrentServerRoomId());
        }
        static function sendPartyMapOpenBI() {
        }
        static function sendAttendPerformanceBI(performerName) {
        }
        static function sendQuestUIGoThereBI() {
        }
        static function sendLaunchMusicGameBI() {
            var _local_1;
            var _local_2 = _shell.getRoomObject().room_id;
            switch (_local_2) {
                case CONSTANTS.CRUISE_STAGE_ROOM_ID : 
                    _local_1 = "cruise_stage";
                    break;
                case CONSTANTS.CRUISE_BUFFET_ROOM_ID : 
                    _local_1 = "cruise_buffet";
                    break;
            }
        }
        static var CLASS_NAME = "BaseParty";
        static var _this = com.clubpenguin.world.rooms2014.music.party.MusicParty;
        static var _isActive = false;
    }
