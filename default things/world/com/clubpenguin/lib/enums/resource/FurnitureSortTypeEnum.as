//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.resource
{
    import com.clubpenguin.lib.enums.Enum;

    public class FurnitureSortTypeEnum extends Enum 
    {

        public static const ROOM:FurnitureSortTypeEnum = new FurnitureSortTypeEnum("room", 0);
        public static const WALL:FurnitureSortTypeEnum = new FurnitureSortTypeEnum("wall", 1);
        public static const FLOOR:FurnitureSortTypeEnum = new FurnitureSortTypeEnum("floor", 2);
        public static const PET:FurnitureSortTypeEnum = new FurnitureSortTypeEnum("pet", 3);
        public static const FURNITURE_SORT_ENUM_LIST:Array = Enum.createList(FurnitureSortTypeEnum);

        public var type:String;
        public var index:int;

        public function FurnitureSortTypeEnum(_arg_1:String, index:int)
        {
            this.type = _arg_1;
            this.index = index;
        }

        public static function getFurnitureSortEnumByIndex(lookupIndex:int):FurnitureSortTypeEnum
        {
            var i:int;
            while (i < FURNITURE_SORT_ENUM_LIST.length)
            {
                if (FurnitureSortTypeEnum(FURNITURE_SORT_ENUM_LIST[i]).index == lookupIndex)
                {
                    return (FurnitureSortTypeEnum(FURNITURE_SORT_ENUM_LIST[i]));
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
