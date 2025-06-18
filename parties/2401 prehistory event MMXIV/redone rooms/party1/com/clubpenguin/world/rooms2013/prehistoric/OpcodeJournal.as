//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.prehistoric.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "blackout.party1112.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var PLAYER_IN_PARTY_ROOM_FIRST_TIME = "11E11E8E-9640-2CA1-3A71-02CD21B0760D";
        static var PLAYER_DIGS_UP_FIRST_DINOSAUR_EGG = "50065E58-E40B-6F5D-1415-CED0141D733A";
        static var NON_MEMBER_ATTEMPTS_TO_BECOME_DINOSAUR = "E096041B-45CD-158E-CAAE-C132192831EB";
        static var MEMBER_BECOMES_DINOSAUR = "E2524250-B84E-97F7-D6A4-34A50C617F28";
        static var PLAYER_FEEDS_DINOSAUR_WITH_SNOWBALL = "51982C91-C3E4-0E89-B95A-C2BAAE782DB5";
    }
