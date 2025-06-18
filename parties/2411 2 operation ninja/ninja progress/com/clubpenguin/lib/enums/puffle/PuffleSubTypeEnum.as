//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.util.StringUtils;

    public class PuffleSubTypeEnum extends Enum 
    {

        public static const BLACK_TREX:PuffleSubTypeEnum = new PuffleSubTypeEnum(1000, 2, "blackTRex", "", true, true);
        public static const PURPLE_TREX:PuffleSubTypeEnum = new PuffleSubTypeEnum(1001, 4, "purpleTRex", "", true, true);
        public static const RED_TRICERATOP:PuffleSubTypeEnum = new PuffleSubTypeEnum(1002, 5, "redTriceratops", "", true, true);
        public static const BLUE_TRICERATOP:PuffleSubTypeEnum = new PuffleSubTypeEnum(1003, 0, "blueTriceratops", "", true, true);
        public static const YELLOW_STEGASAURUS:PuffleSubTypeEnum = new PuffleSubTypeEnum(1004, 6, "yellowStegosaurus", "", true, true);
        public static const PINK_STEGASAURUS:PuffleSubTypeEnum = new PuffleSubTypeEnum(1005, 1, "pinkStegosaurus", "", true, true);
        public static const BLUE_BORDER_COLLIE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1006, 0, "blueBorderCollie", "", true, true, 800);
        public static const ORANGE_TABBY_CAT:PuffleSubTypeEnum = new PuffleSubTypeEnum(1007, 8, "orangeTabbyCat", "", true, true, 800);
        public static const SNOW_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1021, 7, "snow", "", true, true);
        public static const GHOST_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1022, 4, "ghost", "", true, true, 1);
        public static const CRYSTAL_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1023, 0, "crystal", "", true, true, 1);
        public static const GREEN_ALIEN_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(0x0400, 3, "greenAlien", "", true, true);
        public static const ORANGE_ALIEN_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1025, 8, "organeAlien", "", true, true);
        public static const YELLOW_ALIEN_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1026, 6, "yellowAlien", "", true, true);
        public static const PURPLE_ALIEN_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1027, 4, "purpleAlien", "", true, true);
        public static const YELLOW_UNICORN_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1020, 6, "yellowunicorn", "", true, true, 800);
        public static const PURPLE_DEER_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1019, 4, "purpledeer", "", true, true, 800);
        public static const RED_DEER_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1018, 5, "reddeer", "", true, true, 800);
        public static const BLACK_DEER_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1017, 2, "blackdeer", "", true, true, 800);
        public static const BLUE_DEER_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1016, 0, "bluedeer", "", true, true, 800);
        public static const RED_RABBIT_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1015, 5, "redrabbit", "", true, true, 800);
        public static const WHITE_RABBIT_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1014, 7, "whiterabbit", "", true, true, 800);
        public static const PINK_RABBIT_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1013, 1, "pinkrabbit", "", true, true, 800);
        public static const GREEN_RABBIT_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1012, 3, "greenrabbit", "", true, true, 800);
        public static const BLUE_RACCOON_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1011, 0, "blueraccoon", "", true, true, 800);
        public static const PINK_RACCOON_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1010, 1, "pinkraccoon", "", true, true, 800);
        public static const ORANGE_RACCOON_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1009, 8, "orangeraccoon", "", true, true, 800);
        public static const GREEN_RACCOON_PUFFLE:PuffleSubTypeEnum = new PuffleSubTypeEnum(1008, 3, "greenraccoon", "", true, true, 800);
        public static const PUFFLE_SUB_TYPE_ENUM_LIST:Array = Enum.createList(PuffleSubTypeEnum);

        public var id:int = -1;
        public var baseTypeId:int = -1;
        public var name:String = "";
        public var description:String = "";
        public var memberOnly:Boolean = true;
        public var isActive:Boolean = false;
        public var price:uint = 0;

        public function PuffleSubTypeEnum(subTypeId:int, baseTypeId:int, name:String, description:String, memberOnly:Boolean, isActive:Boolean, price:uint=0):void
        {
            this.id = subTypeId;
            this.baseTypeId = baseTypeId;
            this.name = name;
            this.description = description;
            this.memberOnly = memberOnly;
            this.isActive = isActive;
            this.price = price;
        }

        public static function getPuffleSubTypeEnumByID(look_up_id:int):PuffleSubTypeEnum
        {
            var i:int;
            while (i < PUFFLE_SUB_TYPE_ENUM_LIST.length)
            {
                if (PuffleSubTypeEnum(PUFFLE_SUB_TYPE_ENUM_LIST[i]).id == look_up_id)
                {
                    return (PuffleSubTypeEnum(PUFFLE_SUB_TYPE_ENUM_LIST[i]));
                };
                i++;
            };
            return (null);
        }


        public function toString():String
        {
            return (StringUtils.classVariablesDescription(this));
        }


    }
}//package com.clubpenguin.lib.enums.puffle
