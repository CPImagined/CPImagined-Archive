//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.puffleparty.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            trace(((CLASS_NAME + ": sendOpcode(") + opcode) + ")");
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            trace(((CLASS_NAME + ": init(") + playerID) + ")");
            if (playerID == undefined) {
                playerID = "-1";
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "puffle.party0312.k.api.dlsnetwork.com");
            trace("DLSManager loaded and initialized");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var MEMBER_OOPS_PUFFLE_PLAY_ZONE = "8CB173D9-7D08-DBCF-673E-CE3C89751C51";
        static var MEMBER_OOPS_NIGHT_CLUB = "D9917355-439E-724E-A36A-5BF13CA4B6EE";
        static var MEMBER_ENTER_PUFFLE_PLAY_ZONE = "4AA37F73-D0E3-6BEC-9FBD-77EAAAB43A08 ";
        static var PUFFLE_HANDLER_STAMP = "EBA68C07-4070-6E84-AEDE-1078D496D257";
        static var PUFFLE_PLAY_EQUIPMENT = "F4A563C7-F348-F7C0-331F-2FF51DDBBEE5";
    }
