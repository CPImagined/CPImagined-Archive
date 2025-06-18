//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.vo.TemplatedQuestTaskVO
    {
        var memberItemIds, memberItemVOs, nonMemberItemIds, nonMemberItemVOs, gothere, taskLockNumber, unlockDay, taskName, questTaskIndex;
        function TemplatedQuestTaskVO () {
            memberItemIds = new Array();
            memberItemVOs = new Array();
            nonMemberItemIds = new Array();
            nonMemberItemVOs = new Array();
        }
        function setMemberItemId(itemId, itemType) {
            memberItemIds.push(itemId);
            var _local_3 = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, true, getPaperItemCost(itemId));
            memberItemVOs.push(_local_3);
        }
        function setNonMemberItemId(itemId, itemType) {
            nonMemberItemIds.push(itemId);
            var _local_2 = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId, itemType, false, getPaperItemCost(itemId));
            nonMemberItemVOs.push(_local_2);
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
        function get toString() {
            return(((((((((((((((((((("\tTemplatedQuestTaskVO:  questTaskIndex: " + questTaskIndex) + " ") + " taskName: ") + taskName) + " ") + " unlockDay: ") + unlockDay) + " ") + " taskLockNumber: ") + taskLockNumber) + " ") + " gothere: ") + gothere) + " ") + " nonMemberItemIds: ") + nonMemberItemIds) + " ") + " memberItemIds: ") + memberItemIds) + " ");
        }
    }
