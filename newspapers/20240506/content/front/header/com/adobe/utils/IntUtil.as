//Created by Action Script Viewer - https://www.buraks.com/asv
package com.adobe.utils
{
    public class IntUtil 
    {

        private static var hexChars:String = "0123456789abcdef";


        public static function rol(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }

        public static function ror(_arg_1:int, _arg_2:int):uint
        {
            var _local_3:int = (32 - _arg_2);
            return ((_arg_1 << _local_3) | (_arg_1 >>> (32 - _local_3)));
        }

        public static function toHex(_arg_1:int, _arg_2:Boolean=false):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:* = "";
            if (_arg_2)
            {
                _local_4 = 0;
                while (_local_4 < 4)
                {
                    _local_3 = (_local_3 + (hexChars.charAt(((_arg_1 >> (((3 - _local_4) * 8) + 4)) & 0x0F)) + hexChars.charAt(((_arg_1 >> ((3 - _local_4) * 8)) & 0x0F))));
                    _local_4++;
                };
            }
            else
            {
                _local_5 = 0;
                while (_local_5 < 4)
                {
                    _local_3 = (_local_3 + (hexChars.charAt(((_arg_1 >> ((_local_5 * 8) + 4)) & 0x0F)) + hexChars.charAt(((_arg_1 >> (_local_5 * 8)) & 0x0F))));
                    _local_5++;
                };
            };
            return (_local_3);
        }


    }
}//package com.adobe.utils
