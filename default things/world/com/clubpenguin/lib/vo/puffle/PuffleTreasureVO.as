//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;

    public class PuffleTreasureVO implements IVO 
    {

        private static const COINS:int = 0;
        private static const FAVORITE_FOOD:int = 1;
        private static const FURNITURE:int = 2;
        private static const CLOTHING:int = 3;
        private static const GOLD_NUGGET:int = 4;

        private var _id:int;
        private var _puffleId:int;
        private var _treasureType:int;
        private var _treasureId:int;
        private var _quantity:int;
        private var _assetURL:String;

        public function PuffleTreasureVO(puffleId:int, treasureType:int, treasureId:int, quantity:int)
        {
            this._puffleId = puffleId;
            this._treasureType = treasureType;
            this._treasureId = treasureId;
            this._quantity = quantity;
        }

        public function isCoins():Boolean
        {
            return (this._treasureType == COINS);
        }

        public function isFood():Boolean
        {
            return (this._treasureType == FAVORITE_FOOD);
        }

        public function isFurniture():Boolean
        {
            return (this._treasureType == FURNITURE);
        }

        public function isClothing():Boolean
        {
            return (this._treasureType == CLOTHING);
        }

        public function isGoldNugget():Boolean
        {
            return (this.treasureType == GOLD_NUGGET);
        }

        public function get quantity():int
        {
            return (this._quantity);
        }

        public function get puffleId():int
        {
            return (this._puffleId);
        }

        public function get treasureId():int
        {
            return (this._treasureId);
        }

        public function get treasureType():int
        {
            return (this._treasureType);
        }

        public function get assetURL():String
        {
            return (this._assetURL);
        }

        public function set assetURL(url:String):void
        {
            this._assetURL = url;
        }

        public function destroy():void
        {
        }

        public function get id():int
        {
            return (0);
        }

        public function get iconURL():String
        {
            return ("");
        }

        public function update(vo:IVO):void
        {
        }

        public function equals(vo:IVO):Boolean
        {
            return (false);
        }

        public function toString():String
        {
            return (((((((((((((("[PuffleTreasureVO]" + "Puffle Id: ") + this._puffleId) + ", ") + "Treasure Type: ") + this._treasureType) + ", ") + "Treasure Item Id: ") + this._treasureId) + ", ") + "AssetURL: ") + this._assetURL) + ", ") + "Quantity: ") + this._quantity);
        }


    }
}//package com.clubpenguin.lib.vo.puffle
