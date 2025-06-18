//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    public interface ICommandMap 
    {

        function detain(_arg_1:Object):void;
        function release(_arg_1:Object):void;
        function execute(_arg_1:Class, _arg_2:Object=null, _arg_3:Class=null, _arg_4:String=""):void;
        function mapEvent(_arg_1:String, _arg_2:Class, _arg_3:Class=null, _arg_4:Boolean=false):void;
        function unmapEvent(_arg_1:String, _arg_2:Class, _arg_3:Class=null):void;
        function unmapEvents():void;
        function hasEventCommand(_arg_1:String, _arg_2:Class, _arg_3:Class=null):Boolean;

    }
}//package org.robotlegs.core
