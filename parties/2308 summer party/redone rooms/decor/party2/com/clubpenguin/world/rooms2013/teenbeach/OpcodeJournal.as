//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            trace(((CLASS_NAME + ": sendOpcode(") + opcode) + ")");
            init(_global.getCurrentShell.getMyPlayerId());
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            trace(((CLASS_NAME + ": init(") + playerID) + ")");
            if (playerID == undefined) {
                playerID = "-1";
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "monster.party0513.k.api.dlsnetwork.com");
            trace("DLSManager loaded and initialized");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournalTeenBeachParty";
        static var FIRST_LOGIN = "????";
        static var COLLECT_DAY_ONE_ITEM = "????";
        static var COLLECT_DAY_SIX_ITEM = "????";
        static var FIRST_TIME_IN_SURF_ROOM = "????";
        static var PARTY_CATALOG_OOPS = "????";
        static var BACK_STAGE_OOPS = "????";
        static var COLLECT_MASCOT_BACKGROUND = "????";
    }
