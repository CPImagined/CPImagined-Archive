//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.aprilFools2011.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function sendOpcodeBoxDimensionEnterRoom() {
            sendOpcode(APRILFOOLS_BOXDIMENSION_ENTER_ROOM);
        }
        function sendOpcodeBoxDimensionCollectItem() {
            sendOpcode(APRILFOOLS_BOXDIMENSION_COLLECT_ITEM);
        }
        function sendOpcodeDesertEnterRoom() {
            sendOpcode(APRILFOOLS_DESERT_ENTER_ROOM);
        }
        function sendOpcodeDesertCollectItem() {
            sendOpcode(APRILFOOLS_DESERT_COLLECT_ITEM);
        }
        function sendOpcodeDesertAnimationScrubbing() {
            sendOpcode(APRILFOOLS_DESERT_ANIMATION_SCRUBBING);
        }
        function sendOpcodeEscherEnterRoom() {
            sendOpcode(APRILFOOLS_ESCHER_ENTER_ROOM);
        }
        function sendOpcodeEscherCollectItem() {
            sendOpcode(APRILFOOLS_ESCHER_COLLECT_ITEM);
        }
        function sendOpcodeSpaceEnterRoom() {
            sendOpcode(APRILFOOLS_SPACE_ENTER_ROOM);
        }
        function sendOpcodeSpaceCollectItem() {
            sendOpcode(APRILFOOLS_SPACE_COLLECT_ITEM);
        }
        function sendOpcodeSpaceDragDrop() {
            sendOpcode(APRILFOOLS_SPACE_DRAG_DROP);
        }
        function sendOpcodeIceCreamLandEnterRoom() {
            sendOpcode(APRILFOOLS_ICECREAMLAND_ENTER_ROOM);
        }
        function sendOpcodeIceCreamLandCollectItem() {
            sendOpcode(APRILFOOLS_ICECREAMLAND_COLLECT_ITEM);
        }
        function sendOpcodeIceCreamLandFoodFight() {
            sendOpcode(APRILFOOLS_ICECREAMLAND_FOOD_FIGHT);
        }
        function sendOpcodeCreamSodaLandEnterRoom() {
            sendOpcode(APRILFOOLS_CREAMSODALAND_ENTER_ROOM);
        }
        function sendOpcodeCreamSodaLandCollectItem() {
            sendOpcode(APRILFOOLS_CREAMSODALAND_COLLECT_ITEM);
        }
        function sendOpcodeCreamSodaLandTeleportation() {
            sendOpcode(APRILFOOLS_CREAMSODALAND_TELEPORTATION);
        }
        function sendOpcodeCreamSodaLandPartyPuzzle() {
            sendOpcode(APRILFOOLS_CREAMSODALAND_PARTY_PUZZLE);
        }
        function sendOpcodeSillyPlaceEnterRoom() {
            sendOpcode(APRILFOOLS_SILLYPLACE_ENTER_ROOM);
        }
        function sendOpcodeSillyPlaceCollectItem() {
            sendOpcode(APRILFOOLS_SILLYPLACE_COLLECT_ITEM);
        }
        function sendOpcodeSillPlaceTellJoke() {
            sendOpcode(APRILFOOLS_SILLYPLACE_TELL_JOKE);
        }
        function sendOpcodeSillyPlaceTeleportation() {
            sendOpcode(APRILFOOLS_SILLYPLACE_TELEPORTATION);
        }
        function sendOpcodeDoodleEnterRoom() {
            sendOpcode(APRILFOOLS_DOODLE_ENTER_ROOM);
        }
        function sendOpcodeDoodleCollectItem() {
            sendOpcode(APRILFOOLS_DOODLE_COLLECT_ITEM);
        }
        function sendOpcodeLostDimensionEnterRoom() {
            sendOpcode(APRILFOOLS_LOSTDIMENSION_ENTER_ROOM);
        }
        function sendOpcodeLostDimensionSpeech() {
            sendOpcode(APRILFOOLS_LOSTDIMENSION_SPEECH);
        }
        function sendOpcode(opcode) {
            if (opcode == APRILFOOLS_CREAMSODALAND_PARTY_PUZZLE) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("LEAERNERSCORE", opcode, dlsmCallback, "100", "0", "0");
            } else {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", opcode, dlsmCallback, "0", "0", "0");
            }
        }
        function init(playerID) {
            if (playerID == undefined) {
                playerID = -1;
            }
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "april.fools.k.api.dlsnetwork.com");
        }
        function dlsmCallback(stringArg) {
        }
        static var APRILFOOLS_BOXDIMENSION_ENTER_ROOM = "F5542ED5-AECD-6B47-2542-5219B95C768C";
        static var APRILFOOLS_BOXDIMENSION_COLLECT_ITEM = "32B516E4-0D3A-C523-DAD8-5257D19D08AA";
        static var APRILFOOLS_DESERT_ENTER_ROOM = "196674AD-EF0F-4C74-6EC9-DABD949984C8";
        static var APRILFOOLS_DESERT_COLLECT_ITEM = "F30BE957-9248-33BB-350F-DE12B8D10BD8";
        static var APRILFOOLS_DESERT_ANIMATION_SCRUBBING = "DA2AC779-FE81-1E0D-245D-22392B0714B3";
        static var APRILFOOLS_ESCHER_ENTER_ROOM = "04EC1EBD-13D9-E76F-5F0A-478FDD3B9B06";
        static var APRILFOOLS_ESCHER_COLLECT_ITEM = "23001765-9114-BD1A-0125-7FF5E7175CC3";
        static var APRILFOOLS_SPACE_ENTER_ROOM = "4E0F432E-537D-A81F-1FBE-EBFA7314003D";
        static var APRILFOOLS_SPACE_COLLECT_ITEM = "8A344C5C-1030-F24F-9276-D95562FE97E3";
        static var APRILFOOLS_SPACE_DRAG_DROP = "53142FD2-08DF-03DA-487F-9F66715C3B9C";
        static var APRILFOOLS_ICECREAMLAND_ENTER_ROOM = "CB96C1A1-8B63-7ED5-B98E-210C18975427";
        static var APRILFOOLS_ICECREAMLAND_COLLECT_ITEM = "2DA01D73-7DEE-2805-E14D-086657C2B8F4";
        static var APRILFOOLS_ICECREAMLAND_FOOD_FIGHT = "008320D5-48BF-6243-49E6-D1D03597977B";
        static var APRILFOOLS_CREAMSODALAND_ENTER_ROOM = "24ADD418-AA87-25E9-303B-D3ECF3B9F4D5";
        static var APRILFOOLS_CREAMSODALAND_COLLECT_ITEM = "E673729E-B6DF-6C60-29A4-9C143E50DB0F";
        static var APRILFOOLS_CREAMSODALAND_TELEPORTATION = "3384C648-59FC-5460-735D-26F9F49D099F";
        static var APRILFOOLS_CREAMSODALAND_PARTY_PUZZLE = "237D9FF2-DF08-B4E7-A77B-2077006BE565";
        static var APRILFOOLS_SILLYPLACE_ENTER_ROOM = "8C4F6395-220B-23C4-637B-A9585D582AB0";
        static var APRILFOOLS_SILLYPLACE_COLLECT_ITEM = "189B826B-6424-D66D-4895-D15E88F0D187";
        static var APRILFOOLS_SILLYPLACE_TELL_JOKE = "CB0A8DB9-1797-92AF-3993-B21B62DB6014";
        static var APRILFOOLS_SILLYPLACE_TELEPORTATION = "13E2E58C-809F-4EA4-612C-22C843DC5C82";
        static var APRILFOOLS_DOODLE_ENTER_ROOM = "3D7558DF-D355-FD18-55B0-65BA6E2A7C0E";
        static var APRILFOOLS_DOODLE_COLLECT_ITEM = "CEB372ED-E61F-5C6D-2C3A-CCAEEAF6FF79";
        static var APRILFOOLS_LOSTDIMENSION_ENTER_ROOM = "55419A76-329A-6E70-26FB-5FB7C05930ED";
        static var APRILFOOLS_LOSTDIMENSION_SPEECH = "4B788BC3-9796-EB4D-0B3F-ABDB66F15141";
    }
