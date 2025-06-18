//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.vo.PiratePartyQuestVO
    {
        var memberItemVO, memberItemId, nonMemberItemVO, nonMemberItemId;
        function PiratePartyQuestVO () {
        }
        function createItemVOs() {
            memberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(memberItemId, ((memberItemId == Number(com.clubpenguin.world.rooms2014.pirate.party.PiratePartyConstants.PARTY_SERVICE.piratePuffleReward)) ? (com.clubpenguin.party.items.PuffleItem.TYPE) : (com.clubpenguin.party.items.PaperItem.TYPE)), true, 0);
            nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(nonMemberItemId, ((nonMemberItemId == Number(com.clubpenguin.world.rooms2014.pirate.party.PiratePartyConstants.PARTY_SERVICE.pirateFurnitureReward)) ? (com.clubpenguin.party.items.FurnitureItem.TYPE) : (com.clubpenguin.party.items.PaperItem.TYPE)), false, 0);
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
    }
