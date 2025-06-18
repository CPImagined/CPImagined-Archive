//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.superhero.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "superhero.party0612.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var MEMBER_ENTERS_THE_MEMBER_ROOM = "513F73C2-29A8-08F4-5169-82DD1D1EFF9C";
        static var NONMEMBER_TRIES_TO_ENTER_THE_MEMBER_ROOM = "A13F4759-BC60-65B1-9022-9B826C63394A";
        static var NONMEMBER_BUYS_THE_POLICE_OFFICER_UNIFORM = "353E95CC-1D66-9CDC-5D94-5F993518FFA9";
        static var MEMBER_PUTS_ON_A_MARVEL_COSTUME = "DCE52DE7-C10F-2AD4-B113-3C6BA7188D61";
        static var PLAYER_MEETS_AUNT_ARCTIC = "2993990A-12D5-9A13-1A91-5283E66916DD";
        static var MEMBER_SELECTS_TO_BECOME_A_SUPER_HERO = "26820169-1EE7-D6D7-AEB2-77F6C2BFCDE1";
        static var PLAYER_ENTERS_THE_CLUB_PENGUIN_TIMES_ROOM = "93E1A8DB-DF71-81B9-C407-998123582F14";
        static var MEMBER_DEFEATS_THE_DESTRUCTOBOT = "30D8A8BA-7D61-D3C2-315E-B931A693ABA9";
    }
