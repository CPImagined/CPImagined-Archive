//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            init(_global.getCurrentShell.getMyPlayerId());
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = "-1";
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "superhero.party0413.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournalSuperheroParty";
        static var COLLECT_ROBOT_HOODIE = "23B3C043-1C75-EE38-024D-F9FECC6BA23A";
        static var COLLECT_HERO_HOODIE = "AAFDBBE1-22B2-5401-D620-30A718889465";
        static var COLLECT_SUPER_HERO_HOODIE = "2154F4B5-E59E-718E-1E27-ECD4715642CF";
        static var OOPS_BUY_MARVEL_COSTUMES = "347E5A23-1384-856F-EB8C-E99EB1D4A128";
        static var OOPS_EQUIP_POWER_GLOVE = "547A5218-3F63-0D15-38C9-8B648FAAEAF6";
        static var OOPS_DEPLOY_ROBOT = "D9837C34-7226-C0B7-8F34-C9EC27A8E89D";
        static var EQUIP_CONSTRUCTION_GLOVES = "BAE7220A-6B00-9872-349C-BC8425B45207";
        static var CHOOSE_SIDE = "AC2039A6-1E17-3F59-4A01-95BFFBF91F7F";
        static var NON_MEMBER_ATTEMPTS_TO_ACCESS_CANNON = "";
    }
