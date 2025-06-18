//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcode(opcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = -1;
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "rockhopper.party0212.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var ROCKHOPPER_QUEST_ALL_SHIP_TRIGGERS = "A574D9F3-243A-0179-0D46-DA5E45830725";
        static var ROCKHOPPER_QUEST_LAST_ROCKHOPPER_MESSAGE = "500C04A0-A44D-1E3A-7279-3C0FD31FC29C";
        static var ROCKHOPPER_QUEST_DINOSAUR_ISLAND = "F94B5D9F-FAFD-1CC2-2216-F59770973B41";
        static var ROCKHOPPER_QUEST_SHIPWRECK_ISLAND = "12074833-383F-6FE7-B8E5-70DABDD5969B";
        static var ROCKHOPPER_QUEST_BUILD_BEACON = "EEDA8823-50DD-210D-E9F6-830E13408B05";
        static var ROCKHOPPER_QUEST_VIKING_LORDS_ROOM_NONMEMBER = "4B92C14F-6505-A3C9-5FF0-A1592A3D45D5 ";
        static var ROCKHOPPER_QUEST_VIKING_LORDS_ROOM = "E25D878F-411F-D212-F6B5-1932E22484DE";
        static var ROCKHOPPER_QUEST_DINOSAUR_COSTUMES = "6B02ECF8-F31F-4561-78EE-AD5B4DA2320C";
        static var ROCKHOPPER_QUEST_VIKING_COSTUME = "52461F6C-5620-477C-DDDC-D0FF2A48331C";
    }
