//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal
    {
        function RainbowPuffleOpCodeJournal () {
        }
        function sendOpcode(opcode) {
            init(_global.getCurrentShell().getMyPlayerId());
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = "-1";
            }
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "RainbowPuffleOpCodeJournal";
        static var PLAYER_ENTERS_HOTEL = "A206CDA7-1F0C-1F2B-72AE-A016E5550B4E";
        static var PLAYER_COMPLETES_TASK1 = "89C2960E-261B-F05A-652A-132A6193C76A";
        static var PLAYER_COMPLETES_TASK2 = "DBA467D9-CA60-0E8F-3DCE-164E6FFD289F";
        static var PLAYER_COMPLETES_TASK3 = "38CBFA54-839D-2802-5DFE-E34AC48040D8";
        static var PLAYER_COMPLETES_TASK4 = "9201E285-D8FE-FA3D-BEE1-956F5DC7D41E";
        static var PLAYER_COMPLETES_ALL_TASKS = "9BF5B840-E909-021E-C6D3-E848533C7564";
        static var PLAYER_USES_CANNON = "D66D2936-2708-367F-BADC-C15E1D4A63F1";
        static var PLAYER_ENTERS_CLOUD_FOREST = "D52F7EA6-38F7-4BA0-82BB-AA17D3B8BC68";
    }
