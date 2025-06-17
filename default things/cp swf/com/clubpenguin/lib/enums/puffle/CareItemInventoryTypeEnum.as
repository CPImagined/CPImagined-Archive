//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;

    public class CareItemInventoryTypeEnum extends Enum 
    {

        public static const GAME:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("game");
        public static const PLAY:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("play");
        public static const FOOD:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("food");
        public static const CARE:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("care");
        public static const SLEEP:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("sleep");
        public static const HEAD:CareItemInventoryTypeEnum = new CareItemInventoryTypeEnum("head");
        public static const TYPES:Array = [GAME, PLAY, FOOD, CARE, SLEEP, HEAD];

        private var _type:String;

        public function CareItemInventoryTypeEnum(_arg_1:String)
        {
            this._type = _arg_1;
        }

        public static function getEnumByInstanceName(queryName:String):CareItemInventoryTypeEnum
        {
            var _local_3:String;
            var i:uint;
            while (i < TYPES.length)
            {
                _local_3 = CareItemInventoryTypeEnum.getEnum(i).type;
                if (queryName == _local_3)
                {
                    return (CareItemInventoryTypeEnum.getEnum(i));
                };
                i++;
            };
            return (CareItemInventoryTypeEnum.getEnum(0));
        }

        public static function getEnum(id:uint):CareItemInventoryTypeEnum
        {
            return (CareItemInventoryTypeEnum(TYPES[id]));
        }


        public function get type():String
        {
            return (this._type);
        }

        public function toString():String
        {
            return (('[CareItemInventoryTypeEnum type="' + this._type) + '"]');
        }


    }
}//package com.clubpenguin.lib.enums.puffle
