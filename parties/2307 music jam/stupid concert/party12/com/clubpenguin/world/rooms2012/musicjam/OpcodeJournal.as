dynamic class com.clubpenguin.world.rooms2012.musicjam.OpcodeJournal
{
    var CLASS_NAME: String = "OpcodeJournal";
    static var COMPLETE_DAY_1_CHALLENGE: String = "52FB0095-345D-4DC5-A4B7-0972887C125D";
    static var DUBSTEP_PUFFLE_ACTIVATED: String = "30FFD6A0-9CC7-51C9-BF5A-BC595CA34AEA";
    static var COMPLETE_DAY_4_CHALLENGE: String = "CBEB76B8-B546-3A5A-7CE9-8B802BF23C01";
    static var MEMBER_ENTERS_BACKSTAGE: String = "7C0E1BA3-5027-CA67-9088-7130AC6D6576";
    static var NON_MEMBER_OOPS_BACKSTAGE: String = "1F75D0FD-4491-C75E-0DB2-D175BB0E64F0";
    static var DANCE_ON_1_STAGE: String = "79482004-87B5-2B22-5451-5780C1840BCF";
    static var ATTEND_CADENCE_CONCERT: String = "22983169-6DB9-2B5A-01C0-32CAB0576F60";
    static var ALL_BUTTONS_ACTIVATED: String = "10FE1780-2781-F971-7E95-0D82ED25FFF7";

    function OpcodeJournal()
    {
    }

    function sendOpcode(opcode)
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("SELECTED", opcode, this.dlsmCallback, "0", "0", "0");
    }

    function init(playerID)
    {
        if (playerID == undefined) 
        {
            playerID = "-1";
        }
        com.disney.dlearning.managers.DLSManager.init(String(playerID), "musicjam.party0712.k.api.dlsnetwork.com");
    }

    function dlsmCallback(stringArg)
    {
    }

}
