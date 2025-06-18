//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
{
    public class CardVO 
    {

        public static const ICON_URL:String = "iconURL";
        public static const ICON_URL_DEFAULT_VALUE:String = "";
        public static const CARD_LOADER_DATA:Object = {"ICON_URL":ICON_URL_DEFAULT_VALUE};

        public var cardId:Number;
        public var element:String;
        public var colorHex:uint;
        public var value:Number;
        public var isPowercard:Boolean;
        public var count:Number;
        public var memberOnly:Boolean;
        public var available:Boolean;

        public function CardVO(cardId:Number, element:String, colorHex:Number, value:Number, isPowercard:Boolean, count:Number, memberOnly:Boolean, available:Boolean)
        {
            this.cardId = cardId;
            this.element = element;
            this.colorHex = colorHex;
            this.value = value;
            this.isPowercard = isPowercard;
            this.count = count;
            this.memberOnly = memberOnly;
            this.available = available;
        }

        public function destroy():void
        {
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
