//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.school.vo.SchoolQuestRoomVO
    {
        var memberItemVO, memberItemId, nonMemberItemVO, nonMemberItemId;
        function SchoolQuestRoomVO () {
        }
        function createItemVOs() {
            memberItemVO = new com.clubpenguin.party.items.PaperItem(memberItemId, true, getPaperItemCost(memberItemId));
            nonMemberItemVO = new com.clubpenguin.party.items.PaperItem(nonMemberItemId, false, getPaperItemCost(nonMemberItemId));
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
    }
