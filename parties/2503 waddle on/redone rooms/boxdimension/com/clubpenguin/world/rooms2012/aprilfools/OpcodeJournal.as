//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = "-1";
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "aprilfools.party0412.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var BOX_HEAD_ITEM_EARNED = "FE604F2D-6F2C-B865-48C6-8CD7F84EC4CF";
        static var ENTER_BOX_DIMENSION = "99EFBB31-58F1-A4F4-EE8D-30BFA8FD2A8C";
        static var NON_MEMBER_ZANY_OOPS = "BEE5F5E0-4D5A-8910-0FA7-EEE7DAE2A50F ";
        static var MEMBER_ZANY_ENTER = "644F0107-3848-3035-47E1-94124EB302A3";
    }
