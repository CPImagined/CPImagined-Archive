//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "halloween.party1012.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var PLAYER_MEETS_GARY = "4C8F4B4D-643A-B65B-F6DA-6BBE3C3BFC30";
        static var PLAYER_CATCHES_GHOST = "A8EDF6B4-DF6E-3AC0-A9D0-6BA59BE4B104";
        static var MEMBER_BECOMES_GHOST = "2B264678-4B6A-AA6F-004D-74CF67EBD90E";
        static var PLAYER_ENTERS_MANSION = "F71C9D78-0C9A-E798-78D6-3E16C6AAAD90";
        static var PLAYER_ENTERS_LAB = "9B92CDA0-180B-1531-BBFF-3600E497A376";
        static var NON_MEMBER_ATTEMPTS_TO_BE_GHOST = "013F7EB1-0B32-955D-0D34-17E72866B3B4";
        static var MEMBER_COMPLETES_SCAVENGER_HUNT = "5E1575B9-D9D0-08FE-7077-65274A0D0C2E";
    }
