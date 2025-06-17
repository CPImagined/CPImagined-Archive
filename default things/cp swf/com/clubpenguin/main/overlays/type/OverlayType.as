//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.type
{
    public class OverlayType 
    {

        public static const MODULE:OverlayType = new OverlayType("Module", 1);
        public static const DISPLAY:OverlayType = new OverlayType("Display", 2);

        private var value:String;
        private var ordinal:uint;

        public function OverlayType(value:String, ordinal:uint)
        {
            this.value = value;
            this.ordinal = ordinal;
        }

        public static function get list():Array
        {
            return ([MODULE, DISPLAY]);
        }

        public static function selectByValue(value:String):OverlayType
        {
            var overlayType:OverlayType;
            for each (overlayType in OverlayType.list)
            {
                if (value == overlayType.value)
                {
                    return (overlayType);
                };
            };
            return (null);
        }


    }
}//package com.clubpenguin.main.overlays.type
