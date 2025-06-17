//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.utils.ByteArray;

    public class ArrayUtil 
    {


        public static function cloneVector(source:Object):Array
        {
            var clone:Array = new Array();
            var i:uint;
            while (i < source.length)
            {
                clone.push(source[i]);
                i++;
            };
            return (clone);
        }

        public static function deepCloneVector(source:Object):Array
        {
            var clone:Array = new Array();
            var i:uint;
            while (i < source.length)
            {
                if (source[i].clone == undefined)
                {
                    throw (new Error("deepCloneVector must be passed an Array or a Vector whose elements have a clone function"));
                };
                clone.push(source[i].clone());
                i++;
            };
            return (clone);
        }

        public static function clone(source:*):*
        {
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(source);
            byteArray.position = 0;
            return (byteArray.readObject());
        }


    }
}//package com.clubpenguin.lib.util
