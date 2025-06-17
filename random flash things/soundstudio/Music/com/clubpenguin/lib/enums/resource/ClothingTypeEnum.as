//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.resource
{
    import com.clubpenguin.lib.enums.Enum;

    public class ClothingTypeEnum extends Enum 
    {

        public static const COLOUR:ClothingTypeEnum = new ClothingTypeEnum("colour", 0);
        public static const HEAD:ClothingTypeEnum = new ClothingTypeEnum("head", 1);
        public static const FACE:ClothingTypeEnum = new ClothingTypeEnum("face", 2);
        public static const NECK:ClothingTypeEnum = new ClothingTypeEnum("neck", 3);
        public static const BODY:ClothingTypeEnum = new ClothingTypeEnum("body", 4);
        public static const HAND:ClothingTypeEnum = new ClothingTypeEnum("hand", 5);
        public static const FEET:ClothingTypeEnum = new ClothingTypeEnum("feet", 6);
        public static const PIN:ClothingTypeEnum = new ClothingTypeEnum("pin", 7);
        public static const PHOTO:ClothingTypeEnum = new ClothingTypeEnum("photo", 8);
        public static const OTHER:ClothingTypeEnum = new ClothingTypeEnum("other", 9);
        public static const CLOTHING_TYPE_ENUM_LIST:Array = Enum.createList(ClothingTypeEnum);

        public var type:String;
        public var index:int;

        public function ClothingTypeEnum(_arg_1:String, index:int)
        {
            this.type = _arg_1;
            this.index = index;
        }

        public static function getClothingTypeEnumByIndex(lookupIndex:int):ClothingTypeEnum
        {
            var i:int;
            while (i < CLOTHING_TYPE_ENUM_LIST.length)
            {
                if (ClothingTypeEnum(CLOTHING_TYPE_ENUM_LIST[i]).index == lookupIndex)
                {
                    return (ClothingTypeEnum(CLOTHING_TYPE_ENUM_LIST[i]));
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
