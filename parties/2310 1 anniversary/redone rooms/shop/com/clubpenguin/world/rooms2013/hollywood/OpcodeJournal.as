//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.hollywood.OpcodeJournal
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
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "hollywood.party0213.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var PLAYER_BECOMES_SUPERSTAR = "98E15B37-9A5F-88F8-3DC7-19EF951ADAA1";
        static var PLAYER_BECOMES_DIRECTOR = "697DC76F-6F79-0E4C-A99B-6229F55F13A4";
        static var PLAYER_WINS_AWARD = "5931A7C2-E47B-E26B-FD5E-02ED62C2F1C8";
        static var NONMEMBER_OOPS_SUPERSTAR = "735C7D05-082E-2969-E2B9-2EF6820B6412";
        static var PLAYER_ENTERS_STAGE_A = "D266B750-0A32-219E-AB10-F9019443DF49";
        static var PLAYER_ENTERS_STAGE_B = "017323CE-3FB2-80D3-24FE-B17D0202A607";
        static var PLAYER_ENTERS_STAGE_C = "41D7BB9C-DD22-9DDD-133B-C605E060B46E";
    }
