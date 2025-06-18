//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.collection.IglooMapPlayerList extends com.clubpenguin.util.collection.OperatorCollection
    {
        var getItems;
        function IglooMapPlayerList () {
            super(com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO);
        }
        function toString() {
            return("[IglooMapPlayerList]  " + getItems());
        }
    }
