//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "starwars.party0513.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournalStarWarsParty";
        static var COMPLETE_BLASTER_LEVEL_1 = "61713F34-A510-957B-599E-35F13603D18B";
        static var COLLECT_DEATH_STAR_PLANS = "6FED2B13-A96E-5241-6A7A-5DB3B5C20061";
        static var COMPLETE_XWING_LEVEL_1 = "BCC13CDB-EE5C-CAD2-7440-55DEC38C1CA6";
        static var OOPS_JEDI_EXPERIENCE = "F4A979C0-0126-F818-5E18-6F936938E5DE";
        static var OOPS_PARTY_ITEMS = "0353E2D2-F307-757C-2DF6-49D7AF0ABB7D";
        static var COLLECT_LIGHT_SABER = "5F852EAD-8624-A8D5-92EA-9DC9B7C00ADD";
        static var WIN_25_JEDI_BATTLES = "BFAD334B-259D-D2DE-267E-EF0BFBA021C0";
        static var COLLECT_REWARD_MEDAL = "10F6DE21-D552-562A-B499-7917D5EF2F0F";
    }
