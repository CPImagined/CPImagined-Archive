//Created by Action Script Viewer - https://www.buraks.com/asv
package com.adobe.serialization.json
{
    public class JSON 
    {


        public static function encode(o:Object):String
        {
            return (new JSONEncoder(o).getString());
        }

        public static function decode(s:String, strict:Boolean=true):*
        {
            return (new JSONDecoder(s, strict).getValue());
        }


    }
}//package com.adobe.serialization.json
