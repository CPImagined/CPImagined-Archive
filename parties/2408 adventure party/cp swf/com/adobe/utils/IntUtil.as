//Created by Action Script Viewer - https://www.buraks.com/asv
package com.adobe.utils
{
    public class IntUtil 
    {

        private static var hexChars:String = "0123456789abcdef";


        public static function rol(x:int, n:int):int
        {
            return ((x << n) | (x >>> (32 - n)));
        }

        public static function ror(x:int, n:int):uint
        {
            var nn:int = (32 - n);
            return ((x << nn) | (x >>> (32 - nn)));
        }

        public static function toHex(n:int, bigEndian:Boolean=false):String
        {
            var i:int;
            var x:int;
            var s:String = "";
            if (bigEndian)
            {
                i = 0;
                while (i < 4)
                {
                    s = (s + (hexChars.charAt(((n >> (((3 - i) * 8) + 4)) & 0x0F)) + hexChars.charAt(((n >> ((3 - i) * 8)) & 0x0F))));
                    i++;
                };
            }
            else
            {
                x = 0;
                while (x < 4)
                {
                    s = (s + (hexChars.charAt(((n >> ((x * 8) + 4)) & 0x0F)) + hexChars.charAt(((n >> (x * 8)) & 0x0F))));
                    x++;
                };
            };
            return (s);
        }


    }
}//package com.adobe.utils
