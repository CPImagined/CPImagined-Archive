//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.StatusField
    {
        function StatusField (value) {
            bits = value;
        }
        function getBits() {
            return(bits);
        }
        function hasOpenedIglooViewer() {
            return(0 != (bits & OPENED_IGLOO_VIEWER));
        }
        function isActiveIglooAccessStateOpen() {
            return(0 != (bits & ACTIVE_IGLOO_LAYOUT_OPEN_FLAG));
        }
        function hasSeenPuffleTreasureInfographic() {
            return(0 != (bits & PUFFLE_TREASURE_INFOGRAPHIC));
        }
        function isPlayerOptedInDayZeroABTest() {
            return(0 != (bits & PLAYER_OPT_IN_AB_TEST_DAY_ZERO));
        }
        function hasSwappedPuffle() {
            return(0 != (bits & PLAYER_SWAP_PUFFLE));
        }
        function hasSeenBackyard() {
            return(0 != (bits & VISIT_BACKYARD_FIRST_TIME));
        }
        function hasSeenIglooFull() {
            return(0 != (bits & MORE_THAN_TEN_PUFFLES_BACKYARD_MESSAGE));
        }
        function hasWalkedPuffleFirstTime() {
            return(0 != (bits & HAS_WALKED_PUFFLE_FIRST_TIME));
        }
        function hasWalkedPuffleSecondTime() {
            return(0 != (bits & HAS_WALKED_PUFFLE_SECOND_TIME));
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + (", hasOpenedIglooViewer()=" + hasOpenedIglooViewer());
            _local_2 = _local_2 + (", isActiveIglooAccessStateOpen()=" + isActiveIglooAccessStateOpen());
            _local_2 = _local_2 + (", hasSeenPuffleTreasureInfographic()=" + hasSeenPuffleTreasureInfographic());
            _local_2 = _local_2 + (", isPlayerOptedInDayZeroABTest()=" + isPlayerOptedInDayZeroABTest());
            _local_2 = _local_2 + (", hasSwappedPuffle()=" + hasSwappedPuffle());
            _local_2 = _local_2 + (", hasSeenBackyard()=" + hasSeenBackyard());
            _local_2 = _local_2 + (", hasSeenIglooFull()=" + hasSeenIglooFull());
            _local_2 = _local_2 + (", hasWalkedPuffleFirstTime()=" + hasWalkedPuffleFirstTime());
            _local_2 = _local_2 + (", hasWalkedPuffleSecondTime()=" + hasWalkedPuffleSecondTime());
            return(_local_2);
        }
        static var OPENED_IGLOO_VIEWER = 1;
        static var ACTIVE_IGLOO_LAYOUT_OPEN_FLAG = 2;
        static var PUFFLE_TREASURE_INFOGRAPHIC = 512;
        static var PLAYER_OPT_IN_AB_TEST_DAY_ZERO = 1024;
        static var PLAYER_SWAP_PUFFLE = 2048;
        static var MORE_THAN_TEN_PUFFLES_BACKYARD_MESSAGE = 4096;
        static var VISIT_BACKYARD_FIRST_TIME = 8192;
        static var HAS_WALKED_PUFFLE_FIRST_TIME = 65536;
        static var HAS_WALKED_PUFFLE_SECOND_TIME = 131072;
        var bits = 0;
    }
