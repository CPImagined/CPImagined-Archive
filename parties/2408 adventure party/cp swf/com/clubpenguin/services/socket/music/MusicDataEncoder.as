//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.music
{
    import com.adobe.crypto.MD5;

    public class MusicDataEncoder 
    {


        public static function encode(data:String):String
        {
            var result:String = data;
            result = data.split("").reverse().join("");
            result = MD5.hash(result);
            result = (result.substr(-16) + result.substr(0, 16));
            return (result);
        }

        public static function isValid(data:String, crc:String):Boolean
        {
            var result:String = encode(data);
            return (result == crc);
        }


    }
}//package com.clubpenguin.services.socket.music
