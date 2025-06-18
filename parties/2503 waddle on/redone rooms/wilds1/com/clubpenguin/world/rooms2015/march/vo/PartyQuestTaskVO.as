//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.march.vo.PartyQuestTaskVO
    {
        var memberItemId, memberItemVO, nonMemberItemId, nonMemberItemVO;
        function PartyQuestTaskVO () {
        }
        function setMemberItemId(itemId, itemType) {
            memberItemId = itemId;
            memberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, true, getPaperItemCost(itemId));
        }
        function setNonMemberItemId(itemId, itemType) {
            nonMemberItemId = itemId;
            nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, false, getPaperItemCost(itemId));
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
    }
