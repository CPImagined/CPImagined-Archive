//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO implements com.clubpenguin.util.IVO
    {
        var treasureType, _id, assetURL, quantity, treasureId;
        function PuffleTreasureVO () {
        }
        function isCoins() {
            return(treasureType == COINS);
        }
        function isFood() {
            return(treasureType == FAVORITE_FOOD);
        }
        function isFurniture() {
            return(treasureType == FURNITURE);
        }
        function isClothing() {
            return(treasureType == CLOTHING);
        }
        function isGoldNugget() {
            return(treasureType == GOLD_NUGGET);
        }
        function destroy() {
        }
        function getID() {
            return(_id);
        }
        function update(vo) {
        }
        function toString() {
            return((((((((("[PuffleTreasureVO] id: " + _id) + "  treasureType: ") + treasureType) + "  treasureId: ") + treasureId) + "  quantity: ") + quantity) + "  assetURL: ") + assetURL);
        }
        function equals(vo) {
            var _local_2 = com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO(vo);
            return((treasureType == _local_2.treasureType) && (treasureId == _local_2.treasureId));
        }
        static var COINS = 0;
        static var FAVORITE_FOOD = 1;
        static var FURNITURE = 2;
        static var CLOTHING = 3;
        static var GOLD_NUGGET = 4;
    }
