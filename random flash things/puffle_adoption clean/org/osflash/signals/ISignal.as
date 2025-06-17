//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals
{
    public interface ISignal 
    {

        function add(_arg_1:Function):Function;
        function addOnce(_arg_1:Function):Function;
        function remove(_arg_1:Function):Function;
        function get valueClasses():Array;
        function get numListeners():uint;

    }
}//package org.osflash.signals
