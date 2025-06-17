//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.Blackout
    {
        function Blackout () {
        }
        static function getRoomState() {
            var _local_2 = _global.getCurrentShell();
            if (isChallengeUnlocked(CHALLENGE_6) && (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID))) {
                return(4);
            }
            if (isChallengeUnlocked(CHALLENGE_5)) {
                return(3);
            }
            if (isChallengeUnlocked(CHALLENGE_3)) {
                return(2);
            }
            return(1);
        }
        static function playerHasCompletedChallege(challengeID) {
            var _local_2 = _global.getCurrentShell();
            switch (challengeID) {
                case CHALLENGE_1 : 
                    return(((((_local_2.isItemInMyInventory(CHALLENGE_1_PIN_ID) || (_local_2.isItemInMyInventory(CHALLENGE_2_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_3_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_4_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID)));
                    return(false);
                case CHALLENGE_2 : 
                    return((((_local_2.isItemInMyInventory(CHALLENGE_2_PIN_ID) || (_local_2.isItemInMyInventory(CHALLENGE_3_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_4_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID)));
                    return(false);
                case CHALLENGE_3 : 
                    return(((_local_2.isItemInMyInventory(CHALLENGE_3_PIN_ID) || (_local_2.isItemInMyInventory(CHALLENGE_4_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID)));
                    return(false);
                case CHALLENGE_4 : 
                    return((_local_2.isItemInMyInventory(CHALLENGE_4_PIN_ID) || (_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID))) || (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID)));
                    return(false);
                case CHALLENGE_5 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID) || (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID)));
                    return(false);
                case CHALLENGE_6 : 
                case ALL_CHALLENGES_COMPLETE : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID));
                    return(false);
            }
            return(false);
        }
        static function isChallengeUnlocked(challengeID) {
            var _local_2 = _global.getCurrentShell();
            if (!_local_2.server_time.getTime()) {
                return(false);
            }
            switch (challengeID) {
                case CHALLENGE_1 : 
                    return(true);
                    return(false);
                case CHALLENGE_2 : 
                    return(_local_2.server_time.getTime() >= PHASE_2_AVAILABILITY_DATE);
                    return(false);
                case CHALLENGE_3 : 
                    return(_local_2.server_time.getTime() >= PHASE_3_AVAILABILITY_DATE);
                    return(false);
                case CHALLENGE_4 : 
                    return(_local_2.server_time.getTime() >= PHASE_4_AVAILABILITY_DATE);
                    return(false);
                case CHALLENGE_5 : 
                    return(_local_2.server_time.getTime() >= PHASE_5_AVAILABILITY_DATE);
                    return(false);
                case CHALLENGE_6 : 
                    return(_local_2.server_time.getTime() >= PHASE_6_AVAILABILITY_DATE);
                    return(false);
            }
            return(false);
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function getSnowballHitCheck() {
            return(new com.clubpenguin.world.rooms2012.blackout.SnowballHitCheck());
        }
        static function isSpecialThrowRoom(currentRoomID) {
            return(((((((((((((((((((((currentRoomID == 100) || (currentRoomID == 200)) || (currentRoomID == 230)) || (currentRoomID == 300)) || (currentRoomID == 321)) || (currentRoomID == 400)) || (currentRoomID == 411)) || (currentRoomID == 800)) || (currentRoomID == 801)) || (currentRoomID == 802)) || (currentRoomID == 805)) || (currentRoomID == 807)) || (currentRoomID == 809)) || (currentRoomID == 810)) || (currentRoomID == 851)) || (currentRoomID == 852)) || (currentRoomID == 853)) || (currentRoomID == 854)) || (currentRoomID == 855)) || (currentRoomID == 856)) || (currentRoomID == 857));
        }
        static function challengeCompleted(newPinID, oldPinID, challengeID) {
            if ((challengeID != null) && (!playerHasCompletedChallege(challengeID))) {
                _global.getCurrentShell().sendBuyInventory(newPinID);
                if (oldPinID) {
                    _global.getCurrentShell().removeItemFromInventory(oldPinID);
                }
                _justCompletedChallenges.push(challengeID);
                if (challengeID == CHALLENGE_6) {
                    var _local_4 = {source:_global.getCurrentShell().getPath("w.p1112.blackout.cutscene"), autoPlay:true};
                    var _local_3 = _global.getCurrentInterface();
                    _local_3.showContent("videoPlayer", null, undefined, _local_4, true);
                }
            }
        }
        static function getJustCompletedChallenges() {
            return(_justCompletedChallenges);
        }
        static function isChallengeJustCompleted(challengeID) {
            var _local_1 = 0;
            while (_local_1 < _justCompletedChallenges.length) {
                if (_justCompletedChallenges[_local_1] == challengeID) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function clearJustCompletedChallenges() {
            _justCompletedChallenges = [];
        }
        static var PHASE_1_AVAILABILITY_DATE = 1352880000000;
        static var PHASE_2_AVAILABILITY_DATE = 1353052800000;
        static var PHASE_3_AVAILABILITY_DATE = 1353225600000;
        static var PHASE_4_AVAILABILITY_DATE = 1353398400000;
        static var PHASE_5_AVAILABILITY_DATE = 1353571200000;
        static var PHASE_6_AVAILABILITY_DATE = 1353744000000;
        static var CRAB_COSTUME_ID = 4745;
        static var HERBERT_COSTUME_ID = 4744;
        static var GRAPPLING_HOOK_ITEM_ID = 5185;
        static var PLASMA_LASER_ITEM_ID = 3138;
        static var LASER_DEFLECTOR_ITEM_ID = 4746;
        static var SMOKE_GOGGLES_ITEM_ID = 2097;
        static var LAVA_SHOES_ITEM_ID = 6139;
        static var CAPTURE_COSTUME_ID = 4749;
        static var CHALLENGE_1_PIN_ID = 7132;
        static var CHALLENGE_2_PIN_ID = 7133;
        static var CHALLENGE_3_PIN_ID = 7134;
        static var CHALLENGE_4_PIN_ID = 7135;
        static var CHALLENGE_5_PIN_ID = 7136;
        static var CHALLENGE_6_PIN_ID = 7137;
        static var HEAVY_WEIGHTS_PIN_ID = 7129;
        static var CHALLENGE_1 = 1;
        static var CHALLENGE_2 = 2;
        static var CHALLENGE_3 = 3;
        static var CHALLENGE_4 = 4;
        static var CHALLENGE_5 = 5;
        static var CHALLENGE_6 = 6;
        static var ALL_CHALLENGES_COMPLETE = 6;
        static var PARTY_CATALOGUE = "party_catalogue";
        static var PARTY_ANNOUNCEMENT = "w.party.announcement";
        static var QUEST_UI = "w.p1112.blackout.blackoutquestinterface";
        static var HACKING_MINIGAME = "icejam";
        static var END_CUTSCENE = "w.p1112.blackout.cutscene";
        static var OOPS_HERBERT_COSTUME = "oops_party1_catalog";
        static var SNOWBALL_TYPE_REGULAR = 0;
        static var SNOWBALL_TYPE_LARGE = 1;
        static var SNOWBALL_TYPE_NET = 2;
        static var SNOWBALL_STATE_THROW = "throw";
        static var SNOWBALL_STATE_HIT = "hit";
        static var SNOWBALL_STATE_MISS = "miss";
        static var SNOWBALL_STATE_BOUNCE = "bounce";
        static var snowballTypes = ["ball", "ball_large", "ball_net"];
        static var _justCompletedChallenges = [];
    }
