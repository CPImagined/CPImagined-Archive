//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.vo
{
    public class CardDataVO 
    {

        public static var COLOR_RED:Number = 14826534;
        public static var COLOR_GREEN:Number = 6404422;
        public static var COLOR_BLUE:Number = 1132705;
        public static var COLOR_PURPLE:Number = 10721738;
        public static var COLOR_ORANGE:Number = 16225579;
        public static var COLOR_YELLOW:Number = 16509741;

        public var cardId:Number;
        public var element:String;
        public var colorHex:Number;
        public var value:Number;
        public var isPowercard:Boolean;

        public function CardDataVO(cardId:Number, element:String, colorAbbreviation:String, value:Number, powerId:Number):void
        {
            this.cardId = cardId;
            this.element = element;
            this.colorHex = getColorHexByAbbreviation(colorAbbreviation);
            this.value = value;
            this.isPowercard = (powerId > 0);
        }

        private static function getColorHexByAbbreviation(abbr:String):Number
        {
            switch (abbr)
            {
                case "r":
                    return (COLOR_RED);
                case "g":
                    return (COLOR_GREEN);
                case "b":
                    return (COLOR_BLUE);
                case "p":
                    return (COLOR_PURPLE);
                case "o":
                    return (COLOR_ORANGE);
                case "y":
                    return (COLOR_YELLOW);
                default:
                    return (COLOR_RED);
            };
        }


        public function destroy():void
        {
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.vo
