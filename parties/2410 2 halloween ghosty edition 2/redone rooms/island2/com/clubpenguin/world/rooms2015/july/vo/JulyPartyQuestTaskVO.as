//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.vo.JulyPartyQuestTaskVO
    {
        var memberItemIds, memberItemVOs, nonMemberItemId, nonMemberItemVO, emotion, questTaskIndex;
        function JulyPartyQuestTaskVO () {
            memberItemIds = new Array();
            memberItemVOs = new Array();
        }
        function setMemberItemId(itemId, itemType) {
            memberItemIds.push(itemId);
            var _local_3 = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, true, getPaperItemCost(itemId));
            memberItemVOs.push(_local_3);
        }
        function setNonMemberItemId(itemId, itemType) {
            nonMemberItemId = itemId;
            nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, false, getPaperItemCost(itemId));
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
        function get toString() {
            return((((((((((("\tJulyPartyQuestTaskVO:  questTaskIndex: " + questTaskIndex) + " ") + " emotion: ") + emotion) + " ") + " nonMemberItemId: ") + nonMemberItemId) + " ") + " memberItemIds: ") + memberItemIds) + " ");
        }
    }
