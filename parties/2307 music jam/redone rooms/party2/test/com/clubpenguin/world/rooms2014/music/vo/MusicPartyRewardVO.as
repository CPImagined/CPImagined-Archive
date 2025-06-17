class com.clubpenguin.world.rooms2014.music.vo.MusicPartyRewardVO
{
    var memberItemID, memberItemVO, nonMemberItemID, nonMemberItemVO;
    function MusicPartyRewardVO()
    {
    } // End of the function
    function createMemberItemVO(itemID, type, cost)
    {
        memberItemID = itemID;
        memberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemID, type, true, cost);
    } // End of the function
    function createNonMemberItemVO(itemID, type, cost)
    {
        nonMemberItemID = itemID;
        nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemID, type, false, cost);
    } // End of the function
} // End of Class
