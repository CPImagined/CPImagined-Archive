//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.prehistoric.Prehistoric
    {
        static var _dinoHitCheck, _roarScavengerHunt;
        function Prehistoric () {
        }
        static function init() {
            _opcodeJournal = new com.clubpenguin.world.rooms2013.prehistoric.OpcodeJournal();
            var _local_2 = _global.getCurrentShell();
            _opcodeJournal.init(_local_2.getMyPlayerId());
            _dinoHitCheck = new com.clubpenguin.world.rooms2013.prehistoric.snowball.DinoHitCheck(_opcodeJournal);
            _local_2.addListener(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, com.clubpenguin.util.Delegate.create(_dinoHitCheck, _dinoHitCheck.hitCheck));
            _roarScavengerHunt = new com.clubpenguin.world.rooms2013.prehistoric.scavengerhunt.RoarScavengerHunt();
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function checkDestructableIsHit(snowballInfo, destructableList) {
            var _local_6 = _global.getCurrentShell();
            var _local_7;
            _local_7 = 3;
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < destructableList.length) {
                if (destructableList[_local_2].hitTest(snowballInfo.x, snowballInfo.y, true)) {
                    _local_5 = destructableList[_local_2];
                    break;
                }
                _local_2++;
            }
            if (_local_5) {
                snowballInfo.snowballMC._visible = false;
                _local_5.effect.gotoAndStop(_local_7);
            }
        }
        static function isPlayerDinosaur(avatarId) {
            var _local_1 = 0;
            while (_local_1 < DINO_AVATARS.length) {
                if (avatarId == DINO_AVATARS[_local_1][0]) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function isPlayerCaveman(avatarId) {
            return(avatarId == CAVEMAN_AVATAR_ID);
        }
        static function canPlayerStomp(avatarId) {
            var _local_1 = 0;
            while (_local_1 < DINO_AVATARS.length) {
                if ((avatarId == DINO_AVATARS[_local_1][0]) && (DINO_AVATARS[_local_1][1])) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getMovieClipGroup(containerMC, groupName) {
            var _local_2 = [];
            for (var _local_3 in containerMC) {
                if (typeof(containerMC[_local_3]) == "movieclip") {
                    if (containerMC[_local_3]._name.indexOf(groupName) > -1) {
                        _local_2.push(containerMC[_local_3]);
                    }
                }
            }
            return(_local_2);
        }
        static function getRoarScavengerHunt() {
            return(_roarScavengerHunt);
        }
        static var DANCE_FRAME = 26;
        static var EAT_FRAME = 31;
        static var PARTY_COOKIE_ID = "20130101";
        static var TREX_GREEN_EGG = 100;
        static var TREX_GREEN_AVATAR_ID = 13;
        static var TREX_BLUE_EGG = 102;
        static var TREX_BLUE_AVATAR_ID = 14;
        static var TREX_RED_EGG = 104;
        static var TREX_RED_AVATAR_ID = 15;
        static var RARE_TREX_BLACK_EGG = 106;
        static var RARE_TREX_BLACK_AVATAR_ID = 16;
        static var TRICERETOPS_ORANGE_EGG = 200;
        static var TRICERETOPS_ORANGE_AVATAR_ID = 17;
        static var TRICERETOPS_BLUE_EGG = 202;
        static var TRICERETOPS_BLUE_AVATAR_ID = 18;
        static var TRICERETOPS_PURPLE_EGG = 204;
        static var TRICERETOPS_PURPLE_AVATAR_ID = 19;
        static var RARE_TRICERETOPS_RED_EGG = 206;
        static var RARE_TRICERETOPS_RED_AVATAR_ID = 20;
        static var BIRD_GREEN_EGG = 300;
        static var BIRD_GREEN_AVATAR_ID = 21;
        static var BIRD_BLUE_EGG = 302;
        static var BIRD_BLUE_AVATAR_ID = 22;
        static var BIRD_RED_EGG = 304;
        static var BIRD_RED_AVATAR_ID = 23;
        static var RARE_BIRD_BLACK_EGG = 306;
        static var RARE_BIRD_BLACK_AVATAR_ID = 24;
        static var CAVEMAN_AVATAR_ID = 25;
        static var DINOSAUR_HOODIE_ITEM_ID = 4779;
        static var NONMEMBER_OOPS_TRANSFORM = "oops_dinosaur_transform";
        static var COLLECT_EGGS_UI = "w.p2013.prehistoric.questui";
        static var GO_THERE_POSTER = "party_poster";
        static var PARTY_MAP = "w.party.map";
        static var DINO_HUNT_GAME = "dinodig";
        static var ROAR_PRIZE_2_DATE = 1358578800000;
        static var ROAR_PRIZE_3_DATE = 1358751600000;
        static var ROAR_PRIZE_4_DATE = 1358924400000;
        static var ROAR_PRIZE_5_DATE = 1359183600000;
        static var ROAR_PRIZE_1_ID = 950;
        static var ROAR_PRIZE_2_ID = 952;
        static var ROAR_PRIZE_3_ID = 951;
        static var ROAR_PRIZE_4_ID = 953;
        static var ROAR_PRIZE_5_ID = 5;
        static var PREHISTORIC_ROOMS = ["party2", "party3", "party4", "party5", "party6", "party7", "party8", "party9", "party10", "party11", "party12"];
        static var CAN_STOMP = true;
        static var CANNOT_STOMP = false;
        static var DINO_AVATARS = [[TREX_GREEN_AVATAR_ID, CAN_STOMP], [TREX_BLUE_AVATAR_ID, CAN_STOMP], [TREX_RED_AVATAR_ID, CAN_STOMP], [RARE_TREX_BLACK_AVATAR_ID, CAN_STOMP], [TRICERETOPS_ORANGE_AVATAR_ID, CAN_STOMP], [TRICERETOPS_BLUE_AVATAR_ID, CAN_STOMP], [TRICERETOPS_PURPLE_AVATAR_ID, CAN_STOMP], [RARE_TRICERETOPS_RED_AVATAR_ID, CAN_STOMP], [BIRD_GREEN_AVATAR_ID, CANNOT_STOMP], [BIRD_BLUE_AVATAR_ID, CANNOT_STOMP], [BIRD_RED_AVATAR_ID, CANNOT_STOMP], [RARE_BIRD_BLACK_AVATAR_ID, CANNOT_STOMP]];
        static var SHAKEABLE_GROUP_NAME = "shake";
        static var STOMPABLE_GROUP_NAME = "stomp";
        static var ROAR_TIME = 4000;
        static var _opcodeJournal = null;
    }
