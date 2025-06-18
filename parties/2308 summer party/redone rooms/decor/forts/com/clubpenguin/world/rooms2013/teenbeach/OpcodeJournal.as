//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            init(_global.getCurrentShell.getMyPlayerId());
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = "-1";
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "monster.party0513.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournalTeenBeachParty";
        static var FIRST_LOGIN = "3878872F-EDC1-7CFD-AE9F-A3F774B1F3AA";
        static var COLLECT_DAY_ONE_ITEM = "6AB31BEB-4AFC-1C8E-6A1E-DE5EB8C4AD23";
        static var COLLECT_DAY_SIX_ITEM = "C42CF2D7-9FED-69B3-38E6-94E909565299";
        static var FIRST_TIME_IN_SURF_ROOM = "6D12C82A-2385-D5F1-4723-897135D4881F";
        static var PARTY_CATALOG_OOPS = "563A84DF-69E5-3598-72AB-2ECA96856682";
        static var BACK_STAGE_OOPS = "D60C60D9-2DC2-F462-7485-09494DD1D05F";
        static var COLLECT_MASCOT_BACKGROUND = "64D06EF6-8F86-1D7B-3C14-0C8B1820E572";
    }
