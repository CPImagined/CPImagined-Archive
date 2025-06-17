//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PlayExternalEnum;
    import com.clubpenguin.lib.enums.puffle.ConsumptionTypeEnum;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.util.StringUtils;

    public class CareItemVO implements IVO 
    {

        private static const MAX_PLAY_QUANTITY:uint = 1;
        private static const MAX_FOOD_QUANTITY:uint = 99;
        private static const MAX_CARE_QUANTITY:uint = 1;
        public static const MAX_HEAD_QUANTITY:uint = 45;
        private static const DEFAULT_QUANTITY:uint = 1;
        public static const PLAY:String = "play";
        public static const FOOD:String = "food";
        public static const CARE:String = "care";
        public static const HAT:String = "hat";
        public static const NONE:String = "none";
        public static const SLEEP:String = "sleep";
        public static const LEASH:String = "leash";
        public static const BUBBLEGUM:String = "bubblegum";
        public static const SUPERPLAY:String = "superplay";
        public static const DISLIKES:int = 0;
        public static const NEUTRAL:int = 1;
        public static const LIKES:int = 2;
        public static const FAVOURITE:int = 3;
        public static const EAT:String = "eat";
        public static const BRUSH:String = "brush";
        public static const BATHE:String = "bathe";
        public static const WEAR:String = "wear";

        public const voUpdated:Signal = new Signal();

        public var __name:String;
        public var __label:String;
        public var __prompt:String;
        public var __class_name:String;
        public var assetPath:String;
        public var effect:StatsVO;
        public var category:CareItemInventoryTypeEnum;
        public var play_external:PlayExternalEnum;
        public var consumption:ConsumptionTypeEnum;
        public var puffleTypeToReactionType:Dictionary;
        public var cost:uint;
        public var quantityPerCost:uint;
        public var rootItemID:int;
        private var _id:int;
        private var _invalidated:Boolean = false;
        private var _quantity:int = 0;
        private var _totalHatQuantity:int = 0;
        public var isMemberOnly:Boolean;


        public static function getEmptyHatVO():CareItemVO
        {
            var emptyHatVO:CareItemVO = new (CareItemVO)();
            emptyHatVO.id = 0;
            return (emptyHatVO);
        }


        public function get name():String
        {
            return (this.__name);
        }

        public function get label():String
        {
            return (this.__label);
        }

        public function get prompt():String
        {
            return (this.__prompt);
        }

        public function get class_name():String
        {
            return (this.__class_name);
        }

        public function set name(_str:String):void
        {
            this.__name = _str;
        }

        public function set label(_str:String):void
        {
            this.__label = _str;
        }

        public function set prompt(_str:String):void
        {
            this.__prompt = _str;
        }

        public function set class_name(_str:String):void
        {
            this.__class_name = _str;
        }

        public function set id(value:int):void
        {
            this._id = value;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function equals(vo:IVO):Boolean
        {
            return (this._id == vo.id);
        }

        public function get quantity():int
        {
            return (this._quantity);
        }

        public function set quantity(new_quantity:int):void
        {
            if (((!(this._quantity == new_quantity)) && (new_quantity <= this.getMaxQuantity())))
            {
                this._invalidated = true;
                this._quantity = new_quantity;
            };
        }

        public function set totalHatQuantity(totalHatQuantity:int):void
        {
            this._totalHatQuantity = totalHatQuantity;
        }

        public function get totalHatQuantity():int
        {
            return (this._totalHatQuantity);
        }

        public function getMaxQuantity():uint
        {
            switch (this.category)
            {
                case CareItemInventoryTypeEnum.FOOD:
                    return (MAX_FOOD_QUANTITY);
                case CareItemInventoryTypeEnum.PLAY:
                    return (MAX_PLAY_QUANTITY);
                case CareItemInventoryTypeEnum.CARE:
                    return (MAX_CARE_QUANTITY);
                case CareItemInventoryTypeEnum.HEAD:
                    return (MAX_HEAD_QUANTITY);
                case CareItemInventoryTypeEnum.GAME:
                default:
                    return (DEFAULT_QUANTITY);
            };
        }

        public function destroy():void
        {
            this.voUpdated.removeAll();
        }

        public function update(vo:IVO):void
        {
            var careItemVO:CareItemVO = (vo as CareItemVO);
            this.category = careItemVO.category;
            this.name = careItemVO.name;
            this.label = careItemVO.label;
            this.class_name = careItemVO.class_name;
            this.assetPath = careItemVO.assetPath;
            this.effect = careItemVO.effect;
            this.quantity = careItemVO.quantity;
            this.puffleTypeToReactionType = careItemVO.puffleTypeToReactionType;
            this.play_external = careItemVO.play_external;
            this.consumption = careItemVO.consumption;
            this.id = careItemVO.id;
            this.cost = careItemVO.cost;
            this.quantityPerCost = careItemVO.quantityPerCost;
            this.rootItemID = careItemVO.rootItemID;
            this.prompt = careItemVO.prompt;
            this.isMemberOnly = careItemVO.isMemberOnly;
            this.sendUpdate();
        }

        public function sendUpdate():void
        {
            if (this._invalidated)
            {
                this._invalidated = false;
                this.voUpdated.dispatch();
            };
        }

        public function copy():CareItemVO
        {
            var newCareItem:CareItemVO = new CareItemVO();
            newCareItem.category = this.category;
            newCareItem.name = this.name;
            newCareItem.label = this.label;
            newCareItem.class_name = this.class_name;
            newCareItem.assetPath = this.assetPath;
            newCareItem.effect = this.effect;
            newCareItem.quantity = this.quantity;
            newCareItem.puffleTypeToReactionType = this.puffleTypeToReactionType;
            newCareItem.play_external = this.play_external;
            newCareItem.consumption = this.consumption;
            newCareItem.id = this.id;
            newCareItem.cost = this.cost;
            newCareItem.quantityPerCost = this.quantityPerCost;
            newCareItem.rootItemID = this.rootItemID;
            newCareItem.prompt = this.prompt;
            newCareItem.isMemberOnly = this.isMemberOnly;
            return (newCareItem);
        }

        public function toString():String
        {
            return (StringUtils.classVariablesDescription(this));
        }


    }
}//package com.clubpenguin.lib.vo.puffle
