//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcodeSwampOrganSuccessLevel1() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL1);
        }
        function sendOpcodeSwampOrganSuccessLevel2() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL2);
        }
        function sendOpcodeSwampOrganSuccessLevel3() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL3);
        }
        function sendOpcodeSwampOrganFailLevel1() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_FAIL_LEVEL1);
        }
        function sendOpcodeSwampOrganFailLevel2() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_FAIL_LEVEL2);
        }
        function sendOpcodeSwampOrganFailLevel3() {
            sendOpcode(HALLOWEEN_SWAMPORGAN_FAIL_LEVEL3);
        }
        function sendOpcodeDarkChamberItemPickup() {
            sendOpcode(HALLOWEEN_DARKCHAMBER_ITEM_PICKUP);
        }
        function sendOpcodeCJMatchSuccess() {
            sendOpcode(CJ_PARTY_STADIUM_SUCCESS);
        }
        function sendOpcodeCJMatchFail() {
            sendOpcode(CJ_PARTY_STADIUM_FAIL);
        }
        function sendOpcodeTrainingFireItem() {
            sendOpcode(CJ_PARTY_ATTAIN_FIRE_REWARD);
        }
        function sendOpcodeTrainingWaterItem() {
            sendOpcode(CJ_PARTY_ATTAIN_WATER_REWARD);
        }
        function sendOpcodeHolidayForestTakesItem() {
            sendOpcode(HOLIDAY_FOREST_TAKES_ITEM);
        }
        function sendOpcodeHolidayWorkshopBakeryOops() {
            sendOpcode(HOLIDAY_WORKSHOP_BAKERY_OOPS);
        }
        function sendOpcodeHolidaySleighDeliveryComplete() {
            sendOpcode(HOLIDAY_SLEIGH_DELIVERY_COMPLETE);
        }
        function sendOpcodeHolidayBakeryBakeIgloo() {
            sendOpcode(HOLIDAY_BAKERY_BAKE_IGLOO);
        }
        function sendOpcodeAtlantisLightup() {
            sendOpcode(ATLANTIS_FINAL_ROOM_CRYSTAL_LIGHTUP);
        }
        function sendOpcodeAtlantisDockCleanup() {
            sendOpcode(ATLANTIS_DOCK_CLEANUP);
        }
        function sendOpcodeAtlantisMemberExperienceDenial() {
            sendOpcode(ATLANTIS_BEACH_MEMBER_EXPERIENCE_DENIAL);
        }
        function sendOpcode(opcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID, domainStr) {
            if (playerID == undefined) {
                playerID = -1;
            }
            if (domainStr) {
                com.disney.dlearning.managers.DLSManager.init(String(playerID), domainStr);
            } else {
                com.disney.dlearning.managers.DLSManager.init(String(playerID), "atlantis.party012012.k.api.dlsnetwork.com");
            }
        }
        function dlsmCallback(stringArg) {
        }
        var CLASS_NAME = "OpcodeJournal";
        static var HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL1 = "C65397BA-D4AD-5B76-16F1-B37251FECCFC";
        static var HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL2 = "F3EDE04F-FD71-8D01-BB67-44C2D9EA14A2";
        static var HALLOWEEN_SWAMPORGAN_SUCCESS_LEVEL3 = "F19463E7-AB84-74A7-25B3-B7FE53AACC1E";
        static var HALLOWEEN_SWAMPORGAN_FAIL_LEVEL1 = "643FA0C6-155B-E1FF-D28B-3319A9A3A5FB";
        static var HALLOWEEN_SWAMPORGAN_FAIL_LEVEL2 = "A2E7EE1C-51B0-FB90-D0C2-050439AC6752";
        static var HALLOWEEN_SWAMPORGAN_FAIL_LEVEL3 = "57454D75-B0A4-5249-696F-1B2F8E72A924";
        static var HALLOWEEN_DARKCHAMBER_ITEM_PICKUP = "DD6AEBD5-26FC-C055-7BFB-6437EAB61436";
        static var CJ_PARTY_STADIUM_SUCCESS = "B9205ACE-66FC-AFFA-0356-C24A788EE0D6";
        static var CJ_PARTY_STADIUM_FAIL = "8DF8B574-AD8B-3524-9705-9EA841A6861C";
        static var CJ_PARTY_ATTAIN_FIRE_REWARD = "D41D083A-00D3-9C07-19AB-4B2145FB78A0";
        static var CJ_PARTY_ATTAIN_WATER_REWARD = "D43134B3-DF46-4A62-54C7-EA357E58ABBA";
        static var HOLIDAY_FOREST_TAKES_ITEM = "9507192A-70DE-DC1D-CFA7-B6A5454602B7";
        static var HOLIDAY_WORKSHOP_BAKERY_OOPS = "D083D303-1A19-40E2-BFEA-E556264C2917";
        static var HOLIDAY_SLEIGH_DELIVERY_COMPLETE = "E7CBFF25-244F-EF6E-536D-4478904E8653";
        static var HOLIDAY_BAKERY_BAKE_IGLOO = "6940E653-1411-0A46-AA86-8A6A357BDAF4";
        static var ATLANTIS_FINAL_ROOM_CRYSTAL_LIGHTUP = "E6C926DA-9D2A-0009-BBB9-723EAAEE97F5";
        static var ATLANTIS_DOCK_CLEANUP = "D316BE47-0860-3894-D8A0-BB15AFECD406";
        static var ATLANTIS_BEACH_MEMBER_EXPERIENCE_DENIAL = "88719EF4-BB45-D7B5-CA8E-6ED872335318";
        static var ROCKHOPPER_QUEST_ALL_SHIP_TRIGGERS = "A574D9F3-243A-0179-0D46-DA5E45830725";
        static var ROCKHOPPER_QUEST_LAST_ROCKHOPPER_MESSAGE = "500C04A0-A44D-1E3A-7279-3C0FD31FC29C";
        static var ROCKHOPPER_QUEST_BUILD_BEACON = "EEDA8823-50DD-210D-E9F6-830E13408B05";
        static var ROCKHOPPER_QUEST_DINOSAUR_ISLAND = "F94B5D9F-FAFD-1CC2-2216-F59770973B41";
        static var ROCKHOPPER_QUEST_SHIPWRECK_ISLAND = "12074833-383F-6FE7-B8E5-70DABDD5969B";
        static var ROCKHOPPER_QUEST_VIKING_LORDS_ROOM_NONMEMBER = "4B92C14F-6505-A3C9-5FF0-A1592A3D45D5 ";
        static var ROCKHOPPER_QUEST_VIKING_LORDS_ROOM = "E25D878F-411F-D212-F6B5-1932E22484DE";
        static var ROCKHOPPER_QUEST_DINOSAUR_COSTUMES = "6B02ECF8-F31F-4561-78EE-AD5B4DA2320C";
        static var ROCKHOPPER_QUEST_VIKING_COSTUME = "52461F6C-5620-477C-DDDC-D0FF2A48331C";
    }
