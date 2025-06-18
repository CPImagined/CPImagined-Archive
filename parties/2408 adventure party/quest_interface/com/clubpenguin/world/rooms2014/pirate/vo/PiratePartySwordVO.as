//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO
    {
        var itemVO, itemID;
        function PiratePartySwordVO () {
        }
        function createItemVOs(member) {
            itemVO = new com.clubpenguin.party.items.PaperItem(itemID, (member ? true : false), getPaperItemCost(itemID));
        }
        function getPaperItemCost(itemId) {
            return(_global.getCurrentShell().getInventoryObjectById(itemId).cost);
        }
    }
