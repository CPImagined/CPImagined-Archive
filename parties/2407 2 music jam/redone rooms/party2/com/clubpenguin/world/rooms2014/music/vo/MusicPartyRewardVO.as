//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.vo.MusicPartyRewardVO
    {
        var memberItemID, memberItemVO, nonMemberItemID, nonMemberItemVO;
        function MusicPartyRewardVO () {
        }
        function createMemberItemVO(itemID, type, cost) {
            memberItemID = itemID;
            memberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemID, type, true, cost);
        }
        function createNonMemberItemVO(itemID, type, cost) {
            nonMemberItemID = itemID;
            nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemID, type, false, cost);
        }
    }
