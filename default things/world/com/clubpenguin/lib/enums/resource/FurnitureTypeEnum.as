//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.resource
{
    import com.clubpenguin.lib.enums.Enum;

    public class FurnitureTypeEnum extends Enum 
    {

        public static const ROOM:FurnitureTypeEnum = new FurnitureTypeEnum("room", 0);
        public static const WALL:FurnitureTypeEnum = new FurnitureTypeEnum("wall", 1);
        public static const FLOOR:FurnitureTypeEnum = new FurnitureTypeEnum("floor", 2);
        public static const FURNITURE_TYPE_ENUM_LIST:Array = Enum.createList(FurnitureTypeEnum);

        public var type:String;
        public var index:int;

        public function FurnitureTypeEnum(_arg_1:String, index:int)
        {
            this.type = _arg_1;
            this.index = index;
        }

        public static function getFurnitureTypeEnumByIndex(lookupIndex:int):FurnitureTypeEnum
        {
            var i:int;
            while (i < FURNITURE_TYPE_ENUM_LIST.length)
            {
                if (FurnitureTypeEnum(FURNITURE_TYPE_ENUM_LIST[i]).index == lookupIndex)
                {
                    return (FurnitureTypeEnum(FURNITURE_TYPE_ENUM_LIST[i]));
                };
                i++;
            };
            return (null);
        }


        public function toString():String
        {
            return ((("type = " + this.type) + ", index = ") + this.index);
        }


    }
}//package com.clubpenguin.lib.enums.resource
