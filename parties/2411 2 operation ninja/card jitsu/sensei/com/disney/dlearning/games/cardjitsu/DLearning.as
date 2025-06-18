//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.games.cardjitsu.DLearning
    {
        static var gameMode;
        function DLearning (learnerId) {
            com.disney.dlearning.managers.DLSManager.init(learnerId, "cj.k.api.dlsnetwork.com");
            gameMode = EARN_YOUR_BELTS_MODE;
        }
        function playerWonRound() {
            wonRounds++;
        }
        function playerLostRound() {
            lostRounds++;
        }
        function setMode(gMode) {
            gameMode = gMode;
        }
        function startGame() {
            if (gameMode == EARN_YOUR_BELTS_MODE) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("Start", com.disney.dlearning.games.cardjitsu.OpcodeJournal.EARN_YOUR_BELTS, callBackFunc, "0", "0", "0");
            } else {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("Start", com.disney.dlearning.games.cardjitsu.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, "0", "0", "0");
            }
        }
        function readInstructions() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("Selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.INSTRUCTIONS, callBackFunc, "0", "0", "0");
        }
        function sendScore() {
            var _local_2 = (wonRounds / (wonRounds + lostRounds)) * 100;
            if (gameMode == EARN_YOUR_BELTS_MODE) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("learnerscore", com.disney.dlearning.games.cardjitsu.OpcodeJournal.EARN_YOUR_BELTS, callBackFunc, _local_2.toString(), "0", "0");
            } else {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("learnerscore", com.disney.dlearning.games.cardjitsu.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, _local_2.toString(), "0", "0");
            }
        }
        function quitGame() {
            if (gameMode == EARN_YOUR_BELTS_MODE) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("stop", com.disney.dlearning.games.cardjitsu.OpcodeJournal.EARN_YOUR_BELTS, callBackFunc, "0", "0", "0");
            } else {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("stop", com.disney.dlearning.games.cardjitsu.OpcodeJournal.CHALLENGE_SENSEI, callBackFunc, "0", "0", "0");
            }
        }
        function earnedBelt(beltId) {
            switch (beltId) {
                case 1 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.WHITE_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 2 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.YELLOW_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 3 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.ORANGE_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 4 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.GREEN_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 5 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.BLUE_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 6 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.RED_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 7 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.PURPLE_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 8 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.BROWN_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
                case 9 : 
                    com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", com.disney.dlearning.games.cardjitsu.OpcodeJournal.BLACK_BELT_EARNED, callBackFunc, "0", "0", "0");
                    break;
            }
        }
        function callBackFunc(retString) {
            trace("DLSCallback : " + retString);
        }
        static var EARN_YOUR_BELTS_MODE = 2;
        static var SENSEI_MODE = 3;
        var wonRounds = 0;
        var lostRounds = 0;
    }
