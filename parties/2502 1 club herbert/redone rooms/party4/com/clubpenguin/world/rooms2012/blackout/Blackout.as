//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.Blackout
    {
        function Blackout () {
        }
        static function getRoomState() {
			return;
            var _local_2 = _global.getCurrentShell();
            if (isChallengeUnlocked(CHALLENGE_6) && (_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID))) {
                return(4);
            }
            return(1);
        }
        static function playerHasCompletedChallege(challengeID) {
            var _local_2 = _global.getCurrentShell();
            switch (challengeID) {
                case CHALLENGE_1 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_1_PIN_ID));
                    return(false);
                case CHALLENGE_2 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_2_PIN_ID));
                    return(false);
                case CHALLENGE_3 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_3_PIN_ID));
                    return(false);
                case CHALLENGE_4 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_4_PIN_ID));
                    return(false);
                case CHALLENGE_5 : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_5_PIN_ID));
                    return(false);
                case CHALLENGE_6 : 
                case ALL_CHALLENGES_COMPLETE : 
                    return(_local_2.isItemInMyInventory(CHALLENGE_6_PIN_ID));
                    return(false);
            }
            return(false);
        }
        static function isChallengeUnlocked(challengeID) {
			for (var i = 1; i < challengeID; i++) {
            	if (!playerHasCompletedChallege(i)) {
					return (false);
				};
			};
			return (true);
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function challengeCompleted(newPinID, oldPinID, challengeID) {
            if ((challengeID != null) && (!playerHasCompletedChallege(challengeID))) {
                _global.getCurrentShell().sendBuyInventory(newPinID);
                _justCompletedChallenges.push(challengeID);
                if (challengeID == CHALLENGE_6) {
                    var _local_3 = _global.getCurrentInterface();
                    _local_3.showContent("videoPlayer", null, undefined, {source:_global.getCurrentShell().getPath("end"), autoPlay:true}, true);
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
        static var CHALLENGE_1_PIN_ID = 7132;
        static var CHALLENGE_2_PIN_ID = 7133;
        static var CHALLENGE_3_PIN_ID = 7134;
        static var CHALLENGE_4_PIN_ID = 7135;
        static var CHALLENGE_5_PIN_ID = 7136;
        static var CHALLENGE_6_PIN_ID = 7137;
        static var CHALLENGE_1 = 1;
        static var CHALLENGE_2 = 2;
        static var CHALLENGE_3 = 3;
        static var CHALLENGE_4 = 4;
        static var CHALLENGE_5 = 5;
        static var CHALLENGE_6 = 6;
		static var ALL_CHALLENGES_COMPLETE = 6;
        static var HACKING_MINIGAME = "icejam";
        static var END_CUTSCENE = "w.app.p2025.doom.end";
        static var _justCompletedChallenges = [];
    }
