class com.clubpenguin.world.rooms2015.march.vo.PartyQuestTaskVO
{
    var memberItemId, memberItemVO, nonMemberItemId, nonMemberItemVO;
    function PartyQuestTaskVO()
    {
    } // End of the function
    function setMemberItemId(itemId, itemType)
    {
        memberItemId = itemId;
        memberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, true, this.getPaperItemCost(itemId));
    } // End of the function
    function setNonMemberItemId(itemId, itemType)
    {
        nonMemberItemId = itemId;
        nonMemberItemVO = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, false, this.getPaperItemCost(itemId));
    } // End of the function
    function getPaperItemCost(itemId)
    {
        return (_global.getCurrentShell().getInventoryObjectById(itemId).cost);
    } // End of the function
} // End of Class
