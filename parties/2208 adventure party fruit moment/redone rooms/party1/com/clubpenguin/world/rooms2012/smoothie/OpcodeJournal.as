//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "smoothie.party0812.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var NON_MEMBER_TEMPLE_OOPS = "32C3A93B-A213-1A5E-1910-F89D37027657";
        static var KAHUNA_BACKGROUND_EARNED = "8B68F968-0C19-2072-C7E8-0C3661AA42F3";
        static var KAHUNA_GRAPE_COSTUME_EARNED = "AC25965E-7847-616B-3923-0FC5BD7BEE58";
        static var COLLECT_ALL_3_FRUIT = "51E43B69-2F00-6A48-56B0-C5BD24154642";
        static var TEMPLE_REWARD_EARNED = "1F1BFEC1-4228-BE24-E5FF-77D6251D9421";
        static var BUY_FRUIT_COSTUME = "91472D4E4-C0DF-1C4B-63CC-562F5FD16758";
        static var PLAY_SMOOTHIE_SMASH = "FA433CAD-47D5-0D88-0CC0-50B0FE7DD44F";
    }
