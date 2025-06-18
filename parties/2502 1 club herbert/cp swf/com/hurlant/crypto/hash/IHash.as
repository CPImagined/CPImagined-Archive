//Created by Action Script Viewer - https://www.buraks.com/asv
package com.hurlant.crypto.hash
{
    import flash.utils.ByteArray;

    public interface IHash 
    {

        function toString():String;
        function getHashSize():uint;
        function getInputSize():uint;
        function hash(_arg_1:ByteArray):ByteArray;

    }
}//package com.hurlant.crypto.hash
