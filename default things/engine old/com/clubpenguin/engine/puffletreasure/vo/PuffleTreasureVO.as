class com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO implements com.clubpenguin.util.IVO
{
    var treasureType, _id, treasureId, quantity, assetURL;
    function PuffleTreasureVO()
    {
    } // End of the function
    function isCoins()
    {
        return (treasureType == com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO.COINS);
    } // End of the function
    function isFood()
    {
        return (treasureType == com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO.FAVORITE_FOOD);
    } // End of the function
    function isFurniture()
    {
        return (treasureType == com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO.FURNITURE);
    } // End of the function
    function isClothing()
    {
        return (treasureType == com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO.CLOTHING);
    } // End of the function
    function isGoldNugget()
    {
        return (treasureType == com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO.GOLD_NUGGET);
    } // End of the function
    function destroy()
    {
    } // End of the function
    function getID()
    {
        return (_id);
    } // End of the function
    function update(vo)
    {
    } // End of the function
    function toString()
    {
        return ("[PuffleTreasureVO] id: " + _id + "  treasureType: " + treasureType + "  treasureId: " + treasureId + "  quantity: " + quantity + "  assetURL: " + assetURL);
    } // End of the function
    function equals(vo)
    {
        var _loc2 = (com.clubpenguin.engine.puffletreasure.vo.PuffleTreasureVO)(vo);
        return (treasureType == _loc2.treasureType && treasureId == _loc2.treasureId);
    } // End of the function
    static var COINS = 0;
    static var FAVORITE_FOOD = 1;
    static var FURNITURE = 2;
    static var CLOTHING = 3;
    static var GOLD_NUGGET = 4;
} // End of Class
