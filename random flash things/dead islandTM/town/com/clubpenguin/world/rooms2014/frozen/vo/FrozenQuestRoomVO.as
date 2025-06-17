class com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO
{
    var memberItemId, memberItemVO, nonMemberItemId, nonMemberItemVO;
    function FrozenQuestRoomVO()
    {
    } // End of the function
    function createItemVOs()
    {
        memberItemVO = new com.clubpenguin.party.items.PaperItem(memberItemId, true, this.getPaperItemCost(memberItemId));
        nonMemberItemVO = new com.clubpenguin.party.items.PaperItem(nonMemberItemId, false, this.getPaperItemCost(nonMemberItemId));
    } // End of the function
    function getPaperItemCost(itemId)
    {
        return (_global.getCurrentShell().getInventoryObjectById(itemId).cost);
    } // End of the function
} // End of Class
