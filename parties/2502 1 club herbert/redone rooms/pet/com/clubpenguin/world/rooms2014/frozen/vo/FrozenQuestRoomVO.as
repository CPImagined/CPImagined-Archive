//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.vo.FrozenQuestRoomVO
    {
        var memberItemVO, memberItemId, nonMemberItemVO, nonMemberItemId;
        function FrozenQuestRoomVO () {
        }
        function createItemVOs() {
            memberItemVO = new com.clubpenguin.party.items.PaperItem(memberItemId, true, getPaperItemCost(memberItemId));
            nonMemberItemVO = new com.clubpenguin.party.items.PaperItem(nonMemberItemId, false, getPaperItemCost(nonMemberItemId));
        }
        function getPaperItemCost(_arg_2) {
            return(_global.getCurrentShell().getInventoryObjectById(_arg_2).cost);
        }
    }
