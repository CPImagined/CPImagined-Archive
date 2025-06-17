//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.vo
{
    public class CardVO 
    {

        public static const ICON_URL:String = "iconURL";
        public static const CARD_LOADER_DATA:Object = {"iconURL":""};

        public var cardId:Number;
        public var element:String;
        public var colorHex:uint;
        public var value:Number;
        public var isPowercard:Boolean;

        public function CardVO(cardId:Number, element:String, colorHex:Number, value:Number, isPowercard:Boolean)
        {
            this.cardId = cardId;
            this.element = element;
            this.colorHex = colorHex;
            this.value = value;
            this.isPowercard = isPowercard;
        }

    }
}//package com.clubpenguin.main.vo
