//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "medieval.party0512.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var MEMBER_DRAGON_COSTUME = "4904E999-3DF4-C31C-E8EA-95B7C905D229";
        static var SCORN_DEFEATED = "ADED301F-D87C-AEA9-0033-CDFD3891C86A";
        static var MEMBER_UNLOCKS_SKY_KINGDOM = "FFC4CAF7-80B6-3AF1-9170-BC2463BA07CA";
        static var NONMEMBER_OOPS_SCORN_GATE = "0D081BDB-1CA6-FDFF-3DE9-0C67D8C1F511";
        static var NONMEMBER_KNIGHT_QUEST_1_COMPLETE = "7630EC1E-0517-EA28-6917-93C66A142150";
        static var MEMBER_START_QUEST = "2C369CDF-A089-1FDD-2D28-F76DABA9D722";
        static var MEET_GARY_STAMP = "B8C3C97C-9131-CE66-C5E2-ADACD4205536";
        static var TINY_PENGUIN_IN_DOCK = "EFC16E0A-84B8-1A2B-9071-5039495C482C";
    }
