//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.puffle
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.util.StringUtils;

    public class PuffleTypeEnum extends Enum 
    {

        public static const BLUE:PuffleTypeEnum = new PuffleTypeEnum("blue", 0, 400);
        public static const PINK:PuffleTypeEnum = new PuffleTypeEnum("pink", 1, 400);
        public static const BLACK:PuffleTypeEnum = new PuffleTypeEnum("black", 2, 400);
        public static const GREEN:PuffleTypeEnum = new PuffleTypeEnum("green", 3, 400);
        public static const PURPLE:PuffleTypeEnum = new PuffleTypeEnum("purple", 4, 400);
        public static const RED:PuffleTypeEnum = new PuffleTypeEnum("red", 5, 400);
        public static const YELLOW:PuffleTypeEnum = new PuffleTypeEnum("yellow", 6, 400);
        public static const WHITE:PuffleTypeEnum = new PuffleTypeEnum("white", 7, 400);
        public static const ORANGE:PuffleTypeEnum = new PuffleTypeEnum("orange", 8, 400);
        public static const BROWN:PuffleTypeEnum = new PuffleTypeEnum("brown", 9, 400);
        public static const RAINBOW:PuffleTypeEnum = new PuffleTypeEnum("rainbow", 10, 0, false);
        public static const GOLD:PuffleTypeEnum = new PuffleTypeEnum("gold", 11, 0, false);
		public static const MAROON:PuffleTypeEnum = new PuffleTypeEnum("maroon", 12, 0, false);
		public static const YARR:PuffleTypeEnum = new PuffleTypeEnum("yarr", 13, 0, false);
		public static const LOLZ:PuffleTypeEnum = new PuffleTypeEnum("lolz", 14, 0, false);
		public static const PETE:PuffleTypeEnum = new PuffleTypeEnum("pete", 15, 0, false);
		public static const DARWIN:PuffleTypeEnum = new PuffleTypeEnum("darwin", 16, 0, false);
		public static const FLIT:PuffleTypeEnum = new PuffleTypeEnum("flit", 17, 0, false);
        public static const PUFFLE_TYPE_ENUM_LIST:Array = Enum.createList(PuffleTypeEnum);

        public var colorName:String = "";
        public var id:int = -1;
        public var price:int = 0;
        public var puppeteerEnabled:Boolean = true;
        public var description:String = "";
        public var hexColor:uint = 0;

        public function PuffleTypeEnum(colorName:String, id:int, price:int, pupeteerEnabled:Boolean=true):void
        {
            this.colorName = colorName;
            this.id = id;
            this.price = price;
            this.puppeteerEnabled = pupeteerEnabled;
        }

        public static function getPuffleTypeEnumByID(look_up_id:int):PuffleTypeEnum
        {
            var i:int;
            while (i < PUFFLE_TYPE_ENUM_LIST.length)
            {
                if (PuffleTypeEnum(PUFFLE_TYPE_ENUM_LIST[i]).id == look_up_id)
                {
                    return (PuffleTypeEnum(PUFFLE_TYPE_ENUM_LIST[i]));
                };
                i++;
            };
            return (null);
        }

        public static function getPuffleTypeEnumByName(_lookupName:String):PuffleTypeEnum
        {
            var i:int;
            while (i < PUFFLE_TYPE_ENUM_LIST.length)
            {
                if (PuffleTypeEnum(PUFFLE_TYPE_ENUM_LIST[i]).colorName == _lookupName)
                {
                    return (PuffleTypeEnum(PUFFLE_TYPE_ENUM_LIST[i]));
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
