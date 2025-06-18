//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.september2.vo.September2QuestTaskVO
    {
        var nonMemberItemId, nonMemberItemVO, index;
        function September2QuestTaskVO () {
        }
        function setNonMemberItemId(itemId, itemType) {
            nonMemberItemId = itemId;
            nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, false, getPaperItemCost(itemId));
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
        function get toString() {
            return((((("\tPartyQuestTaskVO:  index: " + index) + " ") + " nonMemberItemId: ") + nonMemberItemId) + " ");
        }
    }
