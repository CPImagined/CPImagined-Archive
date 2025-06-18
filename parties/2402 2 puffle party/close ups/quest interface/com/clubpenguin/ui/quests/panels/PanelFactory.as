//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.panels.PanelFactory
    {
        function PanelFactory () {
        }
        static function getQuestPanel(ui, index) {
            var _local_1 = getVO(index);
            switch (_local_1.type) {
                case ITEM_COLLECT : 
                    return(new com.clubpenguin.ui.quests.panels.PanelItemCollect(ui, _local_1));
                case GENERIC : 
            }
            return(new com.clubpenguin.ui.quests.panels.PanelGeneric(ui, _local_1));
        }
        static function getVO(index) {
            return(_global.getCurrentParty().BaseParty.CURRENT_PARTY.getQuestVOByIndex(index));
        }
        static var GENERIC = "generic";
        static var ITEM_COLLECT = "itemcollect";
    }
