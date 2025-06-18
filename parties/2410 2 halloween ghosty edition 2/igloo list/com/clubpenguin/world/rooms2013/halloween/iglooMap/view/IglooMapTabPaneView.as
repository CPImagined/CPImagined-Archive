//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.view.IglooMapTabPaneView extends MovieClip
    {
        function IglooMapTabPaneView () {
            super();
        }
        function getUnselectedTabs() {
            var _local_3 = [];
            var _local_2 = 0;
            while (_local_2 < TAB_COUNT) {
                _local_3.push(this["tab_" + _local_2]);
                _local_2++;
            }
            return(_local_3);
        }
        static var TAB_COUNT = 1;
    }
