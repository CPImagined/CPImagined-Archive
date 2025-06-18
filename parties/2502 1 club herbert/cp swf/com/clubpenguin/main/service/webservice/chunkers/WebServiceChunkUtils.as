//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import flash.utils.ByteArray;
    import flash.net.ObjectEncoding;

    public class WebServiceChunkUtils 
    {

        public static const MAX_SIZE:int = 40946;


        public static function getSize(chunk:Array):int
        {
            ByteArray.defaultObjectEncoding = ObjectEncoding.AMF0;
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(chunk);
            return (byteArray.length);
        }

        public static function getChunk(source:Array, maxElements:int):Array
        {
            var chunk:Array = source.splice(0, maxElements);
            return (chunk);
        }

        public static function getItemCount(source:*):uint
        {
            var item:*;
            var count:uint;
            for (item in source)
            {
                count++;
            };
            return (count);
        }


    }
}//package com.clubpenguin.main.service.webservice.chunkers
