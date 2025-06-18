dynamic class com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO
{
    var memberItemId;
    var memberItemVO;
    var nonMemberItemId;
    var nonMemberItemVO;

    function FrozenQuestRoomVO()
    {
    }

    function createItemVOs()
    {
        this.memberItemVO = new com.clubpenguin.party.items.PaperItem(this.memberItemId, true, this.getPaperItemCost(this.memberItemId));
        this.nonMemberItemVO = new com.clubpenguin.party.items.PaperItem(this.nonMemberItemId, false, this.getPaperItemCost(this.nonMemberItemId));
    }

    function getPaperItemCost(itemId)
    {
        return _global.getCurrentShell().getInventoryObjectById(itemId).cost;
    }

}
