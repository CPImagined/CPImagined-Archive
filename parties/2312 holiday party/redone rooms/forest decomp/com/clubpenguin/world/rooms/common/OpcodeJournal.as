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
        function sendOpcode(opcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = -1;
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "halloween2011.k.api.dlsnetwork.com");
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
    }
