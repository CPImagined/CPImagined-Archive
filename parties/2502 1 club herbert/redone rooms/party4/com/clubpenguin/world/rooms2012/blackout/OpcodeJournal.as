//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.OpcodeJournal
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
        static var PLAYER_MEETS_HERBERT = "8A0132BE-5472-280C-6AEC-6672783CE9EC";
        static var PLAYER_ACCEPT_FIRST_MISSION = "402C665A-0C04-AB34-9AF1-C095F7EEBFEF";
        static var NON_MEMBER_OOPS_HERBERT_COSTUME = "E023602C-21B9-BBA7-9A50-FFCBE8E6290B";
        static var PLAYER_COMPLETES_NEW_EPF_TEST = "D543290D-F319-A5DE-8FC5-07062D1DF76C";
        static var PLAYER_COMPLETES_SIXTH_MISSION = "06933CAB-9420-6338-137B-586EF918D618";
        static var PLAYER_ENTERS_BEACH = "06933CAB-9420-6338-137B-586EF918D618";
    }
